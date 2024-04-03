
_ps:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(void){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  cps();
   6:	e8 f0 02 00 00       	call   2fb <cps>
  exit();
   b:	e8 43 02 00 00       	call   253 <exit>

00000010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  10:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  11:	31 c0                	xor    %eax,%eax
{
  13:	89 e5                	mov    %esp,%ebp
  15:	53                   	push   %ebx
  16:	8b 4d 08             	mov    0x8(%ebp),%ecx
  19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  27:	83 c0 01             	add    $0x1,%eax
  2a:	84 d2                	test   %dl,%dl
  2c:	75 f2                	jne    20 <strcpy+0x10>
    ;
  return os;
}
  2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  31:	89 c8                	mov    %ecx,%eax
  33:	c9                   	leave
  34:	c3                   	ret
  35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 55 08             	mov    0x8(%ebp),%edx
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  4a:	0f b6 02             	movzbl (%edx),%eax
  4d:	84 c0                	test   %al,%al
  4f:	75 17                	jne    68 <strcmp+0x28>
  51:	eb 3a                	jmp    8d <strcmp+0x4d>
  53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  57:	90                   	nop
  58:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
  5c:	83 c2 01             	add    $0x1,%edx
  5f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  62:	84 c0                	test   %al,%al
  64:	74 1a                	je     80 <strcmp+0x40>
    p++, q++;
  66:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
  68:	0f b6 19             	movzbl (%ecx),%ebx
  6b:	38 c3                	cmp    %al,%bl
  6d:	74 e9                	je     58 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
  6f:	29 d8                	sub    %ebx,%eax
}
  71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  74:	c9                   	leave
  75:	c3                   	ret
  76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
  80:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  84:	31 c0                	xor    %eax,%eax
  86:	29 d8                	sub    %ebx,%eax
}
  88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8b:	c9                   	leave
  8c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
  8d:	0f b6 19             	movzbl (%ecx),%ebx
  90:	31 c0                	xor    %eax,%eax
  92:	eb db                	jmp    6f <strcmp+0x2f>
  94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  9f:	90                   	nop

000000a0 <strlen>:

uint
strlen(char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 3a 00             	cmpb   $0x0,(%edx)
  a9:	74 15                	je     c0 <strlen+0x20>
  ab:	31 c0                	xor    %eax,%eax
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	83 c0 01             	add    $0x1,%eax
  b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  b7:	89 c1                	mov    %eax,%ecx
  b9:	75 f5                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  bb:	89 c8                	mov    %ecx,%eax
  bd:	5d                   	pop    %ebp
  be:	c3                   	ret
  bf:	90                   	nop
  for(n = 0; s[n]; n++)
  c0:	31 c9                	xor    %ecx,%ecx
}
  c2:	5d                   	pop    %ebp
  c3:	89 c8                	mov    %ecx,%eax
  c5:	c3                   	ret
  c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
  e5:	89 d0                	mov    %edx,%eax
  e7:	c9                   	leave
  e8:	c3                   	ret
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fa:	0f b6 10             	movzbl (%eax),%edx
  fd:	84 d2                	test   %dl,%dl
  ff:	75 12                	jne    113 <strchr+0x23>
 101:	eb 1d                	jmp    120 <strchr+0x30>
 103:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 107:	90                   	nop
 108:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 10c:	83 c0 01             	add    $0x1,%eax
 10f:	84 d2                	test   %dl,%dl
 111:	74 0d                	je     120 <strchr+0x30>
    if(*s == c)
 113:	38 d1                	cmp    %dl,%cl
 115:	75 f1                	jne    108 <strchr+0x18>
      return (char*)s;
  return 0;
}
 117:	5d                   	pop    %ebp
 118:	c3                   	ret
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 120:	31 c0                	xor    %eax,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret
 124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 135:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 138:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 139:	31 db                	xor    %ebx,%ebx
{
 13b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 13e:	eb 27                	jmp    167 <gets+0x37>
    cc = read(0, &c, 1);
 140:	83 ec 04             	sub    $0x4,%esp
 143:	6a 01                	push   $0x1
 145:	56                   	push   %esi
 146:	6a 00                	push   $0x0
 148:	e8 1e 01 00 00       	call   26b <read>
    if(cc < 1)
 14d:	83 c4 10             	add    $0x10,%esp
 150:	85 c0                	test   %eax,%eax
 152:	7e 1d                	jle    171 <gets+0x41>
      break;
    buf[i++] = c;
 154:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 158:	8b 55 08             	mov    0x8(%ebp),%edx
 15b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 15f:	3c 0a                	cmp    $0xa,%al
 161:	74 10                	je     173 <gets+0x43>
 163:	3c 0d                	cmp    $0xd,%al
 165:	74 0c                	je     173 <gets+0x43>
  for(i=0; i+1 < max; ){
 167:	89 df                	mov    %ebx,%edi
 169:	83 c3 01             	add    $0x1,%ebx
 16c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 16f:	7c cf                	jl     140 <gets+0x10>
 171:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 17a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17d:	5b                   	pop    %ebx
 17e:	5e                   	pop    %esi
 17f:	5f                   	pop    %edi
 180:	5d                   	pop    %ebp
 181:	c3                   	ret
 182:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000190 <stat>:

int
stat(char *n, struct stat *st)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	56                   	push   %esi
 194:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 195:	83 ec 08             	sub    $0x8,%esp
 198:	6a 00                	push   $0x0
 19a:	ff 75 08             	push   0x8(%ebp)
 19d:	e8 f1 00 00 00       	call   293 <open>
  if(fd < 0)
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	85 c0                	test   %eax,%eax
 1a7:	78 27                	js     1d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1a9:	83 ec 08             	sub    $0x8,%esp
 1ac:	ff 75 0c             	push   0xc(%ebp)
 1af:	89 c3                	mov    %eax,%ebx
 1b1:	50                   	push   %eax
 1b2:	e8 f4 00 00 00       	call   2ab <fstat>
  close(fd);
 1b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ba:	89 c6                	mov    %eax,%esi
  close(fd);
 1bc:	e8 ba 00 00 00       	call   27b <close>
  return r;
 1c1:	83 c4 10             	add    $0x10,%esp
}
 1c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c7:	89 f0                	mov    %esi,%eax
 1c9:	5b                   	pop    %ebx
 1ca:	5e                   	pop    %esi
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d5:	eb ed                	jmp    1c4 <stat+0x34>
 1d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1de:	66 90                	xchg   %ax,%ax

000001e0 <atoi>:

int
atoi(const char *s)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	53                   	push   %ebx
 1e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e7:	0f be 02             	movsbl (%edx),%eax
 1ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 1f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 1f5:	77 1e                	ja     215 <atoi+0x35>
 1f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fe:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 200:	83 c2 01             	add    $0x1,%edx
 203:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 206:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 20a:	0f be 02             	movsbl (%edx),%eax
 20d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 210:	80 fb 09             	cmp    $0x9,%bl
 213:	76 eb                	jbe    200 <atoi+0x20>
  return n;
}
 215:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 218:	89 c8                	mov    %ecx,%eax
 21a:	c9                   	leave
 21b:	c3                   	ret
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000220 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	8b 45 10             	mov    0x10(%ebp),%eax
 228:	8b 55 08             	mov    0x8(%ebp),%edx
 22b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22e:	85 c0                	test   %eax,%eax
 230:	7e 13                	jle    245 <memmove+0x25>
 232:	01 d0                	add    %edx,%eax
  dst = vdst;
 234:	89 d7                	mov    %edx,%edi
 236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 240:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 241:	39 f8                	cmp    %edi,%eax
 243:	75 fb                	jne    240 <memmove+0x20>
  return vdst;
}
 245:	5e                   	pop    %esi
 246:	89 d0                	mov    %edx,%eax
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret

0000024b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 24b:	b8 01 00 00 00       	mov    $0x1,%eax
 250:	cd 40                	int    $0x40
 252:	c3                   	ret

00000253 <exit>:
SYSCALL(exit)
 253:	b8 02 00 00 00       	mov    $0x2,%eax
 258:	cd 40                	int    $0x40
 25a:	c3                   	ret

0000025b <wait>:
SYSCALL(wait)
 25b:	b8 03 00 00 00       	mov    $0x3,%eax
 260:	cd 40                	int    $0x40
 262:	c3                   	ret

00000263 <pipe>:
SYSCALL(pipe)
 263:	b8 04 00 00 00       	mov    $0x4,%eax
 268:	cd 40                	int    $0x40
 26a:	c3                   	ret

0000026b <read>:
SYSCALL(read)
 26b:	b8 05 00 00 00       	mov    $0x5,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret

00000273 <write>:
SYSCALL(write)
 273:	b8 10 00 00 00       	mov    $0x10,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret

0000027b <close>:
SYSCALL(close)
 27b:	b8 15 00 00 00       	mov    $0x15,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret

00000283 <kill>:
SYSCALL(kill)
 283:	b8 06 00 00 00       	mov    $0x6,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret

0000028b <exec>:
SYSCALL(exec)
 28b:	b8 07 00 00 00       	mov    $0x7,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret

00000293 <open>:
SYSCALL(open)
 293:	b8 0f 00 00 00       	mov    $0xf,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret

0000029b <mknod>:
SYSCALL(mknod)
 29b:	b8 11 00 00 00       	mov    $0x11,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret

000002a3 <unlink>:
SYSCALL(unlink)
 2a3:	b8 12 00 00 00       	mov    $0x12,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret

000002ab <fstat>:
SYSCALL(fstat)
 2ab:	b8 08 00 00 00       	mov    $0x8,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret

000002b3 <link>:
SYSCALL(link)
 2b3:	b8 13 00 00 00       	mov    $0x13,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret

000002bb <mkdir>:
SYSCALL(mkdir)
 2bb:	b8 14 00 00 00       	mov    $0x14,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret

000002c3 <chdir>:
SYSCALL(chdir)
 2c3:	b8 09 00 00 00       	mov    $0x9,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret

000002cb <dup>:
SYSCALL(dup)
 2cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret

000002d3 <getpid>:
SYSCALL(getpid)
 2d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret

000002db <sbrk>:
SYSCALL(sbrk)
 2db:	b8 0c 00 00 00       	mov    $0xc,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret

000002e3 <sleep>:
SYSCALL(sleep)
 2e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret

000002eb <uptime>:
SYSCALL(uptime)
 2eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret

000002f3 <shutdown>:
SYSCALL(shutdown)
 2f3:	b8 16 00 00 00       	mov    $0x16,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret

000002fb <cps>:
SYSCALL(cps)
 2fb:	b8 17 00 00 00       	mov    $0x17,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret

00000303 <chpr>:
SYSCALL(chpr)
 303:	b8 18 00 00 00       	mov    $0x18,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret
 30b:	66 90                	xchg   %ax,%ax
 30d:	66 90                	xchg   %ax,%ax
 30f:	90                   	nop

00000310 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
 316:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 318:	89 d1                	mov    %edx,%ecx
{
 31a:	83 ec 3c             	sub    $0x3c,%esp
 31d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 320:	85 d2                	test   %edx,%edx
 322:	0f 89 80 00 00 00    	jns    3a8 <printint+0x98>
 328:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 32c:	74 7a                	je     3a8 <printint+0x98>
    x = -xx;
 32e:	f7 d9                	neg    %ecx
    neg = 1;
 330:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 335:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 338:	31 f6                	xor    %esi,%esi
 33a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 340:	89 c8                	mov    %ecx,%eax
 342:	31 d2                	xor    %edx,%edx
 344:	89 f7                	mov    %esi,%edi
 346:	f7 f3                	div    %ebx
 348:	8d 76 01             	lea    0x1(%esi),%esi
 34b:	0f b6 92 38 07 00 00 	movzbl 0x738(%edx),%edx
 352:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 356:	89 ca                	mov    %ecx,%edx
 358:	89 c1                	mov    %eax,%ecx
 35a:	39 da                	cmp    %ebx,%edx
 35c:	73 e2                	jae    340 <printint+0x30>
  if(neg)
 35e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 361:	85 c0                	test   %eax,%eax
 363:	74 07                	je     36c <printint+0x5c>
    buf[i++] = '-';
 365:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
 36a:	89 f7                	mov    %esi,%edi
 36c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 36f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 372:	01 df                	add    %ebx,%edi
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
 378:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 37b:	83 ec 04             	sub    $0x4,%esp
 37e:	88 45 d7             	mov    %al,-0x29(%ebp)
 381:	8d 45 d7             	lea    -0x29(%ebp),%eax
 384:	6a 01                	push   $0x1
 386:	50                   	push   %eax
 387:	56                   	push   %esi
 388:	e8 e6 fe ff ff       	call   273 <write>
  while(--i >= 0)
 38d:	89 f8                	mov    %edi,%eax
 38f:	83 c4 10             	add    $0x10,%esp
 392:	83 ef 01             	sub    $0x1,%edi
 395:	39 d8                	cmp    %ebx,%eax
 397:	75 df                	jne    378 <printint+0x68>
}
 399:	8d 65 f4             	lea    -0xc(%ebp),%esp
 39c:	5b                   	pop    %ebx
 39d:	5e                   	pop    %esi
 39e:	5f                   	pop    %edi
 39f:	5d                   	pop    %ebp
 3a0:	c3                   	ret
 3a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3a8:	31 c0                	xor    %eax,%eax
 3aa:	eb 89                	jmp    335 <printint+0x25>
 3ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
 3b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3b9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 3bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 3bf:	0f b6 1e             	movzbl (%esi),%ebx
 3c2:	83 c6 01             	add    $0x1,%esi
 3c5:	84 db                	test   %bl,%bl
 3c7:	74 67                	je     430 <printf+0x80>
 3c9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3cc:	31 d2                	xor    %edx,%edx
 3ce:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 3d1:	eb 34                	jmp    407 <printf+0x57>
 3d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3d7:	90                   	nop
 3d8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3db:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 3e0:	83 f8 25             	cmp    $0x25,%eax
 3e3:	74 18                	je     3fd <printf+0x4d>
  write(fd, &c, 1);
 3e5:	83 ec 04             	sub    $0x4,%esp
 3e8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3eb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 3ee:	6a 01                	push   $0x1
 3f0:	50                   	push   %eax
 3f1:	57                   	push   %edi
 3f2:	e8 7c fe ff ff       	call   273 <write>
 3f7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 3fa:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 3fd:	0f b6 1e             	movzbl (%esi),%ebx
 400:	83 c6 01             	add    $0x1,%esi
 403:	84 db                	test   %bl,%bl
 405:	74 29                	je     430 <printf+0x80>
    c = fmt[i] & 0xff;
 407:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 40a:	85 d2                	test   %edx,%edx
 40c:	74 ca                	je     3d8 <printf+0x28>
      }
    } else if(state == '%'){
 40e:	83 fa 25             	cmp    $0x25,%edx
 411:	75 ea                	jne    3fd <printf+0x4d>
      if(c == 'd'){
 413:	83 f8 25             	cmp    $0x25,%eax
 416:	0f 84 24 01 00 00    	je     540 <printf+0x190>
 41c:	83 e8 63             	sub    $0x63,%eax
 41f:	83 f8 15             	cmp    $0x15,%eax
 422:	77 1c                	ja     440 <printf+0x90>
 424:	ff 24 85 e0 06 00 00 	jmp    *0x6e0(,%eax,4)
 42b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 42f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 430:	8d 65 f4             	lea    -0xc(%ebp),%esp
 433:	5b                   	pop    %ebx
 434:	5e                   	pop    %esi
 435:	5f                   	pop    %edi
 436:	5d                   	pop    %ebp
 437:	c3                   	ret
 438:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop
  write(fd, &c, 1);
 440:	83 ec 04             	sub    $0x4,%esp
 443:	8d 55 e7             	lea    -0x19(%ebp),%edx
 446:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 44a:	6a 01                	push   $0x1
 44c:	52                   	push   %edx
 44d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 450:	57                   	push   %edi
 451:	e8 1d fe ff ff       	call   273 <write>
 456:	83 c4 0c             	add    $0xc,%esp
 459:	88 5d e7             	mov    %bl,-0x19(%ebp)
 45c:	6a 01                	push   $0x1
 45e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 461:	52                   	push   %edx
 462:	57                   	push   %edi
 463:	e8 0b fe ff ff       	call   273 <write>
        putc(fd, c);
 468:	83 c4 10             	add    $0x10,%esp
      state = 0;
 46b:	31 d2                	xor    %edx,%edx
 46d:	eb 8e                	jmp    3fd <printf+0x4d>
 46f:	90                   	nop
        printint(fd, *ap, 16, 0);
 470:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 473:	83 ec 0c             	sub    $0xc,%esp
 476:	b9 10 00 00 00       	mov    $0x10,%ecx
 47b:	8b 13                	mov    (%ebx),%edx
 47d:	6a 00                	push   $0x0
 47f:	89 f8                	mov    %edi,%eax
        ap++;
 481:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 484:	e8 87 fe ff ff       	call   310 <printint>
        ap++;
 489:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 48c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 48f:	31 d2                	xor    %edx,%edx
 491:	e9 67 ff ff ff       	jmp    3fd <printf+0x4d>
 496:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 49d:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 4a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 4a5:	83 c0 04             	add    $0x4,%eax
 4a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4ab:	85 db                	test   %ebx,%ebx
 4ad:	0f 84 9d 00 00 00    	je     550 <printf+0x1a0>
        while(*s != 0){
 4b3:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 4b6:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 4b8:	84 c0                	test   %al,%al
 4ba:	0f 84 3d ff ff ff    	je     3fd <printf+0x4d>
 4c0:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4c3:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4c6:	89 de                	mov    %ebx,%esi
 4c8:	89 d3                	mov    %edx,%ebx
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 4d6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4d9:	6a 01                	push   $0x1
 4db:	53                   	push   %ebx
 4dc:	57                   	push   %edi
 4dd:	e8 91 fd ff ff       	call   273 <write>
        while(*s != 0){
 4e2:	0f b6 06             	movzbl (%esi),%eax
 4e5:	83 c4 10             	add    $0x10,%esp
 4e8:	84 c0                	test   %al,%al
 4ea:	75 e4                	jne    4d0 <printf+0x120>
      state = 0;
 4ec:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 4ef:	31 d2                	xor    %edx,%edx
 4f1:	e9 07 ff ff ff       	jmp    3fd <printf+0x4d>
 4f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 500:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 503:	83 ec 0c             	sub    $0xc,%esp
 506:	b9 0a 00 00 00       	mov    $0xa,%ecx
 50b:	8b 13                	mov    (%ebx),%edx
 50d:	6a 01                	push   $0x1
 50f:	e9 6b ff ff ff       	jmp    47f <printf+0xcf>
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 518:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 51b:	83 ec 04             	sub    $0x4,%esp
 51e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 521:	8b 03                	mov    (%ebx),%eax
        ap++;
 523:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 526:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 529:	6a 01                	push   $0x1
 52b:	52                   	push   %edx
 52c:	57                   	push   %edi
 52d:	e8 41 fd ff ff       	call   273 <write>
        ap++;
 532:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 535:	83 c4 10             	add    $0x10,%esp
      state = 0;
 538:	31 d2                	xor    %edx,%edx
 53a:	e9 be fe ff ff       	jmp    3fd <printf+0x4d>
 53f:	90                   	nop
  write(fd, &c, 1);
 540:	83 ec 04             	sub    $0x4,%esp
 543:	88 5d e7             	mov    %bl,-0x19(%ebp)
 546:	8d 55 e7             	lea    -0x19(%ebp),%edx
 549:	6a 01                	push   $0x1
 54b:	e9 11 ff ff ff       	jmp    461 <printf+0xb1>
 550:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 555:	bb d8 06 00 00       	mov    $0x6d8,%ebx
 55a:	e9 61 ff ff ff       	jmp    4c0 <printf+0x110>
 55f:	90                   	nop

00000560 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 560:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 561:	a1 cc 09 00 00       	mov    0x9cc,%eax
{
 566:	89 e5                	mov    %esp,%ebp
 568:	57                   	push   %edi
 569:	56                   	push   %esi
 56a:	53                   	push   %ebx
 56b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 56e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 578:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 57a:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 57c:	39 ca                	cmp    %ecx,%edx
 57e:	73 30                	jae    5b0 <free+0x50>
 580:	39 c1                	cmp    %eax,%ecx
 582:	72 04                	jb     588 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 584:	39 c2                	cmp    %eax,%edx
 586:	72 f0                	jb     578 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 588:	8b 73 fc             	mov    -0x4(%ebx),%esi
 58b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 58e:	39 f8                	cmp    %edi,%eax
 590:	74 2e                	je     5c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 592:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 595:	8b 42 04             	mov    0x4(%edx),%eax
 598:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 59b:	39 f1                	cmp    %esi,%ecx
 59d:	74 38                	je     5d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 59f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5a1:	5b                   	pop    %ebx
  freep = p;
 5a2:	89 15 cc 09 00 00    	mov    %edx,0x9cc
}
 5a8:	5e                   	pop    %esi
 5a9:	5f                   	pop    %edi
 5aa:	5d                   	pop    %ebp
 5ab:	c3                   	ret
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b0:	39 c1                	cmp    %eax,%ecx
 5b2:	72 d0                	jb     584 <free+0x24>
 5b4:	eb c2                	jmp    578 <free+0x18>
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 5c0:	03 70 04             	add    0x4(%eax),%esi
 5c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5c6:	8b 02                	mov    (%edx),%eax
 5c8:	8b 00                	mov    (%eax),%eax
 5ca:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 5cd:	8b 42 04             	mov    0x4(%edx),%eax
 5d0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5d3:	39 f1                	cmp    %esi,%ecx
 5d5:	75 c8                	jne    59f <free+0x3f>
    p->s.size += bp->s.size;
 5d7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 5da:	89 15 cc 09 00 00    	mov    %edx,0x9cc
    p->s.size += bp->s.size;
 5e0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 5e3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5e6:	89 0a                	mov    %ecx,(%edx)
}
 5e8:	5b                   	pop    %ebx
 5e9:	5e                   	pop    %esi
 5ea:	5f                   	pop    %edi
 5eb:	5d                   	pop    %ebp
 5ec:	c3                   	ret
 5ed:	8d 76 00             	lea    0x0(%esi),%esi

000005f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	57                   	push   %edi
 5f4:	56                   	push   %esi
 5f5:	53                   	push   %ebx
 5f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 5fc:	8b 15 cc 09 00 00    	mov    0x9cc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 602:	8d 78 07             	lea    0x7(%eax),%edi
 605:	c1 ef 03             	shr    $0x3,%edi
 608:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 60b:	85 d2                	test   %edx,%edx
 60d:	0f 84 8d 00 00 00    	je     6a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 613:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 615:	8b 48 04             	mov    0x4(%eax),%ecx
 618:	39 f9                	cmp    %edi,%ecx
 61a:	73 64                	jae    680 <malloc+0x90>
  if(nu < 4096)
 61c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 621:	39 df                	cmp    %ebx,%edi
 623:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 626:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 62d:	eb 0a                	jmp    639 <malloc+0x49>
 62f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 630:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 632:	8b 48 04             	mov    0x4(%eax),%ecx
 635:	39 f9                	cmp    %edi,%ecx
 637:	73 47                	jae    680 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 639:	89 c2                	mov    %eax,%edx
 63b:	39 05 cc 09 00 00    	cmp    %eax,0x9cc
 641:	75 ed                	jne    630 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 643:	83 ec 0c             	sub    $0xc,%esp
 646:	56                   	push   %esi
 647:	e8 8f fc ff ff       	call   2db <sbrk>
  if(p == (char*)-1)
 64c:	83 c4 10             	add    $0x10,%esp
 64f:	83 f8 ff             	cmp    $0xffffffff,%eax
 652:	74 1c                	je     670 <malloc+0x80>
  hp->s.size = nu;
 654:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 657:	83 ec 0c             	sub    $0xc,%esp
 65a:	83 c0 08             	add    $0x8,%eax
 65d:	50                   	push   %eax
 65e:	e8 fd fe ff ff       	call   560 <free>
  return freep;
 663:	8b 15 cc 09 00 00    	mov    0x9cc,%edx
      if((p = morecore(nunits)) == 0)
 669:	83 c4 10             	add    $0x10,%esp
 66c:	85 d2                	test   %edx,%edx
 66e:	75 c0                	jne    630 <malloc+0x40>
        return 0;
  }
}
 670:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 673:	31 c0                	xor    %eax,%eax
}
 675:	5b                   	pop    %ebx
 676:	5e                   	pop    %esi
 677:	5f                   	pop    %edi
 678:	5d                   	pop    %ebp
 679:	c3                   	ret
 67a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 680:	39 cf                	cmp    %ecx,%edi
 682:	74 4c                	je     6d0 <malloc+0xe0>
        p->s.size -= nunits;
 684:	29 f9                	sub    %edi,%ecx
 686:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 689:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 68c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 68f:	89 15 cc 09 00 00    	mov    %edx,0x9cc
}
 695:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 698:	83 c0 08             	add    $0x8,%eax
}
 69b:	5b                   	pop    %ebx
 69c:	5e                   	pop    %esi
 69d:	5f                   	pop    %edi
 69e:	5d                   	pop    %ebp
 69f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 6a0:	c7 05 cc 09 00 00 d0 	movl   $0x9d0,0x9cc
 6a7:	09 00 00 
    base.s.size = 0;
 6aa:	b8 d0 09 00 00       	mov    $0x9d0,%eax
    base.s.ptr = freep = prevp = &base;
 6af:	c7 05 d0 09 00 00 d0 	movl   $0x9d0,0x9d0
 6b6:	09 00 00 
    base.s.size = 0;
 6b9:	c7 05 d4 09 00 00 00 	movl   $0x0,0x9d4
 6c0:	00 00 00 
    if(p->s.size >= nunits){
 6c3:	e9 54 ff ff ff       	jmp    61c <malloc+0x2c>
 6c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 6d0:	8b 08                	mov    (%eax),%ecx
 6d2:	89 0a                	mov    %ecx,(%edx)
 6d4:	eb b9                	jmp    68f <malloc+0x9f>
