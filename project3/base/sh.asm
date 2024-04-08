
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 14             	sub    $0x14,%esp
  static char buf[100];
  int fd;
  int status; // To be used with waitpid

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      17:	90                   	nop
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f dc 00 00 00    	jg     fd <main+0xfd>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 1a 17 00 00       	push   $0x171a
      2b:	e8 a3 11 00 00       	call   11d3 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
  printf(2, "$ ");
      37:	83 ec 08             	sub    $0x8,%esp
      3a:	68 28 16 00 00       	push   $0x1628
      3f:	6a 02                	push   $0x2
      41:	e8 ba 12 00 00       	call   1300 <printf>
  memset(buf, 0, nbuf);
      46:	83 c4 0c             	add    $0xc,%esp
      49:	6a 64                	push   $0x64
      4b:	6a 00                	push   $0x0
      4d:	68 60 22 00 00       	push   $0x2260
      52:	e8 b9 0f 00 00       	call   1010 <memset>
  gets(buf, nbuf);
      57:	58                   	pop    %eax
      58:	5a                   	pop    %edx
      59:	6a 64                	push   $0x64
      5b:	68 60 22 00 00       	push   $0x2260
      60:	e8 0b 10 00 00       	call   1070 <gets>
  if(buf[0] == 0) // EOF
      65:	83 c4 10             	add    $0x10,%esp
      68:	80 3d 60 22 00 00 00 	cmpb   $0x0,0x2260
      6f:	0f 84 18 01 00 00    	je     18d <main+0x18d>
  int background_pid = -1;

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    // Remove newline character from the end of the command
    buf[strlen(buf)-1] = 0;
      75:	83 ec 0c             	sub    $0xc,%esp
      78:	68 60 22 00 00       	push   $0x2260
      7d:	e8 5e 0f 00 00       	call   fe0 <strlen>

    // add command to history
    add_history(buf);
      82:	c7 04 24 60 22 00 00 	movl   $0x2260,(%esp)
    buf[strlen(buf)-1] = 0;
      89:	c6 80 5f 22 00 00 00 	movb   $0x0,0x225f(%eax)
    add_history(buf);
      90:	e8 3b 0a 00 00       	call   ad0 <add_history>

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      95:	83 c4 10             	add    $0x10,%esp
      98:	80 3d 60 22 00 00 63 	cmpb   $0x63,0x2260
      9f:	75 0d                	jne    ae <main+0xae>
      a1:	80 3d 61 22 00 00 64 	cmpb   $0x64,0x2261
      a8:	0f 84 a0 00 00 00    	je     14e <main+0x14e>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }

    int is_background = buf[strlen(buf) - 1] == '&';
      ae:	83 ec 0c             	sub    $0xc,%esp
      b1:	68 60 22 00 00       	push   $0x2260
      b6:	e8 25 0f 00 00       	call   fe0 <strlen>
    if(is_background) {
      bb:	83 c4 10             	add    $0x10,%esp
      be:	80 b8 5f 22 00 00 26 	cmpb   $0x26,0x225f(%eax)
      c5:	74 47                	je     10e <main+0x10e>
int
fork1(void)
{
  int pid;

  pid = fork();
      c7:	e8 bf 10 00 00       	call   118b <fork>
  if(pid == -1)
      cc:	83 f8 ff             	cmp    $0xffffffff,%eax
      cf:	0f 84 bd 00 00 00    	je     192 <main+0x192>
    if(pid == 0) { // Child process
      d5:	85 c0                	test   %eax,%eax
      d7:	74 0f                	je     e8 <main+0xe8>
        wait();
      d9:	e8 bd 10 00 00       	call   119b <wait>
    if(background_pid > 0) {
      de:	e9 54 ff ff ff       	jmp    37 <main+0x37>
      e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      e7:	90                   	nop
      runcmd(parsecmd(buf));
      e8:	83 ec 0c             	sub    $0xc,%esp
      eb:	68 60 22 00 00       	push   $0x2260
      f0:	e8 2b 09 00 00       	call   a20 <parsecmd>
      f5:	89 04 24             	mov    %eax,(%esp)
      f8:	e8 33 0b 00 00       	call   c30 <runcmd>
      close(fd);
      fd:	83 ec 0c             	sub    $0xc,%esp
     100:	50                   	push   %eax
     101:	e8 b5 10 00 00       	call   11bb <close>
      break;
     106:	83 c4 10             	add    $0x10,%esp
     109:	e9 29 ff ff ff       	jmp    37 <main+0x37>
      buf[strlen(buf) - 1] = 0;
     10e:	83 ec 0c             	sub    $0xc,%esp
     111:	68 60 22 00 00       	push   $0x2260
     116:	e8 c5 0e 00 00       	call   fe0 <strlen>
     11b:	c6 80 5f 22 00 00 00 	movb   $0x0,0x225f(%eax)
  pid = fork();
     122:	e8 64 10 00 00       	call   118b <fork>
  if(pid == -1)
     127:	83 c4 10             	add    $0x10,%esp
     12a:	83 f8 ff             	cmp    $0xffffffff,%eax
     12d:	74 63                	je     192 <main+0x192>
    if(pid == 0) { // Child process
     12f:	85 c0                	test   %eax,%eax
     131:	74 b5                	je     e8 <main+0xe8>
    if(background_pid > 0) {
     133:	0f 8e fe fe ff ff    	jle    37 <main+0x37>
        waitpid(background_pid, &status, 0);
     139:	8d 55 f4             	lea    -0xc(%ebp),%edx
     13c:	51                   	push   %ecx
     13d:	6a 00                	push   $0x0
     13f:	52                   	push   %edx
     140:	50                   	push   %eax
     141:	e8 05 11 00 00       	call   124b <waitpid>
     146:	83 c4 10             	add    $0x10,%esp
     149:	e9 e9 fe ff ff       	jmp    37 <main+0x37>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     14e:	80 3d 62 22 00 00 20 	cmpb   $0x20,0x2262
     155:	0f 85 53 ff ff ff    	jne    ae <main+0xae>
      if(chdir(buf+3) < 0)
     15b:	83 ec 0c             	sub    $0xc,%esp
     15e:	68 63 22 00 00       	push   $0x2263
     163:	e8 9b 10 00 00       	call   1203 <chdir>
     168:	83 c4 10             	add    $0x10,%esp
     16b:	85 c0                	test   %eax,%eax
     16d:	0f 89 c4 fe ff ff    	jns    37 <main+0x37>
        printf(2, "cannot cd %s\n", buf+3);
     173:	50                   	push   %eax
     174:	68 63 22 00 00       	push   $0x2263
     179:	68 22 17 00 00       	push   $0x1722
     17e:	6a 02                	push   $0x2
     180:	e8 7b 11 00 00       	call   1300 <printf>
     185:	83 c4 10             	add    $0x10,%esp
     188:	e9 aa fe ff ff       	jmp    37 <main+0x37>
  exit();
     18d:	e8 01 10 00 00       	call   1193 <exit>
    panic("fork");
     192:	83 ec 0c             	sub    $0xc,%esp
     195:	68 2b 16 00 00       	push   $0x162b
     19a:	e8 41 00 00 00       	call   1e0 <panic>
     19f:	90                   	nop

000001a0 <getcmd>:
{
     1a0:	55                   	push   %ebp
     1a1:	89 e5                	mov    %esp,%ebp
     1a3:	56                   	push   %esi
     1a4:	53                   	push   %ebx
     1a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     1a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     1ab:	83 ec 08             	sub    $0x8,%esp
     1ae:	68 28 16 00 00       	push   $0x1628
     1b3:	6a 02                	push   $0x2
     1b5:	e8 46 11 00 00       	call   1300 <printf>
  memset(buf, 0, nbuf);
     1ba:	83 c4 0c             	add    $0xc,%esp
     1bd:	56                   	push   %esi
     1be:	6a 00                	push   $0x0
     1c0:	53                   	push   %ebx
     1c1:	e8 4a 0e 00 00       	call   1010 <memset>
  gets(buf, nbuf);
     1c6:	58                   	pop    %eax
     1c7:	5a                   	pop    %edx
     1c8:	56                   	push   %esi
     1c9:	53                   	push   %ebx
     1ca:	e8 a1 0e 00 00       	call   1070 <gets>
  if(buf[0] == 0) // EOF
     1cf:	83 c4 10             	add    $0x10,%esp
     1d2:	80 3b 01             	cmpb   $0x1,(%ebx)
     1d5:	19 c0                	sbb    %eax,%eax
}
     1d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1da:	5b                   	pop    %ebx
     1db:	5e                   	pop    %esi
     1dc:	5d                   	pop    %ebp
     1dd:	c3                   	ret
     1de:	66 90                	xchg   %ax,%ax

000001e0 <panic>:
{
     1e0:	55                   	push   %ebp
     1e1:	89 e5                	mov    %esp,%ebp
     1e3:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     1e6:	ff 75 08             	push   0x8(%ebp)
     1e9:	68 b2 16 00 00       	push   $0x16b2
     1ee:	6a 02                	push   $0x2
     1f0:	e8 0b 11 00 00       	call   1300 <printf>
  exit();
     1f5:	e8 99 0f 00 00       	call   1193 <exit>
     1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <fork1>:
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     206:	e8 80 0f 00 00       	call   118b <fork>
  if(pid == -1)
     20b:	83 f8 ff             	cmp    $0xffffffff,%eax
     20e:	74 02                	je     212 <fork1+0x12>
  return pid;
}
     210:	c9                   	leave
     211:	c3                   	ret
    panic("fork");
     212:	83 ec 0c             	sub    $0xc,%esp
     215:	68 2b 16 00 00       	push   $0x162b
     21a:	e8 c1 ff ff ff       	call   1e0 <panic>
     21f:	90                   	nop

00000220 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     220:	55                   	push   %ebp
     221:	89 e5                	mov    %esp,%ebp
     223:	53                   	push   %ebx
     224:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     227:	6a 54                	push   $0x54
     229:	e8 12 13 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     22e:	83 c4 0c             	add    $0xc,%esp
     231:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     233:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     235:	6a 00                	push   $0x0
     237:	50                   	push   %eax
     238:	e8 d3 0d 00 00       	call   1010 <memset>
  cmd->type = EXEC;
     23d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     243:	89 d8                	mov    %ebx,%eax
     245:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     248:	c9                   	leave
     249:	c3                   	ret
     24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     250:	55                   	push   %ebp
     251:	89 e5                	mov    %esp,%ebp
     253:	53                   	push   %ebx
     254:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     257:	6a 18                	push   $0x18
     259:	e8 e2 12 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     25e:	83 c4 0c             	add    $0xc,%esp
     261:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     263:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     265:	6a 00                	push   $0x0
     267:	50                   	push   %eax
     268:	e8 a3 0d 00 00       	call   1010 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     26d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     270:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     276:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     279:	8b 45 0c             	mov    0xc(%ebp),%eax
     27c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     27f:	8b 45 10             	mov    0x10(%ebp),%eax
     282:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     285:	8b 45 14             	mov    0x14(%ebp),%eax
     288:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     28b:	8b 45 18             	mov    0x18(%ebp),%eax
     28e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     291:	89 d8                	mov    %ebx,%eax
     293:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     296:	c9                   	leave
     297:	c3                   	ret
     298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     29f:	90                   	nop

000002a0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	53                   	push   %ebx
     2a4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2a7:	6a 0c                	push   $0xc
     2a9:	e8 92 12 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2ae:	83 c4 0c             	add    $0xc,%esp
     2b1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     2b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2b5:	6a 00                	push   $0x0
     2b7:	50                   	push   %eax
     2b8:	e8 53 0d 00 00       	call   1010 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     2bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     2c0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     2c6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     2c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     2cc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     2cf:	89 d8                	mov    %ebx,%eax
     2d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2d4:	c9                   	leave
     2d5:	c3                   	ret
     2d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     2e0:	55                   	push   %ebp
     2e1:	89 e5                	mov    %esp,%ebp
     2e3:	53                   	push   %ebx
     2e4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2e7:	6a 0c                	push   $0xc
     2e9:	e8 52 12 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2ee:	83 c4 0c             	add    $0xc,%esp
     2f1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     2f3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2f5:	6a 00                	push   $0x0
     2f7:	50                   	push   %eax
     2f8:	e8 13 0d 00 00       	call   1010 <memset>
  cmd->type = LIST;
  cmd->left = left;
     2fd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     300:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     306:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     309:	8b 45 0c             	mov    0xc(%ebp),%eax
     30c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     30f:	89 d8                	mov    %ebx,%eax
     311:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     314:	c9                   	leave
     315:	c3                   	ret
     316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     31d:	8d 76 00             	lea    0x0(%esi),%esi

00000320 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	53                   	push   %ebx
     324:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     327:	6a 08                	push   $0x8
     329:	e8 12 12 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     32e:	83 c4 0c             	add    $0xc,%esp
     331:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     333:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     335:	6a 00                	push   $0x0
     337:	50                   	push   %eax
     338:	e8 d3 0c 00 00       	call   1010 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     33d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     340:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     346:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     349:	89 d8                	mov    %ebx,%eax
     34b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     34e:	c9                   	leave
     34f:	c3                   	ret

00000350 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	57                   	push   %edi
     354:	56                   	push   %esi
     355:	53                   	push   %ebx
     356:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     359:	8b 45 08             	mov    0x8(%ebp),%eax
{
     35c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     35f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     362:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     364:	39 df                	cmp    %ebx,%edi
     366:	72 0f                	jb     377 <gettoken+0x27>
     368:	eb 25                	jmp    38f <gettoken+0x3f>
     36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     370:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     373:	39 fb                	cmp    %edi,%ebx
     375:	74 18                	je     38f <gettoken+0x3f>
     377:	0f be 07             	movsbl (%edi),%eax
     37a:	83 ec 08             	sub    $0x8,%esp
     37d:	50                   	push   %eax
     37e:	68 28 1e 00 00       	push   $0x1e28
     383:	e8 a8 0c 00 00       	call   1030 <strchr>
     388:	83 c4 10             	add    $0x10,%esp
     38b:	85 c0                	test   %eax,%eax
     38d:	75 e1                	jne    370 <gettoken+0x20>
  if(q)
     38f:	85 f6                	test   %esi,%esi
     391:	74 02                	je     395 <gettoken+0x45>
    *q = s;
     393:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     395:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     398:	3c 3c                	cmp    $0x3c,%al
     39a:	0f 8f d0 00 00 00    	jg     470 <gettoken+0x120>
     3a0:	3c 3a                	cmp    $0x3a,%al
     3a2:	0f 8f bc 00 00 00    	jg     464 <gettoken+0x114>
     3a8:	84 c0                	test   %al,%al
     3aa:	75 44                	jne    3f0 <gettoken+0xa0>
     3ac:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     3ae:	8b 4d 14             	mov    0x14(%ebp),%ecx
     3b1:	85 c9                	test   %ecx,%ecx
     3b3:	74 05                	je     3ba <gettoken+0x6a>
    *eq = s;
     3b5:	8b 45 14             	mov    0x14(%ebp),%eax
     3b8:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     3ba:	39 df                	cmp    %ebx,%edi
     3bc:	72 09                	jb     3c7 <gettoken+0x77>
     3be:	eb 1f                	jmp    3df <gettoken+0x8f>
    s++;
     3c0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     3c3:	39 fb                	cmp    %edi,%ebx
     3c5:	74 18                	je     3df <gettoken+0x8f>
     3c7:	0f be 07             	movsbl (%edi),%eax
     3ca:	83 ec 08             	sub    $0x8,%esp
     3cd:	50                   	push   %eax
     3ce:	68 28 1e 00 00       	push   $0x1e28
     3d3:	e8 58 0c 00 00       	call   1030 <strchr>
     3d8:	83 c4 10             	add    $0x10,%esp
     3db:	85 c0                	test   %eax,%eax
     3dd:	75 e1                	jne    3c0 <gettoken+0x70>
  *ps = s;
     3df:	8b 45 08             	mov    0x8(%ebp),%eax
     3e2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     3e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3e7:	89 f0                	mov    %esi,%eax
     3e9:	5b                   	pop    %ebx
     3ea:	5e                   	pop    %esi
     3eb:	5f                   	pop    %edi
     3ec:	5d                   	pop    %ebp
     3ed:	c3                   	ret
     3ee:	66 90                	xchg   %ax,%ax
  switch(*s){
     3f0:	79 66                	jns    458 <gettoken+0x108>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     3f2:	39 df                	cmp    %ebx,%edi
     3f4:	72 39                	jb     42f <gettoken+0xdf>
  if(eq)
     3f6:	8b 55 14             	mov    0x14(%ebp),%edx
     3f9:	85 d2                	test   %edx,%edx
     3fb:	0f 84 b3 00 00 00    	je     4b4 <gettoken+0x164>
    *eq = s;
     401:	8b 45 14             	mov    0x14(%ebp),%eax
     404:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     406:	e9 a9 00 00 00       	jmp    4b4 <gettoken+0x164>
     40b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     40f:	90                   	nop
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     410:	0f be 07             	movsbl (%edi),%eax
     413:	83 ec 08             	sub    $0x8,%esp
     416:	50                   	push   %eax
     417:	68 20 1e 00 00       	push   $0x1e20
     41c:	e8 0f 0c 00 00       	call   1030 <strchr>
     421:	83 c4 10             	add    $0x10,%esp
     424:	85 c0                	test   %eax,%eax
     426:	75 1f                	jne    447 <gettoken+0xf7>
      s++;
     428:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     42b:	39 fb                	cmp    %edi,%ebx
     42d:	74 77                	je     4a6 <gettoken+0x156>
     42f:	0f be 07             	movsbl (%edi),%eax
     432:	83 ec 08             	sub    $0x8,%esp
     435:	50                   	push   %eax
     436:	68 28 1e 00 00       	push   $0x1e28
     43b:	e8 f0 0b 00 00       	call   1030 <strchr>
     440:	83 c4 10             	add    $0x10,%esp
     443:	85 c0                	test   %eax,%eax
     445:	74 c9                	je     410 <gettoken+0xc0>
    ret = 'a';
     447:	be 61 00 00 00       	mov    $0x61,%esi
     44c:	e9 5d ff ff ff       	jmp    3ae <gettoken+0x5e>
     451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     458:	3c 26                	cmp    $0x26,%al
     45a:	74 08                	je     464 <gettoken+0x114>
     45c:	8d 48 d8             	lea    -0x28(%eax),%ecx
     45f:	80 f9 01             	cmp    $0x1,%cl
     462:	77 8e                	ja     3f2 <gettoken+0xa2>
  ret = *s;
     464:	0f be f0             	movsbl %al,%esi
    s++;
     467:	83 c7 01             	add    $0x1,%edi
    break;
     46a:	e9 3f ff ff ff       	jmp    3ae <gettoken+0x5e>
     46f:	90                   	nop
  switch(*s){
     470:	3c 3e                	cmp    $0x3e,%al
     472:	75 1c                	jne    490 <gettoken+0x140>
    if(*s == '>'){
     474:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     478:	74 1f                	je     499 <gettoken+0x149>
    s++;
     47a:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     47d:	be 3e 00 00 00       	mov    $0x3e,%esi
     482:	e9 27 ff ff ff       	jmp    3ae <gettoken+0x5e>
     487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     48e:	66 90                	xchg   %ax,%ax
  switch(*s){
     490:	3c 7c                	cmp    $0x7c,%al
     492:	74 d0                	je     464 <gettoken+0x114>
     494:	e9 59 ff ff ff       	jmp    3f2 <gettoken+0xa2>
      s++;
     499:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     49c:	be 2b 00 00 00       	mov    $0x2b,%esi
     4a1:	e9 08 ff ff ff       	jmp    3ae <gettoken+0x5e>
  if(eq)
     4a6:	8b 45 14             	mov    0x14(%ebp),%eax
     4a9:	85 c0                	test   %eax,%eax
     4ab:	74 05                	je     4b2 <gettoken+0x162>
    *eq = s;
     4ad:	8b 45 14             	mov    0x14(%ebp),%eax
     4b0:	89 18                	mov    %ebx,(%eax)
      s++;
     4b2:	89 df                	mov    %ebx,%edi
    ret = 'a';
     4b4:	be 61 00 00 00       	mov    $0x61,%esi
     4b9:	e9 21 ff ff ff       	jmp    3df <gettoken+0x8f>
     4be:	66 90                	xchg   %ax,%ax

000004c0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     4c0:	55                   	push   %ebp
     4c1:	89 e5                	mov    %esp,%ebp
     4c3:	57                   	push   %edi
     4c4:	56                   	push   %esi
     4c5:	53                   	push   %ebx
     4c6:	83 ec 0c             	sub    $0xc,%esp
     4c9:	8b 7d 08             	mov    0x8(%ebp),%edi
     4cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     4cf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     4d1:	39 f3                	cmp    %esi,%ebx
     4d3:	72 12                	jb     4e7 <peek+0x27>
     4d5:	eb 28                	jmp    4ff <peek+0x3f>
     4d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4de:	66 90                	xchg   %ax,%ax
    s++;
     4e0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     4e3:	39 de                	cmp    %ebx,%esi
     4e5:	74 18                	je     4ff <peek+0x3f>
     4e7:	0f be 03             	movsbl (%ebx),%eax
     4ea:	83 ec 08             	sub    $0x8,%esp
     4ed:	50                   	push   %eax
     4ee:	68 28 1e 00 00       	push   $0x1e28
     4f3:	e8 38 0b 00 00       	call   1030 <strchr>
     4f8:	83 c4 10             	add    $0x10,%esp
     4fb:	85 c0                	test   %eax,%eax
     4fd:	75 e1                	jne    4e0 <peek+0x20>
  *ps = s;
     4ff:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     501:	0f be 03             	movsbl (%ebx),%eax
     504:	31 d2                	xor    %edx,%edx
     506:	84 c0                	test   %al,%al
     508:	75 0e                	jne    518 <peek+0x58>
}
     50a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     50d:	89 d0                	mov    %edx,%eax
     50f:	5b                   	pop    %ebx
     510:	5e                   	pop    %esi
     511:	5f                   	pop    %edi
     512:	5d                   	pop    %ebp
     513:	c3                   	ret
     514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     518:	83 ec 08             	sub    $0x8,%esp
     51b:	50                   	push   %eax
     51c:	ff 75 10             	push   0x10(%ebp)
     51f:	e8 0c 0b 00 00       	call   1030 <strchr>
     524:	83 c4 10             	add    $0x10,%esp
     527:	31 d2                	xor    %edx,%edx
     529:	85 c0                	test   %eax,%eax
     52b:	0f 95 c2             	setne  %dl
}
     52e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     531:	5b                   	pop    %ebx
     532:	89 d0                	mov    %edx,%eax
     534:	5e                   	pop    %esi
     535:	5f                   	pop    %edi
     536:	5d                   	pop    %ebp
     537:	c3                   	ret
     538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     53f:	90                   	nop

00000540 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	57                   	push   %edi
     544:	56                   	push   %esi
     545:	53                   	push   %ebx
     546:	83 ec 2c             	sub    $0x2c,%esp
     549:	8b 75 0c             	mov    0xc(%ebp),%esi
     54c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     54f:	90                   	nop
     550:	83 ec 04             	sub    $0x4,%esp
     553:	68 4d 16 00 00       	push   $0x164d
     558:	53                   	push   %ebx
     559:	56                   	push   %esi
     55a:	e8 61 ff ff ff       	call   4c0 <peek>
     55f:	83 c4 10             	add    $0x10,%esp
     562:	85 c0                	test   %eax,%eax
     564:	0f 84 f6 00 00 00    	je     660 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     56a:	6a 00                	push   $0x0
     56c:	6a 00                	push   $0x0
     56e:	53                   	push   %ebx
     56f:	56                   	push   %esi
     570:	e8 db fd ff ff       	call   350 <gettoken>
     575:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     577:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     57a:	50                   	push   %eax
     57b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     57e:	50                   	push   %eax
     57f:	53                   	push   %ebx
     580:	56                   	push   %esi
     581:	e8 ca fd ff ff       	call   350 <gettoken>
     586:	83 c4 20             	add    $0x20,%esp
     589:	83 f8 61             	cmp    $0x61,%eax
     58c:	0f 85 d9 00 00 00    	jne    66b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     592:	83 ff 3c             	cmp    $0x3c,%edi
     595:	74 69                	je     600 <parseredirs+0xc0>
     597:	83 ff 3e             	cmp    $0x3e,%edi
     59a:	74 05                	je     5a1 <parseredirs+0x61>
     59c:	83 ff 2b             	cmp    $0x2b,%edi
     59f:	75 af                	jne    550 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     5a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     5a4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     5a7:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     5aa:	89 55 d0             	mov    %edx,-0x30(%ebp)
     5ad:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     5b0:	6a 18                	push   $0x18
     5b2:	e8 89 0f 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     5b7:	83 c4 0c             	add    $0xc,%esp
     5ba:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     5bc:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     5be:	6a 00                	push   $0x0
     5c0:	50                   	push   %eax
     5c1:	e8 4a 0a 00 00       	call   1010 <memset>
  cmd->type = REDIR;
     5c6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     5cc:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     5cf:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     5d2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     5d5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     5d8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     5db:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     5de:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     5e5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     5e8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     5ef:	89 7d 08             	mov    %edi,0x8(%ebp)
     5f2:	e9 59 ff ff ff       	jmp    550 <parseredirs+0x10>
     5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5fe:	66 90                	xchg   %ax,%ax
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     600:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     603:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     606:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     609:	89 55 d0             	mov    %edx,-0x30(%ebp)
     60c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     60f:	6a 18                	push   $0x18
     611:	e8 2a 0f 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     616:	83 c4 0c             	add    $0xc,%esp
     619:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     61b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     61d:	6a 00                	push   $0x0
     61f:	50                   	push   %eax
     620:	e8 eb 09 00 00       	call   1010 <memset>
  cmd->cmd = subcmd;
     625:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     628:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     62b:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     62e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     631:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     637:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     63a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     63d:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     640:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     643:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     64a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     651:	e9 fa fe ff ff       	jmp    550 <parseredirs+0x10>
     656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     65d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     660:	8b 45 08             	mov    0x8(%ebp),%eax
     663:	8d 65 f4             	lea    -0xc(%ebp),%esp
     666:	5b                   	pop    %ebx
     667:	5e                   	pop    %esi
     668:	5f                   	pop    %edi
     669:	5d                   	pop    %ebp
     66a:	c3                   	ret
      panic("missing file for redirection");
     66b:	83 ec 0c             	sub    $0xc,%esp
     66e:	68 30 16 00 00       	push   $0x1630
     673:	e8 68 fb ff ff       	call   1e0 <panic>
     678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     67f:	90                   	nop

00000680 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	57                   	push   %edi
     684:	56                   	push   %esi
     685:	53                   	push   %ebx
     686:	83 ec 30             	sub    $0x30,%esp
     689:	8b 5d 08             	mov    0x8(%ebp),%ebx
     68c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     68f:	68 50 16 00 00       	push   $0x1650
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
     696:	e8 25 fe ff ff       	call   4c0 <peek>
     69b:	83 c4 10             	add    $0x10,%esp
     69e:	85 c0                	test   %eax,%eax
     6a0:	0f 85 aa 00 00 00    	jne    750 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     6a6:	83 ec 0c             	sub    $0xc,%esp
     6a9:	89 c7                	mov    %eax,%edi
     6ab:	6a 54                	push   $0x54
     6ad:	e8 8e 0e 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6b2:	83 c4 0c             	add    $0xc,%esp
     6b5:	6a 54                	push   $0x54
     6b7:	6a 00                	push   $0x0
     6b9:	89 45 d0             	mov    %eax,-0x30(%ebp)
     6bc:	50                   	push   %eax
     6bd:	e8 4e 09 00 00       	call   1010 <memset>
  cmd->type = EXEC;
     6c2:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6c5:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     6c8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     6ce:	56                   	push   %esi
     6cf:	53                   	push   %ebx
     6d0:	50                   	push   %eax
     6d1:	e8 6a fe ff ff       	call   540 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     6d6:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     6d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     6dc:	eb 15                	jmp    6f3 <parseexec+0x73>
     6de:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     6e0:	83 ec 04             	sub    $0x4,%esp
     6e3:	56                   	push   %esi
     6e4:	53                   	push   %ebx
     6e5:	ff 75 d4             	push   -0x2c(%ebp)
     6e8:	e8 53 fe ff ff       	call   540 <parseredirs>
     6ed:	83 c4 10             	add    $0x10,%esp
     6f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     6f3:	83 ec 04             	sub    $0x4,%esp
     6f6:	68 67 16 00 00       	push   $0x1667
     6fb:	56                   	push   %esi
     6fc:	53                   	push   %ebx
     6fd:	e8 be fd ff ff       	call   4c0 <peek>
     702:	83 c4 10             	add    $0x10,%esp
     705:	85 c0                	test   %eax,%eax
     707:	75 5f                	jne    768 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     709:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     70c:	50                   	push   %eax
     70d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     710:	50                   	push   %eax
     711:	56                   	push   %esi
     712:	53                   	push   %ebx
     713:	e8 38 fc ff ff       	call   350 <gettoken>
     718:	83 c4 10             	add    $0x10,%esp
     71b:	85 c0                	test   %eax,%eax
     71d:	74 49                	je     768 <parseexec+0xe8>
    if(tok != 'a')
     71f:	83 f8 61             	cmp    $0x61,%eax
     722:	75 62                	jne    786 <parseexec+0x106>
    cmd->argv[argc] = q;
     724:	8b 45 e0             	mov    -0x20(%ebp),%eax
     727:	8b 55 d0             	mov    -0x30(%ebp),%edx
     72a:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     72e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     731:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     735:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     738:	83 ff 0a             	cmp    $0xa,%edi
     73b:	75 a3                	jne    6e0 <parseexec+0x60>
      panic("too many args");
     73d:	83 ec 0c             	sub    $0xc,%esp
     740:	68 59 16 00 00       	push   $0x1659
     745:	e8 96 fa ff ff       	call   1e0 <panic>
     74a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     750:	89 75 0c             	mov    %esi,0xc(%ebp)
     753:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     756:	8d 65 f4             	lea    -0xc(%ebp),%esp
     759:	5b                   	pop    %ebx
     75a:	5e                   	pop    %esi
     75b:	5f                   	pop    %edi
     75c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     75d:	e9 ae 01 00 00       	jmp    910 <parseblock>
     762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     768:	8b 45 d0             	mov    -0x30(%ebp),%eax
     76b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     772:	00 
  cmd->eargv[argc] = 0;
     773:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     77a:	00 
}
     77b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     77e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     781:	5b                   	pop    %ebx
     782:	5e                   	pop    %esi
     783:	5f                   	pop    %edi
     784:	5d                   	pop    %ebp
     785:	c3                   	ret
      panic("syntax");
     786:	83 ec 0c             	sub    $0xc,%esp
     789:	68 52 16 00 00       	push   $0x1652
     78e:	e8 4d fa ff ff       	call   1e0 <panic>
     793:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000007a0 <parsepipe>:
{
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	57                   	push   %edi
     7a4:	56                   	push   %esi
     7a5:	53                   	push   %ebx
     7a6:	83 ec 14             	sub    $0x14,%esp
     7a9:	8b 75 08             	mov    0x8(%ebp),%esi
     7ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     7af:	57                   	push   %edi
     7b0:	56                   	push   %esi
     7b1:	e8 ca fe ff ff       	call   680 <parseexec>
  if(peek(ps, es, "|")){
     7b6:	83 c4 0c             	add    $0xc,%esp
     7b9:	68 6c 16 00 00       	push   $0x166c
  cmd = parseexec(ps, es);
     7be:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     7c0:	57                   	push   %edi
     7c1:	56                   	push   %esi
     7c2:	e8 f9 fc ff ff       	call   4c0 <peek>
     7c7:	83 c4 10             	add    $0x10,%esp
     7ca:	85 c0                	test   %eax,%eax
     7cc:	75 12                	jne    7e0 <parsepipe+0x40>
}
     7ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7d1:	89 d8                	mov    %ebx,%eax
     7d3:	5b                   	pop    %ebx
     7d4:	5e                   	pop    %esi
     7d5:	5f                   	pop    %edi
     7d6:	5d                   	pop    %ebp
     7d7:	c3                   	ret
     7d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     7df:	90                   	nop
    gettoken(ps, es, 0, 0);
     7e0:	6a 00                	push   $0x0
     7e2:	6a 00                	push   $0x0
     7e4:	57                   	push   %edi
     7e5:	56                   	push   %esi
     7e6:	e8 65 fb ff ff       	call   350 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7eb:	58                   	pop    %eax
     7ec:	5a                   	pop    %edx
     7ed:	57                   	push   %edi
     7ee:	56                   	push   %esi
     7ef:	e8 ac ff ff ff       	call   7a0 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     7f4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7fb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     7fd:	e8 3e 0d 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     802:	83 c4 0c             	add    $0xc,%esp
     805:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     807:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     809:	6a 00                	push   $0x0
     80b:	50                   	push   %eax
     80c:	e8 ff 07 00 00       	call   1010 <memset>
  cmd->left = left;
     811:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     814:	83 c4 10             	add    $0x10,%esp
     817:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     819:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     81f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     821:	89 7e 08             	mov    %edi,0x8(%esi)
}
     824:	8d 65 f4             	lea    -0xc(%ebp),%esp
     827:	5b                   	pop    %ebx
     828:	5e                   	pop    %esi
     829:	5f                   	pop    %edi
     82a:	5d                   	pop    %ebp
     82b:	c3                   	ret
     82c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000830 <parseline>:
{
     830:	55                   	push   %ebp
     831:	89 e5                	mov    %esp,%ebp
     833:	57                   	push   %edi
     834:	56                   	push   %esi
     835:	53                   	push   %ebx
     836:	83 ec 24             	sub    $0x24,%esp
     839:	8b 75 08             	mov    0x8(%ebp),%esi
     83c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     83f:	57                   	push   %edi
     840:	56                   	push   %esi
     841:	e8 5a ff ff ff       	call   7a0 <parsepipe>
  while(peek(ps, es, "&")){
     846:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     849:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     84b:	eb 3b                	jmp    888 <parseline+0x58>
     84d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     850:	6a 00                	push   $0x0
     852:	6a 00                	push   $0x0
     854:	57                   	push   %edi
     855:	56                   	push   %esi
     856:	e8 f5 fa ff ff       	call   350 <gettoken>
  cmd = malloc(sizeof(*cmd));
     85b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     862:	e8 d9 0c 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     867:	83 c4 0c             	add    $0xc,%esp
     86a:	6a 08                	push   $0x8
     86c:	6a 00                	push   $0x0
     86e:	50                   	push   %eax
     86f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     872:	e8 99 07 00 00       	call   1010 <memset>
  cmd->type = BACK;
     877:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     87a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     87d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     883:	89 5a 04             	mov    %ebx,0x4(%edx)
     886:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     888:	83 ec 04             	sub    $0x4,%esp
     88b:	68 6e 16 00 00       	push   $0x166e
     890:	57                   	push   %edi
     891:	56                   	push   %esi
     892:	e8 29 fc ff ff       	call   4c0 <peek>
     897:	83 c4 10             	add    $0x10,%esp
     89a:	85 c0                	test   %eax,%eax
     89c:	75 b2                	jne    850 <parseline+0x20>
  if(peek(ps, es, ";")){
     89e:	83 ec 04             	sub    $0x4,%esp
     8a1:	68 6a 16 00 00       	push   $0x166a
     8a6:	57                   	push   %edi
     8a7:	56                   	push   %esi
     8a8:	e8 13 fc ff ff       	call   4c0 <peek>
     8ad:	83 c4 10             	add    $0x10,%esp
     8b0:	85 c0                	test   %eax,%eax
     8b2:	75 0c                	jne    8c0 <parseline+0x90>
}
     8b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8b7:	89 d8                	mov    %ebx,%eax
     8b9:	5b                   	pop    %ebx
     8ba:	5e                   	pop    %esi
     8bb:	5f                   	pop    %edi
     8bc:	5d                   	pop    %ebp
     8bd:	c3                   	ret
     8be:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     8c0:	6a 00                	push   $0x0
     8c2:	6a 00                	push   $0x0
     8c4:	57                   	push   %edi
     8c5:	56                   	push   %esi
     8c6:	e8 85 fa ff ff       	call   350 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8cb:	58                   	pop    %eax
     8cc:	5a                   	pop    %edx
     8cd:	57                   	push   %edi
     8ce:	56                   	push   %esi
     8cf:	e8 5c ff ff ff       	call   830 <parseline>
  cmd = malloc(sizeof(*cmd));
     8d4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     8db:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     8dd:	e8 5e 0c 00 00       	call   1540 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8e2:	83 c4 0c             	add    $0xc,%esp
     8e5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     8e7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     8e9:	6a 00                	push   $0x0
     8eb:	50                   	push   %eax
     8ec:	e8 1f 07 00 00       	call   1010 <memset>
  cmd->left = left;
     8f1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     8f4:	83 c4 10             	add    $0x10,%esp
     8f7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     8f9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     8ff:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     901:	89 7e 08             	mov    %edi,0x8(%esi)
}
     904:	8d 65 f4             	lea    -0xc(%ebp),%esp
     907:	5b                   	pop    %ebx
     908:	5e                   	pop    %esi
     909:	5f                   	pop    %edi
     90a:	5d                   	pop    %ebp
     90b:	c3                   	ret
     90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000910 <parseblock>:
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 10             	sub    $0x10,%esp
     919:	8b 5d 08             	mov    0x8(%ebp),%ebx
     91c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     91f:	68 50 16 00 00       	push   $0x1650
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	e8 95 fb ff ff       	call   4c0 <peek>
     92b:	83 c4 10             	add    $0x10,%esp
     92e:	85 c0                	test   %eax,%eax
     930:	74 4a                	je     97c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     932:	6a 00                	push   $0x0
     934:	6a 00                	push   $0x0
     936:	56                   	push   %esi
     937:	53                   	push   %ebx
     938:	e8 13 fa ff ff       	call   350 <gettoken>
  cmd = parseline(ps, es);
     93d:	58                   	pop    %eax
     93e:	5a                   	pop    %edx
     93f:	56                   	push   %esi
     940:	53                   	push   %ebx
     941:	e8 ea fe ff ff       	call   830 <parseline>
  if(!peek(ps, es, ")"))
     946:	83 c4 0c             	add    $0xc,%esp
     949:	68 8c 16 00 00       	push   $0x168c
  cmd = parseline(ps, es);
     94e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     950:	56                   	push   %esi
     951:	53                   	push   %ebx
     952:	e8 69 fb ff ff       	call   4c0 <peek>
     957:	83 c4 10             	add    $0x10,%esp
     95a:	85 c0                	test   %eax,%eax
     95c:	74 2b                	je     989 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     95e:	6a 00                	push   $0x0
     960:	6a 00                	push   $0x0
     962:	56                   	push   %esi
     963:	53                   	push   %ebx
     964:	e8 e7 f9 ff ff       	call   350 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     969:	83 c4 0c             	add    $0xc,%esp
     96c:	56                   	push   %esi
     96d:	53                   	push   %ebx
     96e:	57                   	push   %edi
     96f:	e8 cc fb ff ff       	call   540 <parseredirs>
}
     974:	8d 65 f4             	lea    -0xc(%ebp),%esp
     977:	5b                   	pop    %ebx
     978:	5e                   	pop    %esi
     979:	5f                   	pop    %edi
     97a:	5d                   	pop    %ebp
     97b:	c3                   	ret
    panic("parseblock");
     97c:	83 ec 0c             	sub    $0xc,%esp
     97f:	68 70 16 00 00       	push   $0x1670
     984:	e8 57 f8 ff ff       	call   1e0 <panic>
    panic("syntax - missing )");
     989:	83 ec 0c             	sub    $0xc,%esp
     98c:	68 7b 16 00 00       	push   $0x167b
     991:	e8 4a f8 ff ff       	call   1e0 <panic>
     996:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     99d:	8d 76 00             	lea    0x0(%esi),%esi

000009a0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	53                   	push   %ebx
     9a4:	83 ec 04             	sub    $0x4,%esp
     9a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9aa:	85 db                	test   %ebx,%ebx
     9ac:	74 6a                	je     a18 <nulterminate+0x78>
    return 0;

  switch(cmd->type){
     9ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     9b1:	77 24                	ja     9d7 <nulterminate+0x37>
     9b3:	8b 03                	mov    (%ebx),%eax
     9b5:	ff 24 85 30 17 00 00 	jmp    *0x1730(,%eax,4)
     9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	ff 73 04             	push   0x4(%ebx)
     9c6:	e8 d5 ff ff ff       	call   9a0 <nulterminate>
    nulterminate(lcmd->right);
     9cb:	58                   	pop    %eax
     9cc:	ff 73 08             	push   0x8(%ebx)
     9cf:	e8 cc ff ff ff       	call   9a0 <nulterminate>
    break;
     9d4:	83 c4 10             	add    $0x10,%esp
    return 0;
     9d7:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9dc:	c9                   	leave
     9dd:	c3                   	ret
     9de:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     9e0:	83 ec 0c             	sub    $0xc,%esp
     9e3:	ff 73 04             	push   0x4(%ebx)
     9e6:	e8 b5 ff ff ff       	call   9a0 <nulterminate>
    break;
     9eb:	83 c4 10             	add    $0x10,%esp
     9ee:	eb e7                	jmp    9d7 <nulterminate+0x37>
    for(i=0; ecmd->argv[i]; i++)
     9f0:	8b 4b 04             	mov    0x4(%ebx),%ecx
     9f3:	8d 43 08             	lea    0x8(%ebx),%eax
     9f6:	85 c9                	test   %ecx,%ecx
     9f8:	74 dd                	je     9d7 <nulterminate+0x37>
     9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a00:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     a03:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     a06:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a09:	8b 50 fc             	mov    -0x4(%eax),%edx
     a0c:	85 d2                	test   %edx,%edx
     a0e:	75 f0                	jne    a00 <nulterminate+0x60>
     a10:	eb c5                	jmp    9d7 <nulterminate+0x37>
     a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return 0;
     a18:	31 c0                	xor    %eax,%eax
     a1a:	eb bd                	jmp    9d9 <nulterminate+0x39>
     a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a20 <parsecmd>:
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	57                   	push   %edi
     a24:	56                   	push   %esi
  cmd = parseline(&s, es);
     a25:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     a28:	53                   	push   %ebx
     a29:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     a2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a2f:	53                   	push   %ebx
     a30:	e8 ab 05 00 00       	call   fe0 <strlen>
  cmd = parseline(&s, es);
     a35:	59                   	pop    %ecx
     a36:	5e                   	pop    %esi
  es = s + strlen(s);
     a37:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a39:	53                   	push   %ebx
     a3a:	57                   	push   %edi
     a3b:	e8 f0 fd ff ff       	call   830 <parseline>
  peek(&s, es, "");
     a40:	83 c4 0c             	add    $0xc,%esp
     a43:	68 f5 16 00 00       	push   $0x16f5
  cmd = parseline(&s, es);
     a48:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a4a:	53                   	push   %ebx
     a4b:	57                   	push   %edi
     a4c:	e8 6f fa ff ff       	call   4c0 <peek>
  if(s != es){
     a51:	8b 45 08             	mov    0x8(%ebp),%eax
     a54:	83 c4 10             	add    $0x10,%esp
     a57:	39 d8                	cmp    %ebx,%eax
     a59:	75 13                	jne    a6e <parsecmd+0x4e>
  nulterminate(cmd);
     a5b:	83 ec 0c             	sub    $0xc,%esp
     a5e:	56                   	push   %esi
     a5f:	e8 3c ff ff ff       	call   9a0 <nulterminate>
}
     a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a67:	89 f0                	mov    %esi,%eax
     a69:	5b                   	pop    %ebx
     a6a:	5e                   	pop    %esi
     a6b:	5f                   	pop    %edi
     a6c:	5d                   	pop    %ebp
     a6d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     a6e:	52                   	push   %edx
     a6f:	50                   	push   %eax
     a70:	68 8e 16 00 00       	push   $0x168e
     a75:	6a 02                	push   $0x2
     a77:	e8 84 08 00 00       	call   1300 <printf>
    panic("syntax");
     a7c:	c7 04 24 52 16 00 00 	movl   $0x1652,(%esp)
     a83:	e8 58 f7 ff ff       	call   1e0 <panic>
     a88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a8f:	90                   	nop

00000a90 <check_history>:

int check_history(char *cmd) {
     a90:	55                   	push   %ebp
  if (cmd[0] == 'h' && cmd[1] == 'i' && cmd[2] == 's' && cmd[3] == 't' && cmd[4] == ' ') {
    return 1;
  }
  return 0;
     a91:	31 d2                	xor    %edx,%edx
int check_history(char *cmd) {
     a93:	89 e5                	mov    %esp,%ebp
     a95:	8b 45 08             	mov    0x8(%ebp),%eax
  if (cmd[0] == 'h' && cmd[1] == 'i' && cmd[2] == 's' && cmd[3] == 't' && cmd[4] == ' ') {
     a98:	80 38 68             	cmpb   $0x68,(%eax)
     a9b:	74 0b                	je     aa8 <check_history+0x18>
}
     a9d:	89 d0                	mov    %edx,%eax
     a9f:	5d                   	pop    %ebp
     aa0:	c3                   	ret
     aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if (cmd[0] == 'h' && cmd[1] == 'i' && cmd[2] == 's' && cmd[3] == 't' && cmd[4] == ' ') {
     aa8:	80 78 01 69          	cmpb   $0x69,0x1(%eax)
     aac:	75 ef                	jne    a9d <check_history+0xd>
     aae:	80 78 02 73          	cmpb   $0x73,0x2(%eax)
     ab2:	75 e9                	jne    a9d <check_history+0xd>
     ab4:	80 78 03 74          	cmpb   $0x74,0x3(%eax)
     ab8:	75 e3                	jne    a9d <check_history+0xd>
     aba:	31 d2                	xor    %edx,%edx
     abc:	80 78 04 20          	cmpb   $0x20,0x4(%eax)
     ac0:	0f 94 c2             	sete   %dl
     ac3:	eb d8                	jmp    a9d <check_history+0xd>
     ac5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ad0 <add_history>:

void add_history(const char *cmd) {
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	57                   	push   %edi
     ad4:	56                   	push   %esi
     ad5:	53                   	push   %ebx
     ad6:	83 ec 0c             	sub    $0xc,%esp
     ad9:	8b 75 08             	mov    0x8(%ebp),%esi
  if (cmd[0] == 'h' && cmd[1] == 'i' && cmd[2] == 's' && cmd[3] == 't' && cmd[4] == ' ') {
     adc:	80 3e 68             	cmpb   $0x68,(%esi)
     adf:	74 5f                	je     b40 <add_history+0x70>
  // ignore history commands
  if (check_history(cmd)) return;

  for (int i = total_cmds; i > 0; i--) {
     ae1:	8b 3d 40 1e 00 00    	mov    0x1e40,%edi
     ae7:	85 ff                	test   %edi,%edi
     ae9:	7e 26                	jle    b11 <add_history+0x41>
     aeb:	6b df 64             	imul   $0x64,%edi,%ebx
     aee:	81 c3 60 1e 00 00    	add    $0x1e60,%ebx
     af4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    strcpy(history[i], history[i - 1]);
     af8:	83 ec 08             	sub    $0x8,%esp
     afb:	89 d8                	mov    %ebx,%eax
     afd:	83 eb 64             	sub    $0x64,%ebx
     b00:	83 ef 01             	sub    $0x1,%edi
     b03:	53                   	push   %ebx
     b04:	50                   	push   %eax
     b05:	e8 46 04 00 00       	call   f50 <strcpy>
  for (int i = total_cmds; i > 0; i--) {
     b0a:	83 c4 10             	add    $0x10,%esp
     b0d:	85 ff                	test   %edi,%edi
     b0f:	75 e7                	jne    af8 <add_history+0x28>
  }
  strcpy(history[0], cmd);
     b11:	83 ec 08             	sub    $0x8,%esp
     b14:	56                   	push   %esi
     b15:	68 60 1e 00 00       	push   $0x1e60
     b1a:	e8 31 04 00 00       	call   f50 <strcpy>
  if (total_cmds < MAX_HISTORY - 1) total_cmds++;
     b1f:	a1 40 1e 00 00       	mov    0x1e40,%eax
     b24:	83 c4 10             	add    $0x10,%esp
     b27:	83 f8 08             	cmp    $0x8,%eax
     b2a:	7f 08                	jg     b34 <add_history+0x64>
     b2c:	83 c0 01             	add    $0x1,%eax
     b2f:	a3 40 1e 00 00       	mov    %eax,0x1e40
}
     b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b37:	5b                   	pop    %ebx
     b38:	5e                   	pop    %esi
     b39:	5f                   	pop    %edi
     b3a:	5d                   	pop    %ebp
     b3b:	c3                   	ret
     b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (cmd[0] == 'h' && cmd[1] == 'i' && cmd[2] == 's' && cmd[3] == 't' && cmd[4] == ' ') {
     b40:	80 7e 01 69          	cmpb   $0x69,0x1(%esi)
     b44:	75 9b                	jne    ae1 <add_history+0x11>
     b46:	80 7e 02 73          	cmpb   $0x73,0x2(%esi)
     b4a:	75 95                	jne    ae1 <add_history+0x11>
     b4c:	80 7e 03 74          	cmpb   $0x74,0x3(%esi)
     b50:	75 8f                	jne    ae1 <add_history+0x11>
     b52:	80 7e 04 20          	cmpb   $0x20,0x4(%esi)
     b56:	75 89                	jne    ae1 <add_history+0x11>
     b58:	eb da                	jmp    b34 <add_history+0x64>
     b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000b60 <print_history>:

void print_history() {
    for(int n = 0; n < total_cmds; n++) {
     b60:	a1 40 1e 00 00       	mov    0x1e40,%eax
     b65:	85 c0                	test   %eax,%eax
     b67:	7e 37                	jle    ba0 <print_history+0x40>
void print_history() {
     b69:	55                   	push   %ebp
     b6a:	89 e5                	mov    %esp,%ebp
     b6c:	56                   	push   %esi
     b6d:	be 60 1e 00 00       	mov    $0x1e60,%esi
     b72:	53                   	push   %ebx
    for(int n = 0; n < total_cmds; n++) {
     b73:	31 db                	xor    %ebx,%ebx
     b75:	8d 76 00             	lea    0x0(%esi),%esi
        printf(2, "Previous command %d: %s\n", n + 1, history[n]);
     b78:	83 c3 01             	add    $0x1,%ebx
     b7b:	56                   	push   %esi
    for(int n = 0; n < total_cmds; n++) {
     b7c:	83 c6 64             	add    $0x64,%esi
        printf(2, "Previous command %d: %s\n", n + 1, history[n]);
     b7f:	53                   	push   %ebx
     b80:	68 9d 16 00 00       	push   $0x169d
     b85:	6a 02                	push   $0x2
     b87:	e8 74 07 00 00       	call   1300 <printf>
    for(int n = 0; n < total_cmds; n++) {
     b8c:	83 c4 10             	add    $0x10,%esp
     b8f:	3b 1d 40 1e 00 00    	cmp    0x1e40,%ebx
     b95:	7c e1                	jl     b78 <print_history+0x18>
    }
}
     b97:	8d 65 f8             	lea    -0x8(%ebp),%esp
     b9a:	5b                   	pop    %ebx
     b9b:	5e                   	pop    %esi
     b9c:	5d                   	pop    %ebp
     b9d:	c3                   	ret
     b9e:	66 90                	xchg   %ax,%ax
     ba0:	c3                   	ret
     ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ba8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     baf:	90                   	nop

00000bb0 <execute_history>:

void execute_history(int n) {
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	53                   	push   %ebx
     bb4:	83 ec 04             	sub    $0x4,%esp
     bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(n > 0 && n <= total_cmds) {
     bba:	85 db                	test   %ebx,%ebx
     bbc:	7e 08                	jle    bc6 <execute_history+0x16>
     bbe:	39 1d 40 1e 00 00    	cmp    %ebx,0x1e40
     bc4:	7d 1a                	jge    be0 <execute_history+0x30>
        if(fork1() == 0) {
          runcmd(parsecmd(history[n - 1]));
        }
        wait();
    } else {
        printf(2, "No such command in history.");
     bc6:	83 ec 08             	sub    $0x8,%esp
     bc9:	68 b6 16 00 00       	push   $0x16b6
     bce:	6a 02                	push   $0x2
     bd0:	e8 2b 07 00 00       	call   1300 <printf>
    }
}
     bd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
        printf(2, "No such command in history.");
     bd8:	83 c4 10             	add    $0x10,%esp
}
     bdb:	c9                   	leave
     bdc:	c3                   	ret
     bdd:	8d 76 00             	lea    0x0(%esi),%esi
  pid = fork();
     be0:	e8 a6 05 00 00       	call   118b <fork>
  if(pid == -1)
     be5:	83 f8 ff             	cmp    $0xffffffff,%eax
     be8:	74 38                	je     c22 <execute_history+0x72>
        if(fork1() == 0) {
     bea:	85 c0                	test   %eax,%eax
     bec:	74 12                	je     c00 <execute_history+0x50>
}
     bee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bf1:	c9                   	leave
        wait();
     bf2:	e9 a4 05 00 00       	jmp    119b <wait>
     bf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bfe:	66 90                	xchg   %ax,%ax
          runcmd(parsecmd(history[n - 1]));
     c00:	83 eb 01             	sub    $0x1,%ebx
     c03:	83 ec 0c             	sub    $0xc,%esp
     c06:	6b db 64             	imul   $0x64,%ebx,%ebx
     c09:	81 c3 60 1e 00 00    	add    $0x1e60,%ebx
     c0f:	53                   	push   %ebx
     c10:	e8 0b fe ff ff       	call   a20 <parsecmd>
     c15:	89 04 24             	mov    %eax,(%esp)
     c18:	e8 13 00 00 00       	call   c30 <runcmd>
     c1d:	83 c4 10             	add    $0x10,%esp
     c20:	eb cc                	jmp    bee <execute_history+0x3e>
    panic("fork");
     c22:	83 ec 0c             	sub    $0xc,%esp
     c25:	68 2b 16 00 00       	push   $0x162b
     c2a:	e8 b1 f5 ff ff       	call   1e0 <panic>
     c2f:	90                   	nop

00000c30 <runcmd>:
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	56                   	push   %esi
     c34:	53                   	push   %ebx
     c35:	83 ec 10             	sub    $0x10,%esp
     c38:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     c3b:	85 db                	test   %ebx,%ebx
     c3d:	74 28                	je     c67 <runcmd+0x37>
  switch(cmd->type){
     c3f:	83 3b 05             	cmpl   $0x5,(%ebx)
     c42:	0f 87 92 01 00 00    	ja     dda <runcmd+0x1aa>
     c48:	8b 03                	mov    (%ebx),%eax
     c4a:	ff 24 85 48 17 00 00 	jmp    *0x1748(,%eax,4)
  pid = fork();
     c51:	e8 35 05 00 00       	call   118b <fork>
  if(pid == -1)
     c56:	83 f8 ff             	cmp    $0xffffffff,%eax
     c59:	0f 84 e3 02 00 00    	je     f42 <runcmd+0x312>
    if(proc == 0) { // backgrounded child
     c5f:	85 c0                	test   %eax,%eax
     c61:	0f 84 1c 01 00 00    	je     d83 <runcmd+0x153>
    exit();
     c67:	e8 27 05 00 00       	call   1193 <exit>
    if(ecmd->argv[0] == 0)
     c6c:	8b 43 04             	mov    0x4(%ebx),%eax
     c6f:	85 c0                	test   %eax,%eax
     c71:	74 f4                	je     c67 <runcmd+0x37>
    if(strcmp(ecmd->argv[0], "hist") == 0) {
     c73:	56                   	push   %esi
     c74:	56                   	push   %esi
     c75:	68 d9 16 00 00       	push   $0x16d9
     c7a:	50                   	push   %eax
     c7b:	e8 00 03 00 00       	call   f80 <strcmp>
     c80:	83 c4 10             	add    $0x10,%esp
     c83:	85 c0                	test   %eax,%eax
     c85:	0f 85 ff 01 00 00    	jne    e8a <runcmd+0x25a>
      if (ecmd->argv[1] && strcmp(ecmd->argv[1], "print") == 0) {
     c8b:	8b 43 08             	mov    0x8(%ebx),%eax
     c8e:	85 c0                	test   %eax,%eax
     c90:	74 d5                	je     c67 <runcmd+0x37>
     c92:	51                   	push   %ecx
     c93:	51                   	push   %ecx
     c94:	68 de 16 00 00       	push   $0x16de
     c99:	50                   	push   %eax
     c9a:	e8 e1 02 00 00       	call   f80 <strcmp>
     c9f:	83 c4 10             	add    $0x10,%esp
     ca2:	89 c6                	mov    %eax,%esi
     ca4:	85 c0                	test   %eax,%eax
     ca6:	0f 84 45 02 00 00    	je     ef1 <runcmd+0x2c1>
      } else if (ecmd->argv[1] && atoi(ecmd->argv[1]) != 0) {
     cac:	8b 43 08             	mov    0x8(%ebx),%eax
     caf:	85 c0                	test   %eax,%eax
     cb1:	74 b4                	je     c67 <runcmd+0x37>
     cb3:	83 ec 0c             	sub    $0xc,%esp
     cb6:	50                   	push   %eax
     cb7:	e8 64 04 00 00       	call   1120 <atoi>
     cbc:	83 c4 10             	add    $0x10,%esp
     cbf:	85 c0                	test   %eax,%eax
     cc1:	0f 85 60 02 00 00    	jne    f27 <runcmd+0x2f7>
      } else if (ecmd->argv[1] && strcmp(ecmd->argv[1], "0") == 0) {
     cc7:	8b 43 08             	mov    0x8(%ebx),%eax
     cca:	85 c0                	test   %eax,%eax
     ccc:	74 99                	je     c67 <runcmd+0x37>
     cce:	52                   	push   %edx
     ccf:	52                   	push   %edx
     cd0:	68 e4 16 00 00       	push   $0x16e4
     cd5:	50                   	push   %eax
     cd6:	e8 a5 02 00 00       	call   f80 <strcmp>
     cdb:	83 c4 10             	add    $0x10,%esp
     cde:	85 c0                	test   %eax,%eax
     ce0:	75 85                	jne    c67 <runcmd+0x37>
        printf(2, "No such command in history.");
     ce2:	50                   	push   %eax
     ce3:	50                   	push   %eax
     ce4:	68 b6 16 00 00       	push   $0x16b6
     ce9:	6a 02                	push   $0x2
     ceb:	e8 10 06 00 00       	call   1300 <printf>
}
     cf0:	83 c4 10             	add    $0x10,%esp
     cf3:	e9 6f ff ff ff       	jmp    c67 <runcmd+0x37>
    if (pipe(p) < 0)
     cf8:	83 ec 0c             	sub    $0xc,%esp
     cfb:	8d 45 f0             	lea    -0x10(%ebp),%eax
     cfe:	50                   	push   %eax
     cff:	e8 9f 04 00 00       	call   11a3 <pipe>
     d04:	83 c4 10             	add    $0x10,%esp
     d07:	85 c0                	test   %eax,%eax
     d09:	0f 88 04 01 00 00    	js     e13 <runcmd+0x1e3>
  pid = fork();
     d0f:	e8 77 04 00 00       	call   118b <fork>
  if(pid == -1)
     d14:	83 f8 ff             	cmp    $0xffffffff,%eax
     d17:	0f 84 25 02 00 00    	je     f42 <runcmd+0x312>
    if (fork1() == 0) { // First command
     d1d:	85 c0                	test   %eax,%eax
     d1f:	0f 84 fb 00 00 00    	je     e20 <runcmd+0x1f0>
  pid = fork();
     d25:	e8 61 04 00 00       	call   118b <fork>
  if(pid == -1)
     d2a:	83 f8 ff             	cmp    $0xffffffff,%eax
     d2d:	0f 84 0f 02 00 00    	je     f42 <runcmd+0x312>
    if (fork1() == 0) { // Second command
     d33:	85 c0                	test   %eax,%eax
     d35:	0f 85 90 01 00 00    	jne    ecb <runcmd+0x29b>
        close(p[1]);
     d3b:	83 ec 0c             	sub    $0xc,%esp
     d3e:	ff 75 f4             	push   -0xc(%ebp)
     d41:	e8 75 04 00 00       	call   11bb <close>
        close(0);
     d46:	31 d2                	xor    %edx,%edx
     d48:	89 14 24             	mov    %edx,(%esp)
     d4b:	e8 6b 04 00 00       	call   11bb <close>
        dup(p[0]);
     d50:	59                   	pop    %ecx
     d51:	ff 75 f0             	push   -0x10(%ebp)
     d54:	e8 b2 04 00 00       	call   120b <dup>
        close(p[0]);
     d59:	5e                   	pop    %esi
     d5a:	ff 75 f0             	push   -0x10(%ebp)
     d5d:	e8 59 04 00 00       	call   11bb <close>
        runcmd(pcmd->right);
     d62:	58                   	pop    %eax
     d63:	ff 73 08             	push   0x8(%ebx)
     d66:	e8 c5 fe ff ff       	call   c30 <runcmd>
    if(lcmd->left)
     d6b:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
     d6f:	74 7b                	je     dec <runcmd+0x1bc>
  pid = fork();
     d71:	e8 15 04 00 00       	call   118b <fork>
  if(pid == -1)
     d76:	83 f8 ff             	cmp    $0xffffffff,%eax
     d79:	0f 84 c3 01 00 00    	je     f42 <runcmd+0x312>
      if(fork1() == 0)
     d7f:	85 c0                	test   %eax,%eax
     d81:	75 64                	jne    de7 <runcmd+0x1b7>
        runcmd(bcmd->cmd); 
     d83:	83 ec 0c             	sub    $0xc,%esp
     d86:	ff 73 04             	push   0x4(%ebx)
     d89:	e8 a2 fe ff ff       	call   c30 <runcmd>
    if (rcmd->mode == O_RDONLY){
     d8e:	8b 43 10             	mov    0x10(%ebx),%eax
     d91:	85 c0                	test   %eax,%eax
     d93:	0f 84 c3 00 00 00    	je     e5c <runcmd+0x22c>
    else if ((rcmd->mode & O_WRONLY) != 0){
     d99:	a8 01                	test   $0x1,%al
     d9b:	0f 85 11 01 00 00    	jne    eb2 <runcmd+0x282>
    if(fd != rcmd->fd) // Check if the file descriptor returned by open is not what we expect
     da1:	8b 43 14             	mov    0x14(%ebx),%eax
     da4:	39 f0                	cmp    %esi,%eax
     da6:	74 db                	je     d83 <runcmd+0x153>
      close(rcmd->fd);
     da8:	83 ec 0c             	sub    $0xc,%esp
     dab:	50                   	push   %eax
     dac:	e8 0a 04 00 00       	call   11bb <close>
      int new_fd = dup(fd); // Use dup to duplicate it to the right file descriptor number
     db1:	89 34 24             	mov    %esi,(%esp)
     db4:	e8 52 04 00 00       	call   120b <dup>
      if(new_fd != rcmd-> fd)
     db9:	83 c4 10             	add    $0x10,%esp
     dbc:	39 43 14             	cmp    %eax,0x14(%ebx)
     dbf:	0f 84 f5 00 00 00    	je     eba <runcmd+0x28a>
        printf(2, "dup %s failed\n", rcmd->file);
     dc5:	50                   	push   %eax
     dc6:	ff 73 08             	push   0x8(%ebx)
     dc9:	68 06 17 00 00       	push   $0x1706
     dce:	6a 02                	push   $0x2
     dd0:	e8 2b 05 00 00       	call   1300 <printf>
        exit();
     dd5:	e8 b9 03 00 00       	call   1193 <exit>
    panic("runcmd");
     dda:	83 ec 0c             	sub    $0xc,%esp
     ddd:	68 d2 16 00 00       	push   $0x16d2
     de2:	e8 f9 f3 ff ff       	call   1e0 <panic>
      wait();
     de7:	e8 af 03 00 00       	call   119b <wait>
    if(lcmd->right)
     dec:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
     df0:	0f 84 71 fe ff ff    	je     c67 <runcmd+0x37>
  pid = fork();
     df6:	e8 90 03 00 00       	call   118b <fork>
  if(pid == -1)
     dfb:	83 f8 ff             	cmp    $0xffffffff,%eax
     dfe:	0f 84 3e 01 00 00    	je     f42 <runcmd+0x312>
      if(fork1() == 0)
     e04:	85 c0                	test   %eax,%eax
     e06:	75 4a                	jne    e52 <runcmd+0x222>
        runcmd(lcmd->right);
     e08:	83 ec 0c             	sub    $0xc,%esp
     e0b:	ff 73 08             	push   0x8(%ebx)
     e0e:	e8 1d fe ff ff       	call   c30 <runcmd>
        panic("pipe");
     e13:	83 ec 0c             	sub    $0xc,%esp
     e16:	68 15 17 00 00       	push   $0x1715
     e1b:	e8 c0 f3 ff ff       	call   1e0 <panic>
        close(p[0]);
     e20:	83 ec 0c             	sub    $0xc,%esp
     e23:	ff 75 f0             	push   -0x10(%ebp)
     e26:	e8 90 03 00 00       	call   11bb <close>
        close(1);
     e2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e32:	e8 84 03 00 00       	call   11bb <close>
        dup(p[1]);
     e37:	58                   	pop    %eax
     e38:	ff 75 f4             	push   -0xc(%ebp)
     e3b:	e8 cb 03 00 00       	call   120b <dup>
        close(p[1]);
     e40:	58                   	pop    %eax
     e41:	ff 75 f4             	push   -0xc(%ebp)
     e44:	e8 72 03 00 00       	call   11bb <close>
        runcmd(pcmd->left);
     e49:	58                   	pop    %eax
     e4a:	ff 73 04             	push   0x4(%ebx)
     e4d:	e8 de fd ff ff       	call   c30 <runcmd>
      wait();
     e52:	e8 44 03 00 00       	call   119b <wait>
     e57:	e9 0b fe ff ff       	jmp    c67 <runcmd+0x37>
        fd = open(rcmd->file, rcmd->mode);
     e5c:	56                   	push   %esi
     e5d:	56                   	push   %esi
     e5e:	6a 00                	push   $0x0
        fd = open(rcmd->file, rcmd->mode | O_RDWR);  // Open the file for writing, and create it if it doesn't exist.
     e60:	ff 73 08             	push   0x8(%ebx)
     e63:	e8 6b 03 00 00       	call   11d3 <open>
        if (fd < 0){
     e68:	83 c4 10             	add    $0x10,%esp
        fd = open(rcmd->file, rcmd->mode | O_RDWR);  // Open the file for writing, and create it if it doesn't exist.
     e6b:	89 c6                	mov    %eax,%esi
        if (fd < 0){
     e6d:	85 c0                	test   %eax,%eax
     e6f:	0f 89 2c ff ff ff    	jns    da1 <runcmd+0x171>
            printf(2, "open %s failed\n", rcmd->file);
     e75:	52                   	push   %edx
     e76:	ff 73 08             	push   0x8(%ebx)
     e79:	68 f6 16 00 00       	push   $0x16f6
     e7e:	6a 02                	push   $0x2
     e80:	e8 7b 04 00 00       	call   1300 <printf>
            exit();
     e85:	e8 09 03 00 00       	call   1193 <exit>
    exec(ecmd->argv[0], ecmd->argv);
     e8a:	50                   	push   %eax
     e8b:	50                   	push   %eax
     e8c:	8d 43 04             	lea    0x4(%ebx),%eax
     e8f:	50                   	push   %eax
     e90:	ff 73 04             	push   0x4(%ebx)
     e93:	e8 33 03 00 00       	call   11cb <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     e98:	83 c4 0c             	add    $0xc,%esp
     e9b:	ff 73 04             	push   0x4(%ebx)
     e9e:	68 e6 16 00 00       	push   $0x16e6
     ea3:	6a 02                	push   $0x2
     ea5:	e8 56 04 00 00       	call   1300 <printf>
    break;
     eaa:	83 c4 10             	add    $0x10,%esp
     ead:	e9 b5 fd ff ff       	jmp    c67 <runcmd+0x37>
        fd = open(rcmd->file, rcmd->mode | O_RDWR);  // Open the file for writing, and create it if it doesn't exist.
     eb2:	83 c8 02             	or     $0x2,%eax
     eb5:	51                   	push   %ecx
     eb6:	51                   	push   %ecx
     eb7:	50                   	push   %eax
     eb8:	eb a6                	jmp    e60 <runcmd+0x230>
      close(fd);
     eba:	83 ec 0c             	sub    $0xc,%esp
     ebd:	56                   	push   %esi
     ebe:	e8 f8 02 00 00       	call   11bb <close>
     ec3:	83 c4 10             	add    $0x10,%esp
    runcmd(rcmd->cmd);
     ec6:	e9 b8 fe ff ff       	jmp    d83 <runcmd+0x153>
    close(p[0]);
     ecb:	83 ec 0c             	sub    $0xc,%esp
     ece:	ff 75 f0             	push   -0x10(%ebp)
     ed1:	e8 e5 02 00 00       	call   11bb <close>
    close(p[1]);
     ed6:	58                   	pop    %eax
     ed7:	ff 75 f4             	push   -0xc(%ebp)
     eda:	e8 dc 02 00 00       	call   11bb <close>
    wait();
     edf:	e8 b7 02 00 00       	call   119b <wait>
    wait();
     ee4:	e8 b2 02 00 00       	call   119b <wait>
    break;
     ee9:	83 c4 10             	add    $0x10,%esp
     eec:	e9 76 fd ff ff       	jmp    c67 <runcmd+0x37>
    for(int n = 0; n < total_cmds; n++) {
     ef1:	83 3d 40 1e 00 00 00 	cmpl   $0x0,0x1e40
     ef8:	0f 8e 69 fd ff ff    	jle    c67 <runcmd+0x37>
     efe:	bb 60 1e 00 00       	mov    $0x1e60,%ebx
        printf(2, "Previous command %d: %s\n", n + 1, history[n]);
     f03:	83 c6 01             	add    $0x1,%esi
     f06:	53                   	push   %ebx
    for(int n = 0; n < total_cmds; n++) {
     f07:	83 c3 64             	add    $0x64,%ebx
        printf(2, "Previous command %d: %s\n", n + 1, history[n]);
     f0a:	56                   	push   %esi
     f0b:	68 9d 16 00 00       	push   $0x169d
     f10:	6a 02                	push   $0x2
     f12:	e8 e9 03 00 00       	call   1300 <printf>
    for(int n = 0; n < total_cmds; n++) {
     f17:	83 c4 10             	add    $0x10,%esp
     f1a:	3b 35 40 1e 00 00    	cmp    0x1e40,%esi
     f20:	7c e1                	jl     f03 <runcmd+0x2d3>
     f22:	e9 40 fd ff ff       	jmp    c67 <runcmd+0x37>
        execute_history(atoi(ecmd->argv[1]));
     f27:	83 ec 0c             	sub    $0xc,%esp
     f2a:	ff 73 08             	push   0x8(%ebx)
     f2d:	e8 ee 01 00 00       	call   1120 <atoi>
     f32:	89 04 24             	mov    %eax,(%esp)
     f35:	e8 76 fc ff ff       	call   bb0 <execute_history>
     f3a:	83 c4 10             	add    $0x10,%esp
     f3d:	e9 25 fd ff ff       	jmp    c67 <runcmd+0x37>
    panic("fork");
     f42:	83 ec 0c             	sub    $0xc,%esp
     f45:	68 2b 16 00 00       	push   $0x162b
     f4a:	e8 91 f2 ff ff       	call   1e0 <panic>
     f4f:	90                   	nop

00000f50 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     f50:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     f51:	31 c0                	xor    %eax,%eax
{
     f53:	89 e5                	mov    %esp,%ebp
     f55:	53                   	push   %ebx
     f56:	8b 4d 08             	mov    0x8(%ebp),%ecx
     f59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     f60:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     f64:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     f67:	83 c0 01             	add    $0x1,%eax
     f6a:	84 d2                	test   %dl,%dl
     f6c:	75 f2                	jne    f60 <strcpy+0x10>
    ;
  return os;
}
     f6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     f71:	89 c8                	mov    %ecx,%eax
     f73:	c9                   	leave
     f74:	c3                   	ret
     f75:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f80 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	53                   	push   %ebx
     f84:	8b 55 08             	mov    0x8(%ebp),%edx
     f87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     f8a:	0f b6 02             	movzbl (%edx),%eax
     f8d:	84 c0                	test   %al,%al
     f8f:	75 17                	jne    fa8 <strcmp+0x28>
     f91:	eb 3a                	jmp    fcd <strcmp+0x4d>
     f93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f97:	90                   	nop
     f98:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     f9c:	83 c2 01             	add    $0x1,%edx
     f9f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     fa2:	84 c0                	test   %al,%al
     fa4:	74 1a                	je     fc0 <strcmp+0x40>
    p++, q++;
     fa6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
     fa8:	0f b6 19             	movzbl (%ecx),%ebx
     fab:	38 c3                	cmp    %al,%bl
     fad:	74 e9                	je     f98 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     faf:	29 d8                	sub    %ebx,%eax
}
     fb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fb4:	c9                   	leave
     fb5:	c3                   	ret
     fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     fc0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     fc4:	31 c0                	xor    %eax,%eax
     fc6:	29 d8                	sub    %ebx,%eax
}
     fc8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     fcb:	c9                   	leave
     fcc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     fcd:	0f b6 19             	movzbl (%ecx),%ebx
     fd0:	31 c0                	xor    %eax,%eax
     fd2:	eb db                	jmp    faf <strcmp+0x2f>
     fd4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fdf:	90                   	nop

00000fe0 <strlen>:

uint
strlen(char *s)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     fe6:	80 3a 00             	cmpb   $0x0,(%edx)
     fe9:	74 15                	je     1000 <strlen+0x20>
     feb:	31 c0                	xor    %eax,%eax
     fed:	8d 76 00             	lea    0x0(%esi),%esi
     ff0:	83 c0 01             	add    $0x1,%eax
     ff3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     ff7:	89 c1                	mov    %eax,%ecx
     ff9:	75 f5                	jne    ff0 <strlen+0x10>
    ;
  return n;
}
     ffb:	89 c8                	mov    %ecx,%eax
     ffd:	5d                   	pop    %ebp
     ffe:	c3                   	ret
     fff:	90                   	nop
  for(n = 0; s[n]; n++)
    1000:	31 c9                	xor    %ecx,%ecx
}
    1002:	5d                   	pop    %ebp
    1003:	89 c8                	mov    %ecx,%eax
    1005:	c3                   	ret
    1006:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    100d:	8d 76 00             	lea    0x0(%esi),%esi

00001010 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	57                   	push   %edi
    1014:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1017:	8b 4d 10             	mov    0x10(%ebp),%ecx
    101a:	8b 45 0c             	mov    0xc(%ebp),%eax
    101d:	89 d7                	mov    %edx,%edi
    101f:	fc                   	cld
    1020:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1022:	8b 7d fc             	mov    -0x4(%ebp),%edi
    1025:	89 d0                	mov    %edx,%eax
    1027:	c9                   	leave
    1028:	c3                   	ret
    1029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001030 <strchr>:

char*
strchr(const char *s, char c)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	8b 45 08             	mov    0x8(%ebp),%eax
    1036:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    103a:	0f b6 10             	movzbl (%eax),%edx
    103d:	84 d2                	test   %dl,%dl
    103f:	75 12                	jne    1053 <strchr+0x23>
    1041:	eb 1d                	jmp    1060 <strchr+0x30>
    1043:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1047:	90                   	nop
    1048:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    104c:	83 c0 01             	add    $0x1,%eax
    104f:	84 d2                	test   %dl,%dl
    1051:	74 0d                	je     1060 <strchr+0x30>
    if(*s == c)
    1053:	38 d1                	cmp    %dl,%cl
    1055:	75 f1                	jne    1048 <strchr+0x18>
      return (char*)s;
  return 0;
}
    1057:	5d                   	pop    %ebp
    1058:	c3                   	ret
    1059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    1060:	31 c0                	xor    %eax,%eax
}
    1062:	5d                   	pop    %ebp
    1063:	c3                   	ret
    1064:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    106b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    106f:	90                   	nop

00001070 <gets>:

char*
gets(char *buf, int max)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	57                   	push   %edi
    1074:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    1075:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
    1078:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    1079:	31 db                	xor    %ebx,%ebx
{
    107b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    107e:	eb 27                	jmp    10a7 <gets+0x37>
    cc = read(0, &c, 1);
    1080:	83 ec 04             	sub    $0x4,%esp
    1083:	6a 01                	push   $0x1
    1085:	56                   	push   %esi
    1086:	6a 00                	push   $0x0
    1088:	e8 1e 01 00 00       	call   11ab <read>
    if(cc < 1)
    108d:	83 c4 10             	add    $0x10,%esp
    1090:	85 c0                	test   %eax,%eax
    1092:	7e 1d                	jle    10b1 <gets+0x41>
      break;
    buf[i++] = c;
    1094:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1098:	8b 55 08             	mov    0x8(%ebp),%edx
    109b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    109f:	3c 0a                	cmp    $0xa,%al
    10a1:	74 10                	je     10b3 <gets+0x43>
    10a3:	3c 0d                	cmp    $0xd,%al
    10a5:	74 0c                	je     10b3 <gets+0x43>
  for(i=0; i+1 < max; ){
    10a7:	89 df                	mov    %ebx,%edi
    10a9:	83 c3 01             	add    $0x1,%ebx
    10ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    10af:	7c cf                	jl     1080 <gets+0x10>
    10b1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
    10b3:	8b 45 08             	mov    0x8(%ebp),%eax
    10b6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
    10ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
    10bd:	5b                   	pop    %ebx
    10be:	5e                   	pop    %esi
    10bf:	5f                   	pop    %edi
    10c0:	5d                   	pop    %ebp
    10c1:	c3                   	ret
    10c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000010d0 <stat>:

int
stat(char *n, struct stat *st)
{
    10d0:	55                   	push   %ebp
    10d1:	89 e5                	mov    %esp,%ebp
    10d3:	56                   	push   %esi
    10d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    10d5:	83 ec 08             	sub    $0x8,%esp
    10d8:	6a 00                	push   $0x0
    10da:	ff 75 08             	push   0x8(%ebp)
    10dd:	e8 f1 00 00 00       	call   11d3 <open>
  if(fd < 0)
    10e2:	83 c4 10             	add    $0x10,%esp
    10e5:	85 c0                	test   %eax,%eax
    10e7:	78 27                	js     1110 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    10e9:	83 ec 08             	sub    $0x8,%esp
    10ec:	ff 75 0c             	push   0xc(%ebp)
    10ef:	89 c3                	mov    %eax,%ebx
    10f1:	50                   	push   %eax
    10f2:	e8 f4 00 00 00       	call   11eb <fstat>
  close(fd);
    10f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    10fa:	89 c6                	mov    %eax,%esi
  close(fd);
    10fc:	e8 ba 00 00 00       	call   11bb <close>
  return r;
    1101:	83 c4 10             	add    $0x10,%esp
}
    1104:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1107:	89 f0                	mov    %esi,%eax
    1109:	5b                   	pop    %ebx
    110a:	5e                   	pop    %esi
    110b:	5d                   	pop    %ebp
    110c:	c3                   	ret
    110d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1110:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1115:	eb ed                	jmp    1104 <stat+0x34>
    1117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    111e:	66 90                	xchg   %ax,%ax

00001120 <atoi>:

int
atoi(const char *s)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	53                   	push   %ebx
    1124:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1127:	0f be 02             	movsbl (%edx),%eax
    112a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    112d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1130:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1135:	77 1e                	ja     1155 <atoi+0x35>
    1137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    113e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    1140:	83 c2 01             	add    $0x1,%edx
    1143:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1146:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    114a:	0f be 02             	movsbl (%edx),%eax
    114d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1150:	80 fb 09             	cmp    $0x9,%bl
    1153:	76 eb                	jbe    1140 <atoi+0x20>
  return n;
}
    1155:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1158:	89 c8                	mov    %ecx,%eax
    115a:	c9                   	leave
    115b:	c3                   	ret
    115c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001160 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1160:	55                   	push   %ebp
    1161:	89 e5                	mov    %esp,%ebp
    1163:	57                   	push   %edi
    1164:	56                   	push   %esi
    1165:	8b 45 10             	mov    0x10(%ebp),%eax
    1168:	8b 55 08             	mov    0x8(%ebp),%edx
    116b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    116e:	85 c0                	test   %eax,%eax
    1170:	7e 13                	jle    1185 <memmove+0x25>
    1172:	01 d0                	add    %edx,%eax
  dst = vdst;
    1174:	89 d7                	mov    %edx,%edi
    1176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    1180:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1181:	39 f8                	cmp    %edi,%eax
    1183:	75 fb                	jne    1180 <memmove+0x20>
  return vdst;
}
    1185:	5e                   	pop    %esi
    1186:	89 d0                	mov    %edx,%eax
    1188:	5f                   	pop    %edi
    1189:	5d                   	pop    %ebp
    118a:	c3                   	ret

0000118b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    118b:	b8 01 00 00 00       	mov    $0x1,%eax
    1190:	cd 40                	int    $0x40
    1192:	c3                   	ret

00001193 <exit>:
SYSCALL(exit)
    1193:	b8 02 00 00 00       	mov    $0x2,%eax
    1198:	cd 40                	int    $0x40
    119a:	c3                   	ret

0000119b <wait>:
SYSCALL(wait)
    119b:	b8 03 00 00 00       	mov    $0x3,%eax
    11a0:	cd 40                	int    $0x40
    11a2:	c3                   	ret

000011a3 <pipe>:
SYSCALL(pipe)
    11a3:	b8 04 00 00 00       	mov    $0x4,%eax
    11a8:	cd 40                	int    $0x40
    11aa:	c3                   	ret

000011ab <read>:
SYSCALL(read)
    11ab:	b8 05 00 00 00       	mov    $0x5,%eax
    11b0:	cd 40                	int    $0x40
    11b2:	c3                   	ret

000011b3 <write>:
SYSCALL(write)
    11b3:	b8 10 00 00 00       	mov    $0x10,%eax
    11b8:	cd 40                	int    $0x40
    11ba:	c3                   	ret

000011bb <close>:
SYSCALL(close)
    11bb:	b8 15 00 00 00       	mov    $0x15,%eax
    11c0:	cd 40                	int    $0x40
    11c2:	c3                   	ret

000011c3 <kill>:
SYSCALL(kill)
    11c3:	b8 06 00 00 00       	mov    $0x6,%eax
    11c8:	cd 40                	int    $0x40
    11ca:	c3                   	ret

000011cb <exec>:
SYSCALL(exec)
    11cb:	b8 07 00 00 00       	mov    $0x7,%eax
    11d0:	cd 40                	int    $0x40
    11d2:	c3                   	ret

000011d3 <open>:
SYSCALL(open)
    11d3:	b8 0f 00 00 00       	mov    $0xf,%eax
    11d8:	cd 40                	int    $0x40
    11da:	c3                   	ret

000011db <mknod>:
SYSCALL(mknod)
    11db:	b8 11 00 00 00       	mov    $0x11,%eax
    11e0:	cd 40                	int    $0x40
    11e2:	c3                   	ret

000011e3 <unlink>:
SYSCALL(unlink)
    11e3:	b8 12 00 00 00       	mov    $0x12,%eax
    11e8:	cd 40                	int    $0x40
    11ea:	c3                   	ret

000011eb <fstat>:
SYSCALL(fstat)
    11eb:	b8 08 00 00 00       	mov    $0x8,%eax
    11f0:	cd 40                	int    $0x40
    11f2:	c3                   	ret

000011f3 <link>:
SYSCALL(link)
    11f3:	b8 13 00 00 00       	mov    $0x13,%eax
    11f8:	cd 40                	int    $0x40
    11fa:	c3                   	ret

000011fb <mkdir>:
SYSCALL(mkdir)
    11fb:	b8 14 00 00 00       	mov    $0x14,%eax
    1200:	cd 40                	int    $0x40
    1202:	c3                   	ret

00001203 <chdir>:
SYSCALL(chdir)
    1203:	b8 09 00 00 00       	mov    $0x9,%eax
    1208:	cd 40                	int    $0x40
    120a:	c3                   	ret

0000120b <dup>:
SYSCALL(dup)
    120b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1210:	cd 40                	int    $0x40
    1212:	c3                   	ret

00001213 <getpid>:
SYSCALL(getpid)
    1213:	b8 0b 00 00 00       	mov    $0xb,%eax
    1218:	cd 40                	int    $0x40
    121a:	c3                   	ret

0000121b <sbrk>:
SYSCALL(sbrk)
    121b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1220:	cd 40                	int    $0x40
    1222:	c3                   	ret

00001223 <sleep>:
SYSCALL(sleep)
    1223:	b8 0d 00 00 00       	mov    $0xd,%eax
    1228:	cd 40                	int    $0x40
    122a:	c3                   	ret

0000122b <uptime>:
SYSCALL(uptime)
    122b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1230:	cd 40                	int    $0x40
    1232:	c3                   	ret

00001233 <shutdown>:
SYSCALL(shutdown)
    1233:	b8 16 00 00 00       	mov    $0x16,%eax
    1238:	cd 40                	int    $0x40
    123a:	c3                   	ret

0000123b <cps>:
SYSCALL(cps)
    123b:	b8 17 00 00 00       	mov    $0x17,%eax
    1240:	cd 40                	int    $0x40
    1242:	c3                   	ret

00001243 <chpr>:
SYSCALL(chpr)
    1243:	b8 18 00 00 00       	mov    $0x18,%eax
    1248:	cd 40                	int    $0x40
    124a:	c3                   	ret

0000124b <waitpid>:
SYSCALL(waitpid)
    124b:	b8 19 00 00 00       	mov    $0x19,%eax
    1250:	cd 40                	int    $0x40
    1252:	c3                   	ret
    1253:	66 90                	xchg   %ax,%ax
    1255:	66 90                	xchg   %ax,%ax
    1257:	66 90                	xchg   %ax,%ax
    1259:	66 90                	xchg   %ax,%ax
    125b:	66 90                	xchg   %ax,%ax
    125d:	66 90                	xchg   %ax,%ax
    125f:	90                   	nop

00001260 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	56                   	push   %esi
    1265:	53                   	push   %ebx
    1266:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1268:	89 d1                	mov    %edx,%ecx
{
    126a:	83 ec 3c             	sub    $0x3c,%esp
    126d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    1270:	85 d2                	test   %edx,%edx
    1272:	0f 89 80 00 00 00    	jns    12f8 <printint+0x98>
    1278:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    127c:	74 7a                	je     12f8 <printint+0x98>
    x = -xx;
    127e:	f7 d9                	neg    %ecx
    neg = 1;
    1280:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    1285:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    1288:	31 f6                	xor    %esi,%esi
    128a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1290:	89 c8                	mov    %ecx,%eax
    1292:	31 d2                	xor    %edx,%edx
    1294:	89 f7                	mov    %esi,%edi
    1296:	f7 f3                	div    %ebx
    1298:	8d 76 01             	lea    0x1(%esi),%esi
    129b:	0f b6 92 c0 17 00 00 	movzbl 0x17c0(%edx),%edx
    12a2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    12a6:	89 ca                	mov    %ecx,%edx
    12a8:	89 c1                	mov    %eax,%ecx
    12aa:	39 da                	cmp    %ebx,%edx
    12ac:	73 e2                	jae    1290 <printint+0x30>
  if(neg)
    12ae:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    12b1:	85 c0                	test   %eax,%eax
    12b3:	74 07                	je     12bc <printint+0x5c>
    buf[i++] = '-';
    12b5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
    12ba:	89 f7                	mov    %esi,%edi
    12bc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    12bf:	8b 75 c0             	mov    -0x40(%ebp),%esi
    12c2:	01 df                	add    %ebx,%edi
    12c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
    12c8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    12cb:	83 ec 04             	sub    $0x4,%esp
    12ce:	88 45 d7             	mov    %al,-0x29(%ebp)
    12d1:	8d 45 d7             	lea    -0x29(%ebp),%eax
    12d4:	6a 01                	push   $0x1
    12d6:	50                   	push   %eax
    12d7:	56                   	push   %esi
    12d8:	e8 d6 fe ff ff       	call   11b3 <write>
  while(--i >= 0)
    12dd:	89 f8                	mov    %edi,%eax
    12df:	83 c4 10             	add    $0x10,%esp
    12e2:	83 ef 01             	sub    $0x1,%edi
    12e5:	39 d8                	cmp    %ebx,%eax
    12e7:	75 df                	jne    12c8 <printint+0x68>
}
    12e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12ec:	5b                   	pop    %ebx
    12ed:	5e                   	pop    %esi
    12ee:	5f                   	pop    %edi
    12ef:	5d                   	pop    %ebp
    12f0:	c3                   	ret
    12f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    12f8:	31 c0                	xor    %eax,%eax
    12fa:	eb 89                	jmp    1285 <printint+0x25>
    12fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001300 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	57                   	push   %edi
    1304:	56                   	push   %esi
    1305:	53                   	push   %ebx
    1306:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1309:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    130c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    130f:	0f b6 1e             	movzbl (%esi),%ebx
    1312:	83 c6 01             	add    $0x1,%esi
    1315:	84 db                	test   %bl,%bl
    1317:	74 67                	je     1380 <printf+0x80>
    1319:	8d 4d 10             	lea    0x10(%ebp),%ecx
    131c:	31 d2                	xor    %edx,%edx
    131e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1321:	eb 34                	jmp    1357 <printf+0x57>
    1323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1327:	90                   	nop
    1328:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    132b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1330:	83 f8 25             	cmp    $0x25,%eax
    1333:	74 18                	je     134d <printf+0x4d>
  write(fd, &c, 1);
    1335:	83 ec 04             	sub    $0x4,%esp
    1338:	8d 45 e7             	lea    -0x19(%ebp),%eax
    133b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    133e:	6a 01                	push   $0x1
    1340:	50                   	push   %eax
    1341:	57                   	push   %edi
    1342:	e8 6c fe ff ff       	call   11b3 <write>
    1347:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    134a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    134d:	0f b6 1e             	movzbl (%esi),%ebx
    1350:	83 c6 01             	add    $0x1,%esi
    1353:	84 db                	test   %bl,%bl
    1355:	74 29                	je     1380 <printf+0x80>
    c = fmt[i] & 0xff;
    1357:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    135a:	85 d2                	test   %edx,%edx
    135c:	74 ca                	je     1328 <printf+0x28>
      }
    } else if(state == '%'){
    135e:	83 fa 25             	cmp    $0x25,%edx
    1361:	75 ea                	jne    134d <printf+0x4d>
      if(c == 'd'){
    1363:	83 f8 25             	cmp    $0x25,%eax
    1366:	0f 84 24 01 00 00    	je     1490 <printf+0x190>
    136c:	83 e8 63             	sub    $0x63,%eax
    136f:	83 f8 15             	cmp    $0x15,%eax
    1372:	77 1c                	ja     1390 <printf+0x90>
    1374:	ff 24 85 68 17 00 00 	jmp    *0x1768(,%eax,4)
    137b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    137f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1380:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1383:	5b                   	pop    %ebx
    1384:	5e                   	pop    %esi
    1385:	5f                   	pop    %edi
    1386:	5d                   	pop    %ebp
    1387:	c3                   	ret
    1388:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    138f:	90                   	nop
  write(fd, &c, 1);
    1390:	83 ec 04             	sub    $0x4,%esp
    1393:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1396:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    139a:	6a 01                	push   $0x1
    139c:	52                   	push   %edx
    139d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    13a0:	57                   	push   %edi
    13a1:	e8 0d fe ff ff       	call   11b3 <write>
    13a6:	83 c4 0c             	add    $0xc,%esp
    13a9:	88 5d e7             	mov    %bl,-0x19(%ebp)
    13ac:	6a 01                	push   $0x1
    13ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    13b1:	52                   	push   %edx
    13b2:	57                   	push   %edi
    13b3:	e8 fb fd ff ff       	call   11b3 <write>
        putc(fd, c);
    13b8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    13bb:	31 d2                	xor    %edx,%edx
    13bd:	eb 8e                	jmp    134d <printf+0x4d>
    13bf:	90                   	nop
        printint(fd, *ap, 16, 0);
    13c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    13c3:	83 ec 0c             	sub    $0xc,%esp
    13c6:	b9 10 00 00 00       	mov    $0x10,%ecx
    13cb:	8b 13                	mov    (%ebx),%edx
    13cd:	6a 00                	push   $0x0
    13cf:	89 f8                	mov    %edi,%eax
        ap++;
    13d1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    13d4:	e8 87 fe ff ff       	call   1260 <printint>
        ap++;
    13d9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    13dc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    13df:	31 d2                	xor    %edx,%edx
    13e1:	e9 67 ff ff ff       	jmp    134d <printf+0x4d>
    13e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13ed:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
    13f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
    13f3:	8b 18                	mov    (%eax),%ebx
        ap++;
    13f5:	83 c0 04             	add    $0x4,%eax
    13f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    13fb:	85 db                	test   %ebx,%ebx
    13fd:	0f 84 9d 00 00 00    	je     14a0 <printf+0x1a0>
        while(*s != 0){
    1403:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1406:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1408:	84 c0                	test   %al,%al
    140a:	0f 84 3d ff ff ff    	je     134d <printf+0x4d>
    1410:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1413:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    1416:	89 de                	mov    %ebx,%esi
    1418:	89 d3                	mov    %edx,%ebx
    141a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1420:	83 ec 04             	sub    $0x4,%esp
    1423:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1426:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1429:	6a 01                	push   $0x1
    142b:	53                   	push   %ebx
    142c:	57                   	push   %edi
    142d:	e8 81 fd ff ff       	call   11b3 <write>
        while(*s != 0){
    1432:	0f b6 06             	movzbl (%esi),%eax
    1435:	83 c4 10             	add    $0x10,%esp
    1438:	84 c0                	test   %al,%al
    143a:	75 e4                	jne    1420 <printf+0x120>
      state = 0;
    143c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    143f:	31 d2                	xor    %edx,%edx
    1441:	e9 07 ff ff ff       	jmp    134d <printf+0x4d>
    1446:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    144d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1450:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1453:	83 ec 0c             	sub    $0xc,%esp
    1456:	b9 0a 00 00 00       	mov    $0xa,%ecx
    145b:	8b 13                	mov    (%ebx),%edx
    145d:	6a 01                	push   $0x1
    145f:	e9 6b ff ff ff       	jmp    13cf <printf+0xcf>
    1464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1468:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    146b:	83 ec 04             	sub    $0x4,%esp
    146e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    1471:	8b 03                	mov    (%ebx),%eax
        ap++;
    1473:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    1476:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1479:	6a 01                	push   $0x1
    147b:	52                   	push   %edx
    147c:	57                   	push   %edi
    147d:	e8 31 fd ff ff       	call   11b3 <write>
        ap++;
    1482:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1485:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1488:	31 d2                	xor    %edx,%edx
    148a:	e9 be fe ff ff       	jmp    134d <printf+0x4d>
    148f:	90                   	nop
  write(fd, &c, 1);
    1490:	83 ec 04             	sub    $0x4,%esp
    1493:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1496:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1499:	6a 01                	push   $0x1
    149b:	e9 11 ff ff ff       	jmp    13b1 <printf+0xb1>
    14a0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    14a5:	bb 60 17 00 00       	mov    $0x1760,%ebx
    14aa:	e9 61 ff ff ff       	jmp    1410 <printf+0x110>
    14af:	90                   	nop

000014b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    14b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14b1:	a1 c4 22 00 00       	mov    0x22c4,%eax
{
    14b6:	89 e5                	mov    %esp,%ebp
    14b8:	57                   	push   %edi
    14b9:	56                   	push   %esi
    14ba:	53                   	push   %ebx
    14bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    14be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    14c8:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14ca:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    14cc:	39 ca                	cmp    %ecx,%edx
    14ce:	73 30                	jae    1500 <free+0x50>
    14d0:	39 c1                	cmp    %eax,%ecx
    14d2:	72 04                	jb     14d8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    14d4:	39 c2                	cmp    %eax,%edx
    14d6:	72 f0                	jb     14c8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    14d8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    14db:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    14de:	39 f8                	cmp    %edi,%eax
    14e0:	74 2e                	je     1510 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    14e2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    14e5:	8b 42 04             	mov    0x4(%edx),%eax
    14e8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    14eb:	39 f1                	cmp    %esi,%ecx
    14ed:	74 38                	je     1527 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    14ef:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    14f1:	5b                   	pop    %ebx
  freep = p;
    14f2:	89 15 c4 22 00 00    	mov    %edx,0x22c4
}
    14f8:	5e                   	pop    %esi
    14f9:	5f                   	pop    %edi
    14fa:	5d                   	pop    %ebp
    14fb:	c3                   	ret
    14fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1500:	39 c1                	cmp    %eax,%ecx
    1502:	72 d0                	jb     14d4 <free+0x24>
    1504:	eb c2                	jmp    14c8 <free+0x18>
    1506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    150d:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
    1510:	03 70 04             	add    0x4(%eax),%esi
    1513:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1516:	8b 02                	mov    (%edx),%eax
    1518:	8b 00                	mov    (%eax),%eax
    151a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    151d:	8b 42 04             	mov    0x4(%edx),%eax
    1520:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1523:	39 f1                	cmp    %esi,%ecx
    1525:	75 c8                	jne    14ef <free+0x3f>
    p->s.size += bp->s.size;
    1527:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    152a:	89 15 c4 22 00 00    	mov    %edx,0x22c4
    p->s.size += bp->s.size;
    1530:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1533:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1536:	89 0a                	mov    %ecx,(%edx)
}
    1538:	5b                   	pop    %ebx
    1539:	5e                   	pop    %esi
    153a:	5f                   	pop    %edi
    153b:	5d                   	pop    %ebp
    153c:	c3                   	ret
    153d:	8d 76 00             	lea    0x0(%esi),%esi

00001540 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1540:	55                   	push   %ebp
    1541:	89 e5                	mov    %esp,%ebp
    1543:	57                   	push   %edi
    1544:	56                   	push   %esi
    1545:	53                   	push   %ebx
    1546:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1549:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    154c:	8b 15 c4 22 00 00    	mov    0x22c4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1552:	8d 78 07             	lea    0x7(%eax),%edi
    1555:	c1 ef 03             	shr    $0x3,%edi
    1558:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    155b:	85 d2                	test   %edx,%edx
    155d:	0f 84 8d 00 00 00    	je     15f0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1563:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1565:	8b 48 04             	mov    0x4(%eax),%ecx
    1568:	39 f9                	cmp    %edi,%ecx
    156a:	73 64                	jae    15d0 <malloc+0x90>
  if(nu < 4096)
    156c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1571:	39 df                	cmp    %ebx,%edi
    1573:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1576:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    157d:	eb 0a                	jmp    1589 <malloc+0x49>
    157f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1580:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1582:	8b 48 04             	mov    0x4(%eax),%ecx
    1585:	39 f9                	cmp    %edi,%ecx
    1587:	73 47                	jae    15d0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1589:	89 c2                	mov    %eax,%edx
    158b:	39 05 c4 22 00 00    	cmp    %eax,0x22c4
    1591:	75 ed                	jne    1580 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1593:	83 ec 0c             	sub    $0xc,%esp
    1596:	56                   	push   %esi
    1597:	e8 7f fc ff ff       	call   121b <sbrk>
  if(p == (char*)-1)
    159c:	83 c4 10             	add    $0x10,%esp
    159f:	83 f8 ff             	cmp    $0xffffffff,%eax
    15a2:	74 1c                	je     15c0 <malloc+0x80>
  hp->s.size = nu;
    15a4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    15a7:	83 ec 0c             	sub    $0xc,%esp
    15aa:	83 c0 08             	add    $0x8,%eax
    15ad:	50                   	push   %eax
    15ae:	e8 fd fe ff ff       	call   14b0 <free>
  return freep;
    15b3:	8b 15 c4 22 00 00    	mov    0x22c4,%edx
      if((p = morecore(nunits)) == 0)
    15b9:	83 c4 10             	add    $0x10,%esp
    15bc:	85 d2                	test   %edx,%edx
    15be:	75 c0                	jne    1580 <malloc+0x40>
        return 0;
  }
}
    15c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    15c3:	31 c0                	xor    %eax,%eax
}
    15c5:	5b                   	pop    %ebx
    15c6:	5e                   	pop    %esi
    15c7:	5f                   	pop    %edi
    15c8:	5d                   	pop    %ebp
    15c9:	c3                   	ret
    15ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    15d0:	39 cf                	cmp    %ecx,%edi
    15d2:	74 4c                	je     1620 <malloc+0xe0>
        p->s.size -= nunits;
    15d4:	29 f9                	sub    %edi,%ecx
    15d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    15d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    15dc:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    15df:	89 15 c4 22 00 00    	mov    %edx,0x22c4
}
    15e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    15e8:	83 c0 08             	add    $0x8,%eax
}
    15eb:	5b                   	pop    %ebx
    15ec:	5e                   	pop    %esi
    15ed:	5f                   	pop    %edi
    15ee:	5d                   	pop    %ebp
    15ef:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    15f0:	c7 05 c4 22 00 00 c8 	movl   $0x22c8,0x22c4
    15f7:	22 00 00 
    base.s.size = 0;
    15fa:	b8 c8 22 00 00       	mov    $0x22c8,%eax
    base.s.ptr = freep = prevp = &base;
    15ff:	c7 05 c8 22 00 00 c8 	movl   $0x22c8,0x22c8
    1606:	22 00 00 
    base.s.size = 0;
    1609:	c7 05 cc 22 00 00 00 	movl   $0x0,0x22cc
    1610:	00 00 00 
    if(p->s.size >= nunits){
    1613:	e9 54 ff ff ff       	jmp    156c <malloc+0x2c>
    1618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    161f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
    1620:	8b 08                	mov    (%eax),%ecx
    1622:	89 0a                	mov    %ecx,(%edx)
    1624:	eb b9                	jmp    15df <malloc+0x9f>
