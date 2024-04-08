
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
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
  27:	7f 26                	jg     4f <main+0x4f>
  29:	eb 52                	jmp    7d <main+0x7d>
  2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  2f:	90                   	nop
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  30:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  33:	83 c6 01             	add    $0x1,%esi
  36:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  39:	50                   	push   %eax
  3a:	e8 51 00 00 00       	call   90 <cat>
    close(fd);
  3f:	89 3c 24             	mov    %edi,(%esp)
  42:	e8 34 03 00 00       	call   37b <close>
  for(i = 1; i < argc; i++){
  47:	83 c4 10             	add    $0x10,%esp
  4a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4d:	74 29                	je     78 <main+0x78>
    if((fd = open(argv[i], 0)) < 0){
  4f:	83 ec 08             	sub    $0x8,%esp
  52:	6a 00                	push   $0x0
  54:	ff 33                	push   (%ebx)
  56:	e8 38 03 00 00       	call   393 <open>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	89 c7                	mov    %eax,%edi
  60:	85 c0                	test   %eax,%eax
  62:	79 cc                	jns    30 <main+0x30>
      printf(1, "cat: cannot open %s\n", argv[i]);
  64:	50                   	push   %eax
  65:	ff 33                	push   (%ebx)
  67:	68 0b 08 00 00       	push   $0x80b
  6c:	6a 01                	push   $0x1
  6e:	e8 4d 04 00 00       	call   4c0 <printf>
      exit();
  73:	e8 db 02 00 00       	call   353 <exit>
  }
  exit();
  78:	e8 d6 02 00 00       	call   353 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 c7 02 00 00       	call   353 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 60 0b 00 00       	push   $0xb60
  a9:	6a 01                	push   $0x1
  ab:	e8 c3 02 00 00       	call   373 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 25                	jne    dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 60 0b 00 00       	push   $0xb60
  c4:	56                   	push   %esi
  c5:	e8 a1 02 00 00       	call   36b <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 c3                	mov    %eax,%ebx
  cf:	85 c0                	test   %eax,%eax
  d1:	7f cd                	jg     a0 <cat+0x10>
  if(n < 0){
  d3:	75 1b                	jne    f0 <cat+0x60>
}
  d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d8:	5b                   	pop    %ebx
  d9:	5e                   	pop    %esi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret
      printf(1, "cat: write error\n");
  dc:	83 ec 08             	sub    $0x8,%esp
  df:	68 e8 07 00 00       	push   $0x7e8
  e4:	6a 01                	push   $0x1
  e6:	e8 d5 03 00 00       	call   4c0 <printf>
      exit();
  eb:	e8 63 02 00 00       	call   353 <exit>
    printf(1, "cat: read error\n");
  f0:	50                   	push   %eax
  f1:	50                   	push   %eax
  f2:	68 fa 07 00 00       	push   $0x7fa
  f7:	6a 01                	push   $0x1
  f9:	e8 c2 03 00 00       	call   4c0 <printf>
    exit();
  fe:	e8 50 02 00 00       	call   353 <exit>
 103:	66 90                	xchg   %ax,%ax
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 111:	31 c0                	xor    %eax,%eax
{
 113:	89 e5                	mov    %esp,%ebp
 115:	53                   	push   %ebx
 116:	8b 4d 08             	mov    0x8(%ebp),%ecx
 119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 127:	83 c0 01             	add    $0x1,%eax
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 131:	89 c8                	mov    %ecx,%eax
 133:	c9                   	leave
 134:	c3                   	ret
 135:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 17                	jne    168 <strcmp+0x28>
 151:	eb 3a                	jmp    18d <strcmp+0x4d>
 153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 157:	90                   	nop
 158:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 15c:	83 c2 01             	add    $0x1,%edx
 15f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 162:	84 c0                	test   %al,%al
 164:	74 1a                	je     180 <strcmp+0x40>
    p++, q++;
 166:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 168:	0f b6 19             	movzbl (%ecx),%ebx
 16b:	38 c3                	cmp    %al,%bl
 16d:	74 e9                	je     158 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 16f:	29 d8                	sub    %ebx,%eax
}
 171:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 174:	c9                   	leave
 175:	c3                   	ret
 176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 180:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 184:	31 c0                	xor    %eax,%eax
 186:	29 d8                	sub    %ebx,%eax
}
 188:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18b:	c9                   	leave
 18c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 18d:	0f b6 19             	movzbl (%ecx),%ebx
 190:	31 c0                	xor    %eax,%eax
 192:	eb db                	jmp    16f <strcmp+0x2f>
 194:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <strlen>:

uint
strlen(char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 c0 01             	add    $0x1,%eax
 1b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b7:	89 c1                	mov    %eax,%ecx
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1bb:	89 c8                	mov    %ecx,%eax
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret
 1bf:	90                   	nop
  for(n = 0; s[n]; n++)
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret
 1c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1e5:	89 d0                	mov    %edx,%eax
 1e7:	c9                   	leave
 1e8:	c3                   	ret
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 12                	jne    213 <strchr+0x23>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 207:	90                   	nop
 208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 20c:	83 c0 01             	add    $0x1,%eax
 20f:	84 d2                	test   %dl,%dl
 211:	74 0d                	je     220 <strchr+0x30>
    if(*s == c)
 213:	38 d1                	cmp    %dl,%cl
 215:	75 f1                	jne    208 <strchr+0x18>
      return (char*)s;
  return 0;
}
 217:	5d                   	pop    %ebp
 218:	c3                   	ret
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret
 224:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 22f:	90                   	nop

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 235:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 238:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 239:	31 db                	xor    %ebx,%ebx
{
 23b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 23e:	eb 27                	jmp    267 <gets+0x37>
    cc = read(0, &c, 1);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	6a 01                	push   $0x1
 245:	56                   	push   %esi
 246:	6a 00                	push   $0x0
 248:	e8 1e 01 00 00       	call   36b <read>
    if(cc < 1)
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	7e 1d                	jle    271 <gets+0x41>
      break;
    buf[i++] = c;
 254:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 258:	8b 55 08             	mov    0x8(%ebp),%edx
 25b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25f:	3c 0a                	cmp    $0xa,%al
 261:	74 10                	je     273 <gets+0x43>
 263:	3c 0d                	cmp    $0xd,%al
 265:	74 0c                	je     273 <gets+0x43>
  for(i=0; i+1 < max; ){
 267:	89 df                	mov    %ebx,%edi
 269:	83 c3 01             	add    $0x1,%ebx
 26c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 26f:	7c cf                	jl     240 <gets+0x10>
 271:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 27a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27d:	5b                   	pop    %ebx
 27e:	5e                   	pop    %esi
 27f:	5f                   	pop    %edi
 280:	5d                   	pop    %ebp
 281:	c3                   	ret
 282:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000290 <stat>:

int
stat(char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	push   0x8(%ebp)
 29d:	e8 f1 00 00 00       	call   393 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	push   0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 f4 00 00 00       	call   3ab <fstat>
  close(fd);
 2b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ba:	89 c6                	mov    %eax,%esi
  close(fd);
 2bc:	e8 ba 00 00 00       	call   37b <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2de:	66 90                	xchg   %ax,%ax

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f5:	77 1e                	ja     315 <atoi+0x35>
 2f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	8b 45 10             	mov    0x10(%ebp),%eax
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c0                	test   %eax,%eax
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 d0                	add    %edx,%eax
  dst = vdst;
 334:	89 d7                	mov    %edx,%edi
 336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <shutdown>:
SYSCALL(shutdown)
 3f3:	b8 16 00 00 00       	mov    $0x16,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <cps>:
SYSCALL(cps)
 3fb:	b8 17 00 00 00       	mov    $0x17,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <chpr>:
SYSCALL(chpr)
 403:	b8 18 00 00 00       	mov    $0x18,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <waitpid>:
SYSCALL(waitpid)
 40b:	b8 19 00 00 00       	mov    $0x19,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret
 413:	66 90                	xchg   %ax,%ax
 415:	66 90                	xchg   %ax,%ax
 417:	66 90                	xchg   %ax,%ax
 419:	66 90                	xchg   %ax,%ax
 41b:	66 90                	xchg   %ax,%ax
 41d:	66 90                	xchg   %ax,%ax
 41f:	90                   	nop

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 428:	89 d1                	mov    %edx,%ecx
{
 42a:	83 ec 3c             	sub    $0x3c,%esp
 42d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 430:	85 d2                	test   %edx,%edx
 432:	0f 89 80 00 00 00    	jns    4b8 <printint+0x98>
 438:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 43c:	74 7a                	je     4b8 <printint+0x98>
    x = -xx;
 43e:	f7 d9                	neg    %ecx
    neg = 1;
 440:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 445:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 448:	31 f6                	xor    %esi,%esi
 44a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 450:	89 c8                	mov    %ecx,%eax
 452:	31 d2                	xor    %edx,%edx
 454:	89 f7                	mov    %esi,%edi
 456:	f7 f3                	div    %ebx
 458:	8d 76 01             	lea    0x1(%esi),%esi
 45b:	0f b6 92 80 08 00 00 	movzbl 0x880(%edx),%edx
 462:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 466:	89 ca                	mov    %ecx,%edx
 468:	89 c1                	mov    %eax,%ecx
 46a:	39 da                	cmp    %ebx,%edx
 46c:	73 e2                	jae    450 <printint+0x30>
  if(neg)
 46e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 471:	85 c0                	test   %eax,%eax
 473:	74 07                	je     47c <printint+0x5c>
    buf[i++] = '-';
 475:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
 47a:	89 f7                	mov    %esi,%edi
 47c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 47f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 482:	01 df                	add    %ebx,%edi
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
 488:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 48b:	83 ec 04             	sub    $0x4,%esp
 48e:	88 45 d7             	mov    %al,-0x29(%ebp)
 491:	8d 45 d7             	lea    -0x29(%ebp),%eax
 494:	6a 01                	push   $0x1
 496:	50                   	push   %eax
 497:	56                   	push   %esi
 498:	e8 d6 fe ff ff       	call   373 <write>
  while(--i >= 0)
 49d:	89 f8                	mov    %edi,%eax
 49f:	83 c4 10             	add    $0x10,%esp
 4a2:	83 ef 01             	sub    $0x1,%edi
 4a5:	39 d8                	cmp    %ebx,%eax
 4a7:	75 df                	jne    488 <printint+0x68>
}
 4a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ac:	5b                   	pop    %ebx
 4ad:	5e                   	pop    %esi
 4ae:	5f                   	pop    %edi
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret
 4b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4b8:	31 c0                	xor    %eax,%eax
 4ba:	eb 89                	jmp    445 <printint+0x25>
 4bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4c9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4cc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4cf:	0f b6 1e             	movzbl (%esi),%ebx
 4d2:	83 c6 01             	add    $0x1,%esi
 4d5:	84 db                	test   %bl,%bl
 4d7:	74 67                	je     540 <printf+0x80>
 4d9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4dc:	31 d2                	xor    %edx,%edx
 4de:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4e1:	eb 34                	jmp    517 <printf+0x57>
 4e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e7:	90                   	nop
 4e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4eb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4f0:	83 f8 25             	cmp    $0x25,%eax
 4f3:	74 18                	je     50d <printf+0x4d>
  write(fd, &c, 1);
 4f5:	83 ec 04             	sub    $0x4,%esp
 4f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4fb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4fe:	6a 01                	push   $0x1
 500:	50                   	push   %eax
 501:	57                   	push   %edi
 502:	e8 6c fe ff ff       	call   373 <write>
 507:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 50a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 50d:	0f b6 1e             	movzbl (%esi),%ebx
 510:	83 c6 01             	add    $0x1,%esi
 513:	84 db                	test   %bl,%bl
 515:	74 29                	je     540 <printf+0x80>
    c = fmt[i] & 0xff;
 517:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 51a:	85 d2                	test   %edx,%edx
 51c:	74 ca                	je     4e8 <printf+0x28>
      }
    } else if(state == '%'){
 51e:	83 fa 25             	cmp    $0x25,%edx
 521:	75 ea                	jne    50d <printf+0x4d>
      if(c == 'd'){
 523:	83 f8 25             	cmp    $0x25,%eax
 526:	0f 84 24 01 00 00    	je     650 <printf+0x190>
 52c:	83 e8 63             	sub    $0x63,%eax
 52f:	83 f8 15             	cmp    $0x15,%eax
 532:	77 1c                	ja     550 <printf+0x90>
 534:	ff 24 85 28 08 00 00 	jmp    *0x828(,%eax,4)
 53b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 53f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 540:	8d 65 f4             	lea    -0xc(%ebp),%esp
 543:	5b                   	pop    %ebx
 544:	5e                   	pop    %esi
 545:	5f                   	pop    %edi
 546:	5d                   	pop    %ebp
 547:	c3                   	ret
 548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop
  write(fd, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	8d 55 e7             	lea    -0x19(%ebp),%edx
 556:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 55a:	6a 01                	push   $0x1
 55c:	52                   	push   %edx
 55d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 560:	57                   	push   %edi
 561:	e8 0d fe ff ff       	call   373 <write>
 566:	83 c4 0c             	add    $0xc,%esp
 569:	88 5d e7             	mov    %bl,-0x19(%ebp)
 56c:	6a 01                	push   $0x1
 56e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 571:	52                   	push   %edx
 572:	57                   	push   %edi
 573:	e8 fb fd ff ff       	call   373 <write>
        putc(fd, c);
 578:	83 c4 10             	add    $0x10,%esp
      state = 0;
 57b:	31 d2                	xor    %edx,%edx
 57d:	eb 8e                	jmp    50d <printf+0x4d>
 57f:	90                   	nop
        printint(fd, *ap, 16, 0);
 580:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 583:	83 ec 0c             	sub    $0xc,%esp
 586:	b9 10 00 00 00       	mov    $0x10,%ecx
 58b:	8b 13                	mov    (%ebx),%edx
 58d:	6a 00                	push   $0x0
 58f:	89 f8                	mov    %edi,%eax
        ap++;
 591:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 594:	e8 87 fe ff ff       	call   420 <printint>
        ap++;
 599:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 59c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 59f:	31 d2                	xor    %edx,%edx
 5a1:	e9 67 ff ff ff       	jmp    50d <printf+0x4d>
 5a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ad:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5bb:	85 db                	test   %ebx,%ebx
 5bd:	0f 84 9d 00 00 00    	je     660 <printf+0x1a0>
        while(*s != 0){
 5c3:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5c6:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5c8:	84 c0                	test   %al,%al
 5ca:	0f 84 3d ff ff ff    	je     50d <printf+0x4d>
 5d0:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5d3:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5d6:	89 de                	mov    %ebx,%esi
 5d8:	89 d3                	mov    %edx,%ebx
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5e9:	6a 01                	push   $0x1
 5eb:	53                   	push   %ebx
 5ec:	57                   	push   %edi
 5ed:	e8 81 fd ff ff       	call   373 <write>
        while(*s != 0){
 5f2:	0f b6 06             	movzbl (%esi),%eax
 5f5:	83 c4 10             	add    $0x10,%esp
 5f8:	84 c0                	test   %al,%al
 5fa:	75 e4                	jne    5e0 <printf+0x120>
      state = 0;
 5fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 07 ff ff ff       	jmp    50d <printf+0x4d>
 606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 610:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 613:	83 ec 0c             	sub    $0xc,%esp
 616:	b9 0a 00 00 00       	mov    $0xa,%ecx
 61b:	8b 13                	mov    (%ebx),%edx
 61d:	6a 01                	push   $0x1
 61f:	e9 6b ff ff ff       	jmp    58f <printf+0xcf>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 628:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 62b:	83 ec 04             	sub    $0x4,%esp
 62e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 631:	8b 03                	mov    (%ebx),%eax
        ap++;
 633:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 636:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 639:	6a 01                	push   $0x1
 63b:	52                   	push   %edx
 63c:	57                   	push   %edi
 63d:	e8 31 fd ff ff       	call   373 <write>
        ap++;
 642:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 645:	83 c4 10             	add    $0x10,%esp
      state = 0;
 648:	31 d2                	xor    %edx,%edx
 64a:	e9 be fe ff ff       	jmp    50d <printf+0x4d>
 64f:	90                   	nop
  write(fd, &c, 1);
 650:	83 ec 04             	sub    $0x4,%esp
 653:	88 5d e7             	mov    %bl,-0x19(%ebp)
 656:	8d 55 e7             	lea    -0x19(%ebp),%edx
 659:	6a 01                	push   $0x1
 65b:	e9 11 ff ff ff       	jmp    571 <printf+0xb1>
 660:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 665:	bb 20 08 00 00       	mov    $0x820,%ebx
 66a:	e9 61 ff ff ff       	jmp    5d0 <printf+0x110>
 66f:	90                   	nop

00000670 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 670:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	a1 60 0d 00 00       	mov    0xd60,%eax
{
 676:	89 e5                	mov    %esp,%ebp
 678:	57                   	push   %edi
 679:	56                   	push   %esi
 67a:	53                   	push   %ebx
 67b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 67e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 688:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68a:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68c:	39 ca                	cmp    %ecx,%edx
 68e:	73 30                	jae    6c0 <free+0x50>
 690:	39 c1                	cmp    %eax,%ecx
 692:	72 04                	jb     698 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 694:	39 c2                	cmp    %eax,%edx
 696:	72 f0                	jb     688 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 698:	8b 73 fc             	mov    -0x4(%ebx),%esi
 69b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 69e:	39 f8                	cmp    %edi,%eax
 6a0:	74 2e                	je     6d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6a5:	8b 42 04             	mov    0x4(%edx),%eax
 6a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6ab:	39 f1                	cmp    %esi,%ecx
 6ad:	74 38                	je     6e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6af:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6b1:	5b                   	pop    %ebx
  freep = p;
 6b2:	89 15 60 0d 00 00    	mov    %edx,0xd60
}
 6b8:	5e                   	pop    %esi
 6b9:	5f                   	pop    %edi
 6ba:	5d                   	pop    %ebp
 6bb:	c3                   	ret
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c0:	39 c1                	cmp    %eax,%ecx
 6c2:	72 d0                	jb     694 <free+0x24>
 6c4:	eb c2                	jmp    688 <free+0x18>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 6d0:	03 70 04             	add    0x4(%eax),%esi
 6d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	8b 02                	mov    (%edx),%eax
 6d8:	8b 00                	mov    (%eax),%eax
 6da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 42 04             	mov    0x4(%edx),%eax
 6e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6e3:	39 f1                	cmp    %esi,%ecx
 6e5:	75 c8                	jne    6af <free+0x3f>
    p->s.size += bp->s.size;
 6e7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6ea:	89 15 60 0d 00 00    	mov    %edx,0xd60
    p->s.size += bp->s.size;
 6f0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6f3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6f6:	89 0a                	mov    %ecx,(%edx)
}
 6f8:	5b                   	pop    %ebx
 6f9:	5e                   	pop    %esi
 6fa:	5f                   	pop    %edi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret
 6fd:	8d 76 00             	lea    0x0(%esi),%esi

00000700 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 70c:	8b 15 60 0d 00 00    	mov    0xd60,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 712:	8d 78 07             	lea    0x7(%eax),%edi
 715:	c1 ef 03             	shr    $0x3,%edi
 718:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 71b:	85 d2                	test   %edx,%edx
 71d:	0f 84 8d 00 00 00    	je     7b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 723:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 725:	8b 48 04             	mov    0x4(%eax),%ecx
 728:	39 f9                	cmp    %edi,%ecx
 72a:	73 64                	jae    790 <malloc+0x90>
  if(nu < 4096)
 72c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 731:	39 df                	cmp    %ebx,%edi
 733:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 736:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 73d:	eb 0a                	jmp    749 <malloc+0x49>
 73f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 742:	8b 48 04             	mov    0x4(%eax),%ecx
 745:	39 f9                	cmp    %edi,%ecx
 747:	73 47                	jae    790 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 749:	89 c2                	mov    %eax,%edx
 74b:	39 05 60 0d 00 00    	cmp    %eax,0xd60
 751:	75 ed                	jne    740 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 753:	83 ec 0c             	sub    $0xc,%esp
 756:	56                   	push   %esi
 757:	e8 7f fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 75c:	83 c4 10             	add    $0x10,%esp
 75f:	83 f8 ff             	cmp    $0xffffffff,%eax
 762:	74 1c                	je     780 <malloc+0x80>
  hp->s.size = nu;
 764:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 767:	83 ec 0c             	sub    $0xc,%esp
 76a:	83 c0 08             	add    $0x8,%eax
 76d:	50                   	push   %eax
 76e:	e8 fd fe ff ff       	call   670 <free>
  return freep;
 773:	8b 15 60 0d 00 00    	mov    0xd60,%edx
      if((p = morecore(nunits)) == 0)
 779:	83 c4 10             	add    $0x10,%esp
 77c:	85 d2                	test   %edx,%edx
 77e:	75 c0                	jne    740 <malloc+0x40>
        return 0;
  }
}
 780:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 783:	31 c0                	xor    %eax,%eax
}
 785:	5b                   	pop    %ebx
 786:	5e                   	pop    %esi
 787:	5f                   	pop    %edi
 788:	5d                   	pop    %ebp
 789:	c3                   	ret
 78a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 790:	39 cf                	cmp    %ecx,%edi
 792:	74 4c                	je     7e0 <malloc+0xe0>
        p->s.size -= nunits;
 794:	29 f9                	sub    %edi,%ecx
 796:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 799:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 79c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 79f:	89 15 60 0d 00 00    	mov    %edx,0xd60
}
 7a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7a8:	83 c0 08             	add    $0x8,%eax
}
 7ab:	5b                   	pop    %ebx
 7ac:	5e                   	pop    %esi
 7ad:	5f                   	pop    %edi
 7ae:	5d                   	pop    %ebp
 7af:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7b0:	c7 05 60 0d 00 00 64 	movl   $0xd64,0xd60
 7b7:	0d 00 00 
    base.s.size = 0;
 7ba:	b8 64 0d 00 00       	mov    $0xd64,%eax
    base.s.ptr = freep = prevp = &base;
 7bf:	c7 05 64 0d 00 00 64 	movl   $0xd64,0xd64
 7c6:	0d 00 00 
    base.s.size = 0;
 7c9:	c7 05 68 0d 00 00 00 	movl   $0x0,0xd68
 7d0:	00 00 00 
    if(p->s.size >= nunits){
 7d3:	e9 54 ff ff ff       	jmp    72c <malloc+0x2c>
 7d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7df:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 08                	mov    (%eax),%ecx
 7e2:	89 0a                	mov    %ecx,(%edx)
 7e4:	eb b9                	jmp    79f <malloc+0x9f>
