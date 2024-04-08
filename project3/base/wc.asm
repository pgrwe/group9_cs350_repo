
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7f 28                	jg     51 <main+0x51>
  29:	eb 54                	jmp    7f <main+0x7f>
  2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  2f:	90                   	nop
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  30:	83 ec 08             	sub    $0x8,%esp
  33:	ff 33                	push   (%ebx)
  for(i = 1; i < argc; i++){
  35:	83 c6 01             	add    $0x1,%esi
  38:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  3b:	50                   	push   %eax
  3c:	e8 5f 00 00 00       	call   a0 <wc>
    close(fd);
  41:	89 3c 24             	mov    %edi,(%esp)
  44:	e8 a2 03 00 00       	call   3eb <close>
  for(i = 1; i < argc; i++){
  49:	83 c4 10             	add    $0x10,%esp
  4c:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4f:	74 29                	je     7a <main+0x7a>
    if((fd = open(argv[i], 0)) < 0){
  51:	83 ec 08             	sub    $0x8,%esp
  54:	6a 00                	push   $0x0
  56:	ff 33                	push   (%ebx)
  58:	e8 a6 03 00 00       	call   403 <open>
  5d:	83 c4 10             	add    $0x10,%esp
  60:	89 c7                	mov    %eax,%edi
  62:	85 c0                	test   %eax,%eax
  64:	79 ca                	jns    30 <main+0x30>
      printf(1, "wc: cannot open %s\n", argv[i]);
  66:	50                   	push   %eax
  67:	ff 33                	push   (%ebx)
  69:	68 7b 08 00 00       	push   $0x87b
  6e:	6a 01                	push   $0x1
  70:	e8 bb 04 00 00       	call   530 <printf>
      exit();
  75:	e8 49 03 00 00       	call   3c3 <exit>
  }
  exit();
  7a:	e8 44 03 00 00       	call   3c3 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 6d 08 00 00       	push   $0x86d
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 31 03 00 00       	call   3c3 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  l = w = c = 0;
  a1:	31 d2                	xor    %edx,%edx
{
  a3:	89 e5                	mov    %esp,%ebp
  a5:	57                   	push   %edi
  a6:	56                   	push   %esi
  inword = 0;
  a7:	31 f6                	xor    %esi,%esi
{
  a9:	53                   	push   %ebx
  l = w = c = 0;
  aa:	31 db                	xor    %ebx,%ebx
{
  ac:	83 ec 1c             	sub    $0x1c,%esp
  l = w = c = 0;
  af:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b6:	89 55 dc             	mov    %edx,-0x24(%ebp)
  b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 e0 0b 00 00       	push   $0xbe0
  cd:	ff 75 08             	push   0x8(%ebp)
  d0:	e8 06 03 00 00       	call   3db <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	89 c1                	mov    %eax,%ecx
  da:	85 c0                	test   %eax,%eax
  dc:	7e 62                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  de:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  e1:	31 ff                	xor    %edi,%edi
  e3:	eb 0d                	jmp    f2 <wc+0x52>
  e5:	8d 76 00             	lea    0x0(%esi),%esi
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  f0:	74 3e                	je     130 <wc+0x90>
      if(buf[i] == '\n')
  f2:	0f be 87 e0 0b 00 00 	movsbl 0xbe0(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
  fb:	3c 0a                	cmp    $0xa,%al
  fd:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 100:	83 ec 08             	sub    $0x8,%esp
 103:	50                   	push   %eax
        l++;
 104:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 106:	68 58 08 00 00       	push   $0x858
 10b:	e8 50 01 00 00       	call   260 <strchr>
 110:	83 c4 10             	add    $0x10,%esp
 113:	85 c0                	test   %eax,%eax
 115:	75 d1                	jne    e8 <wc+0x48>
      else if(!inword){
 117:	85 f6                	test   %esi,%esi
 119:	75 cf                	jne    ea <wc+0x4a>
        w++;
 11b:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
 11f:	be 01 00 00 00       	mov    $0x1,%esi
    for(i=0; i<n; i++){
 124:	83 c7 01             	add    $0x1,%edi
 127:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 12a:	75 c6                	jne    f2 <wc+0x52>
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      c++;
 130:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 133:	01 4d dc             	add    %ecx,-0x24(%ebp)
 136:	eb 88                	jmp    c0 <wc+0x20>
 138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13f:	90                   	nop
  if(n < 0){
 140:	8b 55 dc             	mov    -0x24(%ebp),%edx
 143:	75 22                	jne    167 <wc+0xc7>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 145:	83 ec 08             	sub    $0x8,%esp
 148:	ff 75 0c             	push   0xc(%ebp)
 14b:	52                   	push   %edx
 14c:	ff 75 e0             	push   -0x20(%ebp)
 14f:	53                   	push   %ebx
 150:	68 6e 08 00 00       	push   $0x86e
 155:	6a 01                	push   $0x1
 157:	e8 d4 03 00 00       	call   530 <printf>
}
 15c:	83 c4 20             	add    $0x20,%esp
 15f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 162:	5b                   	pop    %ebx
 163:	5e                   	pop    %esi
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret
    printf(1, "wc: read error\n");
 167:	50                   	push   %eax
 168:	50                   	push   %eax
 169:	68 5e 08 00 00       	push   $0x85e
 16e:	6a 01                	push   $0x1
 170:	e8 bb 03 00 00       	call   530 <printf>
    exit();
 175:	e8 49 02 00 00       	call   3c3 <exit>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 180:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 181:	31 c0                	xor    %eax,%eax
{
 183:	89 e5                	mov    %esp,%ebp
 185:	53                   	push   %ebx
 186:	8b 4d 08             	mov    0x8(%ebp),%ecx
 189:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 190:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 194:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 197:	83 c0 01             	add    $0x1,%eax
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 19e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1a1:	89 c8                	mov    %ecx,%eax
 1a3:	c9                   	leave
 1a4:	c3                   	ret
 1a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	75 17                	jne    1d8 <strcmp+0x28>
 1c1:	eb 3a                	jmp    1fd <strcmp+0x4d>
 1c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c7:	90                   	nop
 1c8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 1cc:	83 c2 01             	add    $0x1,%edx
 1cf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1d2:	84 c0                	test   %al,%al
 1d4:	74 1a                	je     1f0 <strcmp+0x40>
    p++, q++;
 1d6:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 1d8:	0f b6 19             	movzbl (%ecx),%ebx
 1db:	38 c3                	cmp    %al,%bl
 1dd:	74 e9                	je     1c8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 1df:	29 d8                	sub    %ebx,%eax
}
 1e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1e4:	c9                   	leave
 1e5:	c3                   	ret
 1e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 1f0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1f4:	31 c0                	xor    %eax,%eax
 1f6:	29 d8                	sub    %ebx,%eax
}
 1f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 1fb:	c9                   	leave
 1fc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 1fd:	0f b6 19             	movzbl (%ecx),%ebx
 200:	31 c0                	xor    %eax,%eax
 202:	eb db                	jmp    1df <strcmp+0x2f>
 204:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 20f:	90                   	nop

00000210 <strlen>:

uint
strlen(char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 3a 00             	cmpb   $0x0,(%edx)
 219:	74 15                	je     230 <strlen+0x20>
 21b:	31 c0                	xor    %eax,%eax
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c0 01             	add    $0x1,%eax
 223:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 227:	89 c1                	mov    %eax,%ecx
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	89 c8                	mov    %ecx,%eax
 22d:	5d                   	pop    %ebp
 22e:	c3                   	ret
 22f:	90                   	nop
  for(n = 0; s[n]; n++)
 230:	31 c9                	xor    %ecx,%ecx
}
 232:	5d                   	pop    %ebp
 233:	89 c8                	mov    %ecx,%eax
 235:	c3                   	ret
 236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	8b 7d fc             	mov    -0x4(%ebp),%edi
 255:	89 d0                	mov    %edx,%eax
 257:	c9                   	leave
 258:	c3                   	ret
 259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 26a:	0f b6 10             	movzbl (%eax),%edx
 26d:	84 d2                	test   %dl,%dl
 26f:	75 12                	jne    283 <strchr+0x23>
 271:	eb 1d                	jmp    290 <strchr+0x30>
 273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 277:	90                   	nop
 278:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 27c:	83 c0 01             	add    $0x1,%eax
 27f:	84 d2                	test   %dl,%dl
 281:	74 0d                	je     290 <strchr+0x30>
    if(*s == c)
 283:	38 d1                	cmp    %dl,%cl
 285:	75 f1                	jne    278 <strchr+0x18>
      return (char*)s;
  return 0;
}
 287:	5d                   	pop    %ebp
 288:	c3                   	ret
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 290:	31 c0                	xor    %eax,%eax
}
 292:	5d                   	pop    %ebp
 293:	c3                   	ret
 294:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 29b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 29f:	90                   	nop

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 2a5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 2a8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 2a9:	31 db                	xor    %ebx,%ebx
{
 2ab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 2ae:	eb 27                	jmp    2d7 <gets+0x37>
    cc = read(0, &c, 1);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	6a 01                	push   $0x1
 2b5:	56                   	push   %esi
 2b6:	6a 00                	push   $0x0
 2b8:	e8 1e 01 00 00       	call   3db <read>
    if(cc < 1)
 2bd:	83 c4 10             	add    $0x10,%esp
 2c0:	85 c0                	test   %eax,%eax
 2c2:	7e 1d                	jle    2e1 <gets+0x41>
      break;
    buf[i++] = c;
 2c4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
 2cb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2cf:	3c 0a                	cmp    $0xa,%al
 2d1:	74 10                	je     2e3 <gets+0x43>
 2d3:	3c 0d                	cmp    $0xd,%al
 2d5:	74 0c                	je     2e3 <gets+0x43>
  for(i=0; i+1 < max; ){
 2d7:	89 df                	mov    %ebx,%edi
 2d9:	83 c3 01             	add    $0x1,%ebx
 2dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2df:	7c cf                	jl     2b0 <gets+0x10>
 2e1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 2ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ed:	5b                   	pop    %ebx
 2ee:	5e                   	pop    %esi
 2ef:	5f                   	pop    %edi
 2f0:	5d                   	pop    %ebp
 2f1:	c3                   	ret
 2f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <stat>:

int
stat(char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 305:	83 ec 08             	sub    $0x8,%esp
 308:	6a 00                	push   $0x0
 30a:	ff 75 08             	push   0x8(%ebp)
 30d:	e8 f1 00 00 00       	call   403 <open>
  if(fd < 0)
 312:	83 c4 10             	add    $0x10,%esp
 315:	85 c0                	test   %eax,%eax
 317:	78 27                	js     340 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	ff 75 0c             	push   0xc(%ebp)
 31f:	89 c3                	mov    %eax,%ebx
 321:	50                   	push   %eax
 322:	e8 f4 00 00 00       	call   41b <fstat>
  close(fd);
 327:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 32a:	89 c6                	mov    %eax,%esi
  close(fd);
 32c:	e8 ba 00 00 00       	call   3eb <close>
  return r;
 331:	83 c4 10             	add    $0x10,%esp
}
 334:	8d 65 f8             	lea    -0x8(%ebp),%esp
 337:	89 f0                	mov    %esi,%eax
 339:	5b                   	pop    %ebx
 33a:	5e                   	pop    %esi
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 340:	be ff ff ff ff       	mov    $0xffffffff,%esi
 345:	eb ed                	jmp    334 <stat+0x34>
 347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 34e:	66 90                	xchg   %ax,%ax

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 02             	movsbl (%edx),%eax
 35a:	8d 48 d0             	lea    -0x30(%eax),%ecx
 35d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 360:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 365:	77 1e                	ja     385 <atoi+0x35>
 367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 36e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 370:	83 c2 01             	add    $0x1,%edx
 373:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 376:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 37a:	0f be 02             	movsbl (%edx),%eax
 37d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 380:	80 fb 09             	cmp    $0x9,%bl
 383:	76 eb                	jbe    370 <atoi+0x20>
  return n;
}
 385:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 388:	89 c8                	mov    %ecx,%eax
 38a:	c9                   	leave
 38b:	c3                   	ret
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000390 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	8b 45 10             	mov    0x10(%ebp),%eax
 398:	8b 55 08             	mov    0x8(%ebp),%edx
 39b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39e:	85 c0                	test   %eax,%eax
 3a0:	7e 13                	jle    3b5 <memmove+0x25>
 3a2:	01 d0                	add    %edx,%eax
  dst = vdst;
 3a4:	89 d7                	mov    %edx,%edi
 3a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3b1:	39 f8                	cmp    %edi,%eax
 3b3:	75 fb                	jne    3b0 <memmove+0x20>
  return vdst;
}
 3b5:	5e                   	pop    %esi
 3b6:	89 d0                	mov    %edx,%eax
 3b8:	5f                   	pop    %edi
 3b9:	5d                   	pop    %ebp
 3ba:	c3                   	ret

000003bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3bb:	b8 01 00 00 00       	mov    $0x1,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <exit>:
SYSCALL(exit)
 3c3:	b8 02 00 00 00       	mov    $0x2,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <wait>:
SYSCALL(wait)
 3cb:	b8 03 00 00 00       	mov    $0x3,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <pipe>:
SYSCALL(pipe)
 3d3:	b8 04 00 00 00       	mov    $0x4,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <read>:
SYSCALL(read)
 3db:	b8 05 00 00 00       	mov    $0x5,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <write>:
SYSCALL(write)
 3e3:	b8 10 00 00 00       	mov    $0x10,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <close>:
SYSCALL(close)
 3eb:	b8 15 00 00 00       	mov    $0x15,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <kill>:
SYSCALL(kill)
 3f3:	b8 06 00 00 00       	mov    $0x6,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <exec>:
SYSCALL(exec)
 3fb:	b8 07 00 00 00       	mov    $0x7,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <open>:
SYSCALL(open)
 403:	b8 0f 00 00 00       	mov    $0xf,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <mknod>:
SYSCALL(mknod)
 40b:	b8 11 00 00 00       	mov    $0x11,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <unlink>:
SYSCALL(unlink)
 413:	b8 12 00 00 00       	mov    $0x12,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <fstat>:
SYSCALL(fstat)
 41b:	b8 08 00 00 00       	mov    $0x8,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <link>:
SYSCALL(link)
 423:	b8 13 00 00 00       	mov    $0x13,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <mkdir>:
SYSCALL(mkdir)
 42b:	b8 14 00 00 00       	mov    $0x14,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <chdir>:
SYSCALL(chdir)
 433:	b8 09 00 00 00       	mov    $0x9,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <dup>:
SYSCALL(dup)
 43b:	b8 0a 00 00 00       	mov    $0xa,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <getpid>:
SYSCALL(getpid)
 443:	b8 0b 00 00 00       	mov    $0xb,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <sbrk>:
SYSCALL(sbrk)
 44b:	b8 0c 00 00 00       	mov    $0xc,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <sleep>:
SYSCALL(sleep)
 453:	b8 0d 00 00 00       	mov    $0xd,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <uptime>:
SYSCALL(uptime)
 45b:	b8 0e 00 00 00       	mov    $0xe,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <shutdown>:
SYSCALL(shutdown)
 463:	b8 16 00 00 00       	mov    $0x16,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <cps>:
SYSCALL(cps)
 46b:	b8 17 00 00 00       	mov    $0x17,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <chpr>:
SYSCALL(chpr)
 473:	b8 18 00 00 00       	mov    $0x18,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <waitpid>:
SYSCALL(waitpid)
 47b:	b8 19 00 00 00       	mov    $0x19,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret
 483:	66 90                	xchg   %ax,%ax
 485:	66 90                	xchg   %ax,%ax
 487:	66 90                	xchg   %ax,%ax
 489:	66 90                	xchg   %ax,%ax
 48b:	66 90                	xchg   %ax,%ax
 48d:	66 90                	xchg   %ax,%ax
 48f:	90                   	nop

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 498:	89 d1                	mov    %edx,%ecx
{
 49a:	83 ec 3c             	sub    $0x3c,%esp
 49d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 4a0:	85 d2                	test   %edx,%edx
 4a2:	0f 89 80 00 00 00    	jns    528 <printint+0x98>
 4a8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ac:	74 7a                	je     528 <printint+0x98>
    x = -xx;
 4ae:	f7 d9                	neg    %ecx
    neg = 1;
 4b0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 4b5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 4b8:	31 f6                	xor    %esi,%esi
 4ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4c0:	89 c8                	mov    %ecx,%eax
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	89 f7                	mov    %esi,%edi
 4c6:	f7 f3                	div    %ebx
 4c8:	8d 76 01             	lea    0x1(%esi),%esi
 4cb:	0f b6 92 f0 08 00 00 	movzbl 0x8f0(%edx),%edx
 4d2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 4d6:	89 ca                	mov    %ecx,%edx
 4d8:	89 c1                	mov    %eax,%ecx
 4da:	39 da                	cmp    %ebx,%edx
 4dc:	73 e2                	jae    4c0 <printint+0x30>
  if(neg)
 4de:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 4e1:	85 c0                	test   %eax,%eax
 4e3:	74 07                	je     4ec <printint+0x5c>
    buf[i++] = '-';
 4e5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
 4ea:	89 f7                	mov    %esi,%edi
 4ec:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 4ef:	8b 75 c0             	mov    -0x40(%ebp),%esi
 4f2:	01 df                	add    %ebx,%edi
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
 4f8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 4fb:	83 ec 04             	sub    $0x4,%esp
 4fe:	88 45 d7             	mov    %al,-0x29(%ebp)
 501:	8d 45 d7             	lea    -0x29(%ebp),%eax
 504:	6a 01                	push   $0x1
 506:	50                   	push   %eax
 507:	56                   	push   %esi
 508:	e8 d6 fe ff ff       	call   3e3 <write>
  while(--i >= 0)
 50d:	89 f8                	mov    %edi,%eax
 50f:	83 c4 10             	add    $0x10,%esp
 512:	83 ef 01             	sub    $0x1,%edi
 515:	39 d8                	cmp    %ebx,%eax
 517:	75 df                	jne    4f8 <printint+0x68>
}
 519:	8d 65 f4             	lea    -0xc(%ebp),%esp
 51c:	5b                   	pop    %ebx
 51d:	5e                   	pop    %esi
 51e:	5f                   	pop    %edi
 51f:	5d                   	pop    %ebp
 520:	c3                   	ret
 521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 528:	31 c0                	xor    %eax,%eax
 52a:	eb 89                	jmp    4b5 <printint+0x25>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000530 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 539:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 53c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 53f:	0f b6 1e             	movzbl (%esi),%ebx
 542:	83 c6 01             	add    $0x1,%esi
 545:	84 db                	test   %bl,%bl
 547:	74 67                	je     5b0 <printf+0x80>
 549:	8d 4d 10             	lea    0x10(%ebp),%ecx
 54c:	31 d2                	xor    %edx,%edx
 54e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 551:	eb 34                	jmp    587 <printf+0x57>
 553:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 557:	90                   	nop
 558:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 55b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 560:	83 f8 25             	cmp    $0x25,%eax
 563:	74 18                	je     57d <printf+0x4d>
  write(fd, &c, 1);
 565:	83 ec 04             	sub    $0x4,%esp
 568:	8d 45 e7             	lea    -0x19(%ebp),%eax
 56b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 56e:	6a 01                	push   $0x1
 570:	50                   	push   %eax
 571:	57                   	push   %edi
 572:	e8 6c fe ff ff       	call   3e3 <write>
 577:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 57a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 57d:	0f b6 1e             	movzbl (%esi),%ebx
 580:	83 c6 01             	add    $0x1,%esi
 583:	84 db                	test   %bl,%bl
 585:	74 29                	je     5b0 <printf+0x80>
    c = fmt[i] & 0xff;
 587:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 58a:	85 d2                	test   %edx,%edx
 58c:	74 ca                	je     558 <printf+0x28>
      }
    } else if(state == '%'){
 58e:	83 fa 25             	cmp    $0x25,%edx
 591:	75 ea                	jne    57d <printf+0x4d>
      if(c == 'd'){
 593:	83 f8 25             	cmp    $0x25,%eax
 596:	0f 84 24 01 00 00    	je     6c0 <printf+0x190>
 59c:	83 e8 63             	sub    $0x63,%eax
 59f:	83 f8 15             	cmp    $0x15,%eax
 5a2:	77 1c                	ja     5c0 <printf+0x90>
 5a4:	ff 24 85 98 08 00 00 	jmp    *0x898(,%eax,4)
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b3:	5b                   	pop    %ebx
 5b4:	5e                   	pop    %esi
 5b5:	5f                   	pop    %edi
 5b6:	5d                   	pop    %ebp
 5b7:	c3                   	ret
 5b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bf:	90                   	nop
  write(fd, &c, 1);
 5c0:	83 ec 04             	sub    $0x4,%esp
 5c3:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5ca:	6a 01                	push   $0x1
 5cc:	52                   	push   %edx
 5cd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5d0:	57                   	push   %edi
 5d1:	e8 0d fe ff ff       	call   3e3 <write>
 5d6:	83 c4 0c             	add    $0xc,%esp
 5d9:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5dc:	6a 01                	push   $0x1
 5de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5e1:	52                   	push   %edx
 5e2:	57                   	push   %edi
 5e3:	e8 fb fd ff ff       	call   3e3 <write>
        putc(fd, c);
 5e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5eb:	31 d2                	xor    %edx,%edx
 5ed:	eb 8e                	jmp    57d <printf+0x4d>
 5ef:	90                   	nop
        printint(fd, *ap, 16, 0);
 5f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5f3:	83 ec 0c             	sub    $0xc,%esp
 5f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5fb:	8b 13                	mov    (%ebx),%edx
 5fd:	6a 00                	push   $0x0
 5ff:	89 f8                	mov    %edi,%eax
        ap++;
 601:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 604:	e8 87 fe ff ff       	call   490 <printint>
        ap++;
 609:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 60c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 60f:	31 d2                	xor    %edx,%edx
 611:	e9 67 ff ff ff       	jmp    57d <printf+0x4d>
 616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 620:	8b 45 d0             	mov    -0x30(%ebp),%eax
 623:	8b 18                	mov    (%eax),%ebx
        ap++;
 625:	83 c0 04             	add    $0x4,%eax
 628:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 62b:	85 db                	test   %ebx,%ebx
 62d:	0f 84 9d 00 00 00    	je     6d0 <printf+0x1a0>
        while(*s != 0){
 633:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 636:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 638:	84 c0                	test   %al,%al
 63a:	0f 84 3d ff ff ff    	je     57d <printf+0x4d>
 640:	8d 55 e7             	lea    -0x19(%ebp),%edx
 643:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 646:	89 de                	mov    %ebx,%esi
 648:	89 d3                	mov    %edx,%ebx
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 656:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 659:	6a 01                	push   $0x1
 65b:	53                   	push   %ebx
 65c:	57                   	push   %edi
 65d:	e8 81 fd ff ff       	call   3e3 <write>
        while(*s != 0){
 662:	0f b6 06             	movzbl (%esi),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x120>
      state = 0;
 66c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 07 ff ff ff       	jmp    57d <printf+0x4d>
 676:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 67d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 680:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 683:	83 ec 0c             	sub    $0xc,%esp
 686:	b9 0a 00 00 00       	mov    $0xa,%ecx
 68b:	8b 13                	mov    (%ebx),%edx
 68d:	6a 01                	push   $0x1
 68f:	e9 6b ff ff ff       	jmp    5ff <printf+0xcf>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 698:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 69b:	83 ec 04             	sub    $0x4,%esp
 69e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 6a1:	8b 03                	mov    (%ebx),%eax
        ap++;
 6a3:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 6a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6a9:	6a 01                	push   $0x1
 6ab:	52                   	push   %edx
 6ac:	57                   	push   %edi
 6ad:	e8 31 fd ff ff       	call   3e3 <write>
        ap++;
 6b2:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6b5:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6b8:	31 d2                	xor    %edx,%edx
 6ba:	e9 be fe ff ff       	jmp    57d <printf+0x4d>
 6bf:	90                   	nop
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6c6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6c9:	6a 01                	push   $0x1
 6cb:	e9 11 ff ff ff       	jmp    5e1 <printf+0xb1>
 6d0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 6d5:	bb 8f 08 00 00       	mov    $0x88f,%ebx
 6da:	e9 61 ff ff ff       	jmp    640 <printf+0x110>
 6df:	90                   	nop

000006e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e1:	a1 e0 0d 00 00       	mov    0xde0,%eax
{
 6e6:	89 e5                	mov    %esp,%ebp
 6e8:	57                   	push   %edi
 6e9:	56                   	push   %esi
 6ea:	53                   	push   %ebx
 6eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 6ee:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6f8:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fa:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fc:	39 ca                	cmp    %ecx,%edx
 6fe:	73 30                	jae    730 <free+0x50>
 700:	39 c1                	cmp    %eax,%ecx
 702:	72 04                	jb     708 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 704:	39 c2                	cmp    %eax,%edx
 706:	72 f0                	jb     6f8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 708:	8b 73 fc             	mov    -0x4(%ebx),%esi
 70b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 70e:	39 f8                	cmp    %edi,%eax
 710:	74 2e                	je     740 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 712:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 715:	8b 42 04             	mov    0x4(%edx),%eax
 718:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 71b:	39 f1                	cmp    %esi,%ecx
 71d:	74 38                	je     757 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 71f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 721:	5b                   	pop    %ebx
  freep = p;
 722:	89 15 e0 0d 00 00    	mov    %edx,0xde0
}
 728:	5e                   	pop    %esi
 729:	5f                   	pop    %edi
 72a:	5d                   	pop    %ebp
 72b:	c3                   	ret
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 730:	39 c1                	cmp    %eax,%ecx
 732:	72 d0                	jb     704 <free+0x24>
 734:	eb c2                	jmp    6f8 <free+0x18>
 736:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73d:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 740:	03 70 04             	add    0x4(%eax),%esi
 743:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 746:	8b 02                	mov    (%edx),%eax
 748:	8b 00                	mov    (%eax),%eax
 74a:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 74d:	8b 42 04             	mov    0x4(%edx),%eax
 750:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 753:	39 f1                	cmp    %esi,%ecx
 755:	75 c8                	jne    71f <free+0x3f>
    p->s.size += bp->s.size;
 757:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 75a:	89 15 e0 0d 00 00    	mov    %edx,0xde0
    p->s.size += bp->s.size;
 760:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 763:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 766:	89 0a                	mov    %ecx,(%edx)
}
 768:	5b                   	pop    %ebx
 769:	5e                   	pop    %esi
 76a:	5f                   	pop    %edi
 76b:	5d                   	pop    %ebp
 76c:	c3                   	ret
 76d:	8d 76 00             	lea    0x0(%esi),%esi

00000770 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	57                   	push   %edi
 774:	56                   	push   %esi
 775:	53                   	push   %ebx
 776:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 779:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 77c:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8d 78 07             	lea    0x7(%eax),%edi
 785:	c1 ef 03             	shr    $0x3,%edi
 788:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 78b:	85 d2                	test   %edx,%edx
 78d:	0f 84 8d 00 00 00    	je     820 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 793:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 795:	8b 48 04             	mov    0x4(%eax),%ecx
 798:	39 f9                	cmp    %edi,%ecx
 79a:	73 64                	jae    800 <malloc+0x90>
  if(nu < 4096)
 79c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7a1:	39 df                	cmp    %ebx,%edi
 7a3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7a6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7ad:	eb 0a                	jmp    7b9 <malloc+0x49>
 7af:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7b2:	8b 48 04             	mov    0x4(%eax),%ecx
 7b5:	39 f9                	cmp    %edi,%ecx
 7b7:	73 47                	jae    800 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7b9:	89 c2                	mov    %eax,%edx
 7bb:	39 05 e0 0d 00 00    	cmp    %eax,0xde0
 7c1:	75 ed                	jne    7b0 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 7c3:	83 ec 0c             	sub    $0xc,%esp
 7c6:	56                   	push   %esi
 7c7:	e8 7f fc ff ff       	call   44b <sbrk>
  if(p == (char*)-1)
 7cc:	83 c4 10             	add    $0x10,%esp
 7cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7d2:	74 1c                	je     7f0 <malloc+0x80>
  hp->s.size = nu;
 7d4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 7d7:	83 ec 0c             	sub    $0xc,%esp
 7da:	83 c0 08             	add    $0x8,%eax
 7dd:	50                   	push   %eax
 7de:	e8 fd fe ff ff       	call   6e0 <free>
  return freep;
 7e3:	8b 15 e0 0d 00 00    	mov    0xde0,%edx
      if((p = morecore(nunits)) == 0)
 7e9:	83 c4 10             	add    $0x10,%esp
 7ec:	85 d2                	test   %edx,%edx
 7ee:	75 c0                	jne    7b0 <malloc+0x40>
        return 0;
  }
}
 7f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 7f3:	31 c0                	xor    %eax,%eax
}
 7f5:	5b                   	pop    %ebx
 7f6:	5e                   	pop    %esi
 7f7:	5f                   	pop    %edi
 7f8:	5d                   	pop    %ebp
 7f9:	c3                   	ret
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 800:	39 cf                	cmp    %ecx,%edi
 802:	74 4c                	je     850 <malloc+0xe0>
        p->s.size -= nunits;
 804:	29 f9                	sub    %edi,%ecx
 806:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 809:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 80c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 80f:	89 15 e0 0d 00 00    	mov    %edx,0xde0
}
 815:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 818:	83 c0 08             	add    $0x8,%eax
}
 81b:	5b                   	pop    %ebx
 81c:	5e                   	pop    %esi
 81d:	5f                   	pop    %edi
 81e:	5d                   	pop    %ebp
 81f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 820:	c7 05 e0 0d 00 00 e4 	movl   $0xde4,0xde0
 827:	0d 00 00 
    base.s.size = 0;
 82a:	b8 e4 0d 00 00       	mov    $0xde4,%eax
    base.s.ptr = freep = prevp = &base;
 82f:	c7 05 e4 0d 00 00 e4 	movl   $0xde4,0xde4
 836:	0d 00 00 
    base.s.size = 0;
 839:	c7 05 e8 0d 00 00 00 	movl   $0x0,0xde8
 840:	00 00 00 
    if(p->s.size >= nunits){
 843:	e9 54 ff ff ff       	jmp    79c <malloc+0x2c>
 848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 84f:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 850:	8b 08                	mov    (%eax),%ecx
 852:	89 0a                	mov    %ecx,(%edx)
 854:	eb b9                	jmp    80f <malloc+0x9f>
