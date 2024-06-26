// Shell.

#include "types.h"
#include "user.h"
#include "fcntl.h"

// Parsed command representation
#define EXEC  1
#define REDIR 2
#define PIPE  3
#define LIST  4
#define BACK  5

#define MAXARGS 10

// MAX 10 commands in history
#define MAX_HISTORY 10

// 100 because of buffer size
char history[MAX_HISTORY][100];


int total_cmds = 0;
int background_pid = -1;


struct cmd {
  int type;
};

struct execcmd {
  int type;
  char *argv[MAXARGS];
  char *eargv[MAXARGS];
};

struct redircmd {
  int type;
  struct cmd *cmd;
  char *file;
  char *efile;
  int mode;
  int fd;
};

struct pipecmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct listcmd {
  int type;
  struct cmd *left;
  struct cmd *right;
};

struct backcmd {
  int type;
  struct cmd *cmd;
};

int fork1(void);  // Fork but panics on failure.
void panic(char*);
struct cmd *parsecmd(char*);

int check_history(char *cmd);
void add_history(const char *cmd);
void print_history();
void execute_history(int n);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
  int p[2]; // for pipe
        int fd; // for redirects
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;
  
  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
      exit();

    if(strcmp(ecmd->argv[0], "hist") == 0) {
      if (ecmd->argv[1] && strcmp(ecmd->argv[1], "print") == 0) {
        print_history();
      } else if (ecmd->argv[1] && atoi(ecmd->argv[1]) != 0) {
        execute_history(atoi(ecmd->argv[1]));
      } else if (ecmd->argv[1] && strcmp(ecmd->argv[1], "0") == 0) {
        execute_history(0);
      }
      break;
    }

    exec(ecmd->argv[0], ecmd->argv);
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

case REDIR:
    rcmd = (struct redircmd*)cmd;

    //int new_fd;

    if (rcmd->mode == O_RDONLY){
        //close(rcmd->fd);
        fd = open(rcmd->file, rcmd->mode);
        if (fd < 0)
        {
            printf(2, "open %s failed\n", rcmd->file);
            exit();
        }
    }
    else if ((rcmd->mode & O_WRONLY) != 0){
        //close(rcmd->fd);
        fd = open(rcmd->file, rcmd->mode );  // Open the file for writing, and create it if it doesn't exist.
        if (fd < 0){
            printf(2, "open %s failed\n", rcmd->file);
            exit();
        }
    }

    if(fd != rcmd->fd) // Check if the file descriptor returned by open is not what we expect
    {
      close(rcmd->fd);
      int new_fd = dup(fd); // Use dup to duplicate it to the right file descriptor number

      if(new_fd != rcmd-> fd)
      {
        printf(2, "dup %s failed\n", rcmd->file);
        exit();
      }
      close(fd);
    }

    runcmd(rcmd->cmd);

    break;

  case LIST:
    lcmd = (struct listcmd*)cmd; //Cast the cmd pointer to represent the list type
    if(lcmd->left)
    {
      if(fork1() == 0)
      {
        runcmd(lcmd->left);
        exit();
      }
      wait();
    }
    if(lcmd->right)
    {
      if(fork1() == 0)
      {
        runcmd(lcmd->right);
        exit();
      }
      wait();
    }
    //printf(2, "List Not Implemented\n");
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if (pipe(p) < 0)
        panic("pipe");

    if (fork1() == 0) { // First command
        close(p[0]);
        close(1);
        dup(p[1]);
        close(p[1]);
        runcmd(pcmd->left);
        exit();
    }

    if (fork1() == 0) { // Second command
        close(p[1]);
        close(0);
        dup(p[0]);
        close(p[0]);
        runcmd(pcmd->right);
        exit();
    }

    close(p[0]);
    close(p[1]);
    wait();
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd; 
    int proc = fork1();
    if(proc == 0) { // backgrounded child
        runcmd(bcmd->cmd); 
        exit();
    }
      else {
    background_pid = proc;
  }
    break;
  }
  exit();
}

int
getcmd(char *buf, int nbuf)
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}

int
main(void)
{
  static char buf[100];
  int fd;
  int status; 

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      break;
    }
  }

  int background_pid = -1;

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    // Remove newline character from the end of the command
    buf[strlen(buf)-1] = 0;

    // add command to history
    add_history(buf);

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }


    if (fork1() == 0) {
      runcmd(parsecmd(buf));
    } 
    else {
      wait();
      if (background_pid > 0) {
        waitpid(background_pid, &status, 0);
        background_pid = -1;
      }
    }
  }
  exit();
}


void
panic(char *s)
{
  printf(2, "%s\n", s);
  exit();
}

int
fork1(void)
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
  return pid;
}

//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
  cmd->cmd = subcmd;
  cmd->file = file;
  cmd->efile = efile;
  cmd->mode = mode;
  cmd->fd = fd;
  return (struct cmd*)cmd;
}

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
  cmd->left = left;
  cmd->right = right;
  return (struct cmd*)cmd;
}

struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
  cmd->cmd = subcmd;
  return (struct cmd*)cmd;
}
//PAGEBREAK!
// Parsing

char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
  case 0:
    break;
  case '|':
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
}

struct cmd *parseline(char**, char*);
struct cmd *parsepipe(char**, char*);
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
  cmd = parseredirs(cmd, ps, es);
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
  int i;
  struct backcmd *bcmd;
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    *rcmd->efile = 0;
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    nulterminate(pcmd->left);
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}

int check_history(char *cmd) {
  if (cmd[0] == 'h' && cmd[1] == 'i' && cmd[2] == 's' && cmd[3] == 't' && cmd[4] == ' ') {
    return 1;
  }
  return 0;
}

void add_history(const char *cmd) {
  // ignore history commands
  if (check_history(cmd)) return;

  for (int i = total_cmds; i > 0; i--) {
    strcpy(history[i], history[i - 1]);
  }
  strcpy(history[0], cmd);
  if (total_cmds < MAX_HISTORY - 1) total_cmds++;
}

void print_history() {
    for(int n = 0; n < total_cmds; n++) {
        printf(2, "Previous command %d: %s\n", n + 1, history[n]);
    }
}

void execute_history(int n) {
    if(n > 0 && n <= total_cmds) {
        if(fork1() == 0) {
          runcmd(parsecmd(history[n - 1]));
          exit();
        }
        wait();
    } else {
        printf(2, "No such command in history.");
    }
}
