
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
      26:	68 46 13 00 00       	push   $0x1346
      2b:	e8 23 0e 00 00       	call   e53 <open>
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
      40:	80 3d e2 19 00 00 20 	cmpb   $0x20,0x19e2
      47:	0f 84 8d 00 00 00    	je     da <main+0xda>
      4d:	8d 76 00             	lea    0x0(%esi),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 b6 0d 00 00       	call   e0b <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 c1 00 00 00    	je     11f <main+0x11f>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	74 63                	je     c5 <main+0xc5>
    wait();
      62:	e8 b4 0d 00 00       	call   e1b <wait>
  printf(2, "$ ");
      67:	83 ec 08             	sub    $0x8,%esp
      6a:	68 98 12 00 00       	push   $0x1298
      6f:	6a 02                	push   $0x2
      71:	e8 fa 0e 00 00       	call   f70 <printf>
  memset(buf, 0, nbuf);
      76:	83 c4 0c             	add    $0xc,%esp
      79:	6a 64                	push   $0x64
      7b:	6a 00                	push   $0x0
      7d:	68 e0 19 00 00       	push   $0x19e0
      82:	e8 09 0c 00 00       	call   c90 <memset>
  gets(buf, nbuf);
      87:	58                   	pop    %eax
      88:	5a                   	pop    %edx
      89:	6a 64                	push   $0x64
      8b:	68 e0 19 00 00       	push   $0x19e0
      90:	e8 5b 0c 00 00       	call   cf0 <gets>
  if(buf[0] == 0) // EOF
      95:	0f b6 05 e0 19 00 00 	movzbl 0x19e0,%eax
      9c:	83 c4 10             	add    $0x10,%esp
      9f:	84 c0                	test   %al,%al
      a1:	74 0f                	je     b2 <main+0xb2>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a3:	3c 63                	cmp    $0x63,%al
      a5:	75 a9                	jne    50 <main+0x50>
      a7:	80 3d e1 19 00 00 64 	cmpb   $0x64,0x19e1
      ae:	75 a0                	jne    50 <main+0x50>
      b0:	eb 8e                	jmp    40 <main+0x40>
  exit();
      b2:	e8 5c 0d 00 00       	call   e13 <exit>
      close(fd);
      b7:	83 ec 0c             	sub    $0xc,%esp
      ba:	50                   	push   %eax
      bb:	e8 7b 0d 00 00       	call   e3b <close>
      break;
      c0:	83 c4 10             	add    $0x10,%esp
      c3:	eb a2                	jmp    67 <main+0x67>
      runcmd(parsecmd(buf));
      c5:	83 ec 0c             	sub    $0xc,%esp
      c8:	68 e0 19 00 00       	push   $0x19e0
      cd:	e8 8e 0a 00 00       	call   b60 <parsecmd>
      d2:	89 04 24             	mov    %eax,(%esp)
      d5:	e8 d6 00 00 00       	call   1b0 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      da:	83 ec 0c             	sub    $0xc,%esp
      dd:	68 e0 19 00 00       	push   $0x19e0
      e2:	e8 79 0b 00 00       	call   c60 <strlen>
      if(chdir(buf+3) < 0)
      e7:	c7 04 24 e3 19 00 00 	movl   $0x19e3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ee:	c6 80 df 19 00 00 00 	movb   $0x0,0x19df(%eax)
      if(chdir(buf+3) < 0)
      f5:	e8 89 0d 00 00       	call   e83 <chdir>
      fa:	83 c4 10             	add    $0x10,%esp
      fd:	85 c0                	test   %eax,%eax
      ff:	0f 89 62 ff ff ff    	jns    67 <main+0x67>
        printf(2, "cannot cd %s\n", buf+3);
     105:	51                   	push   %ecx
     106:	68 e3 19 00 00       	push   $0x19e3
     10b:	68 4e 13 00 00       	push   $0x134e
     110:	6a 02                	push   $0x2
     112:	e8 59 0e 00 00       	call   f70 <printf>
     117:	83 c4 10             	add    $0x10,%esp
     11a:	e9 48 ff ff ff       	jmp    67 <main+0x67>
    panic("fork");
     11f:	83 ec 0c             	sub    $0xc,%esp
     122:	68 9b 12 00 00       	push   $0x129b
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
     13e:	68 98 12 00 00       	push   $0x1298
     143:	6a 02                	push   $0x2
     145:	e8 26 0e 00 00       	call   f70 <printf>
  memset(buf, 0, nbuf);
     14a:	83 c4 0c             	add    $0xc,%esp
     14d:	56                   	push   %esi
     14e:	6a 00                	push   $0x0
     150:	53                   	push   %ebx
     151:	e8 3a 0b 00 00       	call   c90 <memset>
  gets(buf, nbuf);
     156:	58                   	pop    %eax
     157:	5a                   	pop    %edx
     158:	56                   	push   %esi
     159:	53                   	push   %ebx
     15a:	e8 91 0b 00 00       	call   cf0 <gets>
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
     179:	68 42 13 00 00       	push   $0x1342
     17e:	6a 02                	push   $0x2
     180:	e8 eb 0d 00 00       	call   f70 <printf>
  exit();
     185:	e8 89 0c 00 00       	call   e13 <exit>
     18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <fork1>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     196:	e8 70 0c 00 00       	call   e0b <fork>
  if(pid == -1)
     19b:	83 f8 ff             	cmp    $0xffffffff,%eax
     19e:	74 02                	je     1a2 <fork1+0x12>
  return pid;
}
     1a0:	c9                   	leave
     1a1:	c3                   	ret
    panic("fork");
     1a2:	83 ec 0c             	sub    $0xc,%esp
     1a5:	68 9b 12 00 00       	push   $0x129b
     1aa:	e8 c1 ff ff ff       	call   170 <panic>
     1af:	90                   	nop

000001b0 <runcmd>:
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	53                   	push   %ebx
     1b4:	83 ec 14             	sub    $0x14,%esp
     1b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1ba:	85 db                	test   %ebx,%ebx
     1bc:	74 23                	je     1e1 <runcmd+0x31>
  switch(cmd->type){
     1be:	83 3b 05             	cmpl   $0x5,(%ebx)
     1c1:	0f 87 d7 00 00 00    	ja     29e <runcmd+0xee>
     1c7:	8b 03                	mov    (%ebx),%eax
     1c9:	ff 24 85 7c 13 00 00 	jmp    *0x137c(,%eax,4)
    printf(2, "Redirection Not Implemented\n");
     1d0:	51                   	push   %ecx
     1d1:	51                   	push   %ecx
     1d2:	68 b7 12 00 00       	push   $0x12b7
     1d7:	6a 02                	push   $0x2
     1d9:	e8 92 0d 00 00       	call   f70 <printf>
    break;
     1de:	83 c4 10             	add    $0x10,%esp
    exit();
     1e1:	e8 2d 0c 00 00       	call   e13 <exit>
    printf(2, "Backgrounding not implemented\n");
     1e6:	50                   	push   %eax
     1e7:	50                   	push   %eax
     1e8:	68 5c 13 00 00       	push   $0x135c
     1ed:	6a 02                	push   $0x2
     1ef:	e8 7c 0d 00 00       	call   f70 <printf>
    break;
     1f4:	83 c4 10             	add    $0x10,%esp
     1f7:	eb e8                	jmp    1e1 <runcmd+0x31>
    if(ecmd->argv[0] == 0)
     1f9:	8b 43 04             	mov    0x4(%ebx),%eax
     1fc:	85 c0                	test   %eax,%eax
     1fe:	74 e1                	je     1e1 <runcmd+0x31>
    exec(ecmd->argv[0], ecmd->argv);
     200:	52                   	push   %edx
     201:	52                   	push   %edx
     202:	8d 53 04             	lea    0x4(%ebx),%edx
     205:	52                   	push   %edx
     206:	50                   	push   %eax
     207:	e8 3f 0c 00 00       	call   e4b <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     20c:	83 c4 0c             	add    $0xc,%esp
     20f:	ff 73 04             	push   0x4(%ebx)
     212:	68 a7 12 00 00       	push   $0x12a7
     217:	6a 02                	push   $0x2
     219:	e8 52 0d 00 00       	call   f70 <printf>
    break;
     21e:	83 c4 10             	add    $0x10,%esp
     221:	eb be                	jmp    1e1 <runcmd+0x31>
     if (pipe(p) < 0)
     223:	83 ec 0c             	sub    $0xc,%esp
     226:	8d 45 f0             	lea    -0x10(%ebp),%eax
     229:	50                   	push   %eax
     22a:	e8 f4 0b 00 00       	call   e23 <pipe>
     22f:	83 c4 10             	add    $0x10,%esp
     232:	85 c0                	test   %eax,%eax
     234:	0f 88 94 00 00 00    	js     2ce <runcmd+0x11e>
    if (fork1() == 0) { // First command
     23a:	e8 51 ff ff ff       	call   190 <fork1>
     23f:	85 c0                	test   %eax,%eax
     241:	0f 84 94 00 00 00    	je     2db <runcmd+0x12b>
    if (fork1() == 0) { // Second command
     247:	e8 44 ff ff ff       	call   190 <fork1>
     24c:	85 c0                	test   %eax,%eax
     24e:	0f 85 c3 00 00 00    	jne    317 <runcmd+0x167>
        close(p[1]);
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	ff 75 f4             	push   -0xc(%ebp)
     25a:	e8 dc 0b 00 00       	call   e3b <close>
        close(0);
     25f:	31 c9                	xor    %ecx,%ecx
     261:	89 0c 24             	mov    %ecx,(%esp)
     264:	e8 d2 0b 00 00       	call   e3b <close>
        dup(p[0]);
     269:	58                   	pop    %eax
     26a:	ff 75 f0             	push   -0x10(%ebp)
     26d:	e8 19 0c 00 00       	call   e8b <dup>
        close(p[0]);
     272:	58                   	pop    %eax
     273:	ff 75 f0             	push   -0x10(%ebp)
     276:	e8 c0 0b 00 00       	call   e3b <close>
        runcmd(pcmd->right);
     27b:	58                   	pop    %eax
     27c:	ff 73 08             	push   0x8(%ebx)
     27f:	e8 2c ff ff ff       	call   1b0 <runcmd>
    if(lcmd->left)
     284:	83 7b 04 00          	cmpl   $0x0,0x4(%ebx)
     288:	74 26                	je     2b0 <runcmd+0x100>
      if(fork1() == 0)
     28a:	e8 01 ff ff ff       	call   190 <fork1>
     28f:	85 c0                	test   %eax,%eax
     291:	75 18                	jne    2ab <runcmd+0xfb>
        runcmd(lcmd->left);
     293:	83 ec 0c             	sub    $0xc,%esp
     296:	ff 73 04             	push   0x4(%ebx)
     299:	e8 12 ff ff ff       	call   1b0 <runcmd>
    panic("runcmd");
     29e:	83 ec 0c             	sub    $0xc,%esp
     2a1:	68 a0 12 00 00       	push   $0x12a0
     2a6:	e8 c5 fe ff ff       	call   170 <panic>
      wait();
     2ab:	e8 6b 0b 00 00       	call   e1b <wait>
    if(lcmd->right)
     2b0:	83 7b 08 00          	cmpl   $0x0,0x8(%ebx)
     2b4:	0f 84 27 ff ff ff    	je     1e1 <runcmd+0x31>
      if(fork1() == 0)
     2ba:	e8 d1 fe ff ff       	call   190 <fork1>
     2bf:	85 c0                	test   %eax,%eax
     2c1:	75 4a                	jne    30d <runcmd+0x15d>
        runcmd(lcmd->right);
     2c3:	83 ec 0c             	sub    $0xc,%esp
     2c6:	ff 73 08             	push   0x8(%ebx)
     2c9:	e8 e2 fe ff ff       	call   1b0 <runcmd>
        panic("pipe");
     2ce:	83 ec 0c             	sub    $0xc,%esp
     2d1:	68 d4 12 00 00       	push   $0x12d4
     2d6:	e8 95 fe ff ff       	call   170 <panic>
        close(p[0]);
     2db:	83 ec 0c             	sub    $0xc,%esp
     2de:	ff 75 f0             	push   -0x10(%ebp)
     2e1:	e8 55 0b 00 00       	call   e3b <close>
        close(1);
     2e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2ed:	e8 49 0b 00 00       	call   e3b <close>
        dup(p[1]);
     2f2:	58                   	pop    %eax
     2f3:	ff 75 f4             	push   -0xc(%ebp)
     2f6:	e8 90 0b 00 00       	call   e8b <dup>
        close(p[1]);
     2fb:	58                   	pop    %eax
     2fc:	ff 75 f4             	push   -0xc(%ebp)
     2ff:	e8 37 0b 00 00       	call   e3b <close>
        runcmd(pcmd->left);
     304:	5a                   	pop    %edx
     305:	ff 73 04             	push   0x4(%ebx)
     308:	e8 a3 fe ff ff       	call   1b0 <runcmd>
      wait();
     30d:	e8 09 0b 00 00       	call   e1b <wait>
     312:	e9 ca fe ff ff       	jmp    1e1 <runcmd+0x31>
    close(p[0]);
     317:	83 ec 0c             	sub    $0xc,%esp
     31a:	ff 75 f0             	push   -0x10(%ebp)
     31d:	e8 19 0b 00 00       	call   e3b <close>
    close(p[1]);
     322:	5a                   	pop    %edx
     323:	ff 75 f4             	push   -0xc(%ebp)
     326:	e8 10 0b 00 00       	call   e3b <close>
    wait();
     32b:	e8 eb 0a 00 00       	call   e1b <wait>
    wait();
     330:	e8 e6 0a 00 00       	call   e1b <wait>
    break;
     335:	83 c4 10             	add    $0x10,%esp
     338:	e9 a4 fe ff ff       	jmp    1e1 <runcmd+0x31>
     33d:	8d 76 00             	lea    0x0(%esi),%esi

00000340 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     340:	55                   	push   %ebp
     341:	89 e5                	mov    %esp,%ebp
     343:	53                   	push   %ebx
     344:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     347:	6a 54                	push   $0x54
     349:	e8 62 0e 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     34e:	83 c4 0c             	add    $0xc,%esp
     351:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     353:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     355:	6a 00                	push   $0x0
     357:	50                   	push   %eax
     358:	e8 33 09 00 00       	call   c90 <memset>
  cmd->type = EXEC;
     35d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     363:	89 d8                	mov    %ebx,%eax
     365:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     368:	c9                   	leave
     369:	c3                   	ret
     36a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000370 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     370:	55                   	push   %ebp
     371:	89 e5                	mov    %esp,%ebp
     373:	53                   	push   %ebx
     374:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     377:	6a 18                	push   $0x18
     379:	e8 32 0e 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     37e:	83 c4 0c             	add    $0xc,%esp
     381:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     383:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     385:	6a 00                	push   $0x0
     387:	50                   	push   %eax
     388:	e8 03 09 00 00       	call   c90 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     38d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     390:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     396:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     39f:	8b 45 10             	mov    0x10(%ebp),%eax
     3a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3a5:	8b 45 14             	mov    0x14(%ebp),%eax
     3a8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3ab:	8b 45 18             	mov    0x18(%ebp),%eax
     3ae:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3b1:	89 d8                	mov    %ebx,%eax
     3b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3b6:	c9                   	leave
     3b7:	c3                   	ret
     3b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3bf:	90                   	nop

000003c0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3c0:	55                   	push   %ebp
     3c1:	89 e5                	mov    %esp,%ebp
     3c3:	53                   	push   %ebx
     3c4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c7:	6a 0c                	push   $0xc
     3c9:	e8 e2 0d 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3ce:	83 c4 0c             	add    $0xc,%esp
     3d1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     3d3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d5:	6a 00                	push   $0x0
     3d7:	50                   	push   %eax
     3d8:	e8 b3 08 00 00       	call   c90 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3dd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3e0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3e6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3e9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ec:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ef:	89 d8                	mov    %ebx,%eax
     3f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3f4:	c9                   	leave
     3f5:	c3                   	ret
     3f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     3fd:	8d 76 00             	lea    0x0(%esi),%esi

00000400 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	6a 0c                	push   $0xc
     409:	e8 a2 0d 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     40e:	83 c4 0c             	add    $0xc,%esp
     411:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     413:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     415:	6a 00                	push   $0x0
     417:	50                   	push   %eax
     418:	e8 73 08 00 00       	call   c90 <memset>
  cmd->type = LIST;
  cmd->left = left;
     41d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     420:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     426:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     429:	8b 45 0c             	mov    0xc(%ebp),%eax
     42c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     42f:	89 d8                	mov    %ebx,%eax
     431:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     434:	c9                   	leave
     435:	c3                   	ret
     436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     43d:	8d 76 00             	lea    0x0(%esi),%esi

00000440 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     447:	6a 08                	push   $0x8
     449:	e8 62 0d 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     44e:	83 c4 0c             	add    $0xc,%esp
     451:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     453:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     455:	6a 00                	push   $0x0
     457:	50                   	push   %eax
     458:	e8 33 08 00 00       	call   c90 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     45d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     460:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     466:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     469:	89 d8                	mov    %ebx,%eax
     46b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     46e:	c9                   	leave
     46f:	c3                   	ret

00000470 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     470:	55                   	push   %ebp
     471:	89 e5                	mov    %esp,%ebp
     473:	57                   	push   %edi
     474:	56                   	push   %esi
     475:	53                   	push   %ebx
     476:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     479:	8b 45 08             	mov    0x8(%ebp),%eax
{
     47c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     47f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     482:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     484:	39 df                	cmp    %ebx,%edi
     486:	72 0f                	jb     497 <gettoken+0x27>
     488:	eb 25                	jmp    4af <gettoken+0x3f>
     48a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     490:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     493:	39 fb                	cmp    %edi,%ebx
     495:	74 18                	je     4af <gettoken+0x3f>
     497:	0f be 07             	movsbl (%edi),%eax
     49a:	83 ec 08             	sub    $0x8,%esp
     49d:	50                   	push   %eax
     49e:	68 c4 19 00 00       	push   $0x19c4
     4a3:	e8 08 08 00 00       	call   cb0 <strchr>
     4a8:	83 c4 10             	add    $0x10,%esp
     4ab:	85 c0                	test   %eax,%eax
     4ad:	75 e1                	jne    490 <gettoken+0x20>
  if(q)
     4af:	85 f6                	test   %esi,%esi
     4b1:	74 02                	je     4b5 <gettoken+0x45>
    *q = s;
     4b3:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     4b5:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     4b8:	3c 3c                	cmp    $0x3c,%al
     4ba:	0f 8f d0 00 00 00    	jg     590 <gettoken+0x120>
     4c0:	3c 3a                	cmp    $0x3a,%al
     4c2:	0f 8f bc 00 00 00    	jg     584 <gettoken+0x114>
     4c8:	84 c0                	test   %al,%al
     4ca:	75 44                	jne    510 <gettoken+0xa0>
     4cc:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4ce:	8b 4d 14             	mov    0x14(%ebp),%ecx
     4d1:	85 c9                	test   %ecx,%ecx
     4d3:	74 05                	je     4da <gettoken+0x6a>
    *eq = s;
     4d5:	8b 45 14             	mov    0x14(%ebp),%eax
     4d8:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4da:	39 df                	cmp    %ebx,%edi
     4dc:	72 09                	jb     4e7 <gettoken+0x77>
     4de:	eb 1f                	jmp    4ff <gettoken+0x8f>
    s++;
     4e0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     4e3:	39 fb                	cmp    %edi,%ebx
     4e5:	74 18                	je     4ff <gettoken+0x8f>
     4e7:	0f be 07             	movsbl (%edi),%eax
     4ea:	83 ec 08             	sub    $0x8,%esp
     4ed:	50                   	push   %eax
     4ee:	68 c4 19 00 00       	push   $0x19c4
     4f3:	e8 b8 07 00 00       	call   cb0 <strchr>
     4f8:	83 c4 10             	add    $0x10,%esp
     4fb:	85 c0                	test   %eax,%eax
     4fd:	75 e1                	jne    4e0 <gettoken+0x70>
  *ps = s;
     4ff:	8b 45 08             	mov    0x8(%ebp),%eax
     502:	89 38                	mov    %edi,(%eax)
  return ret;
}
     504:	8d 65 f4             	lea    -0xc(%ebp),%esp
     507:	89 f0                	mov    %esi,%eax
     509:	5b                   	pop    %ebx
     50a:	5e                   	pop    %esi
     50b:	5f                   	pop    %edi
     50c:	5d                   	pop    %ebp
     50d:	c3                   	ret
     50e:	66 90                	xchg   %ax,%ax
  switch(*s){
     510:	79 66                	jns    578 <gettoken+0x108>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     512:	39 df                	cmp    %ebx,%edi
     514:	72 39                	jb     54f <gettoken+0xdf>
  if(eq)
     516:	8b 55 14             	mov    0x14(%ebp),%edx
     519:	85 d2                	test   %edx,%edx
     51b:	0f 84 b3 00 00 00    	je     5d4 <gettoken+0x164>
    *eq = s;
     521:	8b 45 14             	mov    0x14(%ebp),%eax
     524:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     526:	e9 a9 00 00 00       	jmp    5d4 <gettoken+0x164>
     52b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     52f:	90                   	nop
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     530:	0f be 07             	movsbl (%edi),%eax
     533:	83 ec 08             	sub    $0x8,%esp
     536:	50                   	push   %eax
     537:	68 bc 19 00 00       	push   $0x19bc
     53c:	e8 6f 07 00 00       	call   cb0 <strchr>
     541:	83 c4 10             	add    $0x10,%esp
     544:	85 c0                	test   %eax,%eax
     546:	75 1f                	jne    567 <gettoken+0xf7>
      s++;
     548:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     54b:	39 fb                	cmp    %edi,%ebx
     54d:	74 77                	je     5c6 <gettoken+0x156>
     54f:	0f be 07             	movsbl (%edi),%eax
     552:	83 ec 08             	sub    $0x8,%esp
     555:	50                   	push   %eax
     556:	68 c4 19 00 00       	push   $0x19c4
     55b:	e8 50 07 00 00       	call   cb0 <strchr>
     560:	83 c4 10             	add    $0x10,%esp
     563:	85 c0                	test   %eax,%eax
     565:	74 c9                	je     530 <gettoken+0xc0>
    ret = 'a';
     567:	be 61 00 00 00       	mov    $0x61,%esi
     56c:	e9 5d ff ff ff       	jmp    4ce <gettoken+0x5e>
     571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     578:	3c 26                	cmp    $0x26,%al
     57a:	74 08                	je     584 <gettoken+0x114>
     57c:	8d 48 d8             	lea    -0x28(%eax),%ecx
     57f:	80 f9 01             	cmp    $0x1,%cl
     582:	77 8e                	ja     512 <gettoken+0xa2>
  ret = *s;
     584:	0f be f0             	movsbl %al,%esi
    s++;
     587:	83 c7 01             	add    $0x1,%edi
    break;
     58a:	e9 3f ff ff ff       	jmp    4ce <gettoken+0x5e>
     58f:	90                   	nop
  switch(*s){
     590:	3c 3e                	cmp    $0x3e,%al
     592:	75 1c                	jne    5b0 <gettoken+0x140>
    if(*s == '>'){
     594:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     598:	74 1f                	je     5b9 <gettoken+0x149>
    s++;
     59a:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     59d:	be 3e 00 00 00       	mov    $0x3e,%esi
     5a2:	e9 27 ff ff ff       	jmp    4ce <gettoken+0x5e>
     5a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5ae:	66 90                	xchg   %ax,%ax
  switch(*s){
     5b0:	3c 7c                	cmp    $0x7c,%al
     5b2:	74 d0                	je     584 <gettoken+0x114>
     5b4:	e9 59 ff ff ff       	jmp    512 <gettoken+0xa2>
      s++;
     5b9:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     5bc:	be 2b 00 00 00       	mov    $0x2b,%esi
     5c1:	e9 08 ff ff ff       	jmp    4ce <gettoken+0x5e>
  if(eq)
     5c6:	8b 45 14             	mov    0x14(%ebp),%eax
     5c9:	85 c0                	test   %eax,%eax
     5cb:	74 05                	je     5d2 <gettoken+0x162>
    *eq = s;
     5cd:	8b 45 14             	mov    0x14(%ebp),%eax
     5d0:	89 18                	mov    %ebx,(%eax)
      s++;
     5d2:	89 df                	mov    %ebx,%edi
    ret = 'a';
     5d4:	be 61 00 00 00       	mov    $0x61,%esi
     5d9:	e9 21 ff ff ff       	jmp    4ff <gettoken+0x8f>
     5de:	66 90                	xchg   %ax,%ax

000005e0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5e0:	55                   	push   %ebp
     5e1:	89 e5                	mov    %esp,%ebp
     5e3:	57                   	push   %edi
     5e4:	56                   	push   %esi
     5e5:	53                   	push   %ebx
     5e6:	83 ec 0c             	sub    $0xc,%esp
     5e9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5ef:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5f1:	39 f3                	cmp    %esi,%ebx
     5f3:	72 12                	jb     607 <peek+0x27>
     5f5:	eb 28                	jmp    61f <peek+0x3f>
     5f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5fe:	66 90                	xchg   %ax,%ax
    s++;
     600:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     603:	39 de                	cmp    %ebx,%esi
     605:	74 18                	je     61f <peek+0x3f>
     607:	0f be 03             	movsbl (%ebx),%eax
     60a:	83 ec 08             	sub    $0x8,%esp
     60d:	50                   	push   %eax
     60e:	68 c4 19 00 00       	push   $0x19c4
     613:	e8 98 06 00 00       	call   cb0 <strchr>
     618:	83 c4 10             	add    $0x10,%esp
     61b:	85 c0                	test   %eax,%eax
     61d:	75 e1                	jne    600 <peek+0x20>
  *ps = s;
     61f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     621:	0f be 03             	movsbl (%ebx),%eax
     624:	31 d2                	xor    %edx,%edx
     626:	84 c0                	test   %al,%al
     628:	75 0e                	jne    638 <peek+0x58>
}
     62a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     62d:	89 d0                	mov    %edx,%eax
     62f:	5b                   	pop    %ebx
     630:	5e                   	pop    %esi
     631:	5f                   	pop    %edi
     632:	5d                   	pop    %ebp
     633:	c3                   	ret
     634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     638:	83 ec 08             	sub    $0x8,%esp
     63b:	50                   	push   %eax
     63c:	ff 75 10             	push   0x10(%ebp)
     63f:	e8 6c 06 00 00       	call   cb0 <strchr>
     644:	83 c4 10             	add    $0x10,%esp
     647:	31 d2                	xor    %edx,%edx
     649:	85 c0                	test   %eax,%eax
     64b:	0f 95 c2             	setne  %dl
}
     64e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     651:	5b                   	pop    %ebx
     652:	89 d0                	mov    %edx,%eax
     654:	5e                   	pop    %esi
     655:	5f                   	pop    %edi
     656:	5d                   	pop    %ebp
     657:	c3                   	ret
     658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     65f:	90                   	nop

00000660 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	57                   	push   %edi
     664:	56                   	push   %esi
     665:	53                   	push   %ebx
     666:	83 ec 2c             	sub    $0x2c,%esp
     669:	8b 75 0c             	mov    0xc(%ebp),%esi
     66c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     66f:	90                   	nop
     670:	83 ec 04             	sub    $0x4,%esp
     673:	68 f6 12 00 00       	push   $0x12f6
     678:	53                   	push   %ebx
     679:	56                   	push   %esi
     67a:	e8 61 ff ff ff       	call   5e0 <peek>
     67f:	83 c4 10             	add    $0x10,%esp
     682:	85 c0                	test   %eax,%eax
     684:	0f 84 f6 00 00 00    	je     780 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     68a:	6a 00                	push   $0x0
     68c:	6a 00                	push   $0x0
     68e:	53                   	push   %ebx
     68f:	56                   	push   %esi
     690:	e8 db fd ff ff       	call   470 <gettoken>
     695:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     697:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     69a:	50                   	push   %eax
     69b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     69e:	50                   	push   %eax
     69f:	53                   	push   %ebx
     6a0:	56                   	push   %esi
     6a1:	e8 ca fd ff ff       	call   470 <gettoken>
     6a6:	83 c4 20             	add    $0x20,%esp
     6a9:	83 f8 61             	cmp    $0x61,%eax
     6ac:	0f 85 d9 00 00 00    	jne    78b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     6b2:	83 ff 3c             	cmp    $0x3c,%edi
     6b5:	74 69                	je     720 <parseredirs+0xc0>
     6b7:	83 ff 3e             	cmp    $0x3e,%edi
     6ba:	74 05                	je     6c1 <parseredirs+0x61>
     6bc:	83 ff 2b             	cmp    $0x2b,%edi
     6bf:	75 af                	jne    670 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     6c4:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     6c7:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6ca:	89 55 d0             	mov    %edx,-0x30(%ebp)
     6cd:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     6d0:	6a 18                	push   $0x18
     6d2:	e8 d9 0a 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6d7:	83 c4 0c             	add    $0xc,%esp
     6da:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     6dc:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     6de:	6a 00                	push   $0x0
     6e0:	50                   	push   %eax
     6e1:	e8 aa 05 00 00       	call   c90 <memset>
  cmd->type = REDIR;
     6e6:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     6ec:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     6ef:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     6f2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     6f5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     6f8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     6fb:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     6fe:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     705:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     708:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      break;
     70f:	89 7d 08             	mov    %edi,0x8(%ebp)
     712:	e9 59 ff ff ff       	jmp    670 <parseredirs+0x10>
     717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     71e:	66 90                	xchg   %ax,%ax
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     720:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     723:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     726:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     729:	89 55 d0             	mov    %edx,-0x30(%ebp)
     72c:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     72f:	6a 18                	push   $0x18
     731:	e8 7a 0a 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     736:	83 c4 0c             	add    $0xc,%esp
     739:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     73b:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     73d:	6a 00                	push   $0x0
     73f:	50                   	push   %eax
     740:	e8 4b 05 00 00       	call   c90 <memset>
  cmd->cmd = subcmd;
     745:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     748:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     74b:	89 7d 08             	mov    %edi,0x8(%ebp)
  cmd->efile = efile;
     74e:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     751:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
      break;
     757:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     75a:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     75d:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     760:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     763:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     76a:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      break;
     771:	e9 fa fe ff ff       	jmp    670 <parseredirs+0x10>
     776:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     77d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     780:	8b 45 08             	mov    0x8(%ebp),%eax
     783:	8d 65 f4             	lea    -0xc(%ebp),%esp
     786:	5b                   	pop    %ebx
     787:	5e                   	pop    %esi
     788:	5f                   	pop    %edi
     789:	5d                   	pop    %ebp
     78a:	c3                   	ret
      panic("missing file for redirection");
     78b:	83 ec 0c             	sub    $0xc,%esp
     78e:	68 d9 12 00 00       	push   $0x12d9
     793:	e8 d8 f9 ff ff       	call   170 <panic>
     798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     79f:	90                   	nop

000007a0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	57                   	push   %edi
     7a4:	56                   	push   %esi
     7a5:	53                   	push   %ebx
     7a6:	83 ec 30             	sub    $0x30,%esp
     7a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     7ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     7af:	68 f9 12 00 00       	push   $0x12f9
     7b4:	56                   	push   %esi
     7b5:	53                   	push   %ebx
     7b6:	e8 25 fe ff ff       	call   5e0 <peek>
     7bb:	83 c4 10             	add    $0x10,%esp
     7be:	85 c0                	test   %eax,%eax
     7c0:	0f 85 aa 00 00 00    	jne    870 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     7c6:	83 ec 0c             	sub    $0xc,%esp
     7c9:	89 c7                	mov    %eax,%edi
     7cb:	6a 54                	push   $0x54
     7cd:	e8 de 09 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     7d2:	83 c4 0c             	add    $0xc,%esp
     7d5:	6a 54                	push   $0x54
     7d7:	6a 00                	push   $0x0
     7d9:	89 45 d0             	mov    %eax,-0x30(%ebp)
     7dc:	50                   	push   %eax
     7dd:	e8 ae 04 00 00       	call   c90 <memset>
  cmd->type = EXEC;
     7e2:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7e5:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     7e8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     7ee:	56                   	push   %esi
     7ef:	53                   	push   %ebx
     7f0:	50                   	push   %eax
     7f1:	e8 6a fe ff ff       	call   660 <parseredirs>
  while(!peek(ps, es, "|)&;")){
     7f6:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     7f9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     7fc:	eb 15                	jmp    813 <parseexec+0x73>
     7fe:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     800:	83 ec 04             	sub    $0x4,%esp
     803:	56                   	push   %esi
     804:	53                   	push   %ebx
     805:	ff 75 d4             	push   -0x2c(%ebp)
     808:	e8 53 fe ff ff       	call   660 <parseredirs>
     80d:	83 c4 10             	add    $0x10,%esp
     810:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     813:	83 ec 04             	sub    $0x4,%esp
     816:	68 10 13 00 00       	push   $0x1310
     81b:	56                   	push   %esi
     81c:	53                   	push   %ebx
     81d:	e8 be fd ff ff       	call   5e0 <peek>
     822:	83 c4 10             	add    $0x10,%esp
     825:	85 c0                	test   %eax,%eax
     827:	75 5f                	jne    888 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     829:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     82c:	50                   	push   %eax
     82d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     830:	50                   	push   %eax
     831:	56                   	push   %esi
     832:	53                   	push   %ebx
     833:	e8 38 fc ff ff       	call   470 <gettoken>
     838:	83 c4 10             	add    $0x10,%esp
     83b:	85 c0                	test   %eax,%eax
     83d:	74 49                	je     888 <parseexec+0xe8>
    if(tok != 'a')
     83f:	83 f8 61             	cmp    $0x61,%eax
     842:	75 62                	jne    8a6 <parseexec+0x106>
    cmd->argv[argc] = q;
     844:	8b 45 e0             	mov    -0x20(%ebp),%eax
     847:	8b 55 d0             	mov    -0x30(%ebp),%edx
     84a:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     84e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     851:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     855:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     858:	83 ff 0a             	cmp    $0xa,%edi
     85b:	75 a3                	jne    800 <parseexec+0x60>
      panic("too many args");
     85d:	83 ec 0c             	sub    $0xc,%esp
     860:	68 02 13 00 00       	push   $0x1302
     865:	e8 06 f9 ff ff       	call   170 <panic>
     86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     870:	89 75 0c             	mov    %esi,0xc(%ebp)
     873:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     876:	8d 65 f4             	lea    -0xc(%ebp),%esp
     879:	5b                   	pop    %ebx
     87a:	5e                   	pop    %esi
     87b:	5f                   	pop    %edi
     87c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     87d:	e9 ae 01 00 00       	jmp    a30 <parseblock>
     882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     888:	8b 45 d0             	mov    -0x30(%ebp),%eax
     88b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     892:	00 
  cmd->eargv[argc] = 0;
     893:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     89a:	00 
}
     89b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     89e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8a1:	5b                   	pop    %ebx
     8a2:	5e                   	pop    %esi
     8a3:	5f                   	pop    %edi
     8a4:	5d                   	pop    %ebp
     8a5:	c3                   	ret
      panic("syntax");
     8a6:	83 ec 0c             	sub    $0xc,%esp
     8a9:	68 fb 12 00 00       	push   $0x12fb
     8ae:	e8 bd f8 ff ff       	call   170 <panic>
     8b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008c0 <parsepipe>:
{
     8c0:	55                   	push   %ebp
     8c1:	89 e5                	mov    %esp,%ebp
     8c3:	57                   	push   %edi
     8c4:	56                   	push   %esi
     8c5:	53                   	push   %ebx
     8c6:	83 ec 14             	sub    $0x14,%esp
     8c9:	8b 75 08             	mov    0x8(%ebp),%esi
     8cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     8cf:	57                   	push   %edi
     8d0:	56                   	push   %esi
     8d1:	e8 ca fe ff ff       	call   7a0 <parseexec>
  if(peek(ps, es, "|")){
     8d6:	83 c4 0c             	add    $0xc,%esp
     8d9:	68 15 13 00 00       	push   $0x1315
  cmd = parseexec(ps, es);
     8de:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     8e0:	57                   	push   %edi
     8e1:	56                   	push   %esi
     8e2:	e8 f9 fc ff ff       	call   5e0 <peek>
     8e7:	83 c4 10             	add    $0x10,%esp
     8ea:	85 c0                	test   %eax,%eax
     8ec:	75 12                	jne    900 <parsepipe+0x40>
}
     8ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8f1:	89 d8                	mov    %ebx,%eax
     8f3:	5b                   	pop    %ebx
     8f4:	5e                   	pop    %esi
     8f5:	5f                   	pop    %edi
     8f6:	5d                   	pop    %ebp
     8f7:	c3                   	ret
     8f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8ff:	90                   	nop
    gettoken(ps, es, 0, 0);
     900:	6a 00                	push   $0x0
     902:	6a 00                	push   $0x0
     904:	57                   	push   %edi
     905:	56                   	push   %esi
     906:	e8 65 fb ff ff       	call   470 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     90b:	58                   	pop    %eax
     90c:	5a                   	pop    %edx
     90d:	57                   	push   %edi
     90e:	56                   	push   %esi
     90f:	e8 ac ff ff ff       	call   8c0 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     914:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     91b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     91d:	e8 8e 08 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     922:	83 c4 0c             	add    $0xc,%esp
     925:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     927:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     929:	6a 00                	push   $0x0
     92b:	50                   	push   %eax
     92c:	e8 5f 03 00 00       	call   c90 <memset>
  cmd->left = left;
     931:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     934:	83 c4 10             	add    $0x10,%esp
     937:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     939:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     93f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     941:	89 7e 08             	mov    %edi,0x8(%esi)
}
     944:	8d 65 f4             	lea    -0xc(%ebp),%esp
     947:	5b                   	pop    %ebx
     948:	5e                   	pop    %esi
     949:	5f                   	pop    %edi
     94a:	5d                   	pop    %ebp
     94b:	c3                   	ret
     94c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000950 <parseline>:
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	83 ec 24             	sub    $0x24,%esp
     959:	8b 75 08             	mov    0x8(%ebp),%esi
     95c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     95f:	57                   	push   %edi
     960:	56                   	push   %esi
     961:	e8 5a ff ff ff       	call   8c0 <parsepipe>
  while(peek(ps, es, "&")){
     966:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     969:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     96b:	eb 3b                	jmp    9a8 <parseline+0x58>
     96d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     970:	6a 00                	push   $0x0
     972:	6a 00                	push   $0x0
     974:	57                   	push   %edi
     975:	56                   	push   %esi
     976:	e8 f5 fa ff ff       	call   470 <gettoken>
  cmd = malloc(sizeof(*cmd));
     97b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     982:	e8 29 08 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     987:	83 c4 0c             	add    $0xc,%esp
     98a:	6a 08                	push   $0x8
     98c:	6a 00                	push   $0x0
     98e:	50                   	push   %eax
     98f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     992:	e8 f9 02 00 00       	call   c90 <memset>
  cmd->type = BACK;
     997:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     99a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     99d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     9a3:	89 5a 04             	mov    %ebx,0x4(%edx)
     9a6:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     9a8:	83 ec 04             	sub    $0x4,%esp
     9ab:	68 17 13 00 00       	push   $0x1317
     9b0:	57                   	push   %edi
     9b1:	56                   	push   %esi
     9b2:	e8 29 fc ff ff       	call   5e0 <peek>
     9b7:	83 c4 10             	add    $0x10,%esp
     9ba:	85 c0                	test   %eax,%eax
     9bc:	75 b2                	jne    970 <parseline+0x20>
  if(peek(ps, es, ";")){
     9be:	83 ec 04             	sub    $0x4,%esp
     9c1:	68 13 13 00 00       	push   $0x1313
     9c6:	57                   	push   %edi
     9c7:	56                   	push   %esi
     9c8:	e8 13 fc ff ff       	call   5e0 <peek>
     9cd:	83 c4 10             	add    $0x10,%esp
     9d0:	85 c0                	test   %eax,%eax
     9d2:	75 0c                	jne    9e0 <parseline+0x90>
}
     9d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     9d7:	89 d8                	mov    %ebx,%eax
     9d9:	5b                   	pop    %ebx
     9da:	5e                   	pop    %esi
     9db:	5f                   	pop    %edi
     9dc:	5d                   	pop    %ebp
     9dd:	c3                   	ret
     9de:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     9e0:	6a 00                	push   $0x0
     9e2:	6a 00                	push   $0x0
     9e4:	57                   	push   %edi
     9e5:	56                   	push   %esi
     9e6:	e8 85 fa ff ff       	call   470 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     9eb:	58                   	pop    %eax
     9ec:	5a                   	pop    %edx
     9ed:	57                   	push   %edi
     9ee:	56                   	push   %esi
     9ef:	e8 5c ff ff ff       	call   950 <parseline>
  cmd = malloc(sizeof(*cmd));
     9f4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     9fb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     9fd:	e8 ae 07 00 00       	call   11b0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a02:	83 c4 0c             	add    $0xc,%esp
     a05:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     a07:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     a09:	6a 00                	push   $0x0
     a0b:	50                   	push   %eax
     a0c:	e8 7f 02 00 00       	call   c90 <memset>
  cmd->left = left;
     a11:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     a14:	83 c4 10             	add    $0x10,%esp
     a17:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     a19:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     a1f:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     a21:	89 7e 08             	mov    %edi,0x8(%esi)
}
     a24:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a27:	5b                   	pop    %ebx
     a28:	5e                   	pop    %esi
     a29:	5f                   	pop    %edi
     a2a:	5d                   	pop    %ebp
     a2b:	c3                   	ret
     a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a30 <parseblock>:
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	53                   	push   %ebx
     a36:	83 ec 10             	sub    $0x10,%esp
     a39:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     a3f:	68 f9 12 00 00       	push   $0x12f9
     a44:	56                   	push   %esi
     a45:	53                   	push   %ebx
     a46:	e8 95 fb ff ff       	call   5e0 <peek>
     a4b:	83 c4 10             	add    $0x10,%esp
     a4e:	85 c0                	test   %eax,%eax
     a50:	74 4a                	je     a9c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     a52:	6a 00                	push   $0x0
     a54:	6a 00                	push   $0x0
     a56:	56                   	push   %esi
     a57:	53                   	push   %ebx
     a58:	e8 13 fa ff ff       	call   470 <gettoken>
  cmd = parseline(ps, es);
     a5d:	58                   	pop    %eax
     a5e:	5a                   	pop    %edx
     a5f:	56                   	push   %esi
     a60:	53                   	push   %ebx
     a61:	e8 ea fe ff ff       	call   950 <parseline>
  if(!peek(ps, es, ")"))
     a66:	83 c4 0c             	add    $0xc,%esp
     a69:	68 35 13 00 00       	push   $0x1335
  cmd = parseline(ps, es);
     a6e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     a70:	56                   	push   %esi
     a71:	53                   	push   %ebx
     a72:	e8 69 fb ff ff       	call   5e0 <peek>
     a77:	83 c4 10             	add    $0x10,%esp
     a7a:	85 c0                	test   %eax,%eax
     a7c:	74 2b                	je     aa9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     a7e:	6a 00                	push   $0x0
     a80:	6a 00                	push   $0x0
     a82:	56                   	push   %esi
     a83:	53                   	push   %ebx
     a84:	e8 e7 f9 ff ff       	call   470 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     a89:	83 c4 0c             	add    $0xc,%esp
     a8c:	56                   	push   %esi
     a8d:	53                   	push   %ebx
     a8e:	57                   	push   %edi
     a8f:	e8 cc fb ff ff       	call   660 <parseredirs>
}
     a94:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a97:	5b                   	pop    %ebx
     a98:	5e                   	pop    %esi
     a99:	5f                   	pop    %edi
     a9a:	5d                   	pop    %ebp
     a9b:	c3                   	ret
    panic("parseblock");
     a9c:	83 ec 0c             	sub    $0xc,%esp
     a9f:	68 19 13 00 00       	push   $0x1319
     aa4:	e8 c7 f6 ff ff       	call   170 <panic>
    panic("syntax - missing )");
     aa9:	83 ec 0c             	sub    $0xc,%esp
     aac:	68 24 13 00 00       	push   $0x1324
     ab1:	e8 ba f6 ff ff       	call   170 <panic>
     ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     abd:	8d 76 00             	lea    0x0(%esi),%esi

00000ac0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	53                   	push   %ebx
     ac4:	83 ec 04             	sub    $0x4,%esp
     ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     aca:	85 db                	test   %ebx,%ebx
     acc:	0f 84 7e 00 00 00    	je     b50 <nulterminate+0x90>
    return 0;

  switch(cmd->type){
     ad2:	83 3b 05             	cmpl   $0x5,(%ebx)
     ad5:	77 20                	ja     af7 <nulterminate+0x37>
     ad7:	8b 03                	mov    (%ebx),%eax
     ad9:	ff 24 85 94 13 00 00 	jmp    *0x1394(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     ae0:	83 ec 0c             	sub    $0xc,%esp
     ae3:	ff 73 04             	push   0x4(%ebx)
     ae6:	e8 d5 ff ff ff       	call   ac0 <nulterminate>
    nulterminate(lcmd->right);
     aeb:	58                   	pop    %eax
     aec:	ff 73 08             	push   0x8(%ebx)
     aef:	e8 cc ff ff ff       	call   ac0 <nulterminate>
    break;
     af4:	83 c4 10             	add    $0x10,%esp
    return 0;
     af7:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     af9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     afc:	c9                   	leave
     afd:	c3                   	ret
     afe:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     b00:	83 ec 0c             	sub    $0xc,%esp
     b03:	ff 73 04             	push   0x4(%ebx)
     b06:	e8 b5 ff ff ff       	call   ac0 <nulterminate>
    break;
     b0b:	83 c4 10             	add    $0x10,%esp
     b0e:	eb e7                	jmp    af7 <nulterminate+0x37>
    for(i=0; ecmd->argv[i]; i++)
     b10:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b13:	8d 43 08             	lea    0x8(%ebx),%eax
     b16:	85 c9                	test   %ecx,%ecx
     b18:	74 dd                	je     af7 <nulterminate+0x37>
     b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     b20:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     b23:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     b26:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     b29:	8b 50 fc             	mov    -0x4(%eax),%edx
     b2c:	85 d2                	test   %edx,%edx
     b2e:	75 f0                	jne    b20 <nulterminate+0x60>
     b30:	eb c5                	jmp    af7 <nulterminate+0x37>
     b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    nulterminate(rcmd->cmd);
     b38:	83 ec 0c             	sub    $0xc,%esp
     b3b:	ff 73 04             	push   0x4(%ebx)
     b3e:	e8 7d ff ff ff       	call   ac0 <nulterminate>
    *rcmd->efile = 0;
     b43:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     b46:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     b49:	c6 00 00             	movb   $0x0,(%eax)
    break;
     b4c:	eb a9                	jmp    af7 <nulterminate+0x37>
     b4e:	66 90                	xchg   %ax,%ax
    return 0;
     b50:	31 c0                	xor    %eax,%eax
     b52:	eb a5                	jmp    af9 <nulterminate+0x39>
     b54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b5f:	90                   	nop

00000b60 <parsecmd>:
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	57                   	push   %edi
     b64:	56                   	push   %esi
  cmd = parseline(&s, es);
     b65:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     b68:	53                   	push   %ebx
     b69:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     b6c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b6f:	53                   	push   %ebx
     b70:	e8 eb 00 00 00       	call   c60 <strlen>
  cmd = parseline(&s, es);
     b75:	59                   	pop    %ecx
     b76:	5e                   	pop    %esi
  es = s + strlen(s);
     b77:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     b79:	53                   	push   %ebx
     b7a:	57                   	push   %edi
     b7b:	e8 d0 fd ff ff       	call   950 <parseline>
  peek(&s, es, "");
     b80:	83 c4 0c             	add    $0xc,%esp
     b83:	68 b6 12 00 00       	push   $0x12b6
  cmd = parseline(&s, es);
     b88:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     b8a:	53                   	push   %ebx
     b8b:	57                   	push   %edi
     b8c:	e8 4f fa ff ff       	call   5e0 <peek>
  if(s != es){
     b91:	8b 45 08             	mov    0x8(%ebp),%eax
     b94:	83 c4 10             	add    $0x10,%esp
     b97:	39 d8                	cmp    %ebx,%eax
     b99:	75 13                	jne    bae <parsecmd+0x4e>
  nulterminate(cmd);
     b9b:	83 ec 0c             	sub    $0xc,%esp
     b9e:	56                   	push   %esi
     b9f:	e8 1c ff ff ff       	call   ac0 <nulterminate>
}
     ba4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ba7:	89 f0                	mov    %esi,%eax
     ba9:	5b                   	pop    %ebx
     baa:	5e                   	pop    %esi
     bab:	5f                   	pop    %edi
     bac:	5d                   	pop    %ebp
     bad:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     bae:	52                   	push   %edx
     baf:	50                   	push   %eax
     bb0:	68 37 13 00 00       	push   $0x1337
     bb5:	6a 02                	push   $0x2
     bb7:	e8 b4 03 00 00       	call   f70 <printf>
    panic("syntax");
     bbc:	c7 04 24 fb 12 00 00 	movl   $0x12fb,(%esp)
     bc3:	e8 a8 f5 ff ff       	call   170 <panic>
     bc8:	66 90                	xchg   %ax,%ax
     bca:	66 90                	xchg   %ax,%ax
     bcc:	66 90                	xchg   %ax,%ax
     bce:	66 90                	xchg   %ax,%ax

00000bd0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     bd0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bd1:	31 c0                	xor    %eax,%eax
{
     bd3:	89 e5                	mov    %esp,%ebp
     bd5:	53                   	push   %ebx
     bd6:	8b 4d 08             	mov    0x8(%ebp),%ecx
     bd9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     be0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     be4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     be7:	83 c0 01             	add    $0x1,%eax
     bea:	84 d2                	test   %dl,%dl
     bec:	75 f2                	jne    be0 <strcpy+0x10>
    ;
  return os;
}
     bee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     bf1:	89 c8                	mov    %ecx,%eax
     bf3:	c9                   	leave
     bf4:	c3                   	ret
     bf5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	53                   	push   %ebx
     c04:	8b 55 08             	mov    0x8(%ebp),%edx
     c07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     c0a:	0f b6 02             	movzbl (%edx),%eax
     c0d:	84 c0                	test   %al,%al
     c0f:	75 17                	jne    c28 <strcmp+0x28>
     c11:	eb 3a                	jmp    c4d <strcmp+0x4d>
     c13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c17:	90                   	nop
     c18:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     c1c:	83 c2 01             	add    $0x1,%edx
     c1f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     c22:	84 c0                	test   %al,%al
     c24:	74 1a                	je     c40 <strcmp+0x40>
    p++, q++;
     c26:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
     c28:	0f b6 19             	movzbl (%ecx),%ebx
     c2b:	38 c3                	cmp    %al,%bl
     c2d:	74 e9                	je     c18 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     c2f:	29 d8                	sub    %ebx,%eax
}
     c31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c34:	c9                   	leave
     c35:	c3                   	ret
     c36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c3d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
     c40:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     c44:	31 c0                	xor    %eax,%eax
     c46:	29 d8                	sub    %ebx,%eax
}
     c48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c4b:	c9                   	leave
     c4c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     c4d:	0f b6 19             	movzbl (%ecx),%ebx
     c50:	31 c0                	xor    %eax,%eax
     c52:	eb db                	jmp    c2f <strcmp+0x2f>
     c54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c5f:	90                   	nop

00000c60 <strlen>:

uint
strlen(char *s)
{
     c60:	55                   	push   %ebp
     c61:	89 e5                	mov    %esp,%ebp
     c63:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     c66:	80 3a 00             	cmpb   $0x0,(%edx)
     c69:	74 15                	je     c80 <strlen+0x20>
     c6b:	31 c0                	xor    %eax,%eax
     c6d:	8d 76 00             	lea    0x0(%esi),%esi
     c70:	83 c0 01             	add    $0x1,%eax
     c73:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     c77:	89 c1                	mov    %eax,%ecx
     c79:	75 f5                	jne    c70 <strlen+0x10>
    ;
  return n;
}
     c7b:	89 c8                	mov    %ecx,%eax
     c7d:	5d                   	pop    %ebp
     c7e:	c3                   	ret
     c7f:	90                   	nop
  for(n = 0; s[n]; n++)
     c80:	31 c9                	xor    %ecx,%ecx
}
     c82:	5d                   	pop    %ebp
     c83:	89 c8                	mov    %ecx,%eax
     c85:	c3                   	ret
     c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c8d:	8d 76 00             	lea    0x0(%esi),%esi

00000c90 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	57                   	push   %edi
     c94:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     c97:	8b 4d 10             	mov    0x10(%ebp),%ecx
     c9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c9d:	89 d7                	mov    %edx,%edi
     c9f:	fc                   	cld
     ca0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ca2:	8b 7d fc             	mov    -0x4(%ebp),%edi
     ca5:	89 d0                	mov    %edx,%eax
     ca7:	c9                   	leave
     ca8:	c3                   	ret
     ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000cb0 <strchr>:

char*
strchr(const char *s, char c)
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	8b 45 08             	mov    0x8(%ebp),%eax
     cb6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     cba:	0f b6 10             	movzbl (%eax),%edx
     cbd:	84 d2                	test   %dl,%dl
     cbf:	75 12                	jne    cd3 <strchr+0x23>
     cc1:	eb 1d                	jmp    ce0 <strchr+0x30>
     cc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cc7:	90                   	nop
     cc8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     ccc:	83 c0 01             	add    $0x1,%eax
     ccf:	84 d2                	test   %dl,%dl
     cd1:	74 0d                	je     ce0 <strchr+0x30>
    if(*s == c)
     cd3:	38 d1                	cmp    %dl,%cl
     cd5:	75 f1                	jne    cc8 <strchr+0x18>
      return (char*)s;
  return 0;
}
     cd7:	5d                   	pop    %ebp
     cd8:	c3                   	ret
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     ce0:	31 c0                	xor    %eax,%eax
}
     ce2:	5d                   	pop    %ebp
     ce3:	c3                   	ret
     ce4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ceb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cef:	90                   	nop

00000cf0 <gets>:

char*
gets(char *buf, int max)
{
     cf0:	55                   	push   %ebp
     cf1:	89 e5                	mov    %esp,%ebp
     cf3:	57                   	push   %edi
     cf4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     cf5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     cf8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     cf9:	31 db                	xor    %ebx,%ebx
{
     cfb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     cfe:	eb 27                	jmp    d27 <gets+0x37>
    cc = read(0, &c, 1);
     d00:	83 ec 04             	sub    $0x4,%esp
     d03:	6a 01                	push   $0x1
     d05:	56                   	push   %esi
     d06:	6a 00                	push   $0x0
     d08:	e8 1e 01 00 00       	call   e2b <read>
    if(cc < 1)
     d0d:	83 c4 10             	add    $0x10,%esp
     d10:	85 c0                	test   %eax,%eax
     d12:	7e 1d                	jle    d31 <gets+0x41>
      break;
    buf[i++] = c;
     d14:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     d18:	8b 55 08             	mov    0x8(%ebp),%edx
     d1b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     d1f:	3c 0a                	cmp    $0xa,%al
     d21:	74 10                	je     d33 <gets+0x43>
     d23:	3c 0d                	cmp    $0xd,%al
     d25:	74 0c                	je     d33 <gets+0x43>
  for(i=0; i+1 < max; ){
     d27:	89 df                	mov    %ebx,%edi
     d29:	83 c3 01             	add    $0x1,%ebx
     d2c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     d2f:	7c cf                	jl     d00 <gets+0x10>
     d31:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     d33:	8b 45 08             	mov    0x8(%ebp),%eax
     d36:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     d3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d3d:	5b                   	pop    %ebx
     d3e:	5e                   	pop    %esi
     d3f:	5f                   	pop    %edi
     d40:	5d                   	pop    %ebp
     d41:	c3                   	ret
     d42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d50 <stat>:

int
stat(char *n, struct stat *st)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	56                   	push   %esi
     d54:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d55:	83 ec 08             	sub    $0x8,%esp
     d58:	6a 00                	push   $0x0
     d5a:	ff 75 08             	push   0x8(%ebp)
     d5d:	e8 f1 00 00 00       	call   e53 <open>
  if(fd < 0)
     d62:	83 c4 10             	add    $0x10,%esp
     d65:	85 c0                	test   %eax,%eax
     d67:	78 27                	js     d90 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     d69:	83 ec 08             	sub    $0x8,%esp
     d6c:	ff 75 0c             	push   0xc(%ebp)
     d6f:	89 c3                	mov    %eax,%ebx
     d71:	50                   	push   %eax
     d72:	e8 f4 00 00 00       	call   e6b <fstat>
  close(fd);
     d77:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     d7a:	89 c6                	mov    %eax,%esi
  close(fd);
     d7c:	e8 ba 00 00 00       	call   e3b <close>
  return r;
     d81:	83 c4 10             	add    $0x10,%esp
}
     d84:	8d 65 f8             	lea    -0x8(%ebp),%esp
     d87:	89 f0                	mov    %esi,%eax
     d89:	5b                   	pop    %ebx
     d8a:	5e                   	pop    %esi
     d8b:	5d                   	pop    %ebp
     d8c:	c3                   	ret
     d8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     d90:	be ff ff ff ff       	mov    $0xffffffff,%esi
     d95:	eb ed                	jmp    d84 <stat+0x34>
     d97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d9e:	66 90                	xchg   %ax,%ax

00000da0 <atoi>:

int
atoi(const char *s)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	53                   	push   %ebx
     da4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     da7:	0f be 02             	movsbl (%edx),%eax
     daa:	8d 48 d0             	lea    -0x30(%eax),%ecx
     dad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     db0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     db5:	77 1e                	ja     dd5 <atoi+0x35>
     db7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dbe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     dc0:	83 c2 01             	add    $0x1,%edx
     dc3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     dc6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     dca:	0f be 02             	movsbl (%edx),%eax
     dcd:	8d 58 d0             	lea    -0x30(%eax),%ebx
     dd0:	80 fb 09             	cmp    $0x9,%bl
     dd3:	76 eb                	jbe    dc0 <atoi+0x20>
  return n;
}
     dd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dd8:	89 c8                	mov    %ecx,%eax
     dda:	c9                   	leave
     ddb:	c3                   	ret
     ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000de0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     de0:	55                   	push   %ebp
     de1:	89 e5                	mov    %esp,%ebp
     de3:	57                   	push   %edi
     de4:	56                   	push   %esi
     de5:	8b 45 10             	mov    0x10(%ebp),%eax
     de8:	8b 55 08             	mov    0x8(%ebp),%edx
     deb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     dee:	85 c0                	test   %eax,%eax
     df0:	7e 13                	jle    e05 <memmove+0x25>
     df2:	01 d0                	add    %edx,%eax
  dst = vdst;
     df4:	89 d7                	mov    %edx,%edi
     df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     dfd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     e00:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     e01:	39 f8                	cmp    %edi,%eax
     e03:	75 fb                	jne    e00 <memmove+0x20>
  return vdst;
}
     e05:	5e                   	pop    %esi
     e06:	89 d0                	mov    %edx,%eax
     e08:	5f                   	pop    %edi
     e09:	5d                   	pop    %ebp
     e0a:	c3                   	ret

00000e0b <fork>:
     e0b:	b8 01 00 00 00       	mov    $0x1,%eax
     e10:	cd 40                	int    $0x40
     e12:	c3                   	ret

00000e13 <exit>:
     e13:	b8 02 00 00 00       	mov    $0x2,%eax
     e18:	cd 40                	int    $0x40
     e1a:	c3                   	ret

00000e1b <wait>:
     e1b:	b8 03 00 00 00       	mov    $0x3,%eax
     e20:	cd 40                	int    $0x40
     e22:	c3                   	ret

00000e23 <pipe>:
     e23:	b8 04 00 00 00       	mov    $0x4,%eax
     e28:	cd 40                	int    $0x40
     e2a:	c3                   	ret

00000e2b <read>:
     e2b:	b8 05 00 00 00       	mov    $0x5,%eax
     e30:	cd 40                	int    $0x40
     e32:	c3                   	ret

00000e33 <write>:
     e33:	b8 10 00 00 00       	mov    $0x10,%eax
     e38:	cd 40                	int    $0x40
     e3a:	c3                   	ret

00000e3b <close>:
     e3b:	b8 15 00 00 00       	mov    $0x15,%eax
     e40:	cd 40                	int    $0x40
     e42:	c3                   	ret

00000e43 <kill>:
     e43:	b8 06 00 00 00       	mov    $0x6,%eax
     e48:	cd 40                	int    $0x40
     e4a:	c3                   	ret

00000e4b <exec>:
     e4b:	b8 07 00 00 00       	mov    $0x7,%eax
     e50:	cd 40                	int    $0x40
     e52:	c3                   	ret

00000e53 <open>:
     e53:	b8 0f 00 00 00       	mov    $0xf,%eax
     e58:	cd 40                	int    $0x40
     e5a:	c3                   	ret

00000e5b <mknod>:
     e5b:	b8 11 00 00 00       	mov    $0x11,%eax
     e60:	cd 40                	int    $0x40
     e62:	c3                   	ret

00000e63 <unlink>:
     e63:	b8 12 00 00 00       	mov    $0x12,%eax
     e68:	cd 40                	int    $0x40
     e6a:	c3                   	ret

00000e6b <fstat>:
     e6b:	b8 08 00 00 00       	mov    $0x8,%eax
     e70:	cd 40                	int    $0x40
     e72:	c3                   	ret

00000e73 <link>:
     e73:	b8 13 00 00 00       	mov    $0x13,%eax
     e78:	cd 40                	int    $0x40
     e7a:	c3                   	ret

00000e7b <mkdir>:
     e7b:	b8 14 00 00 00       	mov    $0x14,%eax
     e80:	cd 40                	int    $0x40
     e82:	c3                   	ret

00000e83 <chdir>:
     e83:	b8 09 00 00 00       	mov    $0x9,%eax
     e88:	cd 40                	int    $0x40
     e8a:	c3                   	ret

00000e8b <dup>:
     e8b:	b8 0a 00 00 00       	mov    $0xa,%eax
     e90:	cd 40                	int    $0x40
     e92:	c3                   	ret

00000e93 <getpid>:
     e93:	b8 0b 00 00 00       	mov    $0xb,%eax
     e98:	cd 40                	int    $0x40
     e9a:	c3                   	ret

00000e9b <sbrk>:
     e9b:	b8 0c 00 00 00       	mov    $0xc,%eax
     ea0:	cd 40                	int    $0x40
     ea2:	c3                   	ret

00000ea3 <sleep>:
     ea3:	b8 0d 00 00 00       	mov    $0xd,%eax
     ea8:	cd 40                	int    $0x40
     eaa:	c3                   	ret

00000eab <uptime>:
     eab:	b8 0e 00 00 00       	mov    $0xe,%eax
     eb0:	cd 40                	int    $0x40
     eb2:	c3                   	ret

00000eb3 <shutdown>:
     eb3:	b8 16 00 00 00       	mov    $0x16,%eax
     eb8:	cd 40                	int    $0x40
     eba:	c3                   	ret

00000ebb <cps>:
     ebb:	b8 17 00 00 00       	mov    $0x17,%eax
     ec0:	cd 40                	int    $0x40
     ec2:	c3                   	ret

00000ec3 <chpr>:
     ec3:	b8 18 00 00 00       	mov    $0x18,%eax
     ec8:	cd 40                	int    $0x40
     eca:	c3                   	ret
     ecb:	66 90                	xchg   %ax,%ax
     ecd:	66 90                	xchg   %ax,%ax
     ecf:	90                   	nop

00000ed0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     ed0:	55                   	push   %ebp
     ed1:	89 e5                	mov    %esp,%ebp
     ed3:	57                   	push   %edi
     ed4:	56                   	push   %esi
     ed5:	53                   	push   %ebx
     ed6:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     ed8:	89 d1                	mov    %edx,%ecx
{
     eda:	83 ec 3c             	sub    $0x3c,%esp
     edd:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
     ee0:	85 d2                	test   %edx,%edx
     ee2:	0f 89 80 00 00 00    	jns    f68 <printint+0x98>
     ee8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     eec:	74 7a                	je     f68 <printint+0x98>
    x = -xx;
     eee:	f7 d9                	neg    %ecx
    neg = 1;
     ef0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
     ef5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     ef8:	31 f6                	xor    %esi,%esi
     efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     f00:	89 c8                	mov    %ecx,%eax
     f02:	31 d2                	xor    %edx,%edx
     f04:	89 f7                	mov    %esi,%edi
     f06:	f7 f3                	div    %ebx
     f08:	8d 76 01             	lea    0x1(%esi),%esi
     f0b:	0f b6 92 0c 14 00 00 	movzbl 0x140c(%edx),%edx
     f12:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
     f16:	89 ca                	mov    %ecx,%edx
     f18:	89 c1                	mov    %eax,%ecx
     f1a:	39 da                	cmp    %ebx,%edx
     f1c:	73 e2                	jae    f00 <printint+0x30>
  if(neg)
     f1e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     f21:	85 c0                	test   %eax,%eax
     f23:	74 07                	je     f2c <printint+0x5c>
    buf[i++] = '-';
     f25:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
     f2a:	89 f7                	mov    %esi,%edi
     f2c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
     f2f:	8b 75 c0             	mov    -0x40(%ebp),%esi
     f32:	01 df                	add    %ebx,%edi
     f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
     f38:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
     f3b:	83 ec 04             	sub    $0x4,%esp
     f3e:	88 45 d7             	mov    %al,-0x29(%ebp)
     f41:	8d 45 d7             	lea    -0x29(%ebp),%eax
     f44:	6a 01                	push   $0x1
     f46:	50                   	push   %eax
     f47:	56                   	push   %esi
     f48:	e8 e6 fe ff ff       	call   e33 <write>
  while(--i >= 0)
     f4d:	89 f8                	mov    %edi,%eax
     f4f:	83 c4 10             	add    $0x10,%esp
     f52:	83 ef 01             	sub    $0x1,%edi
     f55:	39 d8                	cmp    %ebx,%eax
     f57:	75 df                	jne    f38 <printint+0x68>
}
     f59:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f5c:	5b                   	pop    %ebx
     f5d:	5e                   	pop    %esi
     f5e:	5f                   	pop    %edi
     f5f:	5d                   	pop    %ebp
     f60:	c3                   	ret
     f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     f68:	31 c0                	xor    %eax,%eax
     f6a:	eb 89                	jmp    ef5 <printint+0x25>
     f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f70 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     f70:	55                   	push   %ebp
     f71:	89 e5                	mov    %esp,%ebp
     f73:	57                   	push   %edi
     f74:	56                   	push   %esi
     f75:	53                   	push   %ebx
     f76:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f79:	8b 75 0c             	mov    0xc(%ebp),%esi
{
     f7c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
     f7f:	0f b6 1e             	movzbl (%esi),%ebx
     f82:	83 c6 01             	add    $0x1,%esi
     f85:	84 db                	test   %bl,%bl
     f87:	74 67                	je     ff0 <printf+0x80>
     f89:	8d 4d 10             	lea    0x10(%ebp),%ecx
     f8c:	31 d2                	xor    %edx,%edx
     f8e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
     f91:	eb 34                	jmp    fc7 <printf+0x57>
     f93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f97:	90                   	nop
     f98:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     f9b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     fa0:	83 f8 25             	cmp    $0x25,%eax
     fa3:	74 18                	je     fbd <printf+0x4d>
  write(fd, &c, 1);
     fa5:	83 ec 04             	sub    $0x4,%esp
     fa8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     fab:	88 5d e7             	mov    %bl,-0x19(%ebp)
     fae:	6a 01                	push   $0x1
     fb0:	50                   	push   %eax
     fb1:	57                   	push   %edi
     fb2:	e8 7c fe ff ff       	call   e33 <write>
     fb7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
     fba:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     fbd:	0f b6 1e             	movzbl (%esi),%ebx
     fc0:	83 c6 01             	add    $0x1,%esi
     fc3:	84 db                	test   %bl,%bl
     fc5:	74 29                	je     ff0 <printf+0x80>
    c = fmt[i] & 0xff;
     fc7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     fca:	85 d2                	test   %edx,%edx
     fcc:	74 ca                	je     f98 <printf+0x28>
      }
    } else if(state == '%'){
     fce:	83 fa 25             	cmp    $0x25,%edx
     fd1:	75 ea                	jne    fbd <printf+0x4d>
      if(c == 'd'){
     fd3:	83 f8 25             	cmp    $0x25,%eax
     fd6:	0f 84 24 01 00 00    	je     1100 <printf+0x190>
     fdc:	83 e8 63             	sub    $0x63,%eax
     fdf:	83 f8 15             	cmp    $0x15,%eax
     fe2:	77 1c                	ja     1000 <printf+0x90>
     fe4:	ff 24 85 b4 13 00 00 	jmp    *0x13b4(,%eax,4)
     feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     fef:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ff3:	5b                   	pop    %ebx
     ff4:	5e                   	pop    %esi
     ff5:	5f                   	pop    %edi
     ff6:	5d                   	pop    %ebp
     ff7:	c3                   	ret
     ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fff:	90                   	nop
  write(fd, &c, 1);
    1000:	83 ec 04             	sub    $0x4,%esp
    1003:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1006:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    100a:	6a 01                	push   $0x1
    100c:	52                   	push   %edx
    100d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1010:	57                   	push   %edi
    1011:	e8 1d fe ff ff       	call   e33 <write>
    1016:	83 c4 0c             	add    $0xc,%esp
    1019:	88 5d e7             	mov    %bl,-0x19(%ebp)
    101c:	6a 01                	push   $0x1
    101e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    1021:	52                   	push   %edx
    1022:	57                   	push   %edi
    1023:	e8 0b fe ff ff       	call   e33 <write>
        putc(fd, c);
    1028:	83 c4 10             	add    $0x10,%esp
      state = 0;
    102b:	31 d2                	xor    %edx,%edx
    102d:	eb 8e                	jmp    fbd <printf+0x4d>
    102f:	90                   	nop
        printint(fd, *ap, 16, 0);
    1030:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1033:	83 ec 0c             	sub    $0xc,%esp
    1036:	b9 10 00 00 00       	mov    $0x10,%ecx
    103b:	8b 13                	mov    (%ebx),%edx
    103d:	6a 00                	push   $0x0
    103f:	89 f8                	mov    %edi,%eax
        ap++;
    1041:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    1044:	e8 87 fe ff ff       	call   ed0 <printint>
        ap++;
    1049:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    104c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    104f:	31 d2                	xor    %edx,%edx
    1051:	e9 67 ff ff ff       	jmp    fbd <printf+0x4d>
    1056:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    105d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
    1060:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1063:	8b 18                	mov    (%eax),%ebx
        ap++;
    1065:	83 c0 04             	add    $0x4,%eax
    1068:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    106b:	85 db                	test   %ebx,%ebx
    106d:	0f 84 9d 00 00 00    	je     1110 <printf+0x1a0>
        while(*s != 0){
    1073:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    1076:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    1078:	84 c0                	test   %al,%al
    107a:	0f 84 3d ff ff ff    	je     fbd <printf+0x4d>
    1080:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1083:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    1086:	89 de                	mov    %ebx,%esi
    1088:	89 d3                	mov    %edx,%ebx
    108a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1090:	83 ec 04             	sub    $0x4,%esp
    1093:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1096:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1099:	6a 01                	push   $0x1
    109b:	53                   	push   %ebx
    109c:	57                   	push   %edi
    109d:	e8 91 fd ff ff       	call   e33 <write>
        while(*s != 0){
    10a2:	0f b6 06             	movzbl (%esi),%eax
    10a5:	83 c4 10             	add    $0x10,%esp
    10a8:	84 c0                	test   %al,%al
    10aa:	75 e4                	jne    1090 <printf+0x120>
      state = 0;
    10ac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    10af:	31 d2                	xor    %edx,%edx
    10b1:	e9 07 ff ff ff       	jmp    fbd <printf+0x4d>
    10b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10bd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    10c0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    10c3:	83 ec 0c             	sub    $0xc,%esp
    10c6:	b9 0a 00 00 00       	mov    $0xa,%ecx
    10cb:	8b 13                	mov    (%ebx),%edx
    10cd:	6a 01                	push   $0x1
    10cf:	e9 6b ff ff ff       	jmp    103f <printf+0xcf>
    10d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
    10d8:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    10db:	83 ec 04             	sub    $0x4,%esp
    10de:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    10e1:	8b 03                	mov    (%ebx),%eax
        ap++;
    10e3:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    10e6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    10e9:	6a 01                	push   $0x1
    10eb:	52                   	push   %edx
    10ec:	57                   	push   %edi
    10ed:	e8 41 fd ff ff       	call   e33 <write>
        ap++;
    10f2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    10f5:	83 c4 10             	add    $0x10,%esp
      state = 0;
    10f8:	31 d2                	xor    %edx,%edx
    10fa:	e9 be fe ff ff       	jmp    fbd <printf+0x4d>
    10ff:	90                   	nop
  write(fd, &c, 1);
    1100:	83 ec 04             	sub    $0x4,%esp
    1103:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1106:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1109:	6a 01                	push   $0x1
    110b:	e9 11 ff ff ff       	jmp    1021 <printf+0xb1>
    1110:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1115:	bb ac 13 00 00       	mov    $0x13ac,%ebx
    111a:	e9 61 ff ff ff       	jmp    1080 <printf+0x110>
    111f:	90                   	nop

00001120 <free>:
    1120:	55                   	push   %ebp
    1121:	a1 44 1a 00 00       	mov    0x1a44,%eax
    1126:	89 e5                	mov    %esp,%ebp
    1128:	57                   	push   %edi
    1129:	56                   	push   %esi
    112a:	53                   	push   %ebx
    112b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    112e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1138:	89 c2                	mov    %eax,%edx
    113a:	8b 00                	mov    (%eax),%eax
    113c:	39 ca                	cmp    %ecx,%edx
    113e:	73 30                	jae    1170 <free+0x50>
    1140:	39 c1                	cmp    %eax,%ecx
    1142:	72 04                	jb     1148 <free+0x28>
    1144:	39 c2                	cmp    %eax,%edx
    1146:	72 f0                	jb     1138 <free+0x18>
    1148:	8b 73 fc             	mov    -0x4(%ebx),%esi
    114b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    114e:	39 f8                	cmp    %edi,%eax
    1150:	74 2e                	je     1180 <free+0x60>
    1152:	89 43 f8             	mov    %eax,-0x8(%ebx)
    1155:	8b 42 04             	mov    0x4(%edx),%eax
    1158:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    115b:	39 f1                	cmp    %esi,%ecx
    115d:	74 38                	je     1197 <free+0x77>
    115f:	89 0a                	mov    %ecx,(%edx)
    1161:	5b                   	pop    %ebx
    1162:	89 15 44 1a 00 00    	mov    %edx,0x1a44
    1168:	5e                   	pop    %esi
    1169:	5f                   	pop    %edi
    116a:	5d                   	pop    %ebp
    116b:	c3                   	ret
    116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1170:	39 c1                	cmp    %eax,%ecx
    1172:	72 d0                	jb     1144 <free+0x24>
    1174:	eb c2                	jmp    1138 <free+0x18>
    1176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    117d:	8d 76 00             	lea    0x0(%esi),%esi
    1180:	03 70 04             	add    0x4(%eax),%esi
    1183:	89 73 fc             	mov    %esi,-0x4(%ebx)
    1186:	8b 02                	mov    (%edx),%eax
    1188:	8b 00                	mov    (%eax),%eax
    118a:	89 43 f8             	mov    %eax,-0x8(%ebx)
    118d:	8b 42 04             	mov    0x4(%edx),%eax
    1190:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1193:	39 f1                	cmp    %esi,%ecx
    1195:	75 c8                	jne    115f <free+0x3f>
    1197:	03 43 fc             	add    -0x4(%ebx),%eax
    119a:	89 15 44 1a 00 00    	mov    %edx,0x1a44
    11a0:	89 42 04             	mov    %eax,0x4(%edx)
    11a3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    11a6:	89 0a                	mov    %ecx,(%edx)
    11a8:	5b                   	pop    %ebx
    11a9:	5e                   	pop    %esi
    11aa:	5f                   	pop    %edi
    11ab:	5d                   	pop    %ebp
    11ac:	c3                   	ret
    11ad:	8d 76 00             	lea    0x0(%esi),%esi

000011b0 <malloc>:
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	57                   	push   %edi
    11b4:	56                   	push   %esi
    11b5:	53                   	push   %ebx
    11b6:	83 ec 0c             	sub    $0xc,%esp
    11b9:	8b 45 08             	mov    0x8(%ebp),%eax
    11bc:	8b 15 44 1a 00 00    	mov    0x1a44,%edx
    11c2:	8d 78 07             	lea    0x7(%eax),%edi
    11c5:	c1 ef 03             	shr    $0x3,%edi
    11c8:	83 c7 01             	add    $0x1,%edi
    11cb:	85 d2                	test   %edx,%edx
    11cd:	0f 84 8d 00 00 00    	je     1260 <malloc+0xb0>
    11d3:	8b 02                	mov    (%edx),%eax
    11d5:	8b 48 04             	mov    0x4(%eax),%ecx
    11d8:	39 f9                	cmp    %edi,%ecx
    11da:	73 64                	jae    1240 <malloc+0x90>
    11dc:	bb 00 10 00 00       	mov    $0x1000,%ebx
    11e1:	39 df                	cmp    %ebx,%edi
    11e3:	0f 43 df             	cmovae %edi,%ebx
    11e6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    11ed:	eb 0a                	jmp    11f9 <malloc+0x49>
    11ef:	90                   	nop
    11f0:	8b 02                	mov    (%edx),%eax
    11f2:	8b 48 04             	mov    0x4(%eax),%ecx
    11f5:	39 f9                	cmp    %edi,%ecx
    11f7:	73 47                	jae    1240 <malloc+0x90>
    11f9:	89 c2                	mov    %eax,%edx
    11fb:	39 05 44 1a 00 00    	cmp    %eax,0x1a44
    1201:	75 ed                	jne    11f0 <malloc+0x40>
    1203:	83 ec 0c             	sub    $0xc,%esp
    1206:	56                   	push   %esi
    1207:	e8 8f fc ff ff       	call   e9b <sbrk>
    120c:	83 c4 10             	add    $0x10,%esp
    120f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1212:	74 1c                	je     1230 <malloc+0x80>
    1214:	89 58 04             	mov    %ebx,0x4(%eax)
    1217:	83 ec 0c             	sub    $0xc,%esp
    121a:	83 c0 08             	add    $0x8,%eax
    121d:	50                   	push   %eax
    121e:	e8 fd fe ff ff       	call   1120 <free>
    1223:	8b 15 44 1a 00 00    	mov    0x1a44,%edx
    1229:	83 c4 10             	add    $0x10,%esp
    122c:	85 d2                	test   %edx,%edx
    122e:	75 c0                	jne    11f0 <malloc+0x40>
    1230:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1233:	31 c0                	xor    %eax,%eax
    1235:	5b                   	pop    %ebx
    1236:	5e                   	pop    %esi
    1237:	5f                   	pop    %edi
    1238:	5d                   	pop    %ebp
    1239:	c3                   	ret
    123a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1240:	39 cf                	cmp    %ecx,%edi
    1242:	74 4c                	je     1290 <malloc+0xe0>
    1244:	29 f9                	sub    %edi,%ecx
    1246:	89 48 04             	mov    %ecx,0x4(%eax)
    1249:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    124c:	89 78 04             	mov    %edi,0x4(%eax)
    124f:	89 15 44 1a 00 00    	mov    %edx,0x1a44
    1255:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1258:	83 c0 08             	add    $0x8,%eax
    125b:	5b                   	pop    %ebx
    125c:	5e                   	pop    %esi
    125d:	5f                   	pop    %edi
    125e:	5d                   	pop    %ebp
    125f:	c3                   	ret
    1260:	c7 05 44 1a 00 00 48 	movl   $0x1a48,0x1a44
    1267:	1a 00 00 
    126a:	b8 48 1a 00 00       	mov    $0x1a48,%eax
    126f:	c7 05 48 1a 00 00 48 	movl   $0x1a48,0x1a48
    1276:	1a 00 00 
    1279:	c7 05 4c 1a 00 00 00 	movl   $0x0,0x1a4c
    1280:	00 00 00 
    1283:	e9 54 ff ff ff       	jmp    11dc <malloc+0x2c>
    1288:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    128f:	90                   	nop
    1290:	8b 08                	mov    (%eax),%ecx
    1292:	89 0a                	mov    %ecx,(%edx)
    1294:	eb b9                	jmp    124f <malloc+0x9f>
