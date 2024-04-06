
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
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      17:	90                   	nop
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f 96 00 00 00    	jg     b7 <main+0xb7>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 b7 12 00 00       	push   $0x12b7
      2b:	e8 83 0d 00 00       	call   db3 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	eb 2e                	jmp    67 <main+0x67>
      39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      40:	80 3d 42 19 00 00 20 	cmpb   $0x20,0x1942
      47:	0f 84 8d 00 00 00    	je     da <main+0xda>
      4d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 16 0d 00 00       	call   d6b <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 c1 00 00 00    	je     11f <main+0x11f>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	74 63                	je     c5 <main+0xc5>
    wait();
      62:	e8 14 0d 00 00       	call   d7b <wait>
  printf(2, "$ ");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 f8 11 00 00       	push   $0x11f8
      6f:	6a 02                	push   $0x2
      71:	e8 5a 0e 00 00       	call   ed0 <printf>
  memset(buf, 0, nbuf);
      76:	83 c4 0c             	add    $0xc,%esp
      79:	6a 64                	push   $0x64
      7b:	6a 00                	push   $0x0
      7d:	68 40 19 00 00       	push   $0x1940
      82:	e8 69 0b 00 00       	call   bf0 <memset>
  gets(buf, nbuf);
      87:	58                   	pop    %eax
      88:	5a                   	pop    %edx
      89:	6a 64                	push   $0x64
      8b:	68 40 19 00 00       	push   $0x1940
      90:	e8 bb 0b 00 00       	call   c50 <gets>
  if(buf[0] == 0) // EOF
      95:	0f b6 05 40 19 00 00 	movzbl 0x1940,%eax
      9c:	83 c4 10             	add    $0x10,%esp
      9f:	84 c0                	test   %al,%al
      a1:	74 0f                	je     b2 <main+0xb2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a3:	3c 63                	cmp    $0x63,%al
      a5:	75 a9                	jne    50 <main+0x50>
      a7:	80 3d 41 19 00 00 64 	cmpb   $0x64,0x1941
      ae:	75 a0                	jne    50 <main+0x50>
      b0:	eb 8e                	jmp    40 <main+0x40>
  exit();
      b2:	e8 bc 0c 00 00       	call   d73 <exit>
      close(fd);
      b7:	83 ec 0c             	sub    $0xc,%esp
      ba:	50                   	push   %eax
      bb:	e8 db 0c 00 00       	call   d9b <close>
      break;
      c0:	83 c4 10             	add    $0x10,%esp
      c3:	eb a2                	jmp    67 <main+0x67>
      runcmd(parsecmd(buf));
      c5:	83 ec 0c             	sub    $0xc,%esp
      c8:	68 40 19 00 00       	push   $0x1940
      cd:	e8 ee 09 00 00       	call   ac0 <parsecmd>
      d2:	89 04 24             	mov    %eax,(%esp)
      d5:	e8 d6 00 00 00       	call   1b0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      da:	83 ec 0c             	sub    $0xc,%esp
      dd:	68 40 19 00 00       	push   $0x1940
      e2:	e8 d9 0a 00 00       	call   bc0 <strlen>
      if(chdir(buf+3) < 0)
      e7:	c7 04 24 43 19 00 00 	movl   $0x1943,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ee:	c6 80 3f 19 00 00 00 	movb   $0x0,0x193f(%eax)
      if(chdir(buf+3) < 0)
      f5:	e8 e9 0c 00 00       	call   de3 <chdir>
      fa:	83 c4 10             	add    $0x10,%esp
      fd:	85 c0                	test   %eax,%eax
      ff:	0f 89 62 ff ff ff    	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
     105:	51                   	push   %ecx
     106:	68 43 19 00 00       	push   $0x1943
     10b:	68 bf 12 00 00       	push   $0x12bf
     110:	6a 02                	push   $0x2
     112:	e8 b9 0d 00 00       	call   ed0 <printf>
     117:	83 c4 10             	add    $0x10,%esp
     11a:	e9 48 ff ff ff       	jmp    67 <main+0x67>
    panic("fork");
     11f:	83 ec 0c             	sub    $0xc,%esp
     122:	68 fb 11 00 00       	push   $0x11fb
     127:	e8 44 00 00 00       	call   170 <panic>
     12c:	66 90                	xchg   %ax,%ax
     12e:	66 90                	xchg   %ax,%ax

00000130 <getcmd>:
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	56                   	push   %esi
     134:	53                   	push   %ebx
     135:	8b 5d 08             	mov    0x8(%ebp),%ebx
     138:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     13b:	83 ec 08             	sub    $0x8,%esp
     13e:	68 f8 11 00 00       	push   $0x11f8
     143:	6a 02                	push   $0x2
     145:	e8 86 0d 00 00       	call   ed0 <printf>
  memset(buf, 0, nbuf);
     14a:	83 c4 0c             	add    $0xc,%esp
     14d:	56                   	push   %esi
     14e:	6a 00                	push   $0x0
     150:	53                   	push   %ebx
     151:	e8 9a 0a 00 00       	call   bf0 <memset>
  gets(buf, nbuf);
     156:	58                   	pop    %eax
     157:	5a                   	pop    %edx
     158:	56                   	push   %esi
     159:	53                   	push   %ebx
     15a:	e8 f1 0a 00 00       	call   c50 <gets>
  if(buf[0] == 0) // EOF
     15f:	83 c4 10             	add    $0x10,%esp
     162:	80 3b 01             	cmpb   $0x1,(%ebx)
     165:	19 c0                	sbb    %eax,%eax
}
     167:	8d 65 f8             	lea    -0x8(%ebp),%esp
     16a:	5b                   	pop    %ebx
     16b:	5e                   	pop    %esi
     16c:	5d                   	pop    %ebp
     16d:	c3                   	ret
     16e:	66 90                	xchg   %ax,%ax

00000170 <panic>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     176:	ff 75 08             	push   0x8(%ebp)
     179:	68 b3 12 00 00       	push   $0x12b3
     17e:	6a 02                	push   $0x2
     180:	e8 4b 0d 00 00       	call   ed0 <printf>
  exit();
     185:	e8 e9 0b 00 00       	call   d73 <exit>
     18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <fork1>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     196:	e8 d0 0b 00 00       	call   d6b <fork>
  if(pid == -1)
     19b:	83 f8 ff             	cmp    $0xffffffff,%eax
     19e:	74 02                	je     1a2 <fork1+0x12>
  return pid;
}
     1a0:	c9                   	leave
     1a1:	c3                   	ret
    panic("fork");
     1a2:	83 ec 0c             	sub    $0xc,%esp
     1a5:	68 fb 11 00 00       	push   $0x11fb
     1aa:	e8 c1 ff ff ff       	call   170 <panic>
     1af:	90                   	nop

000001b0 <runcmd>:
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	53                   	push   %ebx
     1b4:	83 ec 04             	sub    $0x4,%esp
     1b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ba:	85 db                	test   %ebx,%ebx
     1bc:	74 2a                	je     1e8 <runcmd+0x38>
  switch(cmd->type){
     1be:	83 3b 05             	cmpl   $0x5,(%ebx)
     1c1:	0f 87 90 00 00 00    	ja     257 <runcmd+0xa7>
     1c7:	8b 03                	mov    (%ebx),%eax
     1c9:	ff 24 85 f0 12 00 00 	jmp    *0x12f0(,%eax,4)
    printf(2, "Pipe Not implemented\n");
     1d0:	52                   	push   %edx
     1d1:	52                   	push   %edx
     1d2:	68 34 12 00 00       	push   $0x1234
     1d7:	6a 02                	push   $0x2
     1d9:	e8 f2 0c 00 00       	call   ed0 <printf>
    break;
     1de:	83 c4 10             	add    $0x10,%esp
     1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
     1e8:	e8 86 0b 00 00       	call   d73 <exit>
    printf(2, "Backgrounding not implemented\n");
     1ed:	50                   	push   %eax
     1ee:	50                   	push   %eax
     1ef:	68 d0 12 00 00       	push   $0x12d0
     1f4:	6a 02                	push   $0x2
     1f6:	e8 d5 0c 00 00       	call   ed0 <printf>
    break;
     1fb:	83 c4 10             	add    $0x10,%esp
     1fe:	eb e8                	jmp    1e8 <runcmd+0x38>
    if(ecmd->argv[0] == 0)
     200:	8b 43 04             	mov    0x4(%ebx),%eax
     203:	85 c0                	test   %eax,%eax
     205:	74 e1                	je     1e8 <runcmd+0x38>
    exec(ecmd->argv[0], ecmd->argv);
     207:	52                   	push   %edx
     208:	52                   	push   %edx
     209:	8d 53 04             	lea    0x4(%ebx),%edx
     20c:	52                   	push   %edx
     20d:	50                   	push   %eax
     20e:	e8 98 0b 00 00       	call   dab <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     213:	83 c4 0c             	add    $0xc,%esp
     216:	ff 73 04             	push   0x4(%ebx)
     219:	68 07 12 00 00       	push   $0x1207
     21e:	6a 02                	push   $0x2
     220:	e8 ab 0c 00 00       	call   ed0 <printf>
    break;
     225:	83 c4 10             	add    $0x10,%esp
     228:	eb be                	jmp    1e8 <runcmd+0x38>
    printf(2, "Redirection Not Implemented\n");
     22a:	51                   	push   %ecx
     22b:	51                   	push   %ecx
     22c:	68 17 12 00 00       	push   $0x1217
     231:	6a 02                	push   $0x2
     233:	e8 98 0c 00 00       	call   ed0 <printf>
    break;
     238:	83 c4 10             	add    $0x10,%esp
     23b:	eb ab                	jmp    1e8 <runcmd+0x38>
    if(lcmd->left)
     23d:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
     241:	74 26                	je     269 <runcmd+0xb9>
      if(fork1() == 0)
     243:	e8 48 ff ff ff       	call   190 <fork1>
     248:	85 c0                	test   %eax,%eax
     24a:	75 18                	jne    264 <runcmd+0xb4>
        runcmd(lcmd->left);
     24c:	83 ec 0c             	sub    $0xc,%esp
     24f:	ff 73 04             	push   0x4(%ebx)
     252:	e8 59 ff ff ff       	call   1b0 <runcmd>
    panic("runcmd");
     257:	83 ec 0c             	sub    $0xc,%esp
     25a:	68 00 12 00 00       	push   $0x1200
     25f:	e8 0c ff ff ff       	call   170 <panic>
      wait();
     264:	e8 12 0b 00 00       	call   d7b <wait>
    if(lcmd->right)
     269:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
     26d:	0f 84 75 ff ff ff    	je     1e8 <runcmd+0x38>
      if(fork1() == 0)
     273:	e8 18 ff ff ff       	call   190 <fork1>
     278:	85 c0                	test   %eax,%eax
     27a:	75 0b                	jne    287 <runcmd+0xd7>
        runcmd(lcmd->right);
     27c:	83 ec 0c             	sub    $0xc,%esp
     27f:	ff 73 08             	push   0x8(%ebx)
     282:	e8 29 ff ff ff       	call   1b0 <runcmd>
      wait();
     287:	e8 ef 0a 00 00       	call   d7b <wait>
     28c:	e9 57 ff ff ff       	jmp    1e8 <runcmd+0x38>
     291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     298:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     29f:	90                   	nop

000002a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	53                   	push   %ebx
     2a4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2a7:	6a 54                	push   $0x54
     2a9:	e8 62 0e 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2ae:	83 c4 0c             	add    $0xc,%esp
     2b1:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     2b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2b5:	6a 00                	push   $0x0
     2b7:	50                   	push   %eax
     2b8:	e8 33 09 00 00       	call   bf0 <memset>
  cmd->type = EXEC;
     2bd:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     2c3:	89 d8                	mov    %ebx,%eax
     2c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2c8:	c9                   	leave
     2c9:	c3                   	ret
     2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2d0:	55                   	push   %ebp
     2d1:	89 e5                	mov    %esp,%ebp
     2d3:	53                   	push   %ebx
     2d4:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2d7:	6a 18                	push   $0x18
     2d9:	e8 32 0e 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     2de:	83 c4 0c             	add    $0xc,%esp
     2e1:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     2e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     2e5:	6a 00                	push   $0x0
     2e7:	50                   	push   %eax
     2e8:	e8 03 09 00 00       	call   bf0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     2ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     2f0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     2f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     2f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     2fc:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     2ff:	8b 45 10             	mov    0x10(%ebp),%eax
     302:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     305:	8b 45 14             	mov    0x14(%ebp),%eax
     308:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     30b:	8b 45 18             	mov    0x18(%ebp),%eax
     30e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     311:	89 d8                	mov    %ebx,%eax
     313:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     316:	c9                   	leave
     317:	c3                   	ret
     318:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     31f:	90                   	nop

00000320 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     320:	55                   	push   %ebp
     321:	89 e5                	mov    %esp,%ebp
     323:	53                   	push   %ebx
     324:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     327:	6a 0c                	push   $0xc
     329:	e8 e2 0d 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     32e:	83 c4 0c             	add    $0xc,%esp
     331:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     333:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     335:	6a 00                	push   $0x0
     337:	50                   	push   %eax
     338:	e8 b3 08 00 00       	call   bf0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     33d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     340:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     346:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     349:	8b 45 0c             	mov    0xc(%ebp),%eax
     34c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     34f:	89 d8                	mov    %ebx,%eax
     351:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     354:	c9                   	leave
     355:	c3                   	ret
     356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     35d:	8d 76 00             	lea    0x0(%esi),%esi

00000360 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
     364:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     367:	6a 0c                	push   $0xc
     369:	e8 a2 0d 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     36e:	83 c4 0c             	add    $0xc,%esp
     371:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     373:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     375:	6a 00                	push   $0x0
     377:	50                   	push   %eax
     378:	e8 73 08 00 00       	call   bf0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     37d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     380:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     386:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     389:	8b 45 0c             	mov    0xc(%ebp),%eax
     38c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     38f:	89 d8                	mov    %ebx,%eax
     391:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     394:	c9                   	leave
     395:	c3                   	ret
     396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     39d:	8d 76 00             	lea    0x0(%esi),%esi

000003a0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	6a 08                	push   $0x8
     3a9:	e8 62 0d 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ae:	83 c4 0c             	add    $0xc,%esp
     3b1:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     3b3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3b5:	6a 00                	push   $0x0
     3b7:	50                   	push   %eax
     3b8:	e8 33 08 00 00       	call   bf0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     3bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     3c0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     3c6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     3c9:	89 d8                	mov    %ebx,%eax
     3cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3ce:	c9                   	leave
     3cf:	c3                   	ret

000003d0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	57                   	push   %edi
     3d4:	56                   	push   %esi
     3d5:	53                   	push   %ebx
     3d6:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     3d9:	8b 45 08             	mov    0x8(%ebp),%eax
{
     3dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     3df:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     3e2:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     3e4:	39 df                	cmp    %ebx,%edi
     3e6:	72 0f                	jb     3f7 <gettoken+0x27>
     3e8:	eb 25                	jmp    40f <gettoken+0x3f>
     3ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     3f0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     3f3:	39 fb                	cmp    %edi,%ebx
     3f5:	74 18                	je     40f <gettoken+0x3f>
     3f7:	0f be 07             	movsbl (%edi),%eax
     3fa:	83 ec 08             	sub    $0x8,%esp
     3fd:	50                   	push   %eax
     3fe:	68 38 19 00 00       	push   $0x1938
     403:	e8 08 08 00 00       	call   c10 <strchr>
     408:	83 c4 10             	add    $0x10,%esp
     40b:	85 c0                	test   %eax,%eax
     40d:	75 e1                	jne    3f0 <gettoken+0x20>
  if(q)
     40f:	85 f6                	test   %esi,%esi
     411:	74 02                	je     415 <gettoken+0x45>
    *q = s;
     413:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     415:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     418:	3c 3c                	cmp    $0x3c,%al
     41a:	0f 8f d0 00 00 00    	jg     4f0 <gettoken+0x120>
     420:	3c 3a                	cmp    $0x3a,%al
     422:	0f 8f bc 00 00 00    	jg     4e4 <gettoken+0x114>
     428:	84 c0                	test   %al,%al
     42a:	75 44                	jne    470 <gettoken+0xa0>
     42c:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     42e:	8b 4d 14             	mov    0x14(%ebp),%ecx
     431:	85 c9                	test   %ecx,%ecx
     433:	74 05                	je     43a <gettoken+0x6a>
    *eq = s;
     435:	8b 45 14             	mov    0x14(%ebp),%eax
     438:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     43a:	39 df                	cmp    %ebx,%edi
     43c:	72 09                	jb     447 <gettoken+0x77>
     43e:	eb 1f                	jmp    45f <gettoken+0x8f>
    s++;
     440:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     443:	39 fb                	cmp    %edi,%ebx
     445:	74 18                	je     45f <gettoken+0x8f>
     447:	0f be 07             	movsbl (%edi),%eax
     44a:	83 ec 08             	sub    $0x8,%esp
     44d:	50                   	push   %eax
     44e:	68 38 19 00 00       	push   $0x1938
     453:	e8 b8 07 00 00       	call   c10 <strchr>
     458:	83 c4 10             	add    $0x10,%esp
     45b:	85 c0                	test   %eax,%eax
     45d:	75 e1                	jne    440 <gettoken+0x70>
  *ps = s;
     45f:	8b 45 08             	mov    0x8(%ebp),%eax
     462:	89 38                	mov    %edi,(%eax)
  return ret;
}
     464:	8d 65 f4             	lea    -0xc(%ebp),%esp
     467:	89 f0                	mov    %esi,%eax
     469:	5b                   	pop    %ebx
     46a:	5e                   	pop    %esi
     46b:	5f                   	pop    %edi
     46c:	5d                   	pop    %ebp
     46d:	c3                   	ret
     46e:	66 90                	xchg   %ax,%ax
  switch(*s){
     470:	79 66                	jns    4d8 <gettoken+0x108>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     472:	39 df                	cmp    %ebx,%edi
     474:	72 39                	jb     4af <gettoken+0xdf>
  if(eq)
     476:	8b 55 14             	mov    0x14(%ebp),%edx
     479:	85 d2                	test   %edx,%edx
     47b:	0f 84 b3 00 00 00    	je     534 <gettoken+0x164>
    *eq = s;
     481:	8b 45 14             	mov    0x14(%ebp),%eax
     484:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     486:	e9 a9 00 00 00       	jmp    534 <gettoken+0x164>
     48b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     48f:	90                   	nop
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     490:	0f be 07             	movsbl (%edi),%eax
     493:	83 ec 08             	sub    $0x8,%esp
     496:	50                   	push   %eax
     497:	68 30 19 00 00       	push   $0x1930
     49c:	e8 6f 07 00 00       	call   c10 <strchr>
     4a1:	83 c4 10             	add    $0x10,%esp
     4a4:	85 c0                	test   %eax,%eax
     4a6:	75 1f                	jne    4c7 <gettoken+0xf7>
      s++;
     4a8:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4ab:	39 fb                	cmp    %edi,%ebx
     4ad:	74 77                	je     526 <gettoken+0x156>
     4af:	0f be 07             	movsbl (%edi),%eax
     4b2:	83 ec 08             	sub    $0x8,%esp
     4b5:	50                   	push   %eax
     4b6:	68 38 19 00 00       	push   $0x1938
     4bb:	e8 50 07 00 00       	call   c10 <strchr>
     4c0:	83 c4 10             	add    $0x10,%esp
     4c3:	85 c0                	test   %eax,%eax
     4c5:	74 c9                	je     490 <gettoken+0xc0>
    ret = 'a';
     4c7:	be 61 00 00 00       	mov    $0x61,%esi
     4cc:	e9 5d ff ff ff       	jmp    42e <gettoken+0x5e>
     4d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     4d8:	3c 26                	cmp    $0x26,%al
     4da:	74 08                	je     4e4 <gettoken+0x114>
     4dc:	8d 48 d8             	lea    -0x28(%eax),%ecx
     4df:	80 f9 01             	cmp    $0x1,%cl
     4e2:	77 8e                	ja     472 <gettoken+0xa2>
  ret = *s;
     4e4:	0f be f0             	movsbl %al,%esi
    s++;
     4e7:	83 c7 01             	add    $0x1,%edi
    break;
     4ea:	e9 3f ff ff ff       	jmp    42e <gettoken+0x5e>
     4ef:	90                   	nop
  switch(*s){
     4f0:	3c 3e                	cmp    $0x3e,%al
     4f2:	75 1c                	jne    510 <gettoken+0x140>
    if(*s == '>'){
     4f4:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     4f8:	74 1f                	je     519 <gettoken+0x149>
    s++;
     4fa:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     4fd:	be 3e 00 00 00       	mov    $0x3e,%esi
     502:	e9 27 ff ff ff       	jmp    42e <gettoken+0x5e>
     507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     50e:	66 90                	xchg   %ax,%ax
  switch(*s){
     510:	3c 7c                	cmp    $0x7c,%al
     512:	74 d0                	je     4e4 <gettoken+0x114>
     514:	e9 59 ff ff ff       	jmp    472 <gettoken+0xa2>
      s++;
     519:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     51c:	be 2b 00 00 00       	mov    $0x2b,%esi
     521:	e9 08 ff ff ff       	jmp    42e <gettoken+0x5e>
  if(eq)
     526:	8b 45 14             	mov    0x14(%ebp),%eax
     529:	85 c0                	test   %eax,%eax
     52b:	74 05                	je     532 <gettoken+0x162>
    *eq = s;
     52d:	8b 45 14             	mov    0x14(%ebp),%eax
     530:	89 18                	mov    %ebx,(%eax)
      s++;
     532:	89 df                	mov    %ebx,%edi
    ret = 'a';
     534:	be 61 00 00 00       	mov    $0x61,%esi
     539:	e9 21 ff ff ff       	jmp    45f <gettoken+0x8f>
     53e:	66 90                	xchg   %ax,%ax

00000540 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     540:	55                   	push   %ebp
     541:	89 e5                	mov    %esp,%ebp
     543:	57                   	push   %edi
     544:	56                   	push   %esi
     545:	53                   	push   %ebx
     546:	83 ec 0c             	sub    $0xc,%esp
     549:	8b 7d 08             	mov    0x8(%ebp),%edi
     54c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     54f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     551:	39 f3                	cmp    %esi,%ebx
     553:	72 12                	jb     567 <peek+0x27>
     555:	eb 28                	jmp    57f <peek+0x3f>
     557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     55e:	66 90                	xchg   %ax,%ax
    s++;
     560:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     563:	39 de                	cmp    %ebx,%esi
     565:	74 18                	je     57f <peek+0x3f>
     567:	0f be 03             	movsbl (%ebx),%eax
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	50                   	push   %eax
     56e:	68 38 19 00 00       	push   $0x1938
     573:	e8 98 06 00 00       	call   c10 <strchr>
     578:	83 c4 10             	add    $0x10,%esp
     57b:	85 c0                	test   %eax,%eax
     57d:	75 e1                	jne    560 <peek+0x20>
  *ps = s;
     57f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     581:	0f be 03             	movsbl (%ebx),%eax
     584:	31 d2                	xor    %edx,%edx
     586:	84 c0                	test   %al,%al
     588:	75 0e                	jne    598 <peek+0x58>
}
     58a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     58d:	89 d0                	mov    %edx,%eax
     58f:	5b                   	pop    %ebx
     590:	5e                   	pop    %esi
     591:	5f                   	pop    %edi
     592:	5d                   	pop    %ebp
     593:	c3                   	ret
     594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     598:	83 ec 08             	sub    $0x8,%esp
     59b:	50                   	push   %eax
     59c:	ff 75 10             	push   0x10(%ebp)
     59f:	e8 6c 06 00 00       	call   c10 <strchr>
     5a4:	83 c4 10             	add    $0x10,%esp
     5a7:	31 d2                	xor    %edx,%edx
     5a9:	85 c0                	test   %eax,%eax
     5ab:	0f 95 c2             	setne  %dl
}
     5ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
     5b1:	5b                   	pop    %ebx
     5b2:	89 d0                	mov    %edx,%eax
     5b4:	5e                   	pop    %esi
     5b5:	5f                   	pop    %edi
     5b6:	5d                   	pop    %ebp
     5b7:	c3                   	ret
     5b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5bf:	90                   	nop

000005c0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     5c0:	55                   	push   %ebp
     5c1:	89 e5                	mov    %esp,%ebp
     5c3:	57                   	push   %edi
     5c4:	56                   	push   %esi
     5c5:	53                   	push   %ebx
     5c6:	83 ec 2c             	sub    $0x2c,%esp
     5c9:	8b 75 0c             	mov    0xc(%ebp),%esi
     5cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5cf:	90                   	nop
     5d0:	83 ec 04             	sub    $0x4,%esp
     5d3:	68 67 12 00 00       	push   $0x1267
     5d8:	53                   	push   %ebx
     5d9:	56                   	push   %esi
     5da:	e8 61 ff ff ff       	call   540 <peek>
     5df:	83 c4 10             	add    $0x10,%esp
     5e2:	85 c0                	test   %eax,%eax
     5e4:	0f 84 f6 00 00 00    	je     6e0 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     5ea:	6a 00                	push   $0x0
     5ec:	6a 00                	push   $0x0
     5ee:	53                   	push   %ebx
     5ef:	56                   	push   %esi
     5f0:	e8 db fd ff ff       	call   3d0 <gettoken>
     5f5:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     5f7:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     5fa:	50                   	push   %eax
     5fb:	8d 45 e0             	lea    -0x20(%ebp),%eax
     5fe:	50                   	push   %eax
     5ff:	53                   	push   %ebx
     600:	56                   	push   %esi
     601:	e8 ca fd ff ff       	call   3d0 <gettoken>
     606:	83 c4 20             	add    $0x20,%esp
     609:	83 f8 61             	cmp    $0x61,%eax
     60c:	0f 85 d9 00 00 00    	jne    6eb <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     612:	83 ff 3c             	cmp    $0x3c,%edi
     615:	74 69                	je     680 <parseredirs+0xc0>
     617:	83 ff 3e             	cmp    $0x3e,%edi
     61a:	74 05                	je     621 <parseredirs+0x61>
     61c:	83 ff 2b             	cmp    $0x2b,%edi
     61f:	75 af                	jne    5d0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     621:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     624:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     627:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     62a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     62d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     630:	6a 18                	push   $0x18
     632:	e8 d9 0a 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     637:	83 c4 0c             	add    $0xc,%esp
     63a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     63c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     63e:	6a 00                	push   $0x0
     640:	50                   	push   %eax
     641:	e8 aa 05 00 00       	call   bf0 <memset>
  cmd->type = REDIR;
     646:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     64c:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     64f:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     652:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     655:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     658:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     65b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     65e:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     665:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     668:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     66f:	89 7d 08             	mov    %edi,0x8(%ebp)
     672:	e9 59 ff ff ff       	jmp    5d0 <parseredirs+0x10>
     677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     67e:	66 90                	xchg   %ax,%ax
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     680:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     683:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     686:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     689:	89 55 d0             	mov    %edx,-0x30(%ebp)
     68c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     68f:	6a 18                	push   $0x18
     691:	e8 7a 0a 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     696:	83 c4 0c             	add    $0xc,%esp
     699:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     69b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     69d:	6a 00                	push   $0x0
     69f:	50                   	push   %eax
     6a0:	e8 4b 05 00 00       	call   bf0 <memset>
  cmd->cmd = subcmd;
     6a5:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     6a8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     6ab:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     6ae:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     6b1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     6b7:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     6ba:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     6bd:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     6c0:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     6c3:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     6ca:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     6d1:	e9 fa fe ff ff       	jmp    5d0 <parseredirs+0x10>
     6d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6dd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     6e0:	8b 45 08             	mov    0x8(%ebp),%eax
     6e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6e6:	5b                   	pop    %ebx
     6e7:	5e                   	pop    %esi
     6e8:	5f                   	pop    %edi
     6e9:	5d                   	pop    %ebp
     6ea:	c3                   	ret
      panic("missing file for redirection");
     6eb:	83 ec 0c             	sub    $0xc,%esp
     6ee:	68 4a 12 00 00       	push   $0x124a
     6f3:	e8 78 fa ff ff       	call   170 <panic>
     6f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     6ff:	90                   	nop

00000700 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 30             	sub    $0x30,%esp
     709:	8b 5d 08             	mov    0x8(%ebp),%ebx
     70c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     70f:	68 6a 12 00 00       	push   $0x126a
     714:	56                   	push   %esi
     715:	53                   	push   %ebx
     716:	e8 25 fe ff ff       	call   540 <peek>
     71b:	83 c4 10             	add    $0x10,%esp
     71e:	85 c0                	test   %eax,%eax
     720:	0f 85 aa 00 00 00    	jne    7d0 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     726:	83 ec 0c             	sub    $0xc,%esp
     729:	89 c7                	mov    %eax,%edi
     72b:	6a 54                	push   $0x54
     72d:	e8 de 09 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     732:	83 c4 0c             	add    $0xc,%esp
     735:	6a 54                	push   $0x54
     737:	6a 00                	push   $0x0
     739:	89 45 d0             	mov    %eax,-0x30(%ebp)
     73c:	50                   	push   %eax
     73d:	e8 ae 04 00 00       	call   bf0 <memset>
  cmd->type = EXEC;
     742:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     745:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     748:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     74e:	56                   	push   %esi
     74f:	53                   	push   %ebx
     750:	50                   	push   %eax
     751:	e8 6a fe ff ff       	call   5c0 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     756:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     759:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     75c:	eb 15                	jmp    773 <parseexec+0x73>
     75e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     760:	83 ec 04             	sub    $0x4,%esp
     763:	56                   	push   %esi
     764:	53                   	push   %ebx
     765:	ff 75 d4             	push   -0x2c(%ebp)
     768:	e8 53 fe ff ff       	call   5c0 <parseredirs>
     76d:	83 c4 10             	add    $0x10,%esp
     770:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     773:	83 ec 04             	sub    $0x4,%esp
     776:	68 81 12 00 00       	push   $0x1281
     77b:	56                   	push   %esi
     77c:	53                   	push   %ebx
     77d:	e8 be fd ff ff       	call   540 <peek>
     782:	83 c4 10             	add    $0x10,%esp
     785:	85 c0                	test   %eax,%eax
     787:	75 5f                	jne    7e8 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     789:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     78c:	50                   	push   %eax
     78d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     790:	50                   	push   %eax
     791:	56                   	push   %esi
     792:	53                   	push   %ebx
     793:	e8 38 fc ff ff       	call   3d0 <gettoken>
     798:	83 c4 10             	add    $0x10,%esp
     79b:	85 c0                	test   %eax,%eax
     79d:	74 49                	je     7e8 <parseexec+0xe8>
    if(tok != 'a')
     79f:	83 f8 61             	cmp    $0x61,%eax
     7a2:	75 62                	jne    806 <parseexec+0x106>
    cmd->argv[argc] = q;
     7a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     7a7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7aa:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     7ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7b1:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     7b5:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     7b8:	83 ff 0a             	cmp    $0xa,%edi
     7bb:	75 a3                	jne    760 <parseexec+0x60>
      panic("too many args");
     7bd:	83 ec 0c             	sub    $0xc,%esp
     7c0:	68 73 12 00 00       	push   $0x1273
     7c5:	e8 a6 f9 ff ff       	call   170 <panic>
     7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7d0:	89 75 0c             	mov    %esi,0xc(%ebp)
     7d3:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7d9:	5b                   	pop    %ebx
     7da:	5e                   	pop    %esi
     7db:	5f                   	pop    %edi
     7dc:	5d                   	pop    %ebp
    return parseblock(ps, es);
     7dd:	e9 ae 01 00 00       	jmp    990 <parseblock>
     7e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     7e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7eb:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     7f2:	00 
  cmd->eargv[argc] = 0;
     7f3:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     7fa:	00 
}
     7fb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
     801:	5b                   	pop    %ebx
     802:	5e                   	pop    %esi
     803:	5f                   	pop    %edi
     804:	5d                   	pop    %ebp
     805:	c3                   	ret
      panic("syntax");
     806:	83 ec 0c             	sub    $0xc,%esp
     809:	68 6c 12 00 00       	push   $0x126c
     80e:	e8 5d f9 ff ff       	call   170 <panic>
     813:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000820 <parsepipe>:
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	57                   	push   %edi
     824:	56                   	push   %esi
     825:	53                   	push   %ebx
     826:	83 ec 14             	sub    $0x14,%esp
     829:	8b 75 08             	mov    0x8(%ebp),%esi
     82c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     82f:	57                   	push   %edi
     830:	56                   	push   %esi
     831:	e8 ca fe ff ff       	call   700 <parseexec>
  if(peek(ps, es, "|")){
     836:	83 c4 0c             	add    $0xc,%esp
     839:	68 86 12 00 00       	push   $0x1286
  cmd = parseexec(ps, es);
     83e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     840:	57                   	push   %edi
     841:	56                   	push   %esi
     842:	e8 f9 fc ff ff       	call   540 <peek>
     847:	83 c4 10             	add    $0x10,%esp
     84a:	85 c0                	test   %eax,%eax
     84c:	75 12                	jne    860 <parsepipe+0x40>
}
     84e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     851:	89 d8                	mov    %ebx,%eax
     853:	5b                   	pop    %ebx
     854:	5e                   	pop    %esi
     855:	5f                   	pop    %edi
     856:	5d                   	pop    %ebp
     857:	c3                   	ret
     858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     85f:	90                   	nop
    gettoken(ps, es, 0, 0);
     860:	6a 00                	push   $0x0
     862:	6a 00                	push   $0x0
     864:	57                   	push   %edi
     865:	56                   	push   %esi
     866:	e8 65 fb ff ff       	call   3d0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     86b:	58                   	pop    %eax
     86c:	5a                   	pop    %edx
     86d:	57                   	push   %edi
     86e:	56                   	push   %esi
     86f:	e8 ac ff ff ff       	call   820 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     874:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     87b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     87d:	e8 8e 08 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     882:	83 c4 0c             	add    $0xc,%esp
     885:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     887:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     889:	6a 00                	push   $0x0
     88b:	50                   	push   %eax
     88c:	e8 5f 03 00 00       	call   bf0 <memset>
  cmd->left = left;
     891:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     894:	83 c4 10             	add    $0x10,%esp
     897:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     899:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     89f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     8a1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     8a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8a7:	5b                   	pop    %ebx
     8a8:	5e                   	pop    %esi
     8a9:	5f                   	pop    %edi
     8aa:	5d                   	pop    %ebp
     8ab:	c3                   	ret
     8ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000008b0 <parseline>:
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	57                   	push   %edi
     8b4:	56                   	push   %esi
     8b5:	53                   	push   %ebx
     8b6:	83 ec 24             	sub    $0x24,%esp
     8b9:	8b 75 08             	mov    0x8(%ebp),%esi
     8bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     8bf:	57                   	push   %edi
     8c0:	56                   	push   %esi
     8c1:	e8 5a ff ff ff       	call   820 <parsepipe>
  while(peek(ps, es, "&")){
     8c6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     8c9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     8cb:	eb 3b                	jmp    908 <parseline+0x58>
     8cd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8d0:	6a 00                	push   $0x0
     8d2:	6a 00                	push   $0x0
     8d4:	57                   	push   %edi
     8d5:	56                   	push   %esi
     8d6:	e8 f5 fa ff ff       	call   3d0 <gettoken>
  cmd = malloc(sizeof(*cmd));
     8db:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     8e2:	e8 29 08 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     8e7:	83 c4 0c             	add    $0xc,%esp
     8ea:	6a 08                	push   $0x8
     8ec:	6a 00                	push   $0x0
     8ee:	50                   	push   %eax
     8ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     8f2:	e8 f9 02 00 00       	call   bf0 <memset>
  cmd->type = BACK;
     8f7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     8fa:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     8fd:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     903:	89 5a 04             	mov    %ebx,0x4(%edx)
     906:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     908:	83 ec 04             	sub    $0x4,%esp
     90b:	68 88 12 00 00       	push   $0x1288
     910:	57                   	push   %edi
     911:	56                   	push   %esi
     912:	e8 29 fc ff ff       	call   540 <peek>
     917:	83 c4 10             	add    $0x10,%esp
     91a:	85 c0                	test   %eax,%eax
     91c:	75 b2                	jne    8d0 <parseline+0x20>
  if(peek(ps, es, ";")){
     91e:	83 ec 04             	sub    $0x4,%esp
     921:	68 84 12 00 00       	push   $0x1284
     926:	57                   	push   %edi
     927:	56                   	push   %esi
     928:	e8 13 fc ff ff       	call   540 <peek>
     92d:	83 c4 10             	add    $0x10,%esp
     930:	85 c0                	test   %eax,%eax
     932:	75 0c                	jne    940 <parseline+0x90>
}
     934:	8d 65 f4             	lea    -0xc(%ebp),%esp
     937:	89 d8                	mov    %ebx,%eax
     939:	5b                   	pop    %ebx
     93a:	5e                   	pop    %esi
     93b:	5f                   	pop    %edi
     93c:	5d                   	pop    %ebp
     93d:	c3                   	ret
     93e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     940:	6a 00                	push   $0x0
     942:	6a 00                	push   $0x0
     944:	57                   	push   %edi
     945:	56                   	push   %esi
     946:	e8 85 fa ff ff       	call   3d0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     94b:	58                   	pop    %eax
     94c:	5a                   	pop    %edx
     94d:	57                   	push   %edi
     94e:	56                   	push   %esi
     94f:	e8 5c ff ff ff       	call   8b0 <parseline>
  cmd = malloc(sizeof(*cmd));
     954:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     95b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     95d:	e8 ae 07 00 00       	call   1110 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     962:	83 c4 0c             	add    $0xc,%esp
     965:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     967:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     969:	6a 00                	push   $0x0
     96b:	50                   	push   %eax
     96c:	e8 7f 02 00 00       	call   bf0 <memset>
  cmd->left = left;
     971:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     974:	83 c4 10             	add    $0x10,%esp
     977:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     979:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     97f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     981:	89 7e 08             	mov    %edi,0x8(%esi)
}
     984:	8d 65 f4             	lea    -0xc(%ebp),%esp
     987:	5b                   	pop    %ebx
     988:	5e                   	pop    %esi
     989:	5f                   	pop    %edi
     98a:	5d                   	pop    %ebp
     98b:	c3                   	ret
     98c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000990 <parseblock>:
{
     990:	55                   	push   %ebp
     991:	89 e5                	mov    %esp,%ebp
     993:	57                   	push   %edi
     994:	56                   	push   %esi
     995:	53                   	push   %ebx
     996:	83 ec 10             	sub    $0x10,%esp
     999:	8b 5d 08             	mov    0x8(%ebp),%ebx
     99c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     99f:	68 6a 12 00 00       	push   $0x126a
     9a4:	56                   	push   %esi
     9a5:	53                   	push   %ebx
     9a6:	e8 95 fb ff ff       	call   540 <peek>
     9ab:	83 c4 10             	add    $0x10,%esp
     9ae:	85 c0                	test   %eax,%eax
     9b0:	74 4a                	je     9fc <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     9b2:	6a 00                	push   $0x0
     9b4:	6a 00                	push   $0x0
     9b6:	56                   	push   %esi
     9b7:	53                   	push   %ebx
     9b8:	e8 13 fa ff ff       	call   3d0 <gettoken>
  cmd = parseline(ps, es);
     9bd:	58                   	pop    %eax
     9be:	5a                   	pop    %edx
     9bf:	56                   	push   %esi
     9c0:	53                   	push   %ebx
     9c1:	e8 ea fe ff ff       	call   8b0 <parseline>
  if(!peek(ps, es, ")"))
     9c6:	83 c4 0c             	add    $0xc,%esp
     9c9:	68 a6 12 00 00       	push   $0x12a6
  cmd = parseline(ps, es);
     9ce:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     9d0:	56                   	push   %esi
     9d1:	53                   	push   %ebx
     9d2:	e8 69 fb ff ff       	call   540 <peek>
     9d7:	83 c4 10             	add    $0x10,%esp
     9da:	85 c0                	test   %eax,%eax
     9dc:	74 2b                	je     a09 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     9de:	6a 00                	push   $0x0
     9e0:	6a 00                	push   $0x0
     9e2:	56                   	push   %esi
     9e3:	53                   	push   %ebx
     9e4:	e8 e7 f9 ff ff       	call   3d0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9e9:	83 c4 0c             	add    $0xc,%esp
     9ec:	56                   	push   %esi
     9ed:	53                   	push   %ebx
     9ee:	57                   	push   %edi
     9ef:	e8 cc fb ff ff       	call   5c0 <parseredirs>
}
     9f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9f7:	5b                   	pop    %ebx
     9f8:	5e                   	pop    %esi
     9f9:	5f                   	pop    %edi
     9fa:	5d                   	pop    %ebp
     9fb:	c3                   	ret
    panic("parseblock");
     9fc:	83 ec 0c             	sub    $0xc,%esp
     9ff:	68 8a 12 00 00       	push   $0x128a
     a04:	e8 67 f7 ff ff       	call   170 <panic>
    panic("syntax - missing )");
     a09:	83 ec 0c             	sub    $0xc,%esp
     a0c:	68 95 12 00 00       	push   $0x1295
     a11:	e8 5a f7 ff ff       	call   170 <panic>
     a16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a1d:	8d 76 00             	lea    0x0(%esi),%esi

00000a20 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     a20:	55                   	push   %ebp
     a21:	89 e5                	mov    %esp,%ebp
     a23:	53                   	push   %ebx
     a24:	83 ec 04             	sub    $0x4,%esp
     a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     a2a:	85 db                	test   %ebx,%ebx
     a2c:	0f 84 7e 00 00 00    	je     ab0 <nulterminate+0x90>
    return 0;

  switch(cmd->type){
     a32:	83 3b 05             	cmpl   $0x5,(%ebx)
     a35:	77 20                	ja     a57 <nulterminate+0x37>
     a37:	8b 03                	mov    (%ebx),%eax
     a39:	ff 24 85 08 13 00 00 	jmp    *0x1308(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a40:	83 ec 0c             	sub    $0xc,%esp
     a43:	ff 73 04             	push   0x4(%ebx)
     a46:	e8 d5 ff ff ff       	call   a20 <nulterminate>
    nulterminate(lcmd->right);
     a4b:	58                   	pop    %eax
     a4c:	ff 73 08             	push   0x8(%ebx)
     a4f:	e8 cc ff ff ff       	call   a20 <nulterminate>
    break;
     a54:	83 c4 10             	add    $0x10,%esp
    return 0;
     a57:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a59:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a5c:	c9                   	leave
     a5d:	c3                   	ret
     a5e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     a60:	83 ec 0c             	sub    $0xc,%esp
     a63:	ff 73 04             	push   0x4(%ebx)
     a66:	e8 b5 ff ff ff       	call   a20 <nulterminate>
    break;
     a6b:	83 c4 10             	add    $0x10,%esp
     a6e:	eb e7                	jmp    a57 <nulterminate+0x37>
    for(i=0; ecmd->argv[i]; i++)
     a70:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a73:	8d 43 08             	lea    0x8(%ebx),%eax
     a76:	85 c9                	test   %ecx,%ecx
     a78:	74 dd                	je     a57 <nulterminate+0x37>
     a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a80:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     a83:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     a86:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a89:	8b 50 fc             	mov    -0x4(%eax),%edx
     a8c:	85 d2                	test   %edx,%edx
     a8e:	75 f0                	jne    a80 <nulterminate+0x60>
     a90:	eb c5                	jmp    a57 <nulterminate+0x37>
     a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    nulterminate(rcmd->cmd);
     a98:	83 ec 0c             	sub    $0xc,%esp
     a9b:	ff 73 04             	push   0x4(%ebx)
     a9e:	e8 7d ff ff ff       	call   a20 <nulterminate>
    *rcmd->efile = 0;
     aa3:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     aa6:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     aa9:	c6 00 00             	movb   $0x0,(%eax)
    break;
     aac:	eb a9                	jmp    a57 <nulterminate+0x37>
     aae:	66 90                	xchg   %ax,%ax
    return 0;
     ab0:	31 c0                	xor    %eax,%eax
     ab2:	eb a5                	jmp    a59 <nulterminate+0x39>
     ab4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     abf:	90                   	nop

00000ac0 <parsecmd>:
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	57                   	push   %edi
     ac4:	56                   	push   %esi
  cmd = parseline(&s, es);
     ac5:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     ac8:	53                   	push   %ebx
     ac9:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     acc:	8b 5d 08             	mov    0x8(%ebp),%ebx
     acf:	53                   	push   %ebx
     ad0:	e8 eb 00 00 00       	call   bc0 <strlen>
  cmd = parseline(&s, es);
     ad5:	59                   	pop    %ecx
     ad6:	5e                   	pop    %esi
  es = s + strlen(s);
     ad7:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     ad9:	53                   	push   %ebx
     ada:	57                   	push   %edi
     adb:	e8 d0 fd ff ff       	call   8b0 <parseline>
  peek(&s, es, "");
     ae0:	83 c4 0c             	add    $0xc,%esp
     ae3:	68 16 12 00 00       	push   $0x1216
  cmd = parseline(&s, es);
     ae8:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     aea:	53                   	push   %ebx
     aeb:	57                   	push   %edi
     aec:	e8 4f fa ff ff       	call   540 <peek>
  if(s != es){
     af1:	8b 45 08             	mov    0x8(%ebp),%eax
     af4:	83 c4 10             	add    $0x10,%esp
     af7:	39 d8                	cmp    %ebx,%eax
     af9:	75 13                	jne    b0e <parsecmd+0x4e>
  nulterminate(cmd);
     afb:	83 ec 0c             	sub    $0xc,%esp
     afe:	56                   	push   %esi
     aff:	e8 1c ff ff ff       	call   a20 <nulterminate>
}
     b04:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b07:	89 f0                	mov    %esi,%eax
     b09:	5b                   	pop    %ebx
     b0a:	5e                   	pop    %esi
     b0b:	5f                   	pop    %edi
     b0c:	5d                   	pop    %ebp
     b0d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     b0e:	52                   	push   %edx
     b0f:	50                   	push   %eax
     b10:	68 a8 12 00 00       	push   $0x12a8
     b15:	6a 02                	push   $0x2
     b17:	e8 b4 03 00 00       	call   ed0 <printf>
    panic("syntax");
     b1c:	c7 04 24 6c 12 00 00 	movl   $0x126c,(%esp)
     b23:	e8 48 f6 ff ff       	call   170 <panic>
     b28:	66 90                	xchg   %ax,%ax
     b2a:	66 90                	xchg   %ax,%ax
     b2c:	66 90                	xchg   %ax,%ax
     b2e:	66 90                	xchg   %ax,%ax

00000b30 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     b30:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b31:	31 c0                	xor    %eax,%eax
{
     b33:	89 e5                	mov    %esp,%ebp
     b35:	53                   	push   %ebx
     b36:	8b 4d 08             	mov    0x8(%ebp),%ecx
     b39:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     b40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     b44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     b47:	83 c0 01             	add    $0x1,%eax
     b4a:	84 d2                	test   %dl,%dl
     b4c:	75 f2                	jne    b40 <strcpy+0x10>
    ;
  return os;
}
     b4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b51:	89 c8                	mov    %ecx,%eax
     b53:	c9                   	leave
     b54:	c3                   	ret
     b55:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b60 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	53                   	push   %ebx
     b64:	8b 55 08             	mov    0x8(%ebp),%edx
     b67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b6a:	0f b6 02             	movzbl (%edx),%eax
     b6d:	84 c0                	test   %al,%al
     b6f:	75 17                	jne    b88 <strcmp+0x28>
     b71:	eb 3a                	jmp    bad <strcmp+0x4d>
     b73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b77:	90                   	nop
     b78:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     b7c:	83 c2 01             	add    $0x1,%edx
     b7f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     b82:	84 c0                	test   %al,%al
     b84:	74 1a                	je     ba0 <strcmp+0x40>
    p++, q++;
     b86:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
     b88:	0f b6 19             	movzbl (%ecx),%ebx
     b8b:	38 c3                	cmp    %al,%bl
     b8d:	74 e9                	je     b78 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     b8f:	29 d8                	sub    %ebx,%eax
}
     b91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     b94:	c9                   	leave
     b95:	c3                   	ret
     b96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b9d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     ba0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     ba4:	31 c0                	xor    %eax,%eax
     ba6:	29 d8                	sub    %ebx,%eax
}
     ba8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bab:	c9                   	leave
     bac:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     bad:	0f b6 19             	movzbl (%ecx),%ebx
     bb0:	31 c0                	xor    %eax,%eax
     bb2:	eb db                	jmp    b8f <strcmp+0x2f>
     bb4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     bbf:	90                   	nop

00000bc0 <strlen>:

uint
strlen(char *s)
{
     bc0:	55                   	push   %ebp
     bc1:	89 e5                	mov    %esp,%ebp
     bc3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     bc6:	80 3a 00             	cmpb   $0x0,(%edx)
     bc9:	74 15                	je     be0 <strlen+0x20>
     bcb:	31 c0                	xor    %eax,%eax
     bcd:	8d 76 00             	lea    0x0(%esi),%esi
     bd0:	83 c0 01             	add    $0x1,%eax
     bd3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     bd7:	89 c1                	mov    %eax,%ecx
     bd9:	75 f5                	jne    bd0 <strlen+0x10>
    ;
  return n;
}
     bdb:	89 c8                	mov    %ecx,%eax
     bdd:	5d                   	pop    %ebp
     bde:	c3                   	ret
     bdf:	90                   	nop
  for(n = 0; s[n]; n++)
     be0:	31 c9                	xor    %ecx,%ecx
}
     be2:	5d                   	pop    %ebp
     be3:	89 c8                	mov    %ecx,%eax
     be5:	c3                   	ret
     be6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bed:	8d 76 00             	lea    0x0(%esi),%esi

00000bf0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	57                   	push   %edi
     bf4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     bf7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     bfa:	8b 45 0c             	mov    0xc(%ebp),%eax
     bfd:	89 d7                	mov    %edx,%edi
     bff:	fc                   	cld
     c00:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     c02:	8b 7d fc             	mov    -0x4(%ebp),%edi
     c05:	89 d0                	mov    %edx,%eax
     c07:	c9                   	leave
     c08:	c3                   	ret
     c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c10 <strchr>:

char*
strchr(const char *s, char c)
{
     c10:	55                   	push   %ebp
     c11:	89 e5                	mov    %esp,%ebp
     c13:	8b 45 08             	mov    0x8(%ebp),%eax
     c16:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     c1a:	0f b6 10             	movzbl (%eax),%edx
     c1d:	84 d2                	test   %dl,%dl
     c1f:	75 12                	jne    c33 <strchr+0x23>
     c21:	eb 1d                	jmp    c40 <strchr+0x30>
     c23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c27:	90                   	nop
     c28:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     c2c:	83 c0 01             	add    $0x1,%eax
     c2f:	84 d2                	test   %dl,%dl
     c31:	74 0d                	je     c40 <strchr+0x30>
    if(*s == c)
     c33:	38 d1                	cmp    %dl,%cl
     c35:	75 f1                	jne    c28 <strchr+0x18>
      return (char*)s;
  return 0;
}
     c37:	5d                   	pop    %ebp
     c38:	c3                   	ret
     c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     c40:	31 c0                	xor    %eax,%eax
}
     c42:	5d                   	pop    %ebp
     c43:	c3                   	ret
     c44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c4f:	90                   	nop

00000c50 <gets>:

char*
gets(char *buf, int max)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	57                   	push   %edi
     c54:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     c55:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     c58:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     c59:	31 db                	xor    %ebx,%ebx
{
     c5b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     c5e:	eb 27                	jmp    c87 <gets+0x37>
    cc = read(0, &c, 1);
     c60:	83 ec 04             	sub    $0x4,%esp
     c63:	6a 01                	push   $0x1
     c65:	56                   	push   %esi
     c66:	6a 00                	push   $0x0
     c68:	e8 1e 01 00 00       	call   d8b <read>
    if(cc < 1)
     c6d:	83 c4 10             	add    $0x10,%esp
     c70:	85 c0                	test   %eax,%eax
     c72:	7e 1d                	jle    c91 <gets+0x41>
      break;
    buf[i++] = c;
     c74:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c78:	8b 55 08             	mov    0x8(%ebp),%edx
     c7b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     c7f:	3c 0a                	cmp    $0xa,%al
     c81:	74 10                	je     c93 <gets+0x43>
     c83:	3c 0d                	cmp    $0xd,%al
     c85:	74 0c                	je     c93 <gets+0x43>
  for(i=0; i+1 < max; ){
     c87:	89 df                	mov    %ebx,%edi
     c89:	83 c3 01             	add    $0x1,%ebx
     c8c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c8f:	7c cf                	jl     c60 <gets+0x10>
     c91:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     c93:	8b 45 08             	mov    0x8(%ebp),%eax
     c96:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c9d:	5b                   	pop    %ebx
     c9e:	5e                   	pop    %esi
     c9f:	5f                   	pop    %edi
     ca0:	5d                   	pop    %ebp
     ca1:	c3                   	ret
     ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <stat>:

int
stat(char *n, struct stat *st)
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	56                   	push   %esi
     cb4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cb5:	83 ec 08             	sub    $0x8,%esp
     cb8:	6a 00                	push   $0x0
     cba:	ff 75 08             	push   0x8(%ebp)
     cbd:	e8 f1 00 00 00       	call   db3 <open>
  if(fd < 0)
     cc2:	83 c4 10             	add    $0x10,%esp
     cc5:	85 c0                	test   %eax,%eax
     cc7:	78 27                	js     cf0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     cc9:	83 ec 08             	sub    $0x8,%esp
     ccc:	ff 75 0c             	push   0xc(%ebp)
     ccf:	89 c3                	mov    %eax,%ebx
     cd1:	50                   	push   %eax
     cd2:	e8 f4 00 00 00       	call   dcb <fstat>
  close(fd);
     cd7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     cda:	89 c6                	mov    %eax,%esi
  close(fd);
     cdc:	e8 ba 00 00 00       	call   d9b <close>
  return r;
     ce1:	83 c4 10             	add    $0x10,%esp
}
     ce4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ce7:	89 f0                	mov    %esi,%eax
     ce9:	5b                   	pop    %ebx
     cea:	5e                   	pop    %esi
     ceb:	5d                   	pop    %ebp
     cec:	c3                   	ret
     ced:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     cf0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     cf5:	eb ed                	jmp    ce4 <stat+0x34>
     cf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cfe:	66 90                	xchg   %ax,%ax

00000d00 <atoi>:

int
atoi(const char *s)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	53                   	push   %ebx
     d04:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d07:	0f be 02             	movsbl (%edx),%eax
     d0a:	8d 48 d0             	lea    -0x30(%eax),%ecx
     d0d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     d10:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     d15:	77 1e                	ja     d35 <atoi+0x35>
     d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d1e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     d20:	83 c2 01             	add    $0x1,%edx
     d23:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     d26:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     d2a:	0f be 02             	movsbl (%edx),%eax
     d2d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     d30:	80 fb 09             	cmp    $0x9,%bl
     d33:	76 eb                	jbe    d20 <atoi+0x20>
  return n;
}
     d35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d38:	89 c8                	mov    %ecx,%eax
     d3a:	c9                   	leave
     d3b:	c3                   	ret
     d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000d40 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	57                   	push   %edi
     d44:	56                   	push   %esi
     d45:	8b 45 10             	mov    0x10(%ebp),%eax
     d48:	8b 55 08             	mov    0x8(%ebp),%edx
     d4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d4e:	85 c0                	test   %eax,%eax
     d50:	7e 13                	jle    d65 <memmove+0x25>
     d52:	01 d0                	add    %edx,%eax
  dst = vdst;
     d54:	89 d7                	mov    %edx,%edi
     d56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d5d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     d60:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     d61:	39 f8                	cmp    %edi,%eax
     d63:	75 fb                	jne    d60 <memmove+0x20>
  return vdst;
}
     d65:	5e                   	pop    %esi
     d66:	89 d0                	mov    %edx,%eax
     d68:	5f                   	pop    %edi
     d69:	5d                   	pop    %ebp
     d6a:	c3                   	ret

00000d6b <fork>:
     d6b:	b8 01 00 00 00       	mov    $0x1,%eax
     d70:	cd 40                	int    $0x40
     d72:	c3                   	ret

00000d73 <exit>:
     d73:	b8 02 00 00 00       	mov    $0x2,%eax
     d78:	cd 40                	int    $0x40
     d7a:	c3                   	ret

00000d7b <wait>:
     d7b:	b8 03 00 00 00       	mov    $0x3,%eax
     d80:	cd 40                	int    $0x40
     d82:	c3                   	ret

00000d83 <pipe>:
     d83:	b8 04 00 00 00       	mov    $0x4,%eax
     d88:	cd 40                	int    $0x40
     d8a:	c3                   	ret

00000d8b <read>:
     d8b:	b8 05 00 00 00       	mov    $0x5,%eax
     d90:	cd 40                	int    $0x40
     d92:	c3                   	ret

00000d93 <write>:
     d93:	b8 10 00 00 00       	mov    $0x10,%eax
     d98:	cd 40                	int    $0x40
     d9a:	c3                   	ret

00000d9b <close>:
     d9b:	b8 15 00 00 00       	mov    $0x15,%eax
     da0:	cd 40                	int    $0x40
     da2:	c3                   	ret

00000da3 <kill>:
     da3:	b8 06 00 00 00       	mov    $0x6,%eax
     da8:	cd 40                	int    $0x40
     daa:	c3                   	ret

00000dab <exec>:
     dab:	b8 07 00 00 00       	mov    $0x7,%eax
     db0:	cd 40                	int    $0x40
     db2:	c3                   	ret

00000db3 <open>:
     db3:	b8 0f 00 00 00       	mov    $0xf,%eax
     db8:	cd 40                	int    $0x40
     dba:	c3                   	ret

00000dbb <mknod>:
     dbb:	b8 11 00 00 00       	mov    $0x11,%eax
     dc0:	cd 40                	int    $0x40
     dc2:	c3                   	ret

00000dc3 <unlink>:
     dc3:	b8 12 00 00 00       	mov    $0x12,%eax
     dc8:	cd 40                	int    $0x40
     dca:	c3                   	ret

00000dcb <fstat>:
     dcb:	b8 08 00 00 00       	mov    $0x8,%eax
     dd0:	cd 40                	int    $0x40
     dd2:	c3                   	ret

00000dd3 <link>:
     dd3:	b8 13 00 00 00       	mov    $0x13,%eax
     dd8:	cd 40                	int    $0x40
     dda:	c3                   	ret

00000ddb <mkdir>:
     ddb:	b8 14 00 00 00       	mov    $0x14,%eax
     de0:	cd 40                	int    $0x40
     de2:	c3                   	ret

00000de3 <chdir>:
     de3:	b8 09 00 00 00       	mov    $0x9,%eax
     de8:	cd 40                	int    $0x40
     dea:	c3                   	ret

00000deb <dup>:
     deb:	b8 0a 00 00 00       	mov    $0xa,%eax
     df0:	cd 40                	int    $0x40
     df2:	c3                   	ret

00000df3 <getpid>:
     df3:	b8 0b 00 00 00       	mov    $0xb,%eax
     df8:	cd 40                	int    $0x40
     dfa:	c3                   	ret

00000dfb <sbrk>:
     dfb:	b8 0c 00 00 00       	mov    $0xc,%eax
     e00:	cd 40                	int    $0x40
     e02:	c3                   	ret

00000e03 <sleep>:
     e03:	b8 0d 00 00 00       	mov    $0xd,%eax
     e08:	cd 40                	int    $0x40
     e0a:	c3                   	ret

00000e0b <uptime>:
     e0b:	b8 0e 00 00 00       	mov    $0xe,%eax
     e10:	cd 40                	int    $0x40
     e12:	c3                   	ret

00000e13 <shutdown>:
     e13:	b8 16 00 00 00       	mov    $0x16,%eax
     e18:	cd 40                	int    $0x40
     e1a:	c3                   	ret

00000e1b <cps>:
     e1b:	b8 17 00 00 00       	mov    $0x17,%eax
     e20:	cd 40                	int    $0x40
     e22:	c3                   	ret

00000e23 <chpr>:
     e23:	b8 18 00 00 00       	mov    $0x18,%eax
     e28:	cd 40                	int    $0x40
     e2a:	c3                   	ret
     e2b:	66 90                	xchg   %ax,%ax
     e2d:	66 90                	xchg   %ax,%ax
     e2f:	90                   	nop

00000e30 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	57                   	push   %edi
     e34:	56                   	push   %esi
     e35:	53                   	push   %ebx
     e36:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     e38:	89 d1                	mov    %edx,%ecx
{
     e3a:	83 ec 3c             	sub    $0x3c,%esp
     e3d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
     e40:	85 d2                	test   %edx,%edx
     e42:	0f 89 80 00 00 00    	jns    ec8 <printint+0x98>
     e48:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     e4c:	74 7a                	je     ec8 <printint+0x98>
    x = -xx;
     e4e:	f7 d9                	neg    %ecx
    neg = 1;
     e50:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
     e55:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     e58:	31 f6                	xor    %esi,%esi
     e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     e60:	89 c8                	mov    %ecx,%eax
     e62:	31 d2                	xor    %edx,%edx
     e64:	89 f7                	mov    %esi,%edi
     e66:	f7 f3                	div    %ebx
     e68:	8d 76 01             	lea    0x1(%esi),%esi
     e6b:	0f b6 92 80 13 00 00 	movzbl 0x1380(%edx),%edx
     e72:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
     e76:	89 ca                	mov    %ecx,%edx
     e78:	89 c1                	mov    %eax,%ecx
     e7a:	39 da                	cmp    %ebx,%edx
     e7c:	73 e2                	jae    e60 <printint+0x30>
  if(neg)
     e7e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e81:	85 c0                	test   %eax,%eax
     e83:	74 07                	je     e8c <printint+0x5c>
    buf[i++] = '-';
     e85:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
     e8a:	89 f7                	mov    %esi,%edi
     e8c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     e8f:	8b 75 c0             	mov    -0x40(%ebp),%esi
     e92:	01 df                	add    %ebx,%edi
     e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
     e98:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
     e9b:	83 ec 04             	sub    $0x4,%esp
     e9e:	88 45 d7             	mov    %al,-0x29(%ebp)
     ea1:	8d 45 d7             	lea    -0x29(%ebp),%eax
     ea4:	6a 01                	push   $0x1
     ea6:	50                   	push   %eax
     ea7:	56                   	push   %esi
     ea8:	e8 e6 fe ff ff       	call   d93 <write>
  while(--i >= 0)
     ead:	89 f8                	mov    %edi,%eax
     eaf:	83 c4 10             	add    $0x10,%esp
     eb2:	83 ef 01             	sub    $0x1,%edi
     eb5:	39 d8                	cmp    %ebx,%eax
     eb7:	75 df                	jne    e98 <printint+0x68>
}
     eb9:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ebc:	5b                   	pop    %ebx
     ebd:	5e                   	pop    %esi
     ebe:	5f                   	pop    %edi
     ebf:	5d                   	pop    %ebp
     ec0:	c3                   	ret
     ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     ec8:	31 c0                	xor    %eax,%eax
     eca:	eb 89                	jmp    e55 <printint+0x25>
     ecc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ed0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	57                   	push   %edi
     ed4:	56                   	push   %esi
     ed5:	53                   	push   %ebx
     ed6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ed9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
     edc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
     edf:	0f b6 1e             	movzbl (%esi),%ebx
     ee2:	83 c6 01             	add    $0x1,%esi
     ee5:	84 db                	test   %bl,%bl
     ee7:	74 67                	je     f50 <printf+0x80>
     ee9:	8d 4d 10             	lea    0x10(%ebp),%ecx
     eec:	31 d2                	xor    %edx,%edx
     eee:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     ef1:	eb 34                	jmp    f27 <printf+0x57>
     ef3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ef7:	90                   	nop
     ef8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     efb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     f00:	83 f8 25             	cmp    $0x25,%eax
     f03:	74 18                	je     f1d <printf+0x4d>
  write(fd, &c, 1);
     f05:	83 ec 04             	sub    $0x4,%esp
     f08:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f0b:	88 5d e7             	mov    %bl,-0x19(%ebp)
     f0e:	6a 01                	push   $0x1
     f10:	50                   	push   %eax
     f11:	57                   	push   %edi
     f12:	e8 7c fe ff ff       	call   d93 <write>
     f17:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
     f1a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     f1d:	0f b6 1e             	movzbl (%esi),%ebx
     f20:	83 c6 01             	add    $0x1,%esi
     f23:	84 db                	test   %bl,%bl
     f25:	74 29                	je     f50 <printf+0x80>
    c = fmt[i] & 0xff;
     f27:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     f2a:	85 d2                	test   %edx,%edx
     f2c:	74 ca                	je     ef8 <printf+0x28>
      }
    } else if(state == '%'){
     f2e:	83 fa 25             	cmp    $0x25,%edx
     f31:	75 ea                	jne    f1d <printf+0x4d>
      if(c == 'd'){
     f33:	83 f8 25             	cmp    $0x25,%eax
     f36:	0f 84 24 01 00 00    	je     1060 <printf+0x190>
     f3c:	83 e8 63             	sub    $0x63,%eax
     f3f:	83 f8 15             	cmp    $0x15,%eax
     f42:	77 1c                	ja     f60 <printf+0x90>
     f44:	ff 24 85 28 13 00 00 	jmp    *0x1328(,%eax,4)
     f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f4f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f53:	5b                   	pop    %ebx
     f54:	5e                   	pop    %esi
     f55:	5f                   	pop    %edi
     f56:	5d                   	pop    %ebp
     f57:	c3                   	ret
     f58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f5f:	90                   	nop
  write(fd, &c, 1);
     f60:	83 ec 04             	sub    $0x4,%esp
     f63:	8d 55 e7             	lea    -0x19(%ebp),%edx
     f66:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f6a:	6a 01                	push   $0x1
     f6c:	52                   	push   %edx
     f6d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f70:	57                   	push   %edi
     f71:	e8 1d fe ff ff       	call   d93 <write>
     f76:	83 c4 0c             	add    $0xc,%esp
     f79:	88 5d e7             	mov    %bl,-0x19(%ebp)
     f7c:	6a 01                	push   $0x1
     f7e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f81:	52                   	push   %edx
     f82:	57                   	push   %edi
     f83:	e8 0b fe ff ff       	call   d93 <write>
        putc(fd, c);
     f88:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f8b:	31 d2                	xor    %edx,%edx
     f8d:	eb 8e                	jmp    f1d <printf+0x4d>
     f8f:	90                   	nop
        printint(fd, *ap, 16, 0);
     f90:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     f93:	83 ec 0c             	sub    $0xc,%esp
     f96:	b9 10 00 00 00       	mov    $0x10,%ecx
     f9b:	8b 13                	mov    (%ebx),%edx
     f9d:	6a 00                	push   $0x0
     f9f:	89 f8                	mov    %edi,%eax
        ap++;
     fa1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
     fa4:	e8 87 fe ff ff       	call   e30 <printint>
        ap++;
     fa9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
     fac:	83 c4 10             	add    $0x10,%esp
      state = 0;
     faf:	31 d2                	xor    %edx,%edx
     fb1:	e9 67 ff ff ff       	jmp    f1d <printf+0x4d>
     fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fbd:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
     fc0:	8b 45 d0             	mov    -0x30(%ebp),%eax
     fc3:	8b 18                	mov    (%eax),%ebx
        ap++;
     fc5:	83 c0 04             	add    $0x4,%eax
     fc8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     fcb:	85 db                	test   %ebx,%ebx
     fcd:	0f 84 9d 00 00 00    	je     1070 <printf+0x1a0>
        while(*s != 0){
     fd3:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
     fd6:	31 d2                	xor    %edx,%edx
        while(*s != 0){
     fd8:	84 c0                	test   %al,%al
     fda:	0f 84 3d ff ff ff    	je     f1d <printf+0x4d>
     fe0:	8d 55 e7             	lea    -0x19(%ebp),%edx
     fe3:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     fe6:	89 de                	mov    %ebx,%esi
     fe8:	89 d3                	mov    %edx,%ebx
     fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
     ff0:	83 ec 04             	sub    $0x4,%esp
     ff3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
     ff6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
     ff9:	6a 01                	push   $0x1
     ffb:	53                   	push   %ebx
     ffc:	57                   	push   %edi
     ffd:	e8 91 fd ff ff       	call   d93 <write>
        while(*s != 0){
    1002:	0f b6 06             	movzbl (%esi),%eax
    1005:	83 c4 10             	add    $0x10,%esp
    1008:	84 c0                	test   %al,%al
    100a:	75 e4                	jne    ff0 <printf+0x120>
      state = 0;
    100c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    100f:	31 d2                	xor    %edx,%edx
    1011:	e9 07 ff ff ff       	jmp    f1d <printf+0x4d>
    1016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    101d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    1020:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1023:	83 ec 0c             	sub    $0xc,%esp
    1026:	b9 0a 00 00 00       	mov    $0xa,%ecx
    102b:	8b 13                	mov    (%ebx),%edx
    102d:	6a 01                	push   $0x1
    102f:	e9 6b ff ff ff       	jmp    f9f <printf+0xcf>
    1034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    1038:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    103b:	83 ec 04             	sub    $0x4,%esp
    103e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    1041:	8b 03                	mov    (%ebx),%eax
        ap++;
    1043:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    1046:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1049:	6a 01                	push   $0x1
    104b:	52                   	push   %edx
    104c:	57                   	push   %edi
    104d:	e8 41 fd ff ff       	call   d93 <write>
        ap++;
    1052:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1055:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1058:	31 d2                	xor    %edx,%edx
    105a:	e9 be fe ff ff       	jmp    f1d <printf+0x4d>
    105f:	90                   	nop
  write(fd, &c, 1);
    1060:	83 ec 04             	sub    $0x4,%esp
    1063:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1066:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1069:	6a 01                	push   $0x1
    106b:	e9 11 ff ff ff       	jmp    f81 <printf+0xb1>
    1070:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1075:	bb 20 13 00 00       	mov    $0x1320,%ebx
    107a:	e9 61 ff ff ff       	jmp    fe0 <printf+0x110>
    107f:	90                   	nop

00001080 <free>:
    1080:	55                   	push   %ebp
    1081:	a1 a4 19 00 00       	mov    0x19a4,%eax
    1086:	89 e5                	mov    %esp,%ebp
    1088:	57                   	push   %edi
    1089:	56                   	push   %esi
    108a:	53                   	push   %ebx
    108b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    108e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1098:	89 c2                	mov    %eax,%edx
    109a:	8b 00                	mov    (%eax),%eax
    109c:	39 ca                	cmp    %ecx,%edx
    109e:	73 30                	jae    10d0 <free+0x50>
    10a0:	39 c1                	cmp    %eax,%ecx
    10a2:	72 04                	jb     10a8 <free+0x28>
    10a4:	39 c2                	cmp    %eax,%edx
    10a6:	72 f0                	jb     1098 <free+0x18>
    10a8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    10ab:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    10ae:	39 f8                	cmp    %edi,%eax
    10b0:	74 2e                	je     10e0 <free+0x60>
    10b2:	89 43 f8             	mov    %eax,-0x8(%ebx)
    10b5:	8b 42 04             	mov    0x4(%edx),%eax
    10b8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    10bb:	39 f1                	cmp    %esi,%ecx
    10bd:	74 38                	je     10f7 <free+0x77>
    10bf:	89 0a                	mov    %ecx,(%edx)
    10c1:	5b                   	pop    %ebx
    10c2:	89 15 a4 19 00 00    	mov    %edx,0x19a4
    10c8:	5e                   	pop    %esi
    10c9:	5f                   	pop    %edi
    10ca:	5d                   	pop    %ebp
    10cb:	c3                   	ret
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    10d0:	39 c1                	cmp    %eax,%ecx
    10d2:	72 d0                	jb     10a4 <free+0x24>
    10d4:	eb c2                	jmp    1098 <free+0x18>
    10d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10dd:	8d 76 00             	lea    0x0(%esi),%esi
    10e0:	03 70 04             	add    0x4(%eax),%esi
    10e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    10e6:	8b 02                	mov    (%edx),%eax
    10e8:	8b 00                	mov    (%eax),%eax
    10ea:	89 43 f8             	mov    %eax,-0x8(%ebx)
    10ed:	8b 42 04             	mov    0x4(%edx),%eax
    10f0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    10f3:	39 f1                	cmp    %esi,%ecx
    10f5:	75 c8                	jne    10bf <free+0x3f>
    10f7:	03 43 fc             	add    -0x4(%ebx),%eax
    10fa:	89 15 a4 19 00 00    	mov    %edx,0x19a4
    1100:	89 42 04             	mov    %eax,0x4(%edx)
    1103:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1106:	89 0a                	mov    %ecx,(%edx)
    1108:	5b                   	pop    %ebx
    1109:	5e                   	pop    %esi
    110a:	5f                   	pop    %edi
    110b:	5d                   	pop    %ebp
    110c:	c3                   	ret
    110d:	8d 76 00             	lea    0x0(%esi),%esi

00001110 <malloc>:
    1110:	55                   	push   %ebp
    1111:	89 e5                	mov    %esp,%ebp
    1113:	57                   	push   %edi
    1114:	56                   	push   %esi
    1115:	53                   	push   %ebx
    1116:	83 ec 0c             	sub    $0xc,%esp
    1119:	8b 45 08             	mov    0x8(%ebp),%eax
    111c:	8b 15 a4 19 00 00    	mov    0x19a4,%edx
    1122:	8d 78 07             	lea    0x7(%eax),%edi
    1125:	c1 ef 03             	shr    $0x3,%edi
    1128:	83 c7 01             	add    $0x1,%edi
    112b:	85 d2                	test   %edx,%edx
    112d:	0f 84 8d 00 00 00    	je     11c0 <malloc+0xb0>
    1133:	8b 02                	mov    (%edx),%eax
    1135:	8b 48 04             	mov    0x4(%eax),%ecx
    1138:	39 f9                	cmp    %edi,%ecx
    113a:	73 64                	jae    11a0 <malloc+0x90>
    113c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1141:	39 df                	cmp    %ebx,%edi
    1143:	0f 43 df             	cmovae %edi,%ebx
    1146:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    114d:	eb 0a                	jmp    1159 <malloc+0x49>
    114f:	90                   	nop
    1150:	8b 02                	mov    (%edx),%eax
    1152:	8b 48 04             	mov    0x4(%eax),%ecx
    1155:	39 f9                	cmp    %edi,%ecx
    1157:	73 47                	jae    11a0 <malloc+0x90>
    1159:	89 c2                	mov    %eax,%edx
    115b:	39 05 a4 19 00 00    	cmp    %eax,0x19a4
    1161:	75 ed                	jne    1150 <malloc+0x40>
    1163:	83 ec 0c             	sub    $0xc,%esp
    1166:	56                   	push   %esi
    1167:	e8 8f fc ff ff       	call   dfb <sbrk>
    116c:	83 c4 10             	add    $0x10,%esp
    116f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1172:	74 1c                	je     1190 <malloc+0x80>
    1174:	89 58 04             	mov    %ebx,0x4(%eax)
    1177:	83 ec 0c             	sub    $0xc,%esp
    117a:	83 c0 08             	add    $0x8,%eax
    117d:	50                   	push   %eax
    117e:	e8 fd fe ff ff       	call   1080 <free>
    1183:	8b 15 a4 19 00 00    	mov    0x19a4,%edx
    1189:	83 c4 10             	add    $0x10,%esp
    118c:	85 d2                	test   %edx,%edx
    118e:	75 c0                	jne    1150 <malloc+0x40>
    1190:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1193:	31 c0                	xor    %eax,%eax
    1195:	5b                   	pop    %ebx
    1196:	5e                   	pop    %esi
    1197:	5f                   	pop    %edi
    1198:	5d                   	pop    %ebp
    1199:	c3                   	ret
    119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11a0:	39 cf                	cmp    %ecx,%edi
    11a2:	74 4c                	je     11f0 <malloc+0xe0>
    11a4:	29 f9                	sub    %edi,%ecx
    11a6:	89 48 04             	mov    %ecx,0x4(%eax)
    11a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    11ac:	89 78 04             	mov    %edi,0x4(%eax)
    11af:	89 15 a4 19 00 00    	mov    %edx,0x19a4
    11b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11b8:	83 c0 08             	add    $0x8,%eax
    11bb:	5b                   	pop    %ebx
    11bc:	5e                   	pop    %esi
    11bd:	5f                   	pop    %edi
    11be:	5d                   	pop    %ebp
    11bf:	c3                   	ret
    11c0:	c7 05 a4 19 00 00 a8 	movl   $0x19a8,0x19a4
    11c7:	19 00 00 
    11ca:	b8 a8 19 00 00       	mov    $0x19a8,%eax
    11cf:	c7 05 a8 19 00 00 a8 	movl   $0x19a8,0x19a8
    11d6:	19 00 00 
    11d9:	c7 05 ac 19 00 00 00 	movl   $0x0,0x19ac
    11e0:	00 00 00 
    11e3:	e9 54 ff ff ff       	jmp    113c <malloc+0x2c>
    11e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    11ef:	90                   	nop
    11f0:	8b 08                	mov    (%eax),%ecx
    11f2:	89 0a                	mov    %ecx,(%edx)
    11f4:	eb b9                	jmp    11af <malloc+0x9f>
