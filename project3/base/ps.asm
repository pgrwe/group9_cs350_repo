
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

0000030b <waitpid>:
SYSCALL(waitpid)
 30b:	b8 19 00 00 00       	mov    $0x19,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret
 313:	66 90                	xchg   %ax,%ax
 315:	66 90                	xchg   %ax,%ax
 317:	66 90                	xchg   %ax,%ax
 319:	66 90                	xchg   %ax,%ax
 31b:	66 90                	xchg   %ax,%ax
 31d:	66 90                	xchg   %ax,%ax
 31f:	90                   	nop

00000320 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	56                   	push   %esi
 325:	53                   	push   %ebx
 326:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 328:	89 d1                	mov    %edx,%ecx
{
 32a:	83 ec 3c             	sub    $0x3c,%esp
 32d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 330:	85 d2                	test   %edx,%edx
 332:	0f 89 80 00 00 00    	jns    3b8 <printint+0x98>
 338:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 33c:	74 7a                	je     3b8 <printint+0x98>
    x = -xx;
 33e:	f7 d9                	neg    %ecx
    neg = 1;
 340:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 345:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 348:	31 f6                	xor    %esi,%esi
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 350:	89 c8                	mov    %ecx,%eax
 352:	31 d2                	xor    %edx,%edx
 354:	89 f7                	mov    %esi,%edi
 356:	f7 f3                	div    %ebx
 358:	8d 76 01             	lea    0x1(%esi),%esi
 35b:	0f b6 92 48 07 00 00 	movzbl 0x748(%edx),%edx
 362:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 366:	89 ca                	mov    %ecx,%edx
 368:	89 c1                	mov    %eax,%ecx
 36a:	39 da                	cmp    %ebx,%edx
 36c:	73 e2                	jae    350 <printint+0x30>
  if(neg)
 36e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 371:	85 c0                	test   %eax,%eax
 373:	74 07                	je     37c <printint+0x5c>
    buf[i++] = '-';
 375:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
 37a:	89 f7                	mov    %esi,%edi
 37c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 37f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 382:	01 df                	add    %ebx,%edi
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  while(--i >= 0)
    putc(fd, buf[i]);
 388:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 38b:	83 ec 04             	sub    $0x4,%esp
 38e:	88 45 d7             	mov    %al,-0x29(%ebp)
 391:	8d 45 d7             	lea    -0x29(%ebp),%eax
 394:	6a 01                	push   $0x1
 396:	50                   	push   %eax
 397:	56                   	push   %esi
 398:	e8 d6 fe ff ff       	call   273 <write>
  while(--i >= 0)
 39d:	89 f8                	mov    %edi,%eax
 39f:	83 c4 10             	add    $0x10,%esp
 3a2:	83 ef 01             	sub    $0x1,%edi
 3a5:	39 d8                	cmp    %ebx,%eax
 3a7:	75 df                	jne    388 <printint+0x68>
}
 3a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ac:	5b                   	pop    %ebx
 3ad:	5e                   	pop    %esi
 3ae:	5f                   	pop    %edi
 3af:	5d                   	pop    %ebp
 3b0:	c3                   	ret
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3b8:	31 c0                	xor    %eax,%eax
 3ba:	eb 89                	jmp    345 <printint+0x25>
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003c0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3c9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 3cc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 3cf:	0f b6 1e             	movzbl (%esi),%ebx
 3d2:	83 c6 01             	add    $0x1,%esi
 3d5:	84 db                	test   %bl,%bl
 3d7:	74 67                	je     440 <printf+0x80>
 3d9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 3dc:	31 d2                	xor    %edx,%edx
 3de:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 3e1:	eb 34                	jmp    417 <printf+0x57>
 3e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e7:	90                   	nop
 3e8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3eb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 3f0:	83 f8 25             	cmp    $0x25,%eax
 3f3:	74 18                	je     40d <printf+0x4d>
  write(fd, &c, 1);
 3f5:	83 ec 04             	sub    $0x4,%esp
 3f8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3fb:	88 5d e7             	mov    %bl,-0x19(%ebp)
 3fe:	6a 01                	push   $0x1
 400:	50                   	push   %eax
 401:	57                   	push   %edi
 402:	e8 6c fe ff ff       	call   273 <write>
 407:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 40a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 40d:	0f b6 1e             	movzbl (%esi),%ebx
 410:	83 c6 01             	add    $0x1,%esi
 413:	84 db                	test   %bl,%bl
 415:	74 29                	je     440 <printf+0x80>
    c = fmt[i] & 0xff;
 417:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 41a:	85 d2                	test   %edx,%edx
 41c:	74 ca                	je     3e8 <printf+0x28>
      }
    } else if(state == '%'){
 41e:	83 fa 25             	cmp    $0x25,%edx
 421:	75 ea                	jne    40d <printf+0x4d>
      if(c == 'd'){
 423:	83 f8 25             	cmp    $0x25,%eax
 426:	0f 84 24 01 00 00    	je     550 <printf+0x190>
 42c:	83 e8 63             	sub    $0x63,%eax
 42f:	83 f8 15             	cmp    $0x15,%eax
 432:	77 1c                	ja     450 <printf+0x90>
 434:	ff 24 85 f0 06 00 00 	jmp    *0x6f0(,%eax,4)
 43b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 440:	8d 65 f4             	lea    -0xc(%ebp),%esp
 443:	5b                   	pop    %ebx
 444:	5e                   	pop    %esi
 445:	5f                   	pop    %edi
 446:	5d                   	pop    %ebp
 447:	c3                   	ret
 448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop
  write(fd, &c, 1);
 450:	83 ec 04             	sub    $0x4,%esp
 453:	8d 55 e7             	lea    -0x19(%ebp),%edx
 456:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 45a:	6a 01                	push   $0x1
 45c:	52                   	push   %edx
 45d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 460:	57                   	push   %edi
 461:	e8 0d fe ff ff       	call   273 <write>
 466:	83 c4 0c             	add    $0xc,%esp
 469:	88 5d e7             	mov    %bl,-0x19(%ebp)
 46c:	6a 01                	push   $0x1
 46e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 471:	52                   	push   %edx
 472:	57                   	push   %edi
 473:	e8 fb fd ff ff       	call   273 <write>
        putc(fd, c);
 478:	83 c4 10             	add    $0x10,%esp
      state = 0;
 47b:	31 d2                	xor    %edx,%edx
 47d:	eb 8e                	jmp    40d <printf+0x4d>
 47f:	90                   	nop
        printint(fd, *ap, 16, 0);
 480:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 483:	83 ec 0c             	sub    $0xc,%esp
 486:	b9 10 00 00 00       	mov    $0x10,%ecx
 48b:	8b 13                	mov    (%ebx),%edx
 48d:	6a 00                	push   $0x0
 48f:	89 f8                	mov    %edi,%eax
        ap++;
 491:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 494:	e8 87 fe ff ff       	call   320 <printint>
        ap++;
 499:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 49c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 49f:	31 d2                	xor    %edx,%edx
 4a1:	e9 67 ff ff ff       	jmp    40d <printf+0x4d>
 4a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
        s = (char*)*ap;
 4b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 4b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 4b5:	83 c0 04             	add    $0x4,%eax
 4b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 4bb:	85 db                	test   %ebx,%ebx
 4bd:	0f 84 9d 00 00 00    	je     560 <printf+0x1a0>
        while(*s != 0){
 4c3:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 4c6:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 4c8:	84 c0                	test   %al,%al
 4ca:	0f 84 3d ff ff ff    	je     40d <printf+0x4d>
 4d0:	8d 55 e7             	lea    -0x19(%ebp),%edx
 4d3:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 4d6:	89 de                	mov    %ebx,%esi
 4d8:	89 d3                	mov    %edx,%ebx
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 4e0:	83 ec 04             	sub    $0x4,%esp
 4e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 4e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 4e9:	6a 01                	push   $0x1
 4eb:	53                   	push   %ebx
 4ec:	57                   	push   %edi
 4ed:	e8 81 fd ff ff       	call   273 <write>
        while(*s != 0){
 4f2:	0f b6 06             	movzbl (%esi),%eax
 4f5:	83 c4 10             	add    $0x10,%esp
 4f8:	84 c0                	test   %al,%al
 4fa:	75 e4                	jne    4e0 <printf+0x120>
      state = 0;
 4fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 4ff:	31 d2                	xor    %edx,%edx
 501:	e9 07 ff ff ff       	jmp    40d <printf+0x4d>
 506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 50d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 510:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 513:	83 ec 0c             	sub    $0xc,%esp
 516:	b9 0a 00 00 00       	mov    $0xa,%ecx
 51b:	8b 13                	mov    (%ebx),%edx
 51d:	6a 01                	push   $0x1
 51f:	e9 6b ff ff ff       	jmp    48f <printf+0xcf>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 528:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 52b:	83 ec 04             	sub    $0x4,%esp
 52e:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 531:	8b 03                	mov    (%ebx),%eax
        ap++;
 533:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 536:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 539:	6a 01                	push   $0x1
 53b:	52                   	push   %edx
 53c:	57                   	push   %edi
 53d:	e8 31 fd ff ff       	call   273 <write>
        ap++;
 542:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 545:	83 c4 10             	add    $0x10,%esp
      state = 0;
 548:	31 d2                	xor    %edx,%edx
 54a:	e9 be fe ff ff       	jmp    40d <printf+0x4d>
 54f:	90                   	nop
  write(fd, &c, 1);
 550:	83 ec 04             	sub    $0x4,%esp
 553:	88 5d e7             	mov    %bl,-0x19(%ebp)
 556:	8d 55 e7             	lea    -0x19(%ebp),%edx
 559:	6a 01                	push   $0x1
 55b:	e9 11 ff ff ff       	jmp    471 <printf+0xb1>
 560:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 565:	bb e8 06 00 00       	mov    $0x6e8,%ebx
 56a:	e9 61 ff ff ff       	jmp    4d0 <printf+0x110>
 56f:	90                   	nop

00000570 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 570:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 571:	a1 dc 09 00 00       	mov    0x9dc,%eax
{
 576:	89 e5                	mov    %esp,%ebp
 578:	57                   	push   %edi
 579:	56                   	push   %esi
 57a:	53                   	push   %ebx
 57b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 57e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 588:	89 c2                	mov    %eax,%edx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58a:	8b 00                	mov    (%eax),%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 58c:	39 ca                	cmp    %ecx,%edx
 58e:	73 30                	jae    5c0 <free+0x50>
 590:	39 c1                	cmp    %eax,%ecx
 592:	72 04                	jb     598 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 594:	39 c2                	cmp    %eax,%edx
 596:	72 f0                	jb     588 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 598:	8b 73 fc             	mov    -0x4(%ebx),%esi
 59b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 59e:	39 f8                	cmp    %edi,%eax
 5a0:	74 2e                	je     5d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 5a2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5a5:	8b 42 04             	mov    0x4(%edx),%eax
 5a8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5ab:	39 f1                	cmp    %esi,%ecx
 5ad:	74 38                	je     5e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 5af:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 5b1:	5b                   	pop    %ebx
  freep = p;
 5b2:	89 15 dc 09 00 00    	mov    %edx,0x9dc
}
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c0:	39 c1                	cmp    %eax,%ecx
 5c2:	72 d0                	jb     594 <free+0x24>
 5c4:	eb c2                	jmp    588 <free+0x18>
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
    bp->s.size += p->s.ptr->s.size;
 5d0:	03 70 04             	add    0x4(%eax),%esi
 5d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5d6:	8b 02                	mov    (%edx),%eax
 5d8:	8b 00                	mov    (%eax),%eax
 5da:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 5dd:	8b 42 04             	mov    0x4(%edx),%eax
 5e0:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 5e3:	39 f1                	cmp    %esi,%ecx
 5e5:	75 c8                	jne    5af <free+0x3f>
    p->s.size += bp->s.size;
 5e7:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 5ea:	89 15 dc 09 00 00    	mov    %edx,0x9dc
    p->s.size += bp->s.size;
 5f0:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 5f3:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 5f6:	89 0a                	mov    %ecx,(%edx)
}
 5f8:	5b                   	pop    %ebx
 5f9:	5e                   	pop    %esi
 5fa:	5f                   	pop    %edi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret
 5fd:	8d 76 00             	lea    0x0(%esi),%esi

00000600 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
 606:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 609:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 60c:	8b 15 dc 09 00 00    	mov    0x9dc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 612:	8d 78 07             	lea    0x7(%eax),%edi
 615:	c1 ef 03             	shr    $0x3,%edi
 618:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 61b:	85 d2                	test   %edx,%edx
 61d:	0f 84 8d 00 00 00    	je     6b0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 623:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 625:	8b 48 04             	mov    0x4(%eax),%ecx
 628:	39 f9                	cmp    %edi,%ecx
 62a:	73 64                	jae    690 <malloc+0x90>
  if(nu < 4096)
 62c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 631:	39 df                	cmp    %ebx,%edi
 633:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 636:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 63d:	eb 0a                	jmp    649 <malloc+0x49>
 63f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 640:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 642:	8b 48 04             	mov    0x4(%eax),%ecx
 645:	39 f9                	cmp    %edi,%ecx
 647:	73 47                	jae    690 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 649:	89 c2                	mov    %eax,%edx
 64b:	39 05 dc 09 00 00    	cmp    %eax,0x9dc
 651:	75 ed                	jne    640 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 653:	83 ec 0c             	sub    $0xc,%esp
 656:	56                   	push   %esi
 657:	e8 7f fc ff ff       	call   2db <sbrk>
  if(p == (char*)-1)
 65c:	83 c4 10             	add    $0x10,%esp
 65f:	83 f8 ff             	cmp    $0xffffffff,%eax
 662:	74 1c                	je     680 <malloc+0x80>
  hp->s.size = nu;
 664:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 667:	83 ec 0c             	sub    $0xc,%esp
 66a:	83 c0 08             	add    $0x8,%eax
 66d:	50                   	push   %eax
 66e:	e8 fd fe ff ff       	call   570 <free>
  return freep;
 673:	8b 15 dc 09 00 00    	mov    0x9dc,%edx
      if((p = morecore(nunits)) == 0)
 679:	83 c4 10             	add    $0x10,%esp
 67c:	85 d2                	test   %edx,%edx
 67e:	75 c0                	jne    640 <malloc+0x40>
        return 0;
  }
}
 680:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 683:	31 c0                	xor    %eax,%eax
}
 685:	5b                   	pop    %ebx
 686:	5e                   	pop    %esi
 687:	5f                   	pop    %edi
 688:	5d                   	pop    %ebp
 689:	c3                   	ret
 68a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 690:	39 cf                	cmp    %ecx,%edi
 692:	74 4c                	je     6e0 <malloc+0xe0>
        p->s.size -= nunits;
 694:	29 f9                	sub    %edi,%ecx
 696:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 699:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 69c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 69f:	89 15 dc 09 00 00    	mov    %edx,0x9dc
}
 6a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 6a8:	83 c0 08             	add    $0x8,%eax
}
 6ab:	5b                   	pop    %ebx
 6ac:	5e                   	pop    %esi
 6ad:	5f                   	pop    %edi
 6ae:	5d                   	pop    %ebp
 6af:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 6b0:	c7 05 dc 09 00 00 e0 	movl   $0x9e0,0x9dc
 6b7:	09 00 00 
    base.s.size = 0;
 6ba:	b8 e0 09 00 00       	mov    $0x9e0,%eax
    base.s.ptr = freep = prevp = &base;
 6bf:	c7 05 e0 09 00 00 e0 	movl   $0x9e0,0x9e0
 6c6:	09 00 00 
    base.s.size = 0;
 6c9:	c7 05 e4 09 00 00 00 	movl   $0x0,0x9e4
 6d0:	00 00 00 
    if(p->s.size >= nunits){
 6d3:	e9 54 ff ff ff       	jmp    62c <malloc+0x2c>
 6d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
        prevp->s.ptr = p->s.ptr;
 6e0:	8b 08                	mov    (%eax),%ecx
 6e2:	89 0a                	mov    %ecx,(%edx)
 6e4:	eb b9                	jmp    69f <malloc+0x9f>
