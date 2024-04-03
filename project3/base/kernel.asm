
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 80 10 00       	mov    $0x108000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc b0 ff 11 80       	mov    $0x8011ffb0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 30 10 80       	mov    $0x80103010,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 95 10 80       	mov    $0x80109554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 a0 72 10 80       	push   $0x801072a0
80100051:	68 20 95 10 80       	push   $0x80109520
80100056:	e8 45 44 00 00       	call   801044a0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c 90 11 80       	mov    $0x8011901c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c 90 11 80 1c 	movl   $0x8011901c,0x8011906c
8010006a:	90 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 90 11 80 1c 	movl   $0x8011901c,0x80119070
80100074:	90 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c 90 11 80 	movl   $0x8011901c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 72 10 80       	push   $0x801072a7
80100097:	50                   	push   %eax
80100098:	e8 f3 42 00 00       	call   80104390 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 90 11 80       	mov    0x80119070,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 08 00 00    	lea    0x85c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 90 11 80    	mov    %ebx,0x80119070
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 87 11 80    	cmp    $0x801187c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 95 10 80       	push   $0x80109520
801000e4:	e8 d7 44 00 00       	call   801045c0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 90 11 80    	mov    0x80119070,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 90 11 80    	mov    0x8011906c,%ebx
80100126:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 90 11 80    	cmp    $0x8011901c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 95 10 80       	push   $0x80109520
80100162:	e8 99 45 00 00       	call   80104700 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 5e 42 00 00       	call   801043d0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 df 21 00 00       	call   80102370 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ae 72 10 80       	push   $0x801072ae
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 ad 42 00 00       	call   80104470 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 97 21 00 00       	jmp    80102370 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 bf 72 10 80       	push   $0x801072bf
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 6c 42 00 00       	call   80104470 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 1c 42 00 00       	call   80104430 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 95 10 80 	movl   $0x80109520,(%esp)
8010021b:	e8 a0 43 00 00       	call   801045c0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 90 11 80       	mov    0x80119070,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c 90 11 80 	movl   $0x8011901c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 90 11 80       	mov    0x80119070,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 90 11 80    	mov    %ebx,0x80119070
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 95 10 80 	movl   $0x80109520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 92 44 00 00       	jmp    80104700 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 c6 72 10 80       	push   $0x801072c6
80100276:	e8 05 01 00 00       	call   80100380 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 37 16 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 99 11 80 	movl   $0x80119920,(%esp)
801002a0:	e8 1b 43 00 00       	call   801045c0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 99 11 80       	mov    0x80119900,%eax
801002b5:	39 05 04 99 11 80    	cmp    %eax,0x80119904
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 99 11 80       	push   $0x80119920
801002c8:	68 00 99 11 80       	push   $0x80119900
801002cd:	e8 4e 3d 00 00       	call   80104020 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 99 11 80       	mov    0x80119900,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 99 11 80    	cmp    0x80119904,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 69 36 00 00       	call   80103950 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 99 11 80       	push   $0x80119920
801002f6:	e8 05 44 00 00       	call   80104700 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 ec 14 00 00       	call   801017f0 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 99 11 80    	mov    %edx,0x80119900
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 98 11 80 	movsbl -0x7fee6780(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 99 11 80       	push   $0x80119920
8010034c:	e8 af 43 00 00       	call   80104700 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 96 14 00 00       	call   801017f0 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 99 11 80       	mov    %eax,0x80119900
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 54 99 11 80 00 	movl   $0x0,0x80119954
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 12 25 00 00       	call   801028b0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 cd 72 10 80       	push   $0x801072cd
801003a7:	e8 04 03 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 fb 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 43 7a 10 80 	movl   $0x80107a43,(%esp)
801003bc:	e8 ef 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 f3 40 00 00       	call   801044c0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 e1 72 10 80       	push   $0x801072e1
801003dd:	e8 ce 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 99 11 80 01 	movl   $0x1,0x80119958
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
80100409:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040e:	0f 84 cc 00 00 00    	je     801004e0 <consputc.part.0+0xe0>
    uartputc(c);
80100414:	83 ec 0c             	sub    $0xc,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100417:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010041c:	89 c3                	mov    %eax,%ebx
8010041e:	50                   	push   %eax
8010041f:	e8 cc 59 00 00       	call   80105df0 <uartputc>
80100424:	b8 0e 00 00 00       	mov    $0xe,%eax
80100429:	89 fa                	mov    %edi,%edx
8010042b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042c:	be d5 03 00 00       	mov    $0x3d5,%esi
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100434:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100437:	89 fa                	mov    %edi,%edx
80100439:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043e:	c1 e1 08             	shl    $0x8,%ecx
80100441:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100442:	89 f2                	mov    %esi,%edx
80100444:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100445:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100448:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	75 76                	jne    801004c8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100452:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100457:	f7 e2                	mul    %edx
80100459:	c1 ea 06             	shr    $0x6,%edx
8010045c:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010045f:	c1 e0 04             	shl    $0x4,%eax
80100462:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100465:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010046b:	0f 8f 2f 01 00 00    	jg     801005a0 <consputc.part.0+0x1a0>
  if((pos/80) >= 24){  // Scroll up.
80100471:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100477:	0f 8f c3 00 00 00    	jg     80100540 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
8010047d:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
8010047f:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100486:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100489:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048c:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100491:	b8 0e 00 00 00       	mov    $0xe,%eax
80100496:	89 da                	mov    %ebx,%edx
80100498:	ee                   	out    %al,(%dx)
80100499:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010049e:	89 f8                	mov    %edi,%eax
801004a0:	89 ca                	mov    %ecx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a8:	89 da                	mov    %ebx,%edx
801004aa:	ee                   	out    %al,(%dx)
801004ab:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004af:	89 ca                	mov    %ecx,%edx
801004b1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004b2:	b8 20 07 00 00       	mov    $0x720,%eax
801004b7:	66 89 06             	mov    %ax,(%esi)
}
801004ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004bd:	5b                   	pop    %ebx
801004be:	5e                   	pop    %esi
801004bf:	5f                   	pop    %edi
801004c0:	5d                   	pop    %ebp
801004c1:	c3                   	ret
801004c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else if(c == 0x41) {
801004c8:	83 fb 41             	cmp    $0x41,%ebx
801004cb:	74 ed                	je     801004ba <consputc.part.0+0xba>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801004cd:	0f b6 db             	movzbl %bl,%ebx
801004d0:	8d 70 01             	lea    0x1(%eax),%esi
801004d3:	80 cf 07             	or     $0x7,%bh
801004d6:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
801004dd:	80 
801004de:	eb 85                	jmp    80100465 <consputc.part.0+0x65>
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e0:	83 ec 0c             	sub    $0xc,%esp
801004e3:	be d4 03 00 00       	mov    $0x3d4,%esi
801004e8:	6a 08                	push   $0x8
801004ea:	e8 01 59 00 00       	call   80105df0 <uartputc>
801004ef:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f6:	e8 f5 58 00 00       	call   80105df0 <uartputc>
801004fb:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100502:	e8 e9 58 00 00       	call   80105df0 <uartputc>
80100507:	b8 0e 00 00 00       	mov    $0xe,%eax
8010050c:	89 f2                	mov    %esi,%edx
8010050e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010050f:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100514:	89 da                	mov    %ebx,%edx
80100516:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100517:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010051a:	89 f2                	mov    %esi,%edx
8010051c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100521:	c1 e1 08             	shl    $0x8,%ecx
80100524:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100525:	89 da                	mov    %ebx,%edx
80100527:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100528:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010052b:	83 c4 10             	add    $0x10,%esp
8010052e:	09 ce                	or     %ecx,%esi
80100530:	74 5e                	je     80100590 <consputc.part.0+0x190>
80100532:	83 ee 01             	sub    $0x1,%esi
80100535:	e9 2b ff ff ff       	jmp    80100465 <consputc.part.0+0x65>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 7a 42 00 00       	call   801047e0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 d5 41 00 00       	call   80104750 <memset>
  outb(CRTPORT+1, pos);
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 06 ff ff ff       	jmp    8010048c <consputc.part.0+0x8c>
80100586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058d:	8d 76 00             	lea    0x0(%esi),%esi
80100590:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
80100594:	be 00 80 0b 80       	mov    $0x800b8000,%esi
80100599:	31 ff                	xor    %edi,%edi
8010059b:	e9 ec fe ff ff       	jmp    8010048c <consputc.part.0+0x8c>
    panic("pos under/overflow");
801005a0:	83 ec 0c             	sub    $0xc,%esp
801005a3:	68 e5 72 10 80       	push   $0x801072e5
801005a8:	e8 d3 fd ff ff       	call   80100380 <panic>
801005ad:	8d 76 00             	lea    0x0(%esi),%esi

801005b0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005b0:	55                   	push   %ebp
801005b1:	89 e5                	mov    %esp,%ebp
801005b3:	57                   	push   %edi
801005b4:	56                   	push   %esi
801005b5:	53                   	push   %ebx
801005b6:	83 ec 18             	sub    $0x18,%esp
801005b9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005bc:	ff 75 08             	push   0x8(%ebp)
801005bf:	e8 0c 13 00 00       	call   801018d0 <iunlock>
  acquire(&cons.lock);
801005c4:	c7 04 24 20 99 11 80 	movl   $0x80119920,(%esp)
801005cb:	e8 f0 3f 00 00       	call   801045c0 <acquire>
  for(i = 0; i < n; i++)
801005d0:	83 c4 10             	add    $0x10,%esp
801005d3:	85 f6                	test   %esi,%esi
801005d5:	7e 25                	jle    801005fc <consolewrite+0x4c>
801005d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005da:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005dd:	8b 15 58 99 11 80    	mov    0x80119958,%edx
    consputc(buf[i] & 0xff);
801005e3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005e6:	85 d2                	test   %edx,%edx
801005e8:	74 06                	je     801005f0 <consolewrite+0x40>
  asm volatile("cli");
801005ea:	fa                   	cli
    for(;;)
801005eb:	eb fe                	jmp    801005eb <consolewrite+0x3b>
801005ed:	8d 76 00             	lea    0x0(%esi),%esi
801005f0:	e8 0b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005f5:	83 c3 01             	add    $0x1,%ebx
801005f8:	39 df                	cmp    %ebx,%edi
801005fa:	75 e1                	jne    801005dd <consolewrite+0x2d>
  release(&cons.lock);
801005fc:	83 ec 0c             	sub    $0xc,%esp
801005ff:	68 20 99 11 80       	push   $0x80119920
80100604:	e8 f7 40 00 00       	call   80104700 <release>
  ilock(ip);
80100609:	58                   	pop    %eax
8010060a:	ff 75 08             	push   0x8(%ebp)
8010060d:	e8 de 11 00 00       	call   801017f0 <ilock>

  return n;
}
80100612:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100615:	89 f0                	mov    %esi,%eax
80100617:	5b                   	pop    %ebx
80100618:	5e                   	pop    %esi
80100619:	5f                   	pop    %edi
8010061a:	5d                   	pop    %ebp
8010061b:	c3                   	ret
8010061c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100620 <printint>:
{
80100620:	55                   	push   %ebp
80100621:	89 e5                	mov    %esp,%ebp
80100623:	57                   	push   %edi
80100624:	56                   	push   %esi
80100625:	89 c6                	mov    %eax,%esi
80100627:	53                   	push   %ebx
80100628:	89 d3                	mov    %edx,%ebx
8010062a:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010062d:	85 c9                	test   %ecx,%ecx
8010062f:	74 04                	je     80100635 <printint+0x15>
80100631:	85 c0                	test   %eax,%eax
80100633:	78 63                	js     80100698 <printint+0x78>
    x = xx;
80100635:	89 f1                	mov    %esi,%ecx
80100637:	31 c0                	xor    %eax,%eax
  i = 0;
80100639:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010063c:	31 f6                	xor    %esi,%esi
8010063e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100640:	89 c8                	mov    %ecx,%eax
80100642:	31 d2                	xor    %edx,%edx
80100644:	89 f7                	mov    %esi,%edi
80100646:	f7 f3                	div    %ebx
80100648:	8d 76 01             	lea    0x1(%esi),%esi
8010064b:	0f b6 92 10 73 10 80 	movzbl -0x7fef8cf0(%edx),%edx
80100652:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100656:	89 ca                	mov    %ecx,%edx
80100658:	89 c1                	mov    %eax,%ecx
8010065a:	39 da                	cmp    %ebx,%edx
8010065c:	73 e2                	jae    80100640 <printint+0x20>
  if(sign)
8010065e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100661:	85 c0                	test   %eax,%eax
80100663:	74 07                	je     8010066c <printint+0x4c>
    buf[i++] = '-';
80100665:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    buf[i++] = digits[x % base];
8010066a:	89 f7                	mov    %esi,%edi
8010066c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010066f:	01 df                	add    %ebx,%edi
  if(panicked){
80100671:	8b 15 58 99 11 80    	mov    0x80119958,%edx
    consputc(buf[i]);
80100677:	0f be 07             	movsbl (%edi),%eax
  if(panicked){
8010067a:	85 d2                	test   %edx,%edx
8010067c:	74 0a                	je     80100688 <printint+0x68>
8010067e:	fa                   	cli
    for(;;)
8010067f:	eb fe                	jmp    8010067f <printint+0x5f>
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100688:	e8 73 fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
8010068d:	8d 47 ff             	lea    -0x1(%edi),%eax
80100690:	39 df                	cmp    %ebx,%edi
80100692:	74 0c                	je     801006a0 <printint+0x80>
80100694:	89 c7                	mov    %eax,%edi
80100696:	eb d9                	jmp    80100671 <printint+0x51>
80100698:	89 c8                	mov    %ecx,%eax
    x = -xx;
8010069a:	89 f1                	mov    %esi,%ecx
8010069c:	f7 d9                	neg    %ecx
8010069e:	eb 99                	jmp    80100639 <printint+0x19>
}
801006a0:	83 c4 2c             	add    $0x2c,%esp
801006a3:	5b                   	pop    %ebx
801006a4:	5e                   	pop    %esi
801006a5:	5f                   	pop    %edi
801006a6:	5d                   	pop    %ebp
801006a7:	c3                   	ret
801006a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801006af:	90                   	nop

801006b0 <cprintf>:
{
801006b0:	55                   	push   %ebp
801006b1:	89 e5                	mov    %esp,%ebp
801006b3:	57                   	push   %edi
801006b4:	56                   	push   %esi
801006b5:	53                   	push   %ebx
801006b6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006b9:	8b 3d 54 99 11 80    	mov    0x80119954,%edi
  if (fmt == 0)
801006bf:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
801006c2:	85 ff                	test   %edi,%edi
801006c4:	0f 85 36 01 00 00    	jne    80100800 <cprintf+0x150>
  if (fmt == 0)
801006ca:	85 f6                	test   %esi,%esi
801006cc:	0f 84 e0 01 00 00    	je     801008b2 <cprintf+0x202>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d2:	0f b6 06             	movzbl (%esi),%eax
801006d5:	85 c0                	test   %eax,%eax
801006d7:	74 6b                	je     80100744 <cprintf+0x94>
  argp = (uint*)(void*)(&fmt + 1);
801006d9:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006dc:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801006df:	31 db                	xor    %ebx,%ebx
801006e1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006e3:	83 f8 25             	cmp    $0x25,%eax
801006e6:	0f 85 dc 00 00 00    	jne    801007c8 <cprintf+0x118>
    c = fmt[++i] & 0xff;
801006ec:	83 c3 01             	add    $0x1,%ebx
801006ef:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006f3:	85 c9                	test   %ecx,%ecx
801006f5:	74 42                	je     80100739 <cprintf+0x89>
    switch(c){
801006f7:	83 f9 70             	cmp    $0x70,%ecx
801006fa:	0f 84 99 00 00 00    	je     80100799 <cprintf+0xe9>
80100700:	7f 4e                	jg     80100750 <cprintf+0xa0>
80100702:	83 f9 25             	cmp    $0x25,%ecx
80100705:	0f 84 cd 00 00 00    	je     801007d8 <cprintf+0x128>
8010070b:	83 f9 64             	cmp    $0x64,%ecx
8010070e:	0f 85 24 01 00 00    	jne    80100838 <cprintf+0x188>
      printint(*argp++, 10, 1);
80100714:	8d 47 04             	lea    0x4(%edi),%eax
80100717:	b9 01 00 00 00       	mov    $0x1,%ecx
8010071c:	ba 0a 00 00 00       	mov    $0xa,%edx
80100721:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100724:	8b 07                	mov    (%edi),%eax
80100726:	e8 f5 fe ff ff       	call   80100620 <printint>
8010072b:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010072e:	83 c3 01             	add    $0x1,%ebx
80100731:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100735:	85 c0                	test   %eax,%eax
80100737:	75 aa                	jne    801006e3 <cprintf+0x33>
80100739:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
8010073c:	85 ff                	test   %edi,%edi
8010073e:	0f 85 df 00 00 00    	jne    80100823 <cprintf+0x173>
}
80100744:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100747:	5b                   	pop    %ebx
80100748:	5e                   	pop    %esi
80100749:	5f                   	pop    %edi
8010074a:	5d                   	pop    %ebp
8010074b:	c3                   	ret
8010074c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100750:	83 f9 73             	cmp    $0x73,%ecx
80100753:	75 3b                	jne    80100790 <cprintf+0xe0>
      if((s = (char*)*argp++) == 0)
80100755:	8b 17                	mov    (%edi),%edx
80100757:	8d 47 04             	lea    0x4(%edi),%eax
8010075a:	85 d2                	test   %edx,%edx
8010075c:	0f 85 0e 01 00 00    	jne    80100870 <cprintf+0x1c0>
80100762:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100767:	bf f8 72 10 80       	mov    $0x801072f8,%edi
8010076c:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010076f:	89 fb                	mov    %edi,%ebx
80100771:	89 f7                	mov    %esi,%edi
80100773:	89 c6                	mov    %eax,%esi
80100775:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100778:	8b 15 58 99 11 80    	mov    0x80119958,%edx
8010077e:	85 d2                	test   %edx,%edx
80100780:	0f 84 fe 00 00 00    	je     80100884 <cprintf+0x1d4>
80100786:	fa                   	cli
    for(;;)
80100787:	eb fe                	jmp    80100787 <cprintf+0xd7>
80100789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100790:	83 f9 78             	cmp    $0x78,%ecx
80100793:	0f 85 9f 00 00 00    	jne    80100838 <cprintf+0x188>
      printint(*argp++, 16, 0);
80100799:	8d 47 04             	lea    0x4(%edi),%eax
8010079c:	31 c9                	xor    %ecx,%ecx
8010079e:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007a3:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
801007a6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007a9:	8b 07                	mov    (%edi),%eax
801007ab:	e8 70 fe ff ff       	call   80100620 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b0:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
801007b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b7:	85 c0                	test   %eax,%eax
801007b9:	0f 85 24 ff ff ff    	jne    801006e3 <cprintf+0x33>
801007bf:	e9 75 ff ff ff       	jmp    80100739 <cprintf+0x89>
801007c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007c8:	8b 0d 58 99 11 80    	mov    0x80119958,%ecx
801007ce:	85 c9                	test   %ecx,%ecx
801007d0:	74 15                	je     801007e7 <cprintf+0x137>
801007d2:	fa                   	cli
    for(;;)
801007d3:	eb fe                	jmp    801007d3 <cprintf+0x123>
801007d5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007d8:	8b 0d 58 99 11 80    	mov    0x80119958,%ecx
801007de:	85 c9                	test   %ecx,%ecx
801007e0:	75 7e                	jne    80100860 <cprintf+0x1b0>
801007e2:	b8 25 00 00 00       	mov    $0x25,%eax
801007e7:	e8 14 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007ec:	83 c3 01             	add    $0x1,%ebx
801007ef:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007f3:	85 c0                	test   %eax,%eax
801007f5:	0f 85 e8 fe ff ff    	jne    801006e3 <cprintf+0x33>
801007fb:	e9 39 ff ff ff       	jmp    80100739 <cprintf+0x89>
    acquire(&cons.lock);
80100800:	83 ec 0c             	sub    $0xc,%esp
80100803:	68 20 99 11 80       	push   $0x80119920
80100808:	e8 b3 3d 00 00       	call   801045c0 <acquire>
  if (fmt == 0)
8010080d:	83 c4 10             	add    $0x10,%esp
80100810:	85 f6                	test   %esi,%esi
80100812:	0f 84 9a 00 00 00    	je     801008b2 <cprintf+0x202>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100818:	0f b6 06             	movzbl (%esi),%eax
8010081b:	85 c0                	test   %eax,%eax
8010081d:	0f 85 b6 fe ff ff    	jne    801006d9 <cprintf+0x29>
    release(&cons.lock);
80100823:	83 ec 0c             	sub    $0xc,%esp
80100826:	68 20 99 11 80       	push   $0x80119920
8010082b:	e8 d0 3e 00 00       	call   80104700 <release>
80100830:	83 c4 10             	add    $0x10,%esp
80100833:	e9 0c ff ff ff       	jmp    80100744 <cprintf+0x94>
  if(panicked){
80100838:	8b 15 58 99 11 80    	mov    0x80119958,%edx
8010083e:	85 d2                	test   %edx,%edx
80100840:	75 26                	jne    80100868 <cprintf+0x1b8>
80100842:	b8 25 00 00 00       	mov    $0x25,%eax
80100847:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010084a:	e8 b1 fb ff ff       	call   80100400 <consputc.part.0>
8010084f:	a1 58 99 11 80       	mov    0x80119958,%eax
80100854:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80100857:	85 c0                	test   %eax,%eax
80100859:	74 4b                	je     801008a6 <cprintf+0x1f6>
8010085b:	fa                   	cli
    for(;;)
8010085c:	eb fe                	jmp    8010085c <cprintf+0x1ac>
8010085e:	66 90                	xchg   %ax,%ax
80100860:	fa                   	cli
80100861:	eb fe                	jmp    80100861 <cprintf+0x1b1>
80100863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100867:	90                   	nop
80100868:	fa                   	cli
80100869:	eb fe                	jmp    80100869 <cprintf+0x1b9>
8010086b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010086f:	90                   	nop
      for(; *s; s++)
80100870:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100873:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100875:	84 c9                	test   %cl,%cl
80100877:	0f 85 ef fe ff ff    	jne    8010076c <cprintf+0xbc>
      if((s = (char*)*argp++) == 0)
8010087d:	89 c7                	mov    %eax,%edi
8010087f:	e9 aa fe ff ff       	jmp    8010072e <cprintf+0x7e>
80100884:	e8 77 fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100889:	0f be 43 01          	movsbl 0x1(%ebx),%eax
8010088d:	83 c3 01             	add    $0x1,%ebx
80100890:	84 c0                	test   %al,%al
80100892:	0f 85 e0 fe ff ff    	jne    80100778 <cprintf+0xc8>
      if((s = (char*)*argp++) == 0)
80100898:	89 f0                	mov    %esi,%eax
8010089a:	8b 5d e0             	mov    -0x20(%ebp),%ebx
8010089d:	89 fe                	mov    %edi,%esi
8010089f:	89 c7                	mov    %eax,%edi
801008a1:	e9 88 fe ff ff       	jmp    8010072e <cprintf+0x7e>
801008a6:	89 c8                	mov    %ecx,%eax
801008a8:	e8 53 fb ff ff       	call   80100400 <consputc.part.0>
801008ad:	e9 7c fe ff ff       	jmp    8010072e <cprintf+0x7e>
    panic("null fmt");
801008b2:	83 ec 0c             	sub    $0xc,%esp
801008b5:	68 ff 72 10 80       	push   $0x801072ff
801008ba:	e8 c1 fa ff ff       	call   80100380 <panic>
801008bf:	90                   	nop

801008c0 <consoleintr>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
801008c4:	56                   	push   %esi
  int c, doprocdump = 0;   
801008c5:	31 f6                	xor    %esi,%esi
{
801008c7:	53                   	push   %ebx
801008c8:	83 ec 18             	sub    $0x18,%esp
801008cb:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
801008ce:	68 20 99 11 80       	push   $0x80119920
801008d3:	e8 e8 3c 00 00       	call   801045c0 <acquire>
  while((c = getc()) >= 0){
801008d8:	83 c4 10             	add    $0x10,%esp
801008db:	eb 1a                	jmp    801008f7 <consoleintr+0x37>
801008dd:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008e0:	83 fb 08             	cmp    $0x8,%ebx
801008e3:	0f 84 d7 00 00 00    	je     801009c0 <consoleintr+0x100>
801008e9:	83 fb 10             	cmp    $0x10,%ebx
801008ec:	0f 85 2d 01 00 00    	jne    80100a1f <consoleintr+0x15f>
801008f2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008f7:	ff d7                	call   *%edi
801008f9:	89 c3                	mov    %eax,%ebx
801008fb:	85 c0                	test   %eax,%eax
801008fd:	0f 88 e5 00 00 00    	js     801009e8 <consoleintr+0x128>
    switch(c){
80100903:	83 fb 15             	cmp    $0x15,%ebx
80100906:	74 7a                	je     80100982 <consoleintr+0xc2>
80100908:	7e d6                	jle    801008e0 <consoleintr+0x20>
8010090a:	83 fb 7f             	cmp    $0x7f,%ebx
8010090d:	0f 84 ad 00 00 00    	je     801009c0 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100913:	a1 08 99 11 80       	mov    0x80119908,%eax
80100918:	89 c2                	mov    %eax,%edx
8010091a:	2b 15 00 99 11 80    	sub    0x80119900,%edx
80100920:	83 fa 7f             	cmp    $0x7f,%edx
80100923:	77 d2                	ja     801008f7 <consoleintr+0x37>
  if(panicked){
80100925:	8b 15 58 99 11 80    	mov    0x80119958,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
8010092b:	8d 48 01             	lea    0x1(%eax),%ecx
8010092e:	83 e0 7f             	and    $0x7f,%eax
80100931:	89 0d 08 99 11 80    	mov    %ecx,0x80119908
80100937:	88 98 80 98 11 80    	mov    %bl,-0x7fee6780(%eax)
  if(panicked){
8010093d:	85 d2                	test   %edx,%edx
8010093f:	0f 85 47 01 00 00    	jne    80100a8c <consoleintr+0x1cc>
80100945:	89 d8                	mov    %ebx,%eax
80100947:	e8 b4 fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010094c:	83 fb 0a             	cmp    $0xa,%ebx
8010094f:	0f 84 18 01 00 00    	je     80100a6d <consoleintr+0x1ad>
80100955:	83 fb 04             	cmp    $0x4,%ebx
80100958:	0f 84 0f 01 00 00    	je     80100a6d <consoleintr+0x1ad>
8010095e:	a1 00 99 11 80       	mov    0x80119900,%eax
80100963:	83 e8 80             	sub    $0xffffff80,%eax
80100966:	39 05 08 99 11 80    	cmp    %eax,0x80119908
8010096c:	75 89                	jne    801008f7 <consoleintr+0x37>
8010096e:	e9 ff 00 00 00       	jmp    80100a72 <consoleintr+0x1b2>
80100973:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100977:	90                   	nop
80100978:	b8 00 01 00 00       	mov    $0x100,%eax
8010097d:	e8 7e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
80100982:	a1 08 99 11 80       	mov    0x80119908,%eax
80100987:	3b 05 04 99 11 80    	cmp    0x80119904,%eax
8010098d:	0f 84 64 ff ff ff    	je     801008f7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100993:	83 e8 01             	sub    $0x1,%eax
80100996:	89 c2                	mov    %eax,%edx
80100998:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010099b:	80 ba 80 98 11 80 0a 	cmpb   $0xa,-0x7fee6780(%edx)
801009a2:	0f 84 4f ff ff ff    	je     801008f7 <consoleintr+0x37>
  if(panicked){
801009a8:	8b 15 58 99 11 80    	mov    0x80119958,%edx
        input.e--;
801009ae:	a3 08 99 11 80       	mov    %eax,0x80119908
  if(panicked){
801009b3:	85 d2                	test   %edx,%edx
801009b5:	74 c1                	je     80100978 <consoleintr+0xb8>
801009b7:	fa                   	cli
    for(;;)
801009b8:	eb fe                	jmp    801009b8 <consoleintr+0xf8>
801009ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(input.e != input.w){
801009c0:	a1 08 99 11 80       	mov    0x80119908,%eax
801009c5:	3b 05 04 99 11 80    	cmp    0x80119904,%eax
801009cb:	0f 84 26 ff ff ff    	je     801008f7 <consoleintr+0x37>
        input.e--;
801009d1:	83 e8 01             	sub    $0x1,%eax
801009d4:	a3 08 99 11 80       	mov    %eax,0x80119908
  if(panicked){
801009d9:	a1 58 99 11 80       	mov    0x80119958,%eax
801009de:	85 c0                	test   %eax,%eax
801009e0:	74 22                	je     80100a04 <consoleintr+0x144>
801009e2:	fa                   	cli
    for(;;)
801009e3:	eb fe                	jmp    801009e3 <consoleintr+0x123>
801009e5:	8d 76 00             	lea    0x0(%esi),%esi
  release(&cons.lock);
801009e8:	83 ec 0c             	sub    $0xc,%esp
801009eb:	68 20 99 11 80       	push   $0x80119920
801009f0:	e8 0b 3d 00 00       	call   80104700 <release>
  if(doprocdump) {
801009f5:	83 c4 10             	add    $0x10,%esp
801009f8:	85 f6                	test   %esi,%esi
801009fa:	75 17                	jne    80100a13 <consoleintr+0x153>
}
801009fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009ff:	5b                   	pop    %ebx
80100a00:	5e                   	pop    %esi
80100a01:	5f                   	pop    %edi
80100a02:	5d                   	pop    %ebp
80100a03:	c3                   	ret
80100a04:	b8 00 01 00 00       	mov    $0x100,%eax
80100a09:	e8 f2 f9 ff ff       	call   80100400 <consputc.part.0>
80100a0e:	e9 e4 fe ff ff       	jmp    801008f7 <consoleintr+0x37>
80100a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a16:	5b                   	pop    %ebx
80100a17:	5e                   	pop    %esi
80100a18:	5f                   	pop    %edi
80100a19:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a1a:	e9 a1 37 00 00       	jmp    801041c0 <procdump>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a1f:	85 db                	test   %ebx,%ebx
80100a21:	0f 84 d0 fe ff ff    	je     801008f7 <consoleintr+0x37>
80100a27:	a1 08 99 11 80       	mov    0x80119908,%eax
80100a2c:	89 c2                	mov    %eax,%edx
80100a2e:	2b 15 00 99 11 80    	sub    0x80119900,%edx
80100a34:	83 fa 7f             	cmp    $0x7f,%edx
80100a37:	0f 87 ba fe ff ff    	ja     801008f7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a3d:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
80100a40:	8b 15 58 99 11 80    	mov    0x80119958,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
80100a46:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100a49:	83 fb 0d             	cmp    $0xd,%ebx
80100a4c:	0f 85 df fe ff ff    	jne    80100931 <consoleintr+0x71>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a52:	89 0d 08 99 11 80    	mov    %ecx,0x80119908
80100a58:	c6 80 80 98 11 80 0a 	movb   $0xa,-0x7fee6780(%eax)
  if(panicked){
80100a5f:	85 d2                	test   %edx,%edx
80100a61:	75 29                	jne    80100a8c <consoleintr+0x1cc>
80100a63:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a68:	e8 93 f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a6d:	a1 08 99 11 80       	mov    0x80119908,%eax
          wakeup(&input.r);
80100a72:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a75:	a3 04 99 11 80       	mov    %eax,0x80119904
          wakeup(&input.r);
80100a7a:	68 00 99 11 80       	push   $0x80119900
80100a7f:	e8 5c 36 00 00       	call   801040e0 <wakeup>
80100a84:	83 c4 10             	add    $0x10,%esp
80100a87:	e9 6b fe ff ff       	jmp    801008f7 <consoleintr+0x37>
80100a8c:	fa                   	cli
    for(;;)
80100a8d:	eb fe                	jmp    80100a8d <consoleintr+0x1cd>
80100a8f:	90                   	nop

80100a90 <consoleinit>:

void
consoleinit(void)
{
80100a90:	55                   	push   %ebp
80100a91:	89 e5                	mov    %esp,%ebp
80100a93:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a96:	68 08 73 10 80       	push   $0x80107308
80100a9b:	68 20 99 11 80       	push   $0x80119920
80100aa0:	e8 fb 39 00 00       	call   801044a0 <initlock>

  devsw[CONSOLE].write = consolewrite;
80100aa5:	c7 05 0c a3 11 80 b0 	movl   $0x801005b0,0x8011a30c
80100aac:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100aaf:	c7 05 08 a3 11 80 80 	movl   $0x80100280,0x8011a308
80100ab6:	02 10 80 
  cons.locking = 1;
80100ab9:	c7 05 54 99 11 80 01 	movl   $0x1,0x80119954
80100ac0:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100ac3:	58                   	pop    %eax
80100ac4:	5a                   	pop    %edx
80100ac5:	6a 00                	push   $0x0
80100ac7:	6a 01                	push   $0x1
80100ac9:	e8 32 1a 00 00       	call   80102500 <ioapicenable>
}
80100ace:	83 c4 10             	add    $0x10,%esp
80100ad1:	c9                   	leave
80100ad2:	c3                   	ret
80100ad3:	66 90                	xchg   %ax,%ax
80100ad5:	66 90                	xchg   %ax,%ax
80100ad7:	66 90                	xchg   %ax,%ax
80100ad9:	66 90                	xchg   %ax,%ax
80100adb:	66 90                	xchg   %ax,%ax
80100add:	66 90                	xchg   %ax,%ax
80100adf:	90                   	nop

80100ae0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ae0:	55                   	push   %ebp
80100ae1:	89 e5                	mov    %esp,%ebp
80100ae3:	57                   	push   %edi
80100ae4:	56                   	push   %esi
80100ae5:	53                   	push   %ebx
80100ae6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100aec:	e8 5f 2e 00 00       	call   80103950 <myproc>
80100af1:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100af7:	e8 24 22 00 00       	call   80102d20 <begin_op>

  if((ip = namei(path)) == 0){
80100afc:	83 ec 0c             	sub    $0xc,%esp
80100aff:	ff 75 08             	push   0x8(%ebp)
80100b02:	e8 19 16 00 00       	call   80102120 <namei>
80100b07:	83 c4 10             	add    $0x10,%esp
80100b0a:	85 c0                	test   %eax,%eax
80100b0c:	0f 84 30 03 00 00    	je     80100e42 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100b12:	83 ec 0c             	sub    $0xc,%esp
80100b15:	89 c7                	mov    %eax,%edi
80100b17:	50                   	push   %eax
80100b18:	e8 d3 0c 00 00       	call   801017f0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100b1d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100b23:	6a 34                	push   $0x34
80100b25:	6a 00                	push   $0x0
80100b27:	50                   	push   %eax
80100b28:	57                   	push   %edi
80100b29:	e8 d2 0f 00 00       	call   80101b00 <readi>
80100b2e:	83 c4 20             	add    $0x20,%esp
80100b31:	83 f8 34             	cmp    $0x34,%eax
80100b34:	0f 85 01 01 00 00    	jne    80100c3b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b3a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b41:	45 4c 46 
80100b44:	0f 85 f1 00 00 00    	jne    80100c3b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b4a:	e8 11 64 00 00       	call   80106f60 <setupkvm>
80100b4f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b55:	85 c0                	test   %eax,%eax
80100b57:	0f 84 de 00 00 00    	je     80100c3b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b5d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b64:	00 
80100b65:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b6b:	0f 84 a1 02 00 00    	je     80100e12 <exec+0x332>
  sz = 0;
80100b71:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b78:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b7b:	31 db                	xor    %ebx,%ebx
80100b7d:	e9 8c 00 00 00       	jmp    80100c0e <exec+0x12e>
80100b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b88:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b8f:	75 6c                	jne    80100bfd <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100b91:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b97:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b9d:	0f 82 87 00 00 00    	jb     80100c2a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ba3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ba9:	72 7f                	jb     80100c2a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bab:	83 ec 04             	sub    $0x4,%esp
80100bae:	50                   	push   %eax
80100baf:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100bb5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bbb:	e8 d0 61 00 00       	call   80106d90 <allocuvm>
80100bc0:	83 c4 10             	add    $0x10,%esp
80100bc3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bc9:	85 c0                	test   %eax,%eax
80100bcb:	74 5d                	je     80100c2a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100bcd:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bd3:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bd8:	75 50                	jne    80100c2a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bda:	83 ec 0c             	sub    $0xc,%esp
80100bdd:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100be3:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100be9:	57                   	push   %edi
80100bea:	50                   	push   %eax
80100beb:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bf1:	e8 ca 60 00 00       	call   80106cc0 <loaduvm>
80100bf6:	83 c4 20             	add    $0x20,%esp
80100bf9:	85 c0                	test   %eax,%eax
80100bfb:	78 2d                	js     80100c2a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bfd:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100c04:	83 c3 01             	add    $0x1,%ebx
80100c07:	83 c6 20             	add    $0x20,%esi
80100c0a:	39 d8                	cmp    %ebx,%eax
80100c0c:	7e 52                	jle    80100c60 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c0e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100c14:	6a 20                	push   $0x20
80100c16:	56                   	push   %esi
80100c17:	50                   	push   %eax
80100c18:	57                   	push   %edi
80100c19:	e8 e2 0e 00 00       	call   80101b00 <readi>
80100c1e:	83 c4 10             	add    $0x10,%esp
80100c21:	83 f8 20             	cmp    $0x20,%eax
80100c24:	0f 84 5e ff ff ff    	je     80100b88 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100c2a:	83 ec 0c             	sub    $0xc,%esp
80100c2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c33:	e8 a8 62 00 00       	call   80106ee0 <freevm>
  if(ip){
80100c38:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100c3b:	83 ec 0c             	sub    $0xc,%esp
80100c3e:	57                   	push   %edi
80100c3f:	e8 3c 0e 00 00       	call   80101a80 <iunlockput>
    end_op();
80100c44:	e8 47 21 00 00       	call   80102d90 <end_op>
80100c49:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100c51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c54:	5b                   	pop    %ebx
80100c55:	5e                   	pop    %esi
80100c56:	5f                   	pop    %edi
80100c57:	5d                   	pop    %ebp
80100c58:	c3                   	ret
80100c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100c60:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c66:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100c6c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c72:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100c78:	83 ec 0c             	sub    $0xc,%esp
80100c7b:	57                   	push   %edi
80100c7c:	e8 ff 0d 00 00       	call   80101a80 <iunlockput>
  end_op();
80100c81:	e8 0a 21 00 00       	call   80102d90 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c86:	83 c4 0c             	add    $0xc,%esp
80100c89:	53                   	push   %ebx
80100c8a:	56                   	push   %esi
80100c8b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c91:	56                   	push   %esi
80100c92:	e8 f9 60 00 00       	call   80106d90 <allocuvm>
80100c97:	83 c4 10             	add    $0x10,%esp
80100c9a:	89 c7                	mov    %eax,%edi
80100c9c:	85 c0                	test   %eax,%eax
80100c9e:	0f 84 86 00 00 00    	je     80100d2a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ca4:	83 ec 08             	sub    $0x8,%esp
80100ca7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100cad:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100caf:	50                   	push   %eax
80100cb0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100cb1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cb3:	e8 48 63 00 00       	call   80107000 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100cb8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cbb:	83 c4 10             	add    $0x10,%esp
80100cbe:	8b 10                	mov    (%eax),%edx
80100cc0:	85 d2                	test   %edx,%edx
80100cc2:	0f 84 56 01 00 00    	je     80100e1e <exec+0x33e>
80100cc8:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100cce:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100cd1:	eb 23                	jmp    80100cf6 <exec+0x216>
80100cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cd7:	90                   	nop
80100cd8:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100cdb:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100ce2:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100ce8:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100ceb:	85 d2                	test   %edx,%edx
80100ced:	74 51                	je     80100d40 <exec+0x260>
    if(argc >= MAXARG)
80100cef:	83 f8 20             	cmp    $0x20,%eax
80100cf2:	74 36                	je     80100d2a <exec+0x24a>
  for(argc = 0; argv[argc]; argc++) {
80100cf4:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cf6:	83 ec 0c             	sub    $0xc,%esp
80100cf9:	52                   	push   %edx
80100cfa:	e8 41 3c 00 00       	call   80104940 <strlen>
80100cff:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d01:	58                   	pop    %eax
80100d02:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d05:	83 eb 01             	sub    $0x1,%ebx
80100d08:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d0b:	e8 30 3c 00 00       	call   80104940 <strlen>
80100d10:	83 c0 01             	add    $0x1,%eax
80100d13:	50                   	push   %eax
80100d14:	ff 34 b7             	push   (%edi,%esi,4)
80100d17:	53                   	push   %ebx
80100d18:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d1e:	e8 9d 64 00 00       	call   801071c0 <copyout>
80100d23:	83 c4 20             	add    $0x20,%esp
80100d26:	85 c0                	test   %eax,%eax
80100d28:	79 ae                	jns    80100cd8 <exec+0x1f8>
    freevm(pgdir);
80100d2a:	83 ec 0c             	sub    $0xc,%esp
80100d2d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d33:	e8 a8 61 00 00       	call   80106ee0 <freevm>
80100d38:	83 c4 10             	add    $0x10,%esp
80100d3b:	e9 0c ff ff ff       	jmp    80100c4c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d40:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100d47:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100d4d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d53:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100d56:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100d59:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100d60:	00 00 00 00 
  ustack[1] = argc;
80100d64:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100d6a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d71:	ff ff ff 
  ustack[1] = argc;
80100d74:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d7a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100d7c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d7e:	29 d0                	sub    %edx,%eax
80100d80:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d86:	56                   	push   %esi
80100d87:	51                   	push   %ecx
80100d88:	53                   	push   %ebx
80100d89:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d8f:	e8 2c 64 00 00       	call   801071c0 <copyout>
80100d94:	83 c4 10             	add    $0x10,%esp
80100d97:	85 c0                	test   %eax,%eax
80100d99:	78 8f                	js     80100d2a <exec+0x24a>
  for(last=s=path; *s; s++)
80100d9b:	8b 45 08             	mov    0x8(%ebp),%eax
80100d9e:	8b 55 08             	mov    0x8(%ebp),%edx
80100da1:	0f b6 00             	movzbl (%eax),%eax
80100da4:	84 c0                	test   %al,%al
80100da6:	74 17                	je     80100dbf <exec+0x2df>
80100da8:	89 d1                	mov    %edx,%ecx
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100db0:	83 c1 01             	add    $0x1,%ecx
80100db3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100db5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100db8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100dbb:	84 c0                	test   %al,%al
80100dbd:	75 f1                	jne    80100db0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100dbf:	83 ec 04             	sub    $0x4,%esp
80100dc2:	6a 10                	push   $0x10
80100dc4:	52                   	push   %edx
80100dc5:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100dcb:	8d 46 6c             	lea    0x6c(%esi),%eax
80100dce:	50                   	push   %eax
80100dcf:	e8 2c 3b 00 00       	call   80104900 <safestrcpy>
  curproc->pgdir = pgdir;
80100dd4:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dda:	89 f0                	mov    %esi,%eax
80100ddc:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100ddf:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100de1:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100de4:	89 c1                	mov    %eax,%ecx
80100de6:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dec:	8b 40 18             	mov    0x18(%eax),%eax
80100def:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100df2:	8b 41 18             	mov    0x18(%ecx),%eax
80100df5:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100df8:	89 0c 24             	mov    %ecx,(%esp)
80100dfb:	e8 30 5d 00 00       	call   80106b30 <switchuvm>
  freevm(oldpgdir);
80100e00:	89 34 24             	mov    %esi,(%esp)
80100e03:	e8 d8 60 00 00       	call   80106ee0 <freevm>
  return 0;
80100e08:	83 c4 10             	add    $0x10,%esp
80100e0b:	31 c0                	xor    %eax,%eax
80100e0d:	e9 3f fe ff ff       	jmp    80100c51 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e12:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100e17:	31 f6                	xor    %esi,%esi
80100e19:	e9 5a fe ff ff       	jmp    80100c78 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100e1e:	be 10 00 00 00       	mov    $0x10,%esi
80100e23:	ba 04 00 00 00       	mov    $0x4,%edx
80100e28:	b8 03 00 00 00       	mov    $0x3,%eax
80100e2d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100e34:	00 00 00 
80100e37:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100e3d:	e9 17 ff ff ff       	jmp    80100d59 <exec+0x279>
    end_op();
80100e42:	e8 49 1f 00 00       	call   80102d90 <end_op>
    cprintf("exec: fail\n");
80100e47:	83 ec 0c             	sub    $0xc,%esp
80100e4a:	68 21 73 10 80       	push   $0x80107321
80100e4f:	e8 5c f8 ff ff       	call   801006b0 <cprintf>
    return -1;
80100e54:	83 c4 10             	add    $0x10,%esp
80100e57:	e9 f0 fd ff ff       	jmp    80100c4c <exec+0x16c>
80100e5c:	66 90                	xchg   %ax,%ax
80100e5e:	66 90                	xchg   %ax,%ax

80100e60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e60:	55                   	push   %ebp
80100e61:	89 e5                	mov    %esp,%ebp
80100e63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e66:	68 2d 73 10 80       	push   $0x8010732d
80100e6b:	68 60 99 11 80       	push   $0x80119960
80100e70:	e8 2b 36 00 00       	call   801044a0 <initlock>
}
80100e75:	83 c4 10             	add    $0x10,%esp
80100e78:	c9                   	leave
80100e79:	c3                   	ret
80100e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e84:	bb 94 99 11 80       	mov    $0x80119994,%ebx
{
80100e89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e8c:	68 60 99 11 80       	push   $0x80119960
80100e91:	e8 2a 37 00 00       	call   801045c0 <acquire>
80100e96:	83 c4 10             	add    $0x10,%esp
80100e99:	eb 10                	jmp    80100eab <filealloc+0x2b>
80100e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e9f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100ea0:	83 c3 18             	add    $0x18,%ebx
80100ea3:	81 fb f4 a2 11 80    	cmp    $0x8011a2f4,%ebx
80100ea9:	74 25                	je     80100ed0 <filealloc+0x50>
    if(f->ref == 0){
80100eab:	8b 43 04             	mov    0x4(%ebx),%eax
80100eae:	85 c0                	test   %eax,%eax
80100eb0:	75 ee                	jne    80100ea0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100eb2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100eb5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100ebc:	68 60 99 11 80       	push   $0x80119960
80100ec1:	e8 3a 38 00 00       	call   80104700 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100ec6:	89 d8                	mov    %ebx,%eax
      return f;
80100ec8:	83 c4 10             	add    $0x10,%esp
}
80100ecb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ece:	c9                   	leave
80100ecf:	c3                   	ret
  release(&ftable.lock);
80100ed0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100ed3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100ed5:	68 60 99 11 80       	push   $0x80119960
80100eda:	e8 21 38 00 00       	call   80104700 <release>
}
80100edf:	89 d8                	mov    %ebx,%eax
  return 0;
80100ee1:	83 c4 10             	add    $0x10,%esp
}
80100ee4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ee7:	c9                   	leave
80100ee8:	c3                   	ret
80100ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 10             	sub    $0x10,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100efa:	68 60 99 11 80       	push   $0x80119960
80100eff:	e8 bc 36 00 00       	call   801045c0 <acquire>
  if(f->ref < 1)
80100f04:	8b 43 04             	mov    0x4(%ebx),%eax
80100f07:	83 c4 10             	add    $0x10,%esp
80100f0a:	85 c0                	test   %eax,%eax
80100f0c:	7e 1a                	jle    80100f28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100f0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100f11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100f14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100f17:	68 60 99 11 80       	push   $0x80119960
80100f1c:	e8 df 37 00 00       	call   80104700 <release>
  return f;
}
80100f21:	89 d8                	mov    %ebx,%eax
80100f23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f26:	c9                   	leave
80100f27:	c3                   	ret
    panic("filedup");
80100f28:	83 ec 0c             	sub    $0xc,%esp
80100f2b:	68 34 73 10 80       	push   $0x80107334
80100f30:	e8 4b f4 ff ff       	call   80100380 <panic>
80100f35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 28             	sub    $0x28,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100f4c:	68 60 99 11 80       	push   $0x80119960
80100f51:	e8 6a 36 00 00       	call   801045c0 <acquire>
  if(f->ref < 1)
80100f56:	8b 53 04             	mov    0x4(%ebx),%edx
80100f59:	83 c4 10             	add    $0x10,%esp
80100f5c:	85 d2                	test   %edx,%edx
80100f5e:	0f 8e a5 00 00 00    	jle    80101009 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f64:	83 ea 01             	sub    $0x1,%edx
80100f67:	89 53 04             	mov    %edx,0x4(%ebx)
80100f6a:	75 44                	jne    80100fb0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f6c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f70:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f73:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f75:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f7b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f7e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f81:	8b 43 10             	mov    0x10(%ebx),%eax
80100f84:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f87:	68 60 99 11 80       	push   $0x80119960
80100f8c:	e8 6f 37 00 00       	call   80104700 <release>

  if(ff.type == FD_PIPE)
80100f91:	83 c4 10             	add    $0x10,%esp
80100f94:	83 ff 01             	cmp    $0x1,%edi
80100f97:	74 57                	je     80100ff0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f99:	83 ff 02             	cmp    $0x2,%edi
80100f9c:	74 2a                	je     80100fc8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fa1:	5b                   	pop    %ebx
80100fa2:	5e                   	pop    %esi
80100fa3:	5f                   	pop    %edi
80100fa4:	5d                   	pop    %ebp
80100fa5:	c3                   	ret
80100fa6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fad:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100fb0:	c7 45 08 60 99 11 80 	movl   $0x80119960,0x8(%ebp)
}
80100fb7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fba:	5b                   	pop    %ebx
80100fbb:	5e                   	pop    %esi
80100fbc:	5f                   	pop    %edi
80100fbd:	5d                   	pop    %ebp
    release(&ftable.lock);
80100fbe:	e9 3d 37 00 00       	jmp    80104700 <release>
80100fc3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100fc7:	90                   	nop
    begin_op();
80100fc8:	e8 53 1d 00 00       	call   80102d20 <begin_op>
    iput(ff.ip);
80100fcd:	83 ec 0c             	sub    $0xc,%esp
80100fd0:	ff 75 e0             	push   -0x20(%ebp)
80100fd3:	e8 48 09 00 00       	call   80101920 <iput>
    end_op();
80100fd8:	83 c4 10             	add    $0x10,%esp
}
80100fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fde:	5b                   	pop    %ebx
80100fdf:	5e                   	pop    %esi
80100fe0:	5f                   	pop    %edi
80100fe1:	5d                   	pop    %ebp
    end_op();
80100fe2:	e9 a9 1d 00 00       	jmp    80102d90 <end_op>
80100fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fee:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100ff0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ff4:	83 ec 08             	sub    $0x8,%esp
80100ff7:	53                   	push   %ebx
80100ff8:	56                   	push   %esi
80100ff9:	e8 e2 24 00 00       	call   801034e0 <pipeclose>
80100ffe:	83 c4 10             	add    $0x10,%esp
}
80101001:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101004:	5b                   	pop    %ebx
80101005:	5e                   	pop    %esi
80101006:	5f                   	pop    %edi
80101007:	5d                   	pop    %ebp
80101008:	c3                   	ret
    panic("fileclose");
80101009:	83 ec 0c             	sub    $0xc,%esp
8010100c:	68 3c 73 10 80       	push   $0x8010733c
80101011:	e8 6a f3 ff ff       	call   80100380 <panic>
80101016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010101d:	8d 76 00             	lea    0x0(%esi),%esi

80101020 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	53                   	push   %ebx
80101024:	83 ec 04             	sub    $0x4,%esp
80101027:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010102a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010102d:	75 31                	jne    80101060 <filestat+0x40>
    ilock(f->ip);
8010102f:	83 ec 0c             	sub    $0xc,%esp
80101032:	ff 73 10             	push   0x10(%ebx)
80101035:	e8 b6 07 00 00       	call   801017f0 <ilock>
    stati(f->ip, st);
8010103a:	58                   	pop    %eax
8010103b:	5a                   	pop    %edx
8010103c:	ff 75 0c             	push   0xc(%ebp)
8010103f:	ff 73 10             	push   0x10(%ebx)
80101042:	e8 89 0a 00 00       	call   80101ad0 <stati>
    iunlock(f->ip);
80101047:	59                   	pop    %ecx
80101048:	ff 73 10             	push   0x10(%ebx)
8010104b:	e8 80 08 00 00       	call   801018d0 <iunlock>
    return 0;
  }
  return -1;
}
80101050:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101053:	83 c4 10             	add    $0x10,%esp
80101056:	31 c0                	xor    %eax,%eax
}
80101058:	c9                   	leave
80101059:	c3                   	ret
8010105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101060:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101063:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101068:	c9                   	leave
80101069:	c3                   	ret
8010106a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101070 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	57                   	push   %edi
80101074:	56                   	push   %esi
80101075:	53                   	push   %ebx
80101076:	83 ec 0c             	sub    $0xc,%esp
80101079:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010107c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010107f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101082:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101086:	74 60                	je     801010e8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101088:	8b 03                	mov    (%ebx),%eax
8010108a:	83 f8 01             	cmp    $0x1,%eax
8010108d:	74 41                	je     801010d0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010108f:	83 f8 02             	cmp    $0x2,%eax
80101092:	75 5b                	jne    801010ef <fileread+0x7f>
    ilock(f->ip);
80101094:	83 ec 0c             	sub    $0xc,%esp
80101097:	ff 73 10             	push   0x10(%ebx)
8010109a:	e8 51 07 00 00       	call   801017f0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010109f:	57                   	push   %edi
801010a0:	ff 73 14             	push   0x14(%ebx)
801010a3:	56                   	push   %esi
801010a4:	ff 73 10             	push   0x10(%ebx)
801010a7:	e8 54 0a 00 00       	call   80101b00 <readi>
801010ac:	83 c4 20             	add    $0x20,%esp
801010af:	89 c6                	mov    %eax,%esi
801010b1:	85 c0                	test   %eax,%eax
801010b3:	7e 03                	jle    801010b8 <fileread+0x48>
      f->off += r;
801010b5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801010b8:	83 ec 0c             	sub    $0xc,%esp
801010bb:	ff 73 10             	push   0x10(%ebx)
801010be:	e8 0d 08 00 00       	call   801018d0 <iunlock>
    return r;
801010c3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801010c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010c9:	89 f0                	mov    %esi,%eax
801010cb:	5b                   	pop    %ebx
801010cc:	5e                   	pop    %esi
801010cd:	5f                   	pop    %edi
801010ce:	5d                   	pop    %ebp
801010cf:	c3                   	ret
    return piperead(f->pipe, addr, n);
801010d0:	8b 43 0c             	mov    0xc(%ebx),%eax
801010d3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d9:	5b                   	pop    %ebx
801010da:	5e                   	pop    %esi
801010db:	5f                   	pop    %edi
801010dc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801010dd:	e9 be 25 00 00       	jmp    801036a0 <piperead>
801010e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010e8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801010ed:	eb d7                	jmp    801010c6 <fileread+0x56>
  panic("fileread");
801010ef:	83 ec 0c             	sub    $0xc,%esp
801010f2:	68 46 73 10 80       	push   $0x80107346
801010f7:	e8 84 f2 ff ff       	call   80100380 <panic>
801010fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101100 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	56                   	push   %esi
80101105:	53                   	push   %ebx
80101106:	83 ec 1c             	sub    $0x1c,%esp
80101109:	8b 45 0c             	mov    0xc(%ebp),%eax
8010110c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010110f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101112:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101115:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101119:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010111c:	0f 84 bb 00 00 00    	je     801011dd <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101122:	8b 03                	mov    (%ebx),%eax
80101124:	83 f8 01             	cmp    $0x1,%eax
80101127:	0f 84 bf 00 00 00    	je     801011ec <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010112d:	83 f8 02             	cmp    $0x2,%eax
80101130:	0f 85 c8 00 00 00    	jne    801011fe <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101136:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101139:	31 f6                	xor    %esi,%esi
    while(i < n){
8010113b:	85 c0                	test   %eax,%eax
8010113d:	7f 30                	jg     8010116f <filewrite+0x6f>
8010113f:	e9 94 00 00 00       	jmp    801011d8 <filewrite+0xd8>
80101144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101148:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010114b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010114e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101151:	ff 73 10             	push   0x10(%ebx)
80101154:	e8 77 07 00 00       	call   801018d0 <iunlock>
      end_op();
80101159:	e8 32 1c 00 00       	call   80102d90 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010115e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101161:	83 c4 10             	add    $0x10,%esp
80101164:	39 c7                	cmp    %eax,%edi
80101166:	75 5c                	jne    801011c4 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101168:	01 fe                	add    %edi,%esi
    while(i < n){
8010116a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010116d:	7e 69                	jle    801011d8 <filewrite+0xd8>
      int n1 = n - i;
8010116f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101172:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101177:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101179:	39 c7                	cmp    %eax,%edi
8010117b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010117e:	e8 9d 1b 00 00       	call   80102d20 <begin_op>
      ilock(f->ip);
80101183:	83 ec 0c             	sub    $0xc,%esp
80101186:	ff 73 10             	push   0x10(%ebx)
80101189:	e8 62 06 00 00       	call   801017f0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010118e:	57                   	push   %edi
8010118f:	ff 73 14             	push   0x14(%ebx)
80101192:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101195:	01 f0                	add    %esi,%eax
80101197:	50                   	push   %eax
80101198:	ff 73 10             	push   0x10(%ebx)
8010119b:	e8 60 0a 00 00       	call   80101c00 <writei>
801011a0:	83 c4 20             	add    $0x20,%esp
801011a3:	85 c0                	test   %eax,%eax
801011a5:	7f a1                	jg     80101148 <filewrite+0x48>
801011a7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011aa:	83 ec 0c             	sub    $0xc,%esp
801011ad:	ff 73 10             	push   0x10(%ebx)
801011b0:	e8 1b 07 00 00       	call   801018d0 <iunlock>
      end_op();
801011b5:	e8 d6 1b 00 00       	call   80102d90 <end_op>
      if(r < 0)
801011ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011bd:	83 c4 10             	add    $0x10,%esp
801011c0:	85 c0                	test   %eax,%eax
801011c2:	75 14                	jne    801011d8 <filewrite+0xd8>
        panic("short filewrite");
801011c4:	83 ec 0c             	sub    $0xc,%esp
801011c7:	68 4f 73 10 80       	push   $0x8010734f
801011cc:	e8 af f1 ff ff       	call   80100380 <panic>
801011d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
801011d8:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801011db:	74 05                	je     801011e2 <filewrite+0xe2>
    return -1;
801011dd:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801011e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011e5:	89 f0                	mov    %esi,%eax
801011e7:	5b                   	pop    %ebx
801011e8:	5e                   	pop    %esi
801011e9:	5f                   	pop    %edi
801011ea:	5d                   	pop    %ebp
801011eb:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
801011ec:	8b 43 0c             	mov    0xc(%ebx),%eax
801011ef:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011f5:	5b                   	pop    %ebx
801011f6:	5e                   	pop    %esi
801011f7:	5f                   	pop    %edi
801011f8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011f9:	e9 82 23 00 00       	jmp    80103580 <pipewrite>
  panic("filewrite");
801011fe:	83 ec 0c             	sub    $0xc,%esp
80101201:	68 55 73 10 80       	push   $0x80107355
80101206:	e8 75 f1 ff ff       	call   80100380 <panic>
8010120b:	66 90                	xchg   %ax,%ax
8010120d:	66 90                	xchg   %ax,%ax
8010120f:	90                   	nop

80101210 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101219:	8b 0d b4 bf 11 80    	mov    0x8011bfb4,%ecx
{
8010121f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101222:	85 c9                	test   %ecx,%ecx
80101224:	0f 84 8c 00 00 00    	je     801012b6 <balloc+0xa6>
8010122a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010122c:	89 f8                	mov    %edi,%eax
8010122e:	83 ec 08             	sub    $0x8,%esp
80101231:	89 fe                	mov    %edi,%esi
80101233:	c1 f8 0e             	sar    $0xe,%eax
80101236:	03 05 cc bf 11 80    	add    0x8011bfcc,%eax
8010123c:	50                   	push   %eax
8010123d:	ff 75 dc             	push   -0x24(%ebp)
80101240:	e8 8b ee ff ff       	call   801000d0 <bread>
80101245:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101248:	83 c4 10             	add    $0x10,%esp
8010124b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010124e:	a1 b4 bf 11 80       	mov    0x8011bfb4,%eax
80101253:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101256:	31 c0                	xor    %eax,%eax
80101258:	eb 32                	jmp    8010128c <balloc+0x7c>
8010125a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101260:	89 c1                	mov    %eax,%ecx
80101262:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101267:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010126a:	83 e1 07             	and    $0x7,%ecx
8010126d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010126f:	89 c1                	mov    %eax,%ecx
80101271:	c1 f9 03             	sar    $0x3,%ecx
80101274:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101279:	89 fa                	mov    %edi,%edx
8010127b:	85 df                	test   %ebx,%edi
8010127d:	74 49                	je     801012c8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010127f:	83 c0 01             	add    $0x1,%eax
80101282:	83 c6 01             	add    $0x1,%esi
80101285:	3d 00 40 00 00       	cmp    $0x4000,%eax
8010128a:	74 07                	je     80101293 <balloc+0x83>
8010128c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010128f:	39 d6                	cmp    %edx,%esi
80101291:	72 cd                	jb     80101260 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101293:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101296:	83 ec 0c             	sub    $0xc,%esp
80101299:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010129c:	81 c7 00 40 00 00    	add    $0x4000,%edi
    brelse(bp);
801012a2:	e8 49 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012a7:	83 c4 10             	add    $0x10,%esp
801012aa:	3b 3d b4 bf 11 80    	cmp    0x8011bfb4,%edi
801012b0:	0f 82 76 ff ff ff    	jb     8010122c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801012b6:	83 ec 0c             	sub    $0xc,%esp
801012b9:	68 5f 73 10 80       	push   $0x8010735f
801012be:	e8 bd f0 ff ff       	call   80100380 <panic>
801012c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012c7:	90                   	nop
        bp->data[bi/8] |= m;  // Mark block in use.
801012c8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012cb:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012ce:	09 da                	or     %ebx,%edx
801012d0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012d4:	57                   	push   %edi
801012d5:	e8 26 1c 00 00       	call   80102f00 <log_write>
        brelse(bp);
801012da:	89 3c 24             	mov    %edi,(%esp)
801012dd:	e8 0e ef ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801012e2:	58                   	pop    %eax
801012e3:	5a                   	pop    %edx
801012e4:	56                   	push   %esi
801012e5:	ff 75 dc             	push   -0x24(%ebp)
801012e8:	e8 e3 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012ed:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801012f0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012f2:	8d 40 5c             	lea    0x5c(%eax),%eax
801012f5:	68 00 08 00 00       	push   $0x800
801012fa:	6a 00                	push   $0x0
801012fc:	50                   	push   %eax
801012fd:	e8 4e 34 00 00       	call   80104750 <memset>
  log_write(bp);
80101302:	89 1c 24             	mov    %ebx,(%esp)
80101305:	e8 f6 1b 00 00       	call   80102f00 <log_write>
  brelse(bp);
8010130a:	89 1c 24             	mov    %ebx,(%esp)
8010130d:	e8 de ee ff ff       	call   801001f0 <brelse>
}
80101312:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101315:	89 f0                	mov    %esi,%eax
80101317:	5b                   	pop    %ebx
80101318:	5e                   	pop    %esi
80101319:	5f                   	pop    %edi
8010131a:	5d                   	pop    %ebp
8010131b:	c3                   	ret
8010131c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101320 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101320:	55                   	push   %ebp
80101321:	89 e5                	mov    %esp,%ebp
80101323:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101324:	31 ff                	xor    %edi,%edi
{
80101326:	56                   	push   %esi
80101327:	89 c6                	mov    %eax,%esi
80101329:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010132a:	bb 94 a3 11 80       	mov    $0x8011a394,%ebx
{
8010132f:	83 ec 28             	sub    $0x28,%esp
80101332:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101335:	68 60 a3 11 80       	push   $0x8011a360
8010133a:	e8 81 32 00 00       	call   801045c0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010133f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101342:	83 c4 10             	add    $0x10,%esp
80101345:	eb 1b                	jmp    80101362 <iget+0x42>
80101347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101350:	39 33                	cmp    %esi,(%ebx)
80101352:	74 6c                	je     801013c0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101354:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010135a:	81 fb b4 bf 11 80    	cmp    $0x8011bfb4,%ebx
80101360:	74 26                	je     80101388 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101362:	8b 43 08             	mov    0x8(%ebx),%eax
80101365:	85 c0                	test   %eax,%eax
80101367:	7f e7                	jg     80101350 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101369:	85 ff                	test   %edi,%edi
8010136b:	75 e7                	jne    80101354 <iget+0x34>
8010136d:	85 c0                	test   %eax,%eax
8010136f:	75 76                	jne    801013e7 <iget+0xc7>
80101371:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101373:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101379:	81 fb b4 bf 11 80    	cmp    $0x8011bfb4,%ebx
8010137f:	75 e1                	jne    80101362 <iget+0x42>
80101381:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101388:	85 ff                	test   %edi,%edi
8010138a:	74 79                	je     80101405 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010138c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010138f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101391:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101394:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010139b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801013a2:	68 60 a3 11 80       	push   $0x8011a360
801013a7:	e8 54 33 00 00       	call   80104700 <release>

  return ip;
801013ac:	83 c4 10             	add    $0x10,%esp
}
801013af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013b2:	89 f8                	mov    %edi,%eax
801013b4:	5b                   	pop    %ebx
801013b5:	5e                   	pop    %esi
801013b6:	5f                   	pop    %edi
801013b7:	5d                   	pop    %ebp
801013b8:	c3                   	ret
801013b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013c0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013c3:	75 8f                	jne    80101354 <iget+0x34>
      ip->ref++;
801013c5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801013c8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801013cb:	89 df                	mov    %ebx,%edi
      ip->ref++;
801013cd:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801013d0:	68 60 a3 11 80       	push   $0x8011a360
801013d5:	e8 26 33 00 00       	call   80104700 <release>
      return ip;
801013da:	83 c4 10             	add    $0x10,%esp
}
801013dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e0:	89 f8                	mov    %edi,%eax
801013e2:	5b                   	pop    %ebx
801013e3:	5e                   	pop    %esi
801013e4:	5f                   	pop    %edi
801013e5:	5d                   	pop    %ebp
801013e6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013e7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013ed:	81 fb b4 bf 11 80    	cmp    $0x8011bfb4,%ebx
801013f3:	74 10                	je     80101405 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f5:	8b 43 08             	mov    0x8(%ebx),%eax
801013f8:	85 c0                	test   %eax,%eax
801013fa:	0f 8f 50 ff ff ff    	jg     80101350 <iget+0x30>
80101400:	e9 68 ff ff ff       	jmp    8010136d <iget+0x4d>
    panic("iget: no inodes");
80101405:	83 ec 0c             	sub    $0xc,%esp
80101408:	68 75 73 10 80       	push   $0x80107375
8010140d:	e8 6e ef ff ff       	call   80100380 <panic>
80101412:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101420 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	57                   	push   %edi
80101424:	56                   	push   %esi
80101425:	89 c6                	mov    %eax,%esi
80101427:	53                   	push   %ebx
80101428:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010142b:	83 fa 0b             	cmp    $0xb,%edx
8010142e:	0f 86 8c 00 00 00    	jbe    801014c0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101434:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101437:	81 fb ff 01 00 00    	cmp    $0x1ff,%ebx
8010143d:	0f 87 9f 00 00 00    	ja     801014e2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101443:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101449:	85 c0                	test   %eax,%eax
8010144b:	74 5b                	je     801014a8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010144d:	83 ec 08             	sub    $0x8,%esp
80101450:	50                   	push   %eax
80101451:	ff 36                	push   (%esi)
80101453:	e8 78 ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101458:	83 c4 10             	add    $0x10,%esp
8010145b:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010145f:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
80101461:	8b 3b                	mov    (%ebx),%edi
80101463:	85 ff                	test   %edi,%edi
80101465:	74 19                	je     80101480 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101467:	83 ec 0c             	sub    $0xc,%esp
8010146a:	52                   	push   %edx
8010146b:	e8 80 ed ff ff       	call   801001f0 <brelse>
80101470:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101473:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101476:	89 f8                	mov    %edi,%eax
80101478:	5b                   	pop    %ebx
80101479:	5e                   	pop    %esi
8010147a:	5f                   	pop    %edi
8010147b:	5d                   	pop    %ebp
8010147c:	c3                   	ret
8010147d:	8d 76 00             	lea    0x0(%esi),%esi
80101480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101483:	8b 06                	mov    (%esi),%eax
80101485:	e8 86 fd ff ff       	call   80101210 <balloc>
      log_write(bp);
8010148a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010148d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101490:	89 03                	mov    %eax,(%ebx)
80101492:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101494:	52                   	push   %edx
80101495:	e8 66 1a 00 00       	call   80102f00 <log_write>
8010149a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010149d:	83 c4 10             	add    $0x10,%esp
801014a0:	eb c5                	jmp    80101467 <bmap+0x47>
801014a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014a8:	8b 06                	mov    (%esi),%eax
801014aa:	e8 61 fd ff ff       	call   80101210 <balloc>
801014af:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014b5:	eb 96                	jmp    8010144d <bmap+0x2d>
801014b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014be:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801014c0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014c3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014c7:	85 ff                	test   %edi,%edi
801014c9:	75 a8                	jne    80101473 <bmap+0x53>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014cb:	8b 00                	mov    (%eax),%eax
801014cd:	e8 3e fd ff ff       	call   80101210 <balloc>
801014d2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801014d6:	89 c7                	mov    %eax,%edi
}
801014d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014db:	5b                   	pop    %ebx
801014dc:	89 f8                	mov    %edi,%eax
801014de:	5e                   	pop    %esi
801014df:	5f                   	pop    %edi
801014e0:	5d                   	pop    %ebp
801014e1:	c3                   	ret
  panic("bmap: out of range");
801014e2:	83 ec 0c             	sub    $0xc,%esp
801014e5:	68 85 73 10 80       	push   $0x80107385
801014ea:	e8 91 ee ff ff       	call   80100380 <panic>
801014ef:	90                   	nop

801014f0 <bfree>:
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	89 c6                	mov    %eax,%esi
801014f7:	53                   	push   %ebx
801014f8:	89 d3                	mov    %edx,%ebx
801014fa:	83 ec 14             	sub    $0x14,%esp
  bp = bread(dev, 1);
801014fd:	6a 01                	push   $0x1
801014ff:	50                   	push   %eax
80101500:	e8 cb eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101505:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101508:	89 c7                	mov    %eax,%edi
  memmove(sb, bp->data, sizeof(*sb));
8010150a:	83 c0 5c             	add    $0x5c,%eax
8010150d:	6a 1c                	push   $0x1c
8010150f:	50                   	push   %eax
80101510:	68 b4 bf 11 80       	push   $0x8011bfb4
80101515:	e8 c6 32 00 00       	call   801047e0 <memmove>
  brelse(bp);
8010151a:	89 3c 24             	mov    %edi,(%esp)
8010151d:	e8 ce ec ff ff       	call   801001f0 <brelse>
  bp = bread(dev, BBLOCK(b, sb));
80101522:	58                   	pop    %eax
80101523:	89 d8                	mov    %ebx,%eax
80101525:	5a                   	pop    %edx
80101526:	c1 e8 0e             	shr    $0xe,%eax
80101529:	03 05 cc bf 11 80    	add    0x8011bfcc,%eax
8010152f:	50                   	push   %eax
80101530:	56                   	push   %esi
80101531:	e8 9a eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101536:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101538:	c1 fb 03             	sar    $0x3,%ebx
8010153b:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
8010153e:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101540:	83 e1 07             	and    $0x7,%ecx
80101543:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101548:	81 e3 ff 07 00 00    	and    $0x7ff,%ebx
  m = 1 << (bi % 8);
8010154e:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101550:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101555:	85 c1                	test   %eax,%ecx
80101557:	74 24                	je     8010157d <bfree+0x8d>
  bp->data[bi/8] &= ~m;
80101559:	f7 d0                	not    %eax
  log_write(bp);
8010155b:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
8010155e:	21 c8                	and    %ecx,%eax
80101560:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
80101564:	56                   	push   %esi
80101565:	e8 96 19 00 00       	call   80102f00 <log_write>
  brelse(bp);
8010156a:	89 34 24             	mov    %esi,(%esp)
8010156d:	e8 7e ec ff ff       	call   801001f0 <brelse>
}
80101572:	83 c4 10             	add    $0x10,%esp
80101575:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101578:	5b                   	pop    %ebx
80101579:	5e                   	pop    %esi
8010157a:	5f                   	pop    %edi
8010157b:	5d                   	pop    %ebp
8010157c:	c3                   	ret
    panic("freeing free block");
8010157d:	83 ec 0c             	sub    $0xc,%esp
80101580:	68 98 73 10 80       	push   $0x80107398
80101585:	e8 f6 ed ff ff       	call   80100380 <panic>
8010158a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101590 <readsb>:
{
80101590:	55                   	push   %ebp
80101591:	89 e5                	mov    %esp,%ebp
80101593:	56                   	push   %esi
80101594:	53                   	push   %ebx
80101595:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101598:	83 ec 08             	sub    $0x8,%esp
8010159b:	6a 01                	push   $0x1
8010159d:	ff 75 08             	push   0x8(%ebp)
801015a0:	e8 2b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015a5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015a8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015aa:	8d 40 5c             	lea    0x5c(%eax),%eax
801015ad:	6a 1c                	push   $0x1c
801015af:	50                   	push   %eax
801015b0:	56                   	push   %esi
801015b1:	e8 2a 32 00 00       	call   801047e0 <memmove>
  brelse(bp);
801015b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801015b9:	83 c4 10             	add    $0x10,%esp
}
801015bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015bf:	5b                   	pop    %ebx
801015c0:	5e                   	pop    %esi
801015c1:	5d                   	pop    %ebp
  brelse(bp);
801015c2:	e9 29 ec ff ff       	jmp    801001f0 <brelse>
801015c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015ce:	66 90                	xchg   %ax,%ax

801015d0 <iinit>:
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	53                   	push   %ebx
801015d4:	bb a0 a3 11 80       	mov    $0x8011a3a0,%ebx
801015d9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801015dc:	68 ab 73 10 80       	push   $0x801073ab
801015e1:	68 60 a3 11 80       	push   $0x8011a360
801015e6:	e8 b5 2e 00 00       	call   801044a0 <initlock>
  for(i = 0; i < NINODE; i++) {
801015eb:	83 c4 10             	add    $0x10,%esp
801015ee:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801015f0:	83 ec 08             	sub    $0x8,%esp
801015f3:	68 b2 73 10 80       	push   $0x801073b2
801015f8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801015f9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801015ff:	e8 8c 2d 00 00       	call   80104390 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101604:	83 c4 10             	add    $0x10,%esp
80101607:	81 fb c0 bf 11 80    	cmp    $0x8011bfc0,%ebx
8010160d:	75 e1                	jne    801015f0 <iinit+0x20>
  bp = bread(dev, 1);
8010160f:	83 ec 08             	sub    $0x8,%esp
80101612:	6a 01                	push   $0x1
80101614:	ff 75 08             	push   0x8(%ebp)
80101617:	e8 b4 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010161c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010161f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101621:	8d 40 5c             	lea    0x5c(%eax),%eax
80101624:	6a 1c                	push   $0x1c
80101626:	50                   	push   %eax
80101627:	68 b4 bf 11 80       	push   $0x8011bfb4
8010162c:	e8 af 31 00 00       	call   801047e0 <memmove>
  brelse(bp);
80101631:	89 1c 24             	mov    %ebx,(%esp)
80101634:	e8 b7 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101639:	ff 35 cc bf 11 80    	push   0x8011bfcc
8010163f:	ff 35 c8 bf 11 80    	push   0x8011bfc8
80101645:	ff 35 c4 bf 11 80    	push   0x8011bfc4
8010164b:	ff 35 c0 bf 11 80    	push   0x8011bfc0
80101651:	ff 35 bc bf 11 80    	push   0x8011bfbc
80101657:	ff 35 b8 bf 11 80    	push   0x8011bfb8
8010165d:	ff 35 b4 bf 11 80    	push   0x8011bfb4
80101663:	68 18 74 10 80       	push   $0x80107418
80101668:	e8 43 f0 ff ff       	call   801006b0 <cprintf>
}
8010166d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101670:	83 c4 30             	add    $0x30,%esp
80101673:	c9                   	leave
80101674:	c3                   	ret
80101675:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ialloc>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	57                   	push   %edi
80101684:	56                   	push   %esi
80101685:	53                   	push   %ebx
80101686:	83 ec 1c             	sub    $0x1c,%esp
80101689:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010168c:	83 3d bc bf 11 80 01 	cmpl   $0x1,0x8011bfbc
{
80101693:	8b 75 08             	mov    0x8(%ebp),%esi
80101696:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101699:	0f 86 91 00 00 00    	jbe    80101730 <ialloc+0xb0>
8010169f:	bf 01 00 00 00       	mov    $0x1,%edi
801016a4:	eb 21                	jmp    801016c7 <ialloc+0x47>
801016a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ad:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
801016b0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801016b3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801016b6:	53                   	push   %ebx
801016b7:	e8 34 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801016bc:	83 c4 10             	add    $0x10,%esp
801016bf:	3b 3d bc bf 11 80    	cmp    0x8011bfbc,%edi
801016c5:	73 69                	jae    80101730 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801016c7:	89 f8                	mov    %edi,%eax
801016c9:	83 ec 08             	sub    $0x8,%esp
801016cc:	c1 e8 05             	shr    $0x5,%eax
801016cf:	03 05 c8 bf 11 80    	add    0x8011bfc8,%eax
801016d5:	50                   	push   %eax
801016d6:	56                   	push   %esi
801016d7:	e8 f4 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801016dc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801016df:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801016e1:	89 f8                	mov    %edi,%eax
801016e3:	83 e0 1f             	and    $0x1f,%eax
801016e6:	c1 e0 06             	shl    $0x6,%eax
801016e9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801016ed:	66 83 39 00          	cmpw   $0x0,(%ecx)
801016f1:	75 bd                	jne    801016b0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801016f3:	83 ec 04             	sub    $0x4,%esp
801016f6:	6a 40                	push   $0x40
801016f8:	6a 00                	push   $0x0
801016fa:	51                   	push   %ecx
801016fb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801016fe:	e8 4d 30 00 00       	call   80104750 <memset>
      dip->type = type;
80101703:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101707:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010170a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010170d:	89 1c 24             	mov    %ebx,(%esp)
80101710:	e8 eb 17 00 00       	call   80102f00 <log_write>
      brelse(bp);
80101715:	89 1c 24             	mov    %ebx,(%esp)
80101718:	e8 d3 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010171d:	83 c4 10             	add    $0x10,%esp
}
80101720:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101723:	89 fa                	mov    %edi,%edx
}
80101725:	5b                   	pop    %ebx
      return iget(dev, inum);
80101726:	89 f0                	mov    %esi,%eax
}
80101728:	5e                   	pop    %esi
80101729:	5f                   	pop    %edi
8010172a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010172b:	e9 f0 fb ff ff       	jmp    80101320 <iget>
  panic("ialloc: no inodes");
80101730:	83 ec 0c             	sub    $0xc,%esp
80101733:	68 b8 73 10 80       	push   $0x801073b8
80101738:	e8 43 ec ff ff       	call   80100380 <panic>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi

80101740 <iupdate>:
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	56                   	push   %esi
80101744:	53                   	push   %ebx
80101745:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101748:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010174b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010174e:	83 ec 08             	sub    $0x8,%esp
80101751:	c1 e8 05             	shr    $0x5,%eax
80101754:	03 05 c8 bf 11 80    	add    0x8011bfc8,%eax
8010175a:	50                   	push   %eax
8010175b:	ff 73 a4             	push   -0x5c(%ebx)
8010175e:	e8 6d e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101763:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101767:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010176a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010176c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010176f:	83 e0 1f             	and    $0x1f,%eax
80101772:	c1 e0 06             	shl    $0x6,%eax
80101775:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101779:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010177c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101780:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101783:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101787:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010178b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010178f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101793:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101797:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010179a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010179d:	6a 34                	push   $0x34
8010179f:	53                   	push   %ebx
801017a0:	50                   	push   %eax
801017a1:	e8 3a 30 00 00       	call   801047e0 <memmove>
  log_write(bp);
801017a6:	89 34 24             	mov    %esi,(%esp)
801017a9:	e8 52 17 00 00       	call   80102f00 <log_write>
  brelse(bp);
801017ae:	89 75 08             	mov    %esi,0x8(%ebp)
801017b1:	83 c4 10             	add    $0x10,%esp
}
801017b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b7:	5b                   	pop    %ebx
801017b8:	5e                   	pop    %esi
801017b9:	5d                   	pop    %ebp
  brelse(bp);
801017ba:	e9 31 ea ff ff       	jmp    801001f0 <brelse>
801017bf:	90                   	nop

801017c0 <idup>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	53                   	push   %ebx
801017c4:	83 ec 10             	sub    $0x10,%esp
801017c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801017ca:	68 60 a3 11 80       	push   $0x8011a360
801017cf:	e8 ec 2d 00 00       	call   801045c0 <acquire>
  ip->ref++;
801017d4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017d8:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
801017df:	e8 1c 2f 00 00       	call   80104700 <release>
}
801017e4:	89 d8                	mov    %ebx,%eax
801017e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017e9:	c9                   	leave
801017ea:	c3                   	ret
801017eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ef:	90                   	nop

801017f0 <ilock>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	56                   	push   %esi
801017f4:	53                   	push   %ebx
801017f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801017f8:	85 db                	test   %ebx,%ebx
801017fa:	0f 84 b7 00 00 00    	je     801018b7 <ilock+0xc7>
80101800:	8b 53 08             	mov    0x8(%ebx),%edx
80101803:	85 d2                	test   %edx,%edx
80101805:	0f 8e ac 00 00 00    	jle    801018b7 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010180b:	83 ec 0c             	sub    $0xc,%esp
8010180e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101811:	50                   	push   %eax
80101812:	e8 b9 2b 00 00       	call   801043d0 <acquiresleep>
  if(ip->valid == 0){
80101817:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010181a:	83 c4 10             	add    $0x10,%esp
8010181d:	85 c0                	test   %eax,%eax
8010181f:	74 0f                	je     80101830 <ilock+0x40>
}
80101821:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101824:	5b                   	pop    %ebx
80101825:	5e                   	pop    %esi
80101826:	5d                   	pop    %ebp
80101827:	c3                   	ret
80101828:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010182f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101830:	8b 43 04             	mov    0x4(%ebx),%eax
80101833:	83 ec 08             	sub    $0x8,%esp
80101836:	c1 e8 05             	shr    $0x5,%eax
80101839:	03 05 c8 bf 11 80    	add    0x8011bfc8,%eax
8010183f:	50                   	push   %eax
80101840:	ff 33                	push   (%ebx)
80101842:	e8 89 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101847:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010184a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010184c:	8b 43 04             	mov    0x4(%ebx),%eax
8010184f:	83 e0 1f             	and    $0x1f,%eax
80101852:	c1 e0 06             	shl    $0x6,%eax
80101855:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101859:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010185c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010185f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101863:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101867:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010186b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010186f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101873:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101877:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010187b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010187e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101881:	6a 34                	push   $0x34
80101883:	50                   	push   %eax
80101884:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101887:	50                   	push   %eax
80101888:	e8 53 2f 00 00       	call   801047e0 <memmove>
    brelse(bp);
8010188d:	89 34 24             	mov    %esi,(%esp)
80101890:	e8 5b e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101895:	83 c4 10             	add    $0x10,%esp
80101898:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010189d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
801018a4:	0f 85 77 ff ff ff    	jne    80101821 <ilock+0x31>
      panic("ilock: no type");
801018aa:	83 ec 0c             	sub    $0xc,%esp
801018ad:	68 d0 73 10 80       	push   $0x801073d0
801018b2:	e8 c9 ea ff ff       	call   80100380 <panic>
    panic("ilock");
801018b7:	83 ec 0c             	sub    $0xc,%esp
801018ba:	68 ca 73 10 80       	push   $0x801073ca
801018bf:	e8 bc ea ff ff       	call   80100380 <panic>
801018c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018cf:	90                   	nop

801018d0 <iunlock>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801018d8:	85 db                	test   %ebx,%ebx
801018da:	74 28                	je     80101904 <iunlock+0x34>
801018dc:	83 ec 0c             	sub    $0xc,%esp
801018df:	8d 73 0c             	lea    0xc(%ebx),%esi
801018e2:	56                   	push   %esi
801018e3:	e8 88 2b 00 00       	call   80104470 <holdingsleep>
801018e8:	83 c4 10             	add    $0x10,%esp
801018eb:	85 c0                	test   %eax,%eax
801018ed:	74 15                	je     80101904 <iunlock+0x34>
801018ef:	8b 43 08             	mov    0x8(%ebx),%eax
801018f2:	85 c0                	test   %eax,%eax
801018f4:	7e 0e                	jle    80101904 <iunlock+0x34>
  releasesleep(&ip->lock);
801018f6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801018f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801018ff:	e9 2c 2b 00 00       	jmp    80104430 <releasesleep>
    panic("iunlock");
80101904:	83 ec 0c             	sub    $0xc,%esp
80101907:	68 df 73 10 80       	push   $0x801073df
8010190c:	e8 6f ea ff ff       	call   80100380 <panic>
80101911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101918:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010191f:	90                   	nop

80101920 <iput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	57                   	push   %edi
80101924:	56                   	push   %esi
80101925:	53                   	push   %ebx
80101926:	83 ec 28             	sub    $0x28,%esp
80101929:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
8010192c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010192f:	57                   	push   %edi
80101930:	e8 9b 2a 00 00       	call   801043d0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101935:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101938:	83 c4 10             	add    $0x10,%esp
8010193b:	85 d2                	test   %edx,%edx
8010193d:	74 07                	je     80101946 <iput+0x26>
8010193f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101944:	74 32                	je     80101978 <iput+0x58>
  releasesleep(&ip->lock);
80101946:	83 ec 0c             	sub    $0xc,%esp
80101949:	57                   	push   %edi
8010194a:	e8 e1 2a 00 00       	call   80104430 <releasesleep>
  acquire(&icache.lock);
8010194f:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
80101956:	e8 65 2c 00 00       	call   801045c0 <acquire>
  ip->ref--;
8010195b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010195f:	83 c4 10             	add    $0x10,%esp
80101962:	c7 45 08 60 a3 11 80 	movl   $0x8011a360,0x8(%ebp)
}
80101969:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010196c:	5b                   	pop    %ebx
8010196d:	5e                   	pop    %esi
8010196e:	5f                   	pop    %edi
8010196f:	5d                   	pop    %ebp
  release(&icache.lock);
80101970:	e9 8b 2d 00 00       	jmp    80104700 <release>
80101975:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101978:	83 ec 0c             	sub    $0xc,%esp
8010197b:	68 60 a3 11 80       	push   $0x8011a360
80101980:	e8 3b 2c 00 00       	call   801045c0 <acquire>
    int r = ip->ref;
80101985:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101988:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
8010198f:	e8 6c 2d 00 00       	call   80104700 <release>
    if(r == 1){
80101994:	83 c4 10             	add    $0x10,%esp
80101997:	83 fe 01             	cmp    $0x1,%esi
8010199a:	75 aa                	jne    80101946 <iput+0x26>
8010199c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801019a2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801019a5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801019a8:	89 df                	mov    %ebx,%edi
801019aa:	89 cb                	mov    %ecx,%ebx
801019ac:	eb 09                	jmp    801019b7 <iput+0x97>
801019ae:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801019b0:	83 c6 04             	add    $0x4,%esi
801019b3:	39 de                	cmp    %ebx,%esi
801019b5:	74 19                	je     801019d0 <iput+0xb0>
    if(ip->addrs[i]){
801019b7:	8b 16                	mov    (%esi),%edx
801019b9:	85 d2                	test   %edx,%edx
801019bb:	74 f3                	je     801019b0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
801019bd:	8b 07                	mov    (%edi),%eax
801019bf:	e8 2c fb ff ff       	call   801014f0 <bfree>
      ip->addrs[i] = 0;
801019c4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801019ca:	eb e4                	jmp    801019b0 <iput+0x90>
801019cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
801019d0:	89 fb                	mov    %edi,%ebx
801019d2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019d5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801019db:	85 c0                	test   %eax,%eax
801019dd:	75 2d                	jne    80101a0c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
801019df:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801019e2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801019e9:	53                   	push   %ebx
801019ea:	e8 51 fd ff ff       	call   80101740 <iupdate>
      ip->type = 0;
801019ef:	31 c0                	xor    %eax,%eax
801019f1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801019f5:	89 1c 24             	mov    %ebx,(%esp)
801019f8:	e8 43 fd ff ff       	call   80101740 <iupdate>
      ip->valid = 0;
801019fd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a04:	83 c4 10             	add    $0x10,%esp
80101a07:	e9 3a ff ff ff       	jmp    80101946 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a0c:	83 ec 08             	sub    $0x8,%esp
80101a0f:	50                   	push   %eax
80101a10:	ff 33                	push   (%ebx)
80101a12:	e8 b9 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a17:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a1a:	83 c4 10             	add    $0x10,%esp
80101a1d:	8d 88 5c 08 00 00    	lea    0x85c(%eax),%ecx
80101a23:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101a26:	8d 70 5c             	lea    0x5c(%eax),%esi
80101a29:	89 cf                	mov    %ecx,%edi
80101a2b:	eb 0a                	jmp    80101a37 <iput+0x117>
80101a2d:	8d 76 00             	lea    0x0(%esi),%esi
80101a30:	83 c6 04             	add    $0x4,%esi
80101a33:	39 fe                	cmp    %edi,%esi
80101a35:	74 0f                	je     80101a46 <iput+0x126>
      if(a[j])
80101a37:	8b 16                	mov    (%esi),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0x110>
        bfree(ip->dev, a[j]);
80101a3d:	8b 03                	mov    (%ebx),%eax
80101a3f:	e8 ac fa ff ff       	call   801014f0 <bfree>
80101a44:	eb ea                	jmp    80101a30 <iput+0x110>
    brelse(bp);
80101a46:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a49:	83 ec 0c             	sub    $0xc,%esp
80101a4c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a4f:	50                   	push   %eax
80101a50:	e8 9b e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101a55:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101a5b:	8b 03                	mov    (%ebx),%eax
80101a5d:	e8 8e fa ff ff       	call   801014f0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101a62:	83 c4 10             	add    $0x10,%esp
80101a65:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101a6c:	00 00 00 
80101a6f:	e9 6b ff ff ff       	jmp    801019df <iput+0xbf>
80101a74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a7f:	90                   	nop

80101a80 <iunlockput>:
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	56                   	push   %esi
80101a84:	53                   	push   %ebx
80101a85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a88:	85 db                	test   %ebx,%ebx
80101a8a:	74 34                	je     80101ac0 <iunlockput+0x40>
80101a8c:	83 ec 0c             	sub    $0xc,%esp
80101a8f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a92:	56                   	push   %esi
80101a93:	e8 d8 29 00 00       	call   80104470 <holdingsleep>
80101a98:	83 c4 10             	add    $0x10,%esp
80101a9b:	85 c0                	test   %eax,%eax
80101a9d:	74 21                	je     80101ac0 <iunlockput+0x40>
80101a9f:	8b 43 08             	mov    0x8(%ebx),%eax
80101aa2:	85 c0                	test   %eax,%eax
80101aa4:	7e 1a                	jle    80101ac0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101aa6:	83 ec 0c             	sub    $0xc,%esp
80101aa9:	56                   	push   %esi
80101aaa:	e8 81 29 00 00       	call   80104430 <releasesleep>
  iput(ip);
80101aaf:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101ab2:	83 c4 10             	add    $0x10,%esp
}
80101ab5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ab8:	5b                   	pop    %ebx
80101ab9:	5e                   	pop    %esi
80101aba:	5d                   	pop    %ebp
  iput(ip);
80101abb:	e9 60 fe ff ff       	jmp    80101920 <iput>
    panic("iunlock");
80101ac0:	83 ec 0c             	sub    $0xc,%esp
80101ac3:	68 df 73 10 80       	push   $0x801073df
80101ac8:	e8 b3 e8 ff ff       	call   80100380 <panic>
80101acd:	8d 76 00             	lea    0x0(%esi),%esi

80101ad0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ad6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ad9:	8b 0a                	mov    (%edx),%ecx
80101adb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101ade:	8b 4a 04             	mov    0x4(%edx),%ecx
80101ae1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ae4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101ae8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101aeb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101aef:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101af3:	8b 52 58             	mov    0x58(%edx),%edx
80101af6:	89 50 10             	mov    %edx,0x10(%eax)
}
80101af9:	5d                   	pop    %ebp
80101afa:	c3                   	ret
80101afb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aff:	90                   	nop

80101b00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	57                   	push   %edi
80101b04:	56                   	push   %esi
80101b05:	53                   	push   %ebx
80101b06:	83 ec 1c             	sub    $0x1c,%esp
80101b09:	8b 75 08             	mov    0x8(%ebp),%esi
80101b0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b0f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b12:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101b17:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b1a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101b1d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101b20:	0f 84 aa 00 00 00    	je     80101bd0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101b26:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101b29:	8b 56 58             	mov    0x58(%esi),%edx
80101b2c:	39 fa                	cmp    %edi,%edx
80101b2e:	0f 82 bd 00 00 00    	jb     80101bf1 <readi+0xf1>
80101b34:	89 f9                	mov    %edi,%ecx
80101b36:	31 db                	xor    %ebx,%ebx
80101b38:	01 c1                	add    %eax,%ecx
80101b3a:	0f 92 c3             	setb   %bl
80101b3d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101b40:	0f 82 ab 00 00 00    	jb     80101bf1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101b46:	89 d3                	mov    %edx,%ebx
80101b48:	29 fb                	sub    %edi,%ebx
80101b4a:	39 ca                	cmp    %ecx,%edx
80101b4c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b4f:	85 c0                	test   %eax,%eax
80101b51:	74 73                	je     80101bc6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101b53:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101b56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101b63:	89 fa                	mov    %edi,%edx
80101b65:	c1 ea 0b             	shr    $0xb,%edx
80101b68:	89 d8                	mov    %ebx,%eax
80101b6a:	e8 b1 f8 ff ff       	call   80101420 <bmap>
80101b6f:	83 ec 08             	sub    $0x8,%esp
80101b72:	50                   	push   %eax
80101b73:	ff 33                	push   (%ebx)
80101b75:	e8 56 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b7a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b7d:	b9 00 08 00 00       	mov    $0x800,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b82:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b84:	89 f8                	mov    %edi,%eax
80101b86:	25 ff 07 00 00       	and    $0x7ff,%eax
80101b8b:	29 f3                	sub    %esi,%ebx
80101b8d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b8f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b93:	39 d9                	cmp    %ebx,%ecx
80101b95:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b98:	83 c4 0c             	add    $0xc,%esp
80101b9b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b9c:	01 de                	add    %ebx,%esi
80101b9e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101ba0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ba3:	50                   	push   %eax
80101ba4:	ff 75 e0             	push   -0x20(%ebp)
80101ba7:	e8 34 2c 00 00       	call   801047e0 <memmove>
    brelse(bp);
80101bac:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101baf:	89 14 24             	mov    %edx,(%esp)
80101bb2:	e8 39 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bb7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101bba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bbd:	83 c4 10             	add    $0x10,%esp
80101bc0:	39 de                	cmp    %ebx,%esi
80101bc2:	72 9c                	jb     80101b60 <readi+0x60>
80101bc4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101bc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101bc9:	5b                   	pop    %ebx
80101bca:	5e                   	pop    %esi
80101bcb:	5f                   	pop    %edi
80101bcc:	5d                   	pop    %ebp
80101bcd:	c3                   	ret
80101bce:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101bd0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101bd4:	66 83 fa 09          	cmp    $0x9,%dx
80101bd8:	77 17                	ja     80101bf1 <readi+0xf1>
80101bda:	8b 14 d5 00 a3 11 80 	mov    -0x7fee5d00(,%edx,8),%edx
80101be1:	85 d2                	test   %edx,%edx
80101be3:	74 0c                	je     80101bf1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101be5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101be8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101beb:	5b                   	pop    %ebx
80101bec:	5e                   	pop    %esi
80101bed:	5f                   	pop    %edi
80101bee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101bef:	ff e2                	jmp    *%edx
      return -1;
80101bf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bf6:	eb ce                	jmp    80101bc6 <readi+0xc6>
80101bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bff:	90                   	nop

80101c00 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 1c             	sub    $0x1c,%esp
80101c09:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c0f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c12:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c17:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101c1a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c1d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101c20:	0f 84 ca 00 00 00    	je     80101cf0 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101c26:	39 78 58             	cmp    %edi,0x58(%eax)
80101c29:	0f 82 fa 00 00 00    	jb     80101d29 <writei+0x129>
80101c2f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101c32:	31 c9                	xor    %ecx,%ecx
80101c34:	89 f2                	mov    %esi,%edx
80101c36:	01 fa                	add    %edi,%edx
80101c38:	0f 92 c1             	setb   %cl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101c3b:	81 fa 00 60 10 00    	cmp    $0x106000,%edx
80101c41:	0f 87 e2 00 00 00    	ja     80101d29 <writei+0x129>
80101c47:	85 c9                	test   %ecx,%ecx
80101c49:	0f 85 da 00 00 00    	jne    80101d29 <writei+0x129>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c4f:	85 f6                	test   %esi,%esi
80101c51:	0f 84 86 00 00 00    	je     80101cdd <writei+0xdd>
80101c57:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101c5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c68:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101c6b:	89 fa                	mov    %edi,%edx
80101c6d:	c1 ea 0b             	shr    $0xb,%edx
80101c70:	89 f0                	mov    %esi,%eax
80101c72:	e8 a9 f7 ff ff       	call   80101420 <bmap>
80101c77:	83 ec 08             	sub    $0x8,%esp
80101c7a:	50                   	push   %eax
80101c7b:	ff 36                	push   (%esi)
80101c7d:	e8 4e e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c82:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101c85:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c88:	b9 00 08 00 00       	mov    $0x800,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c8d:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c8f:	89 f8                	mov    %edi,%eax
80101c91:	25 ff 07 00 00       	and    $0x7ff,%eax
80101c96:	29 d3                	sub    %edx,%ebx
80101c98:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c9a:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c9e:	39 d9                	cmp    %ebx,%ecx
80101ca0:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ca3:	83 c4 0c             	add    $0xc,%esp
80101ca6:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ca7:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101ca9:	ff 75 dc             	push   -0x24(%ebp)
80101cac:	50                   	push   %eax
80101cad:	e8 2e 2b 00 00       	call   801047e0 <memmove>
    log_write(bp);
80101cb2:	89 34 24             	mov    %esi,(%esp)
80101cb5:	e8 46 12 00 00       	call   80102f00 <log_write>
    brelse(bp);
80101cba:	89 34 24             	mov    %esi,(%esp)
80101cbd:	e8 2e e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cc2:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101cc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101cc8:	83 c4 10             	add    $0x10,%esp
80101ccb:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101cce:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101cd1:	39 d8                	cmp    %ebx,%eax
80101cd3:	72 93                	jb     80101c68 <writei+0x68>
  }

  if(n > 0 && off > ip->size){
80101cd5:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101cd8:	39 78 58             	cmp    %edi,0x58(%eax)
80101cdb:	72 3b                	jb     80101d18 <writei+0x118>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101cdd:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ce0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ce3:	5b                   	pop    %ebx
80101ce4:	5e                   	pop    %esi
80101ce5:	5f                   	pop    %edi
80101ce6:	5d                   	pop    %ebp
80101ce7:	c3                   	ret
80101ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cef:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101cf0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101cf4:	66 83 f8 09          	cmp    $0x9,%ax
80101cf8:	77 2f                	ja     80101d29 <writei+0x129>
80101cfa:	8b 04 c5 04 a3 11 80 	mov    -0x7fee5cfc(,%eax,8),%eax
80101d01:	85 c0                	test   %eax,%eax
80101d03:	74 24                	je     80101d29 <writei+0x129>
    return devsw[ip->major].write(ip, src, n);
80101d05:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101d08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d0b:	5b                   	pop    %ebx
80101d0c:	5e                   	pop    %esi
80101d0d:	5f                   	pop    %edi
80101d0e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d0f:	ff e0                	jmp    *%eax
80101d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101d18:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d1b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101d1e:	50                   	push   %eax
80101d1f:	e8 1c fa ff ff       	call   80101740 <iupdate>
80101d24:	83 c4 10             	add    $0x10,%esp
80101d27:	eb b4                	jmp    80101cdd <writei+0xdd>
      return -1;
80101d29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d2e:	eb b0                	jmp    80101ce0 <writei+0xe0>

80101d30 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101d30:	55                   	push   %ebp
80101d31:	89 e5                	mov    %esp,%ebp
80101d33:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101d36:	6a 0e                	push   $0xe
80101d38:	ff 75 0c             	push   0xc(%ebp)
80101d3b:	ff 75 08             	push   0x8(%ebp)
80101d3e:	e8 0d 2b 00 00       	call   80104850 <strncmp>
}
80101d43:	c9                   	leave
80101d44:	c3                   	ret
80101d45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d50 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101d50:	55                   	push   %ebp
80101d51:	89 e5                	mov    %esp,%ebp
80101d53:	57                   	push   %edi
80101d54:	56                   	push   %esi
80101d55:	53                   	push   %ebx
80101d56:	83 ec 1c             	sub    $0x1c,%esp
80101d59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101d5c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101d61:	0f 85 85 00 00 00    	jne    80101dec <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d67:	8b 53 58             	mov    0x58(%ebx),%edx
80101d6a:	31 ff                	xor    %edi,%edi
80101d6c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101d6f:	85 d2                	test   %edx,%edx
80101d71:	74 3e                	je     80101db1 <dirlookup+0x61>
80101d73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d77:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d78:	6a 10                	push   $0x10
80101d7a:	57                   	push   %edi
80101d7b:	56                   	push   %esi
80101d7c:	53                   	push   %ebx
80101d7d:	e8 7e fd ff ff       	call   80101b00 <readi>
80101d82:	83 c4 10             	add    $0x10,%esp
80101d85:	83 f8 10             	cmp    $0x10,%eax
80101d88:	75 55                	jne    80101ddf <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d8f:	74 18                	je     80101da9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d91:	83 ec 04             	sub    $0x4,%esp
80101d94:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d97:	6a 0e                	push   $0xe
80101d99:	50                   	push   %eax
80101d9a:	ff 75 0c             	push   0xc(%ebp)
80101d9d:	e8 ae 2a 00 00       	call   80104850 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101da2:	83 c4 10             	add    $0x10,%esp
80101da5:	85 c0                	test   %eax,%eax
80101da7:	74 17                	je     80101dc0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101da9:	83 c7 10             	add    $0x10,%edi
80101dac:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101daf:	72 c7                	jb     80101d78 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101db1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101db4:	31 c0                	xor    %eax,%eax
}
80101db6:	5b                   	pop    %ebx
80101db7:	5e                   	pop    %esi
80101db8:	5f                   	pop    %edi
80101db9:	5d                   	pop    %ebp
80101dba:	c3                   	ret
80101dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101dbf:	90                   	nop
      if(poff)
80101dc0:	8b 45 10             	mov    0x10(%ebp),%eax
80101dc3:	85 c0                	test   %eax,%eax
80101dc5:	74 05                	je     80101dcc <dirlookup+0x7c>
        *poff = off;
80101dc7:	8b 45 10             	mov    0x10(%ebp),%eax
80101dca:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101dcc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101dd0:	8b 03                	mov    (%ebx),%eax
80101dd2:	e8 49 f5 ff ff       	call   80101320 <iget>
}
80101dd7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dda:	5b                   	pop    %ebx
80101ddb:	5e                   	pop    %esi
80101ddc:	5f                   	pop    %edi
80101ddd:	5d                   	pop    %ebp
80101dde:	c3                   	ret
      panic("dirlookup read");
80101ddf:	83 ec 0c             	sub    $0xc,%esp
80101de2:	68 f9 73 10 80       	push   $0x801073f9
80101de7:	e8 94 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101dec:	83 ec 0c             	sub    $0xc,%esp
80101def:	68 e7 73 10 80       	push   $0x801073e7
80101df4:	e8 87 e5 ff ff       	call   80100380 <panic>
80101df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e00 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	57                   	push   %edi
80101e04:	56                   	push   %esi
80101e05:	53                   	push   %ebx
80101e06:	89 c3                	mov    %eax,%ebx
80101e08:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e0b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e0e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e11:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e14:	0f 84 64 01 00 00    	je     80101f7e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e1a:	e8 31 1b 00 00       	call   80103950 <myproc>
  acquire(&icache.lock);
80101e1f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e22:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e25:	68 60 a3 11 80       	push   $0x8011a360
80101e2a:	e8 91 27 00 00       	call   801045c0 <acquire>
  ip->ref++;
80101e2f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101e33:	c7 04 24 60 a3 11 80 	movl   $0x8011a360,(%esp)
80101e3a:	e8 c1 28 00 00       	call   80104700 <release>
80101e3f:	83 c4 10             	add    $0x10,%esp
80101e42:	eb 07                	jmp    80101e4b <namex+0x4b>
80101e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e48:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e4b:	0f b6 03             	movzbl (%ebx),%eax
80101e4e:	3c 2f                	cmp    $0x2f,%al
80101e50:	74 f6                	je     80101e48 <namex+0x48>
  if(*path == 0)
80101e52:	84 c0                	test   %al,%al
80101e54:	0f 84 06 01 00 00    	je     80101f60 <namex+0x160>
  while(*path != '/' && *path != 0)
80101e5a:	0f b6 03             	movzbl (%ebx),%eax
80101e5d:	84 c0                	test   %al,%al
80101e5f:	0f 84 10 01 00 00    	je     80101f75 <namex+0x175>
80101e65:	89 df                	mov    %ebx,%edi
80101e67:	3c 2f                	cmp    $0x2f,%al
80101e69:	0f 84 06 01 00 00    	je     80101f75 <namex+0x175>
80101e6f:	90                   	nop
80101e70:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e74:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e77:	3c 2f                	cmp    $0x2f,%al
80101e79:	74 04                	je     80101e7f <namex+0x7f>
80101e7b:	84 c0                	test   %al,%al
80101e7d:	75 f1                	jne    80101e70 <namex+0x70>
  len = path - s;
80101e7f:	89 f8                	mov    %edi,%eax
80101e81:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e83:	83 f8 0d             	cmp    $0xd,%eax
80101e86:	0f 8e ac 00 00 00    	jle    80101f38 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e8c:	83 ec 04             	sub    $0x4,%esp
80101e8f:	6a 0e                	push   $0xe
80101e91:	53                   	push   %ebx
    path++;
80101e92:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e94:	ff 75 e4             	push   -0x1c(%ebp)
80101e97:	e8 44 29 00 00       	call   801047e0 <memmove>
80101e9c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e9f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101ea2:	75 0c                	jne    80101eb0 <namex+0xb0>
80101ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101ea8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101eab:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101eae:	74 f8                	je     80101ea8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101eb0:	83 ec 0c             	sub    $0xc,%esp
80101eb3:	56                   	push   %esi
80101eb4:	e8 37 f9 ff ff       	call   801017f0 <ilock>
    if(ip->type != T_DIR){
80101eb9:	83 c4 10             	add    $0x10,%esp
80101ebc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101ec1:	0f 85 cd 00 00 00    	jne    80101f94 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101ec7:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101eca:	85 c0                	test   %eax,%eax
80101ecc:	74 09                	je     80101ed7 <namex+0xd7>
80101ece:	80 3b 00             	cmpb   $0x0,(%ebx)
80101ed1:	0f 84 34 01 00 00    	je     8010200b <namex+0x20b>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ed7:	83 ec 04             	sub    $0x4,%esp
80101eda:	6a 00                	push   $0x0
80101edc:	ff 75 e4             	push   -0x1c(%ebp)
80101edf:	56                   	push   %esi
80101ee0:	e8 6b fe ff ff       	call   80101d50 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ee5:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101ee8:	83 c4 10             	add    $0x10,%esp
80101eeb:	89 c7                	mov    %eax,%edi
80101eed:	85 c0                	test   %eax,%eax
80101eef:	0f 84 e1 00 00 00    	je     80101fd6 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	52                   	push   %edx
80101ef9:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101efc:	e8 6f 25 00 00       	call   80104470 <holdingsleep>
80101f01:	83 c4 10             	add    $0x10,%esp
80101f04:	85 c0                	test   %eax,%eax
80101f06:	0f 84 3f 01 00 00    	je     8010204b <namex+0x24b>
80101f0c:	8b 56 08             	mov    0x8(%esi),%edx
80101f0f:	85 d2                	test   %edx,%edx
80101f11:	0f 8e 34 01 00 00    	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80101f17:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f1a:	83 ec 0c             	sub    $0xc,%esp
80101f1d:	52                   	push   %edx
80101f1e:	e8 0d 25 00 00       	call   80104430 <releasesleep>
  iput(ip);
80101f23:	89 34 24             	mov    %esi,(%esp)
80101f26:	89 fe                	mov    %edi,%esi
80101f28:	e8 f3 f9 ff ff       	call   80101920 <iput>
80101f2d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f30:	e9 16 ff ff ff       	jmp    80101e4b <namex+0x4b>
80101f35:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101f38:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101f3b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101f3e:	83 ec 04             	sub    $0x4,%esp
80101f41:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101f44:	50                   	push   %eax
80101f45:	53                   	push   %ebx
    name[len] = 0;
80101f46:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101f48:	ff 75 e4             	push   -0x1c(%ebp)
80101f4b:	e8 90 28 00 00       	call   801047e0 <memmove>
    name[len] = 0;
80101f50:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101f53:	83 c4 10             	add    $0x10,%esp
80101f56:	c6 02 00             	movb   $0x0,(%edx)
80101f59:	e9 41 ff ff ff       	jmp    80101e9f <namex+0x9f>
80101f5e:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101f60:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f63:	85 c0                	test   %eax,%eax
80101f65:	0f 85 d0 00 00 00    	jne    8010203b <namex+0x23b>
    iput(ip);
    return 0;
  }
  return ip;
}
80101f6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f6e:	89 f0                	mov    %esi,%eax
80101f70:	5b                   	pop    %ebx
80101f71:	5e                   	pop    %esi
80101f72:	5f                   	pop    %edi
80101f73:	5d                   	pop    %ebp
80101f74:	c3                   	ret
  while(*path != '/' && *path != 0)
80101f75:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f78:	89 df                	mov    %ebx,%edi
80101f7a:	31 c0                	xor    %eax,%eax
80101f7c:	eb c0                	jmp    80101f3e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101f7e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f83:	b8 01 00 00 00       	mov    $0x1,%eax
80101f88:	e8 93 f3 ff ff       	call   80101320 <iget>
80101f8d:	89 c6                	mov    %eax,%esi
80101f8f:	e9 b7 fe ff ff       	jmp    80101e4b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f94:	83 ec 0c             	sub    $0xc,%esp
80101f97:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f9a:	53                   	push   %ebx
80101f9b:	e8 d0 24 00 00       	call   80104470 <holdingsleep>
80101fa0:	83 c4 10             	add    $0x10,%esp
80101fa3:	85 c0                	test   %eax,%eax
80101fa5:	0f 84 a0 00 00 00    	je     8010204b <namex+0x24b>
80101fab:	8b 46 08             	mov    0x8(%esi),%eax
80101fae:	85 c0                	test   %eax,%eax
80101fb0:	0f 8e 95 00 00 00    	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80101fb6:	83 ec 0c             	sub    $0xc,%esp
80101fb9:	53                   	push   %ebx
80101fba:	e8 71 24 00 00       	call   80104430 <releasesleep>
  iput(ip);
80101fbf:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fc2:	31 f6                	xor    %esi,%esi
  iput(ip);
80101fc4:	e8 57 f9 ff ff       	call   80101920 <iput>
      return 0;
80101fc9:	83 c4 10             	add    $0x10,%esp
}
80101fcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcf:	89 f0                	mov    %esi,%eax
80101fd1:	5b                   	pop    %ebx
80101fd2:	5e                   	pop    %esi
80101fd3:	5f                   	pop    %edi
80101fd4:	5d                   	pop    %ebp
80101fd5:	c3                   	ret
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fd6:	83 ec 0c             	sub    $0xc,%esp
80101fd9:	52                   	push   %edx
80101fda:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101fdd:	e8 8e 24 00 00       	call   80104470 <holdingsleep>
80101fe2:	83 c4 10             	add    $0x10,%esp
80101fe5:	85 c0                	test   %eax,%eax
80101fe7:	74 62                	je     8010204b <namex+0x24b>
80101fe9:	8b 4e 08             	mov    0x8(%esi),%ecx
80101fec:	85 c9                	test   %ecx,%ecx
80101fee:	7e 5b                	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80101ff0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101ff3:	83 ec 0c             	sub    $0xc,%esp
80101ff6:	52                   	push   %edx
80101ff7:	e8 34 24 00 00       	call   80104430 <releasesleep>
  iput(ip);
80101ffc:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101fff:	31 f6                	xor    %esi,%esi
  iput(ip);
80102001:	e8 1a f9 ff ff       	call   80101920 <iput>
      return 0;
80102006:	83 c4 10             	add    $0x10,%esp
80102009:	eb c1                	jmp    80101fcc <namex+0x1cc>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010200b:	83 ec 0c             	sub    $0xc,%esp
8010200e:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102011:	53                   	push   %ebx
80102012:	e8 59 24 00 00       	call   80104470 <holdingsleep>
80102017:	83 c4 10             	add    $0x10,%esp
8010201a:	85 c0                	test   %eax,%eax
8010201c:	74 2d                	je     8010204b <namex+0x24b>
8010201e:	8b 7e 08             	mov    0x8(%esi),%edi
80102021:	85 ff                	test   %edi,%edi
80102023:	7e 26                	jle    8010204b <namex+0x24b>
  releasesleep(&ip->lock);
80102025:	83 ec 0c             	sub    $0xc,%esp
80102028:	53                   	push   %ebx
80102029:	e8 02 24 00 00       	call   80104430 <releasesleep>
}
8010202e:	83 c4 10             	add    $0x10,%esp
}
80102031:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102034:	89 f0                	mov    %esi,%eax
80102036:	5b                   	pop    %ebx
80102037:	5e                   	pop    %esi
80102038:	5f                   	pop    %edi
80102039:	5d                   	pop    %ebp
8010203a:	c3                   	ret
    iput(ip);
8010203b:	83 ec 0c             	sub    $0xc,%esp
8010203e:	56                   	push   %esi
      return 0;
8010203f:	31 f6                	xor    %esi,%esi
    iput(ip);
80102041:	e8 da f8 ff ff       	call   80101920 <iput>
    return 0;
80102046:	83 c4 10             	add    $0x10,%esp
80102049:	eb 81                	jmp    80101fcc <namex+0x1cc>
    panic("iunlock");
8010204b:	83 ec 0c             	sub    $0xc,%esp
8010204e:	68 df 73 10 80       	push   $0x801073df
80102053:	e8 28 e3 ff ff       	call   80100380 <panic>
80102058:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010205f:	90                   	nop

80102060 <dirlink>:
{
80102060:	55                   	push   %ebp
80102061:	89 e5                	mov    %esp,%ebp
80102063:	57                   	push   %edi
80102064:	56                   	push   %esi
80102065:	53                   	push   %ebx
80102066:	83 ec 20             	sub    $0x20,%esp
80102069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010206c:	6a 00                	push   $0x0
8010206e:	ff 75 0c             	push   0xc(%ebp)
80102071:	53                   	push   %ebx
80102072:	e8 d9 fc ff ff       	call   80101d50 <dirlookup>
80102077:	83 c4 10             	add    $0x10,%esp
8010207a:	85 c0                	test   %eax,%eax
8010207c:	75 67                	jne    801020e5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010207e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102081:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102084:	85 ff                	test   %edi,%edi
80102086:	74 29                	je     801020b1 <dirlink+0x51>
80102088:	31 ff                	xor    %edi,%edi
8010208a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010208d:	eb 09                	jmp    80102098 <dirlink+0x38>
8010208f:	90                   	nop
80102090:	83 c7 10             	add    $0x10,%edi
80102093:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102096:	73 19                	jae    801020b1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102098:	6a 10                	push   $0x10
8010209a:	57                   	push   %edi
8010209b:	56                   	push   %esi
8010209c:	53                   	push   %ebx
8010209d:	e8 5e fa ff ff       	call   80101b00 <readi>
801020a2:	83 c4 10             	add    $0x10,%esp
801020a5:	83 f8 10             	cmp    $0x10,%eax
801020a8:	75 4e                	jne    801020f8 <dirlink+0x98>
    if(de.inum == 0)
801020aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020af:	75 df                	jne    80102090 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801020b1:	83 ec 04             	sub    $0x4,%esp
801020b4:	8d 45 da             	lea    -0x26(%ebp),%eax
801020b7:	6a 0e                	push   $0xe
801020b9:	ff 75 0c             	push   0xc(%ebp)
801020bc:	50                   	push   %eax
801020bd:	e8 de 27 00 00       	call   801048a0 <strncpy>
  de.inum = inum;
801020c2:	8b 45 10             	mov    0x10(%ebp),%eax
801020c5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020c9:	6a 10                	push   $0x10
801020cb:	57                   	push   %edi
801020cc:	56                   	push   %esi
801020cd:	53                   	push   %ebx
801020ce:	e8 2d fb ff ff       	call   80101c00 <writei>
801020d3:	83 c4 20             	add    $0x20,%esp
801020d6:	83 f8 10             	cmp    $0x10,%eax
801020d9:	75 2a                	jne    80102105 <dirlink+0xa5>
  return 0;
801020db:	31 c0                	xor    %eax,%eax
}
801020dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020e0:	5b                   	pop    %ebx
801020e1:	5e                   	pop    %esi
801020e2:	5f                   	pop    %edi
801020e3:	5d                   	pop    %ebp
801020e4:	c3                   	ret
    iput(ip);
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	50                   	push   %eax
801020e9:	e8 32 f8 ff ff       	call   80101920 <iput>
    return -1;
801020ee:	83 c4 10             	add    $0x10,%esp
801020f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020f6:	eb e5                	jmp    801020dd <dirlink+0x7d>
      panic("dirlink read");
801020f8:	83 ec 0c             	sub    $0xc,%esp
801020fb:	68 08 74 10 80       	push   $0x80107408
80102100:	e8 7b e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102105:	83 ec 0c             	sub    $0xc,%esp
80102108:	68 2a 78 10 80       	push   $0x8010782a
8010210d:	e8 6e e2 ff ff       	call   80100380 <panic>
80102112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102120 <namei>:

struct inode*
namei(char *path)
{
80102120:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102121:	31 d2                	xor    %edx,%edx
{
80102123:	89 e5                	mov    %esp,%ebp
80102125:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102128:	8b 45 08             	mov    0x8(%ebp),%eax
8010212b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010212e:	e8 cd fc ff ff       	call   80101e00 <namex>
}
80102133:	c9                   	leave
80102134:	c3                   	ret
80102135:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102140:	55                   	push   %ebp
  return namex(path, 1, name);
80102141:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102146:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102148:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010214b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010214e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010214f:	e9 ac fc ff ff       	jmp    80101e00 <namex>
80102154:	66 90                	xchg   %ax,%ax
80102156:	66 90                	xchg   %ax,%ax
80102158:	66 90                	xchg   %ax,%ax
8010215a:	66 90                	xchg   %ax,%ax
8010215c:	66 90                	xchg   %ax,%ax
8010215e:	66 90                	xchg   %ax,%ax

80102160 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	57                   	push   %edi
80102164:	56                   	push   %esi
80102165:	53                   	push   %ebx
80102166:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102169:	85 c0                	test   %eax,%eax
8010216b:	0f 84 b4 00 00 00    	je     80102225 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102171:	8b 70 08             	mov    0x8(%eax),%esi
80102174:	89 c3                	mov    %eax,%ebx
80102176:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010217c:	0f 87 96 00 00 00    	ja     80102218 <idestart+0xb8>
    panic("incorrect blockno");
  int sector_per_block =  BSIZE/SECTOR_SIZE;
  int sector = b->blockno * sector_per_block;
80102182:	c1 e6 02             	shl    $0x2,%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102185:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010218a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102190:	89 ca                	mov    %ecx,%edx
80102192:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102193:	83 e0 c0             	and    $0xffffffc0,%eax
80102196:	3c 40                	cmp    $0x40,%al
80102198:	75 f6                	jne    80102190 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010219a:	31 ff                	xor    %edi,%edi
8010219c:	ba f6 03 00 00       	mov    $0x3f6,%edx
801021a1:	89 f8                	mov    %edi,%eax
801021a3:	ee                   	out    %al,(%dx)
801021a4:	b8 04 00 00 00       	mov    $0x4,%eax
801021a9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801021ae:	ee                   	out    %al,(%dx)
801021af:	ba f3 01 00 00       	mov    $0x1f3,%edx
801021b4:	89 f0                	mov    %esi,%eax
801021b6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801021b7:	89 f0                	mov    %esi,%eax
801021b9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801021be:	c1 f8 08             	sar    $0x8,%eax
801021c1:	ee                   	out    %al,(%dx)
801021c2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801021c7:	89 f8                	mov    %edi,%eax
801021c9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801021ca:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801021ce:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021d3:	c1 e0 04             	shl    $0x4,%eax
801021d6:	83 e0 10             	and    $0x10,%eax
801021d9:	83 c8 e0             	or     $0xffffffe0,%eax
801021dc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801021dd:	f6 03 04             	testb  $0x4,(%ebx)
801021e0:	75 16                	jne    801021f8 <idestart+0x98>
801021e2:	b8 c4 ff ff ff       	mov    $0xffffffc4,%eax
801021e7:	89 ca                	mov    %ecx,%edx
801021e9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801021ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021ed:	5b                   	pop    %ebx
801021ee:	5e                   	pop    %esi
801021ef:	5f                   	pop    %edi
801021f0:	5d                   	pop    %ebp
801021f1:	c3                   	ret
801021f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021f8:	b8 c5 ff ff ff       	mov    $0xffffffc5,%eax
801021fd:	89 ca                	mov    %ecx,%edx
801021ff:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102200:	b9 00 02 00 00       	mov    $0x200,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102205:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102208:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010220d:	fc                   	cld
8010220e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102210:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102213:	5b                   	pop    %ebx
80102214:	5e                   	pop    %esi
80102215:	5f                   	pop    %edi
80102216:	5d                   	pop    %ebp
80102217:	c3                   	ret
    panic("incorrect blockno");
80102218:	83 ec 0c             	sub    $0xc,%esp
8010221b:	68 74 74 10 80       	push   $0x80107474
80102220:	e8 5b e1 ff ff       	call   80100380 <panic>
    panic("idestart");
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	68 6b 74 10 80       	push   $0x8010746b
8010222d:	e8 4e e1 ff ff       	call   80100380 <panic>
80102232:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102240 <ideinit>:
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102246:	68 86 74 10 80       	push   $0x80107486
8010224b:	68 00 c0 11 80       	push   $0x8011c000
80102250:	e8 4b 22 00 00       	call   801044a0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102255:	58                   	pop    %eax
80102256:	a1 64 c1 11 80       	mov    0x8011c164,%eax
8010225b:	5a                   	pop    %edx
8010225c:	83 e8 01             	sub    $0x1,%eax
8010225f:	50                   	push   %eax
80102260:	6a 0e                	push   $0xe
80102262:	e8 99 02 00 00       	call   80102500 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102267:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010226a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010226f:	90                   	nop
80102270:	89 ca                	mov    %ecx,%edx
80102272:	ec                   	in     (%dx),%al
80102273:	83 e0 c0             	and    $0xffffffc0,%eax
80102276:	3c 40                	cmp    $0x40,%al
80102278:	75 f6                	jne    80102270 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010227a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010227f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102284:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102285:	89 ca                	mov    %ecx,%edx
80102287:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102288:	84 c0                	test   %al,%al
8010228a:	75 1e                	jne    801022aa <ideinit+0x6a>
8010228c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102291:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i=0; i<1000; i++){
801022a0:	83 e9 01             	sub    $0x1,%ecx
801022a3:	74 0f                	je     801022b4 <ideinit+0x74>
801022a5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022a6:	84 c0                	test   %al,%al
801022a8:	74 f6                	je     801022a0 <ideinit+0x60>
      havedisk1 = 1;
801022aa:	c7 05 e0 bf 11 80 01 	movl   $0x1,0x8011bfe0
801022b1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022b4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801022b9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022be:	ee                   	out    %al,(%dx)
}
801022bf:	c9                   	leave
801022c0:	c3                   	ret
801022c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022cf:	90                   	nop

801022d0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801022d0:	55                   	push   %ebp
801022d1:	89 e5                	mov    %esp,%ebp
801022d3:	57                   	push   %edi
801022d4:	56                   	push   %esi
801022d5:	53                   	push   %ebx
801022d6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801022d9:	68 00 c0 11 80       	push   $0x8011c000
801022de:	e8 dd 22 00 00       	call   801045c0 <acquire>

  if((b = idequeue) == 0){
801022e3:	8b 1d e4 bf 11 80    	mov    0x8011bfe4,%ebx
801022e9:	83 c4 10             	add    $0x10,%esp
801022ec:	85 db                	test   %ebx,%ebx
801022ee:	74 63                	je     80102353 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801022f0:	8b 43 58             	mov    0x58(%ebx),%eax
801022f3:	a3 e4 bf 11 80       	mov    %eax,0x8011bfe4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801022f8:	8b 33                	mov    (%ebx),%esi
801022fa:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102300:	75 2f                	jne    80102331 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102302:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010230e:	66 90                	xchg   %ax,%ax
80102310:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102311:	89 c1                	mov    %eax,%ecx
80102313:	83 e1 c0             	and    $0xffffffc0,%ecx
80102316:	80 f9 40             	cmp    $0x40,%cl
80102319:	75 f5                	jne    80102310 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010231b:	a8 21                	test   $0x21,%al
8010231d:	75 12                	jne    80102331 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010231f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102322:	b9 00 02 00 00       	mov    $0x200,%ecx
80102327:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010232c:	fc                   	cld
8010232d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010232f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102331:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102334:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102337:	83 ce 02             	or     $0x2,%esi
8010233a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010233c:	53                   	push   %ebx
8010233d:	e8 9e 1d 00 00       	call   801040e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102342:	a1 e4 bf 11 80       	mov    0x8011bfe4,%eax
80102347:	83 c4 10             	add    $0x10,%esp
8010234a:	85 c0                	test   %eax,%eax
8010234c:	74 05                	je     80102353 <ideintr+0x83>
    idestart(idequeue);
8010234e:	e8 0d fe ff ff       	call   80102160 <idestart>
    release(&idelock);
80102353:	83 ec 0c             	sub    $0xc,%esp
80102356:	68 00 c0 11 80       	push   $0x8011c000
8010235b:	e8 a0 23 00 00       	call   80104700 <release>

  release(&idelock);
}
80102360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102363:	5b                   	pop    %ebx
80102364:	5e                   	pop    %esi
80102365:	5f                   	pop    %edi
80102366:	5d                   	pop    %ebp
80102367:	c3                   	ret
80102368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010236f:	90                   	nop

80102370 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	53                   	push   %ebx
80102374:	83 ec 10             	sub    $0x10,%esp
80102377:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010237a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010237d:	50                   	push   %eax
8010237e:	e8 ed 20 00 00       	call   80104470 <holdingsleep>
80102383:	83 c4 10             	add    $0x10,%esp
80102386:	85 c0                	test   %eax,%eax
80102388:	0f 84 c3 00 00 00    	je     80102451 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010238e:	8b 03                	mov    (%ebx),%eax
80102390:	83 e0 06             	and    $0x6,%eax
80102393:	83 f8 02             	cmp    $0x2,%eax
80102396:	0f 84 a8 00 00 00    	je     80102444 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010239c:	8b 53 04             	mov    0x4(%ebx),%edx
8010239f:	85 d2                	test   %edx,%edx
801023a1:	74 0d                	je     801023b0 <iderw+0x40>
801023a3:	a1 e0 bf 11 80       	mov    0x8011bfe0,%eax
801023a8:	85 c0                	test   %eax,%eax
801023aa:	0f 84 87 00 00 00    	je     80102437 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 00 c0 11 80       	push   $0x8011c000
801023b8:	e8 03 22 00 00       	call   801045c0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023bd:	a1 e4 bf 11 80       	mov    0x8011bfe4,%eax
  b->qnext = 0;
801023c2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023c9:	83 c4 10             	add    $0x10,%esp
801023cc:	85 c0                	test   %eax,%eax
801023ce:	74 60                	je     80102430 <iderw+0xc0>
801023d0:	89 c2                	mov    %eax,%edx
801023d2:	8b 40 58             	mov    0x58(%eax),%eax
801023d5:	85 c0                	test   %eax,%eax
801023d7:	75 f7                	jne    801023d0 <iderw+0x60>
801023d9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801023dc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801023de:	39 1d e4 bf 11 80    	cmp    %ebx,0x8011bfe4
801023e4:	74 3a                	je     80102420 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023e6:	8b 03                	mov    (%ebx),%eax
801023e8:	83 e0 06             	and    $0x6,%eax
801023eb:	83 f8 02             	cmp    $0x2,%eax
801023ee:	74 1b                	je     8010240b <iderw+0x9b>
    sleep(b, &idelock);
801023f0:	83 ec 08             	sub    $0x8,%esp
801023f3:	68 00 c0 11 80       	push   $0x8011c000
801023f8:	53                   	push   %ebx
801023f9:	e8 22 1c 00 00       	call   80104020 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801023fe:	8b 03                	mov    (%ebx),%eax
80102400:	83 c4 10             	add    $0x10,%esp
80102403:	83 e0 06             	and    $0x6,%eax
80102406:	83 f8 02             	cmp    $0x2,%eax
80102409:	75 e5                	jne    801023f0 <iderw+0x80>
  }


  release(&idelock);
8010240b:	c7 45 08 00 c0 11 80 	movl   $0x8011c000,0x8(%ebp)
}
80102412:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102415:	c9                   	leave
  release(&idelock);
80102416:	e9 e5 22 00 00       	jmp    80104700 <release>
8010241b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010241f:	90                   	nop
    idestart(b);
80102420:	89 d8                	mov    %ebx,%eax
80102422:	e8 39 fd ff ff       	call   80102160 <idestart>
80102427:	eb bd                	jmp    801023e6 <iderw+0x76>
80102429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102430:	ba e4 bf 11 80       	mov    $0x8011bfe4,%edx
80102435:	eb a5                	jmp    801023dc <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102437:	83 ec 0c             	sub    $0xc,%esp
8010243a:	68 b5 74 10 80       	push   $0x801074b5
8010243f:	e8 3c df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102444:	83 ec 0c             	sub    $0xc,%esp
80102447:	68 a0 74 10 80       	push   $0x801074a0
8010244c:	e8 2f df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102451:	83 ec 0c             	sub    $0xc,%esp
80102454:	68 8a 74 10 80       	push   $0x8010748a
80102459:	e8 22 df ff ff       	call   80100380 <panic>
8010245e:	66 90                	xchg   %ax,%ax

80102460 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102460:	55                   	push   %ebp
80102461:	89 e5                	mov    %esp,%ebp
80102463:	56                   	push   %esi
80102464:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102465:	c7 05 34 c0 11 80 00 	movl   $0xfec00000,0x8011c034
8010246c:	00 c0 fe 
  ioapic->reg = reg;
8010246f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102476:	00 00 00 
  return ioapic->data;
80102479:	8b 15 34 c0 11 80    	mov    0x8011c034,%edx
8010247f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102482:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102488:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010248e:	0f b6 15 60 c1 11 80 	movzbl 0x8011c160,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102495:	c1 ee 10             	shr    $0x10,%esi
80102498:	89 f0                	mov    %esi,%eax
8010249a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010249d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801024a0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801024a3:	39 c2                	cmp    %eax,%edx
801024a5:	74 16                	je     801024bd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801024a7:	83 ec 0c             	sub    $0xc,%esp
801024aa:	68 d4 74 10 80       	push   $0x801074d4
801024af:	e8 fc e1 ff ff       	call   801006b0 <cprintf>
  ioapic->reg = reg;
801024b4:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx
801024ba:	83 c4 10             	add    $0x10,%esp
{
801024bd:	ba 10 00 00 00       	mov    $0x10,%edx
801024c2:	31 c0                	xor    %eax,%eax
801024c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
801024c8:	89 13                	mov    %edx,(%ebx)
801024ca:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
801024cd:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801024d3:	83 c0 01             	add    $0x1,%eax
801024d6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
801024dc:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801024df:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801024e2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801024e5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801024e7:	8b 1d 34 c0 11 80    	mov    0x8011c034,%ebx
801024ed:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801024f4:	39 c6                	cmp    %eax,%esi
801024f6:	7d d0                	jge    801024c8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801024f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024fb:	5b                   	pop    %ebx
801024fc:	5e                   	pop    %esi
801024fd:	5d                   	pop    %ebp
801024fe:	c3                   	ret
801024ff:	90                   	nop

80102500 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102500:	55                   	push   %ebp
  ioapic->reg = reg;
80102501:	8b 0d 34 c0 11 80    	mov    0x8011c034,%ecx
{
80102507:	89 e5                	mov    %esp,%ebp
80102509:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010250c:	8d 50 20             	lea    0x20(%eax),%edx
8010250f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102513:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102515:	8b 0d 34 c0 11 80    	mov    0x8011c034,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010251b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010251e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102521:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102524:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102526:	a1 34 c0 11 80       	mov    0x8011c034,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010252b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010252e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102531:	5d                   	pop    %ebp
80102532:	c3                   	ret
80102533:	66 90                	xchg   %ax,%ax
80102535:	66 90                	xchg   %ax,%ax
80102537:	66 90                	xchg   %ax,%ax
80102539:	66 90                	xchg   %ax,%ax
8010253b:	66 90                	xchg   %ax,%ax
8010253d:	66 90                	xchg   %ax,%ax
8010253f:	90                   	nop

80102540 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	53                   	push   %ebx
80102544:	83 ec 04             	sub    $0x4,%esp
80102547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010254a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102550:	75 76                	jne    801025c8 <kfree+0x88>
80102552:	81 fb b0 ff 11 80    	cmp    $0x8011ffb0,%ebx
80102558:	72 6e                	jb     801025c8 <kfree+0x88>
8010255a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102560:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102565:	77 61                	ja     801025c8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102567:	83 ec 04             	sub    $0x4,%esp
8010256a:	68 00 10 00 00       	push   $0x1000
8010256f:	6a 01                	push   $0x1
80102571:	53                   	push   %ebx
80102572:	e8 d9 21 00 00       	call   80104750 <memset>

  if(kmem.use_lock)
80102577:	8b 15 74 c0 11 80    	mov    0x8011c074,%edx
8010257d:	83 c4 10             	add    $0x10,%esp
80102580:	85 d2                	test   %edx,%edx
80102582:	75 1c                	jne    801025a0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102584:	a1 78 c0 11 80       	mov    0x8011c078,%eax
80102589:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010258b:	a1 74 c0 11 80       	mov    0x8011c074,%eax
  kmem.freelist = r;
80102590:	89 1d 78 c0 11 80    	mov    %ebx,0x8011c078
  if(kmem.use_lock)
80102596:	85 c0                	test   %eax,%eax
80102598:	75 1e                	jne    801025b8 <kfree+0x78>
    release(&kmem.lock);
}
8010259a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010259d:	c9                   	leave
8010259e:	c3                   	ret
8010259f:	90                   	nop
    acquire(&kmem.lock);
801025a0:	83 ec 0c             	sub    $0xc,%esp
801025a3:	68 40 c0 11 80       	push   $0x8011c040
801025a8:	e8 13 20 00 00       	call   801045c0 <acquire>
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	eb d2                	jmp    80102584 <kfree+0x44>
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801025b8:	c7 45 08 40 c0 11 80 	movl   $0x8011c040,0x8(%ebp)
}
801025bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025c2:	c9                   	leave
    release(&kmem.lock);
801025c3:	e9 38 21 00 00       	jmp    80104700 <release>
    panic("kfree");
801025c8:	83 ec 0c             	sub    $0xc,%esp
801025cb:	68 06 75 10 80       	push   $0x80107506
801025d0:	e8 ab dd ff ff       	call   80100380 <panic>
801025d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801025e0 <freerange>:
{
801025e0:	55                   	push   %ebp
801025e1:	89 e5                	mov    %esp,%ebp
801025e3:	56                   	push   %esi
801025e4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025e5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801025eb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025f1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025f7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025fd:	39 de                	cmp    %ebx,%esi
801025ff:	72 23                	jb     80102624 <freerange+0x44>
80102601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102608:	83 ec 0c             	sub    $0xc,%esp
8010260b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102611:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102617:	50                   	push   %eax
80102618:	e8 23 ff ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010261d:	83 c4 10             	add    $0x10,%esp
80102620:	39 de                	cmp    %ebx,%esi
80102622:	73 e4                	jae    80102608 <freerange+0x28>
}
80102624:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102627:	5b                   	pop    %ebx
80102628:	5e                   	pop    %esi
80102629:	5d                   	pop    %ebp
8010262a:	c3                   	ret
8010262b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010262f:	90                   	nop

80102630 <kinit2>:
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	56                   	push   %esi
80102634:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102635:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102638:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010263b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102641:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102647:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264d:	39 de                	cmp    %ebx,%esi
8010264f:	72 23                	jb     80102674 <kinit2+0x44>
80102651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102658:	83 ec 0c             	sub    $0xc,%esp
8010265b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102661:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102667:	50                   	push   %eax
80102668:	e8 d3 fe ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010266d:	83 c4 10             	add    $0x10,%esp
80102670:	39 de                	cmp    %ebx,%esi
80102672:	73 e4                	jae    80102658 <kinit2+0x28>
  kmem.use_lock = 1;
80102674:	c7 05 74 c0 11 80 01 	movl   $0x1,0x8011c074
8010267b:	00 00 00 
}
8010267e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102681:	5b                   	pop    %ebx
80102682:	5e                   	pop    %esi
80102683:	5d                   	pop    %ebp
80102684:	c3                   	ret
80102685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102690 <kinit1>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	56                   	push   %esi
80102694:	53                   	push   %ebx
80102695:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102698:	83 ec 08             	sub    $0x8,%esp
8010269b:	68 0c 75 10 80       	push   $0x8010750c
801026a0:	68 40 c0 11 80       	push   $0x8011c040
801026a5:	e8 f6 1d 00 00       	call   801044a0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801026aa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026ad:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801026b0:	c7 05 74 c0 11 80 00 	movl   $0x0,0x8011c074
801026b7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801026ba:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026c0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026c6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026cc:	39 de                	cmp    %ebx,%esi
801026ce:	72 1c                	jb     801026ec <kinit1+0x5c>
    kfree(p);
801026d0:	83 ec 0c             	sub    $0xc,%esp
801026d3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026d9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801026df:	50                   	push   %eax
801026e0:	e8 5b fe ff ff       	call   80102540 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026e5:	83 c4 10             	add    $0x10,%esp
801026e8:	39 de                	cmp    %ebx,%esi
801026ea:	73 e4                	jae    801026d0 <kinit1+0x40>
}
801026ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026ef:	5b                   	pop    %ebx
801026f0:	5e                   	pop    %esi
801026f1:	5d                   	pop    %ebp
801026f2:	c3                   	ret
801026f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102700 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102700:	55                   	push   %ebp
80102701:	89 e5                	mov    %esp,%ebp
80102703:	53                   	push   %ebx
80102704:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102707:	a1 74 c0 11 80       	mov    0x8011c074,%eax
8010270c:	85 c0                	test   %eax,%eax
8010270e:	75 20                	jne    80102730 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102710:	8b 1d 78 c0 11 80    	mov    0x8011c078,%ebx
  if(r)
80102716:	85 db                	test   %ebx,%ebx
80102718:	74 07                	je     80102721 <kalloc+0x21>
    kmem.freelist = r->next;
8010271a:	8b 03                	mov    (%ebx),%eax
8010271c:	a3 78 c0 11 80       	mov    %eax,0x8011c078
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102721:	89 d8                	mov    %ebx,%eax
80102723:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102726:	c9                   	leave
80102727:	c3                   	ret
80102728:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010272f:	90                   	nop
    acquire(&kmem.lock);
80102730:	83 ec 0c             	sub    $0xc,%esp
80102733:	68 40 c0 11 80       	push   $0x8011c040
80102738:	e8 83 1e 00 00       	call   801045c0 <acquire>
  r = kmem.freelist;
8010273d:	8b 1d 78 c0 11 80    	mov    0x8011c078,%ebx
  if(kmem.use_lock)
80102743:	a1 74 c0 11 80       	mov    0x8011c074,%eax
  if(r)
80102748:	83 c4 10             	add    $0x10,%esp
8010274b:	85 db                	test   %ebx,%ebx
8010274d:	74 08                	je     80102757 <kalloc+0x57>
    kmem.freelist = r->next;
8010274f:	8b 13                	mov    (%ebx),%edx
80102751:	89 15 78 c0 11 80    	mov    %edx,0x8011c078
  if(kmem.use_lock)
80102757:	85 c0                	test   %eax,%eax
80102759:	74 c6                	je     80102721 <kalloc+0x21>
    release(&kmem.lock);
8010275b:	83 ec 0c             	sub    $0xc,%esp
8010275e:	68 40 c0 11 80       	push   $0x8011c040
80102763:	e8 98 1f 00 00       	call   80104700 <release>
}
80102768:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010276a:	83 c4 10             	add    $0x10,%esp
}
8010276d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102770:	c9                   	leave
80102771:	c3                   	ret
80102772:	66 90                	xchg   %ax,%ax
80102774:	66 90                	xchg   %ax,%ax
80102776:	66 90                	xchg   %ax,%ax
80102778:	66 90                	xchg   %ax,%ax
8010277a:	66 90                	xchg   %ax,%ax
8010277c:	66 90                	xchg   %ax,%ax
8010277e:	66 90                	xchg   %ax,%ax

80102780 <kbdgetc>:
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  
  return c;
}
80102780:	b8 05 00 00 00       	mov    $0x5,%eax
80102785:	c3                   	ret
80102786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010278d:	8d 76 00             	lea    0x0(%esi),%esi

80102790 <kbdintr>:

void
kbdintr(void)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
80102793:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102796:	68 80 27 10 80       	push   $0x80102780
8010279b:	e8 20 e1 ff ff       	call   801008c0 <consoleintr>
}
801027a0:	83 c4 10             	add    $0x10,%esp
801027a3:	c9                   	leave
801027a4:	c3                   	ret
801027a5:	66 90                	xchg   %ax,%ax
801027a7:	66 90                	xchg   %ax,%ax
801027a9:	66 90                	xchg   %ax,%ax
801027ab:	66 90                	xchg   %ax,%ax
801027ad:	66 90                	xchg   %ax,%ax
801027af:	90                   	nop

801027b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027b0:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
801027b5:	85 c0                	test   %eax,%eax
801027b7:	0f 84 cb 00 00 00    	je     80102888 <lapicinit+0xd8>
  lapic[index] = value;
801027bd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801027c4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027ca:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801027d1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027d7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801027de:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801027e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027e4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801027eb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801027ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027f1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801027f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801027fe:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102805:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102808:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010280b:	8b 50 30             	mov    0x30(%eax),%edx
8010280e:	c1 ea 10             	shr    $0x10,%edx
80102811:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102817:	75 77                	jne    80102890 <lapicinit+0xe0>
  lapic[index] = value;
80102819:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102820:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102823:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102826:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010282d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102830:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102833:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010283a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010283d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102840:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102847:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010284a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010284d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102854:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102857:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010285a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102861:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 50 20             	mov    0x20(%eax),%edx
80102867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010286e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102870:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102876:	80 e6 10             	and    $0x10,%dh
80102879:	75 f5                	jne    80102870 <lapicinit+0xc0>
  lapic[index] = value;
8010287b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102882:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102885:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102888:	c3                   	ret
80102889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102890:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102897:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010289a:	8b 50 20             	mov    0x20(%eax),%edx
}
8010289d:	e9 77 ff ff ff       	jmp    80102819 <lapicinit+0x69>
801028a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028b0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028b0:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
801028b5:	85 c0                	test   %eax,%eax
801028b7:	74 07                	je     801028c0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028b9:	8b 40 20             	mov    0x20(%eax),%eax
801028bc:	c1 e8 18             	shr    $0x18,%eax
801028bf:	c3                   	ret
    return 0;
801028c0:	31 c0                	xor    %eax,%eax
}
801028c2:	c3                   	ret
801028c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801028d0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801028d0:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
801028d5:	85 c0                	test   %eax,%eax
801028d7:	74 0d                	je     801028e6 <lapiceoi+0x16>
  lapic[index] = value;
801028d9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801028e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028e3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801028e6:	c3                   	ret
801028e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ee:	66 90                	xchg   %ax,%ax

801028f0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801028f0:	c3                   	ret
801028f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ff:	90                   	nop

80102900 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102900:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102901:	b8 0f 00 00 00       	mov    $0xf,%eax
80102906:	ba 70 00 00 00       	mov    $0x70,%edx
8010290b:	89 e5                	mov    %esp,%ebp
8010290d:	53                   	push   %ebx
8010290e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102911:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102914:	ee                   	out    %al,(%dx)
80102915:	b8 0a 00 00 00       	mov    $0xa,%eax
8010291a:	ba 71 00 00 00       	mov    $0x71,%edx
8010291f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102920:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102922:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102925:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010292b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010292d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102930:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102932:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102935:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102938:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010293e:	a1 7c c0 11 80       	mov    0x8011c07c,%eax
80102943:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102949:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010294c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102953:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102956:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102959:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102960:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102963:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102966:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010296c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010296f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102975:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102978:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010297e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102981:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102987:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010298a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010298d:	c9                   	leave
8010298e:	c3                   	ret
8010298f:	90                   	nop

80102990 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102990:	55                   	push   %ebp
80102991:	b8 0b 00 00 00       	mov    $0xb,%eax
80102996:	ba 70 00 00 00       	mov    $0x70,%edx
8010299b:	89 e5                	mov    %esp,%ebp
8010299d:	57                   	push   %edi
8010299e:	56                   	push   %esi
8010299f:	53                   	push   %ebx
801029a0:	83 ec 4c             	sub    $0x4c,%esp
801029a3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a4:	ba 71 00 00 00       	mov    $0x71,%edx
801029a9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029aa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ad:	bf 70 00 00 00       	mov    $0x70,%edi
801029b2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029b5:	8d 76 00             	lea    0x0(%esi),%esi
801029b8:	31 c0                	xor    %eax,%eax
801029ba:	89 fa                	mov    %edi,%edx
801029bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029bd:	b9 71 00 00 00       	mov    $0x71,%ecx
801029c2:	89 ca                	mov    %ecx,%edx
801029c4:	ec                   	in     (%dx),%al
801029c5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c8:	89 fa                	mov    %edi,%edx
801029ca:	b8 02 00 00 00       	mov    $0x2,%eax
801029cf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d0:	89 ca                	mov    %ecx,%edx
801029d2:	ec                   	in     (%dx),%al
801029d3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029d6:	89 fa                	mov    %edi,%edx
801029d8:	b8 04 00 00 00       	mov    $0x4,%eax
801029dd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029de:	89 ca                	mov    %ecx,%edx
801029e0:	ec                   	in     (%dx),%al
801029e1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029e4:	89 fa                	mov    %edi,%edx
801029e6:	b8 07 00 00 00       	mov    $0x7,%eax
801029eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029ec:	89 ca                	mov    %ecx,%edx
801029ee:	ec                   	in     (%dx),%al
801029ef:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f2:	89 fa                	mov    %edi,%edx
801029f4:	b8 08 00 00 00       	mov    $0x8,%eax
801029f9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fa:	89 ca                	mov    %ecx,%edx
801029fc:	ec                   	in     (%dx),%al
801029fd:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ff:	89 fa                	mov    %edi,%edx
80102a01:	b8 09 00 00 00       	mov    $0x9,%eax
80102a06:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a07:	89 ca                	mov    %ecx,%edx
80102a09:	ec                   	in     (%dx),%al
80102a0a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a0d:	89 fa                	mov    %edi,%edx
80102a0f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a14:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a15:	89 ca                	mov    %ecx,%edx
80102a17:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a18:	84 c0                	test   %al,%al
80102a1a:	78 9c                	js     801029b8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a1c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a20:	89 f2                	mov    %esi,%edx
80102a22:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102a25:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a28:	89 fa                	mov    %edi,%edx
80102a2a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a2d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a31:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102a34:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a37:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a3e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a42:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a45:	31 c0                	xor    %eax,%eax
80102a47:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a48:	89 ca                	mov    %ecx,%edx
80102a4a:	ec                   	in     (%dx),%al
80102a4b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a4e:	89 fa                	mov    %edi,%edx
80102a50:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a53:	b8 02 00 00 00       	mov    $0x2,%eax
80102a58:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a59:	89 ca                	mov    %ecx,%edx
80102a5b:	ec                   	in     (%dx),%al
80102a5c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a5f:	89 fa                	mov    %edi,%edx
80102a61:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102a64:	b8 04 00 00 00       	mov    $0x4,%eax
80102a69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a6a:	89 ca                	mov    %ecx,%edx
80102a6c:	ec                   	in     (%dx),%al
80102a6d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a70:	89 fa                	mov    %edi,%edx
80102a72:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a75:	b8 07 00 00 00       	mov    $0x7,%eax
80102a7a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a7b:	89 ca                	mov    %ecx,%edx
80102a7d:	ec                   	in     (%dx),%al
80102a7e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a81:	89 fa                	mov    %edi,%edx
80102a83:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102a86:	b8 08 00 00 00       	mov    $0x8,%eax
80102a8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a92:	89 fa                	mov    %edi,%edx
80102a94:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102a97:	b8 09 00 00 00       	mov    $0x9,%eax
80102a9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
80102aa0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aa3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aa6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aa9:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102aac:	6a 18                	push   $0x18
80102aae:	50                   	push   %eax
80102aaf:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ab2:	50                   	push   %eax
80102ab3:	e8 d8 1c 00 00       	call   80104790 <memcmp>
80102ab8:	83 c4 10             	add    $0x10,%esp
80102abb:	85 c0                	test   %eax,%eax
80102abd:	0f 85 f5 fe ff ff    	jne    801029b8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102ac3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102aca:	89 f0                	mov    %esi,%eax
80102acc:	84 c0                	test   %al,%al
80102ace:	75 78                	jne    80102b48 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102ad0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ad3:	89 c2                	mov    %eax,%edx
80102ad5:	83 e0 0f             	and    $0xf,%eax
80102ad8:	c1 ea 04             	shr    $0x4,%edx
80102adb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ade:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ae1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ae4:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ae7:	89 c2                	mov    %eax,%edx
80102ae9:	83 e0 0f             	and    $0xf,%eax
80102aec:	c1 ea 04             	shr    $0x4,%edx
80102aef:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102af2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102af5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102af8:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102afb:	89 c2                	mov    %eax,%edx
80102afd:	83 e0 0f             	and    $0xf,%eax
80102b00:	c1 ea 04             	shr    $0x4,%edx
80102b03:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b06:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b09:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b0c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b0f:	89 c2                	mov    %eax,%edx
80102b11:	83 e0 0f             	and    $0xf,%eax
80102b14:	c1 ea 04             	shr    $0x4,%edx
80102b17:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b20:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b23:	89 c2                	mov    %eax,%edx
80102b25:	83 e0 0f             	and    $0xf,%eax
80102b28:	c1 ea 04             	shr    $0x4,%edx
80102b2b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b31:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b34:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b37:	89 c2                	mov    %eax,%edx
80102b39:	83 e0 0f             	and    $0xf,%eax
80102b3c:	c1 ea 04             	shr    $0x4,%edx
80102b3f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b42:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b45:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b48:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b4b:	89 03                	mov    %eax,(%ebx)
80102b4d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b50:	89 43 04             	mov    %eax,0x4(%ebx)
80102b53:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b56:	89 43 08             	mov    %eax,0x8(%ebx)
80102b59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b5c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102b5f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b62:	89 43 10             	mov    %eax,0x10(%ebx)
80102b65:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b68:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102b6b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102b72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b75:	5b                   	pop    %ebx
80102b76:	5e                   	pop    %esi
80102b77:	5f                   	pop    %edi
80102b78:	5d                   	pop    %ebp
80102b79:	c3                   	ret
80102b7a:	66 90                	xchg   %ax,%ax
80102b7c:	66 90                	xchg   %ax,%ax
80102b7e:	66 90                	xchg   %ax,%ax

80102b80 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b80:	8b 0d c8 c0 11 80    	mov    0x8011c0c8,%ecx
80102b86:	85 c9                	test   %ecx,%ecx
80102b88:	0f 8e 8a 00 00 00    	jle    80102c18 <install_trans+0x98>
{
80102b8e:	55                   	push   %ebp
80102b8f:	89 e5                	mov    %esp,%ebp
80102b91:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102b92:	31 ff                	xor    %edi,%edi
{
80102b94:	56                   	push   %esi
80102b95:	53                   	push   %ebx
80102b96:	83 ec 0c             	sub    $0xc,%esp
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ba0:	a1 b4 c0 11 80       	mov    0x8011c0b4,%eax
80102ba5:	83 ec 08             	sub    $0x8,%esp
80102ba8:	01 f8                	add    %edi,%eax
80102baa:	83 c0 01             	add    $0x1,%eax
80102bad:	50                   	push   %eax
80102bae:	ff 35 c4 c0 11 80    	push   0x8011c0c4
80102bb4:	e8 17 d5 ff ff       	call   801000d0 <bread>
80102bb9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bbb:	58                   	pop    %eax
80102bbc:	5a                   	pop    %edx
80102bbd:	ff 34 bd cc c0 11 80 	push   -0x7fee3f34(,%edi,4)
80102bc4:	ff 35 c4 c0 11 80    	push   0x8011c0c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102bca:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bcd:	e8 fe d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bd2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bd5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102bd7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102bda:	68 00 08 00 00       	push   $0x800
80102bdf:	50                   	push   %eax
80102be0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102be3:	50                   	push   %eax
80102be4:	e8 f7 1b 00 00       	call   801047e0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102be9:	89 1c 24             	mov    %ebx,(%esp)
80102bec:	e8 bf d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102bf1:	89 34 24             	mov    %esi,(%esp)
80102bf4:	e8 f7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102bf9:	89 1c 24             	mov    %ebx,(%esp)
80102bfc:	e8 ef d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c01:	83 c4 10             	add    $0x10,%esp
80102c04:	39 3d c8 c0 11 80    	cmp    %edi,0x8011c0c8
80102c0a:	7f 94                	jg     80102ba0 <install_trans+0x20>
  }
}
80102c0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c0f:	5b                   	pop    %ebx
80102c10:	5e                   	pop    %esi
80102c11:	5f                   	pop    %edi
80102c12:	5d                   	pop    %ebp
80102c13:	c3                   	ret
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c18:	c3                   	ret
80102c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c20:	55                   	push   %ebp
80102c21:	89 e5                	mov    %esp,%ebp
80102c23:	53                   	push   %ebx
80102c24:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c27:	ff 35 b4 c0 11 80    	push   0x8011c0b4
80102c2d:	ff 35 c4 c0 11 80    	push   0x8011c0c4
80102c33:	e8 98 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c38:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c3b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c3d:	a1 c8 c0 11 80       	mov    0x8011c0c8,%eax
80102c42:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c45:	85 c0                	test   %eax,%eax
80102c47:	7e 19                	jle    80102c62 <write_head+0x42>
80102c49:	31 d2                	xor    %edx,%edx
80102c4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c4f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c50:	8b 0c 95 cc c0 11 80 	mov    -0x7fee3f34(,%edx,4),%ecx
80102c57:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c5b:	83 c2 01             	add    $0x1,%edx
80102c5e:	39 d0                	cmp    %edx,%eax
80102c60:	75 ee                	jne    80102c50 <write_head+0x30>
  }
  bwrite(buf);
80102c62:	83 ec 0c             	sub    $0xc,%esp
80102c65:	53                   	push   %ebx
80102c66:	e8 45 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102c6b:	89 1c 24             	mov    %ebx,(%esp)
80102c6e:	e8 7d d5 ff ff       	call   801001f0 <brelse>
}
80102c73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c76:	83 c4 10             	add    $0x10,%esp
80102c79:	c9                   	leave
80102c7a:	c3                   	ret
80102c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c7f:	90                   	nop

80102c80 <initlog>:
{
80102c80:	55                   	push   %ebp
80102c81:	89 e5                	mov    %esp,%ebp
80102c83:	53                   	push   %ebx
80102c84:	83 ec 2c             	sub    $0x2c,%esp
80102c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102c8a:	68 11 75 10 80       	push   $0x80107511
80102c8f:	68 80 c0 11 80       	push   $0x8011c080
80102c94:	e8 07 18 00 00       	call   801044a0 <initlock>
  readsb(dev, &sb);
80102c99:	58                   	pop    %eax
80102c9a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102c9d:	5a                   	pop    %edx
80102c9e:	50                   	push   %eax
80102c9f:	53                   	push   %ebx
80102ca0:	e8 eb e8 ff ff       	call   80101590 <readsb>
  log.size = sb.nlog;
80102ca5:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102ca8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.dev = dev;
80102cab:	89 1d c4 c0 11 80    	mov    %ebx,0x8011c0c4
  log.start = sb.logstart;
80102cb1:	a3 b4 c0 11 80       	mov    %eax,0x8011c0b4
  log.size = sb.nlog;
80102cb6:	89 15 b8 c0 11 80    	mov    %edx,0x8011c0b8
  struct buf *buf = bread(log.dev, log.start);
80102cbc:	59                   	pop    %ecx
80102cbd:	5a                   	pop    %edx
80102cbe:	50                   	push   %eax
80102cbf:	53                   	push   %ebx
80102cc0:	e8 0b d4 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102cc5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102cc8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ccb:	89 1d c8 c0 11 80    	mov    %ebx,0x8011c0c8
  for (i = 0; i < log.lh.n; i++) {
80102cd1:	85 db                	test   %ebx,%ebx
80102cd3:	7e 1d                	jle    80102cf2 <initlog+0x72>
80102cd5:	31 d2                	xor    %edx,%edx
80102cd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cde:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102ce0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102ce4:	89 0c 95 cc c0 11 80 	mov    %ecx,-0x7fee3f34(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102ceb:	83 c2 01             	add    $0x1,%edx
80102cee:	39 d3                	cmp    %edx,%ebx
80102cf0:	75 ee                	jne    80102ce0 <initlog+0x60>
  brelse(buf);
80102cf2:	83 ec 0c             	sub    $0xc,%esp
80102cf5:	50                   	push   %eax
80102cf6:	e8 f5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102cfb:	e8 80 fe ff ff       	call   80102b80 <install_trans>
  log.lh.n = 0;
80102d00:	c7 05 c8 c0 11 80 00 	movl   $0x0,0x8011c0c8
80102d07:	00 00 00 
  write_head(); // clear the log
80102d0a:	e8 11 ff ff ff       	call   80102c20 <write_head>
}
80102d0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d12:	83 c4 10             	add    $0x10,%esp
80102d15:	c9                   	leave
80102d16:	c3                   	ret
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax

80102d20 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d26:	68 80 c0 11 80       	push   $0x8011c080
80102d2b:	e8 90 18 00 00       	call   801045c0 <acquire>
80102d30:	83 c4 10             	add    $0x10,%esp
80102d33:	eb 18                	jmp    80102d4d <begin_op+0x2d>
80102d35:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d38:	83 ec 08             	sub    $0x8,%esp
80102d3b:	68 80 c0 11 80       	push   $0x8011c080
80102d40:	68 80 c0 11 80       	push   $0x8011c080
80102d45:	e8 d6 12 00 00       	call   80104020 <sleep>
80102d4a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d4d:	a1 c0 c0 11 80       	mov    0x8011c0c0,%eax
80102d52:	85 c0                	test   %eax,%eax
80102d54:	75 e2                	jne    80102d38 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d56:	a1 bc c0 11 80       	mov    0x8011c0bc,%eax
80102d5b:	8b 15 c8 c0 11 80    	mov    0x8011c0c8,%edx
80102d61:	83 c0 01             	add    $0x1,%eax
80102d64:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102d67:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102d6a:	83 fa 1e             	cmp    $0x1e,%edx
80102d6d:	7f c9                	jg     80102d38 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102d6f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102d72:	a3 bc c0 11 80       	mov    %eax,0x8011c0bc
      release(&log.lock);
80102d77:	68 80 c0 11 80       	push   $0x8011c080
80102d7c:	e8 7f 19 00 00       	call   80104700 <release>
      break;
    }
  }
}
80102d81:	83 c4 10             	add    $0x10,%esp
80102d84:	c9                   	leave
80102d85:	c3                   	ret
80102d86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d8d:	8d 76 00             	lea    0x0(%esi),%esi

80102d90 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	57                   	push   %edi
80102d94:	56                   	push   %esi
80102d95:	53                   	push   %ebx
80102d96:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102d99:	68 80 c0 11 80       	push   $0x8011c080
80102d9e:	e8 1d 18 00 00       	call   801045c0 <acquire>
  log.outstanding -= 1;
80102da3:	a1 bc c0 11 80       	mov    0x8011c0bc,%eax
  if(log.committing)
80102da8:	8b 35 c0 c0 11 80    	mov    0x8011c0c0,%esi
80102dae:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102db1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102db4:	89 1d bc c0 11 80    	mov    %ebx,0x8011c0bc
  if(log.committing)
80102dba:	85 f6                	test   %esi,%esi
80102dbc:	0f 85 22 01 00 00    	jne    80102ee4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102dc2:	85 db                	test   %ebx,%ebx
80102dc4:	0f 85 f6 00 00 00    	jne    80102ec0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102dca:	c7 05 c0 c0 11 80 01 	movl   $0x1,0x8011c0c0
80102dd1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102dd4:	83 ec 0c             	sub    $0xc,%esp
80102dd7:	68 80 c0 11 80       	push   $0x8011c080
80102ddc:	e8 1f 19 00 00       	call   80104700 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102de1:	8b 0d c8 c0 11 80    	mov    0x8011c0c8,%ecx
80102de7:	83 c4 10             	add    $0x10,%esp
80102dea:	85 c9                	test   %ecx,%ecx
80102dec:	7f 42                	jg     80102e30 <end_op+0xa0>
    acquire(&log.lock);
80102dee:	83 ec 0c             	sub    $0xc,%esp
80102df1:	68 80 c0 11 80       	push   $0x8011c080
80102df6:	e8 c5 17 00 00       	call   801045c0 <acquire>
    log.committing = 0;
80102dfb:	c7 05 c0 c0 11 80 00 	movl   $0x0,0x8011c0c0
80102e02:	00 00 00 
    wakeup(&log);
80102e05:	c7 04 24 80 c0 11 80 	movl   $0x8011c080,(%esp)
80102e0c:	e8 cf 12 00 00       	call   801040e0 <wakeup>
    release(&log.lock);
80102e11:	c7 04 24 80 c0 11 80 	movl   $0x8011c080,(%esp)
80102e18:	e8 e3 18 00 00       	call   80104700 <release>
80102e1d:	83 c4 10             	add    $0x10,%esp
}
80102e20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e23:	5b                   	pop    %ebx
80102e24:	5e                   	pop    %esi
80102e25:	5f                   	pop    %edi
80102e26:	5d                   	pop    %ebp
80102e27:	c3                   	ret
80102e28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e2f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e30:	a1 b4 c0 11 80       	mov    0x8011c0b4,%eax
80102e35:	83 ec 08             	sub    $0x8,%esp
80102e38:	01 d8                	add    %ebx,%eax
80102e3a:	83 c0 01             	add    $0x1,%eax
80102e3d:	50                   	push   %eax
80102e3e:	ff 35 c4 c0 11 80    	push   0x8011c0c4
80102e44:	e8 87 d2 ff ff       	call   801000d0 <bread>
80102e49:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e4b:	58                   	pop    %eax
80102e4c:	5a                   	pop    %edx
80102e4d:	ff 34 9d cc c0 11 80 	push   -0x7fee3f34(,%ebx,4)
80102e54:	ff 35 c4 c0 11 80    	push   0x8011c0c4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e5a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e5d:	e8 6e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102e62:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e65:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102e67:	8d 40 5c             	lea    0x5c(%eax),%eax
80102e6a:	68 00 08 00 00       	push   $0x800
80102e6f:	50                   	push   %eax
80102e70:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e73:	50                   	push   %eax
80102e74:	e8 67 19 00 00       	call   801047e0 <memmove>
    bwrite(to);  // write the log
80102e79:	89 34 24             	mov    %esi,(%esp)
80102e7c:	e8 2f d3 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102e81:	89 3c 24             	mov    %edi,(%esp)
80102e84:	e8 67 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102e89:	89 34 24             	mov    %esi,(%esp)
80102e8c:	e8 5f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e91:	83 c4 10             	add    $0x10,%esp
80102e94:	3b 1d c8 c0 11 80    	cmp    0x8011c0c8,%ebx
80102e9a:	7c 94                	jl     80102e30 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102e9c:	e8 7f fd ff ff       	call   80102c20 <write_head>
    install_trans(); // Now install writes to home locations
80102ea1:	e8 da fc ff ff       	call   80102b80 <install_trans>
    log.lh.n = 0;
80102ea6:	c7 05 c8 c0 11 80 00 	movl   $0x0,0x8011c0c8
80102ead:	00 00 00 
    write_head();    // Erase the transaction from the log
80102eb0:	e8 6b fd ff ff       	call   80102c20 <write_head>
80102eb5:	e9 34 ff ff ff       	jmp    80102dee <end_op+0x5e>
80102eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102ec0:	83 ec 0c             	sub    $0xc,%esp
80102ec3:	68 80 c0 11 80       	push   $0x8011c080
80102ec8:	e8 13 12 00 00       	call   801040e0 <wakeup>
  release(&log.lock);
80102ecd:	c7 04 24 80 c0 11 80 	movl   $0x8011c080,(%esp)
80102ed4:	e8 27 18 00 00       	call   80104700 <release>
80102ed9:	83 c4 10             	add    $0x10,%esp
}
80102edc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102edf:	5b                   	pop    %ebx
80102ee0:	5e                   	pop    %esi
80102ee1:	5f                   	pop    %edi
80102ee2:	5d                   	pop    %ebp
80102ee3:	c3                   	ret
    panic("log.committing");
80102ee4:	83 ec 0c             	sub    $0xc,%esp
80102ee7:	68 15 75 10 80       	push   $0x80107515
80102eec:	e8 8f d4 ff ff       	call   80100380 <panic>
80102ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102eff:	90                   	nop

80102f00 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	53                   	push   %ebx
80102f04:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f07:	8b 15 c8 c0 11 80    	mov    0x8011c0c8,%edx
{
80102f0d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f10:	83 fa 1d             	cmp    $0x1d,%edx
80102f13:	7f 7d                	jg     80102f92 <log_write+0x92>
80102f15:	a1 b8 c0 11 80       	mov    0x8011c0b8,%eax
80102f1a:	83 e8 01             	sub    $0x1,%eax
80102f1d:	39 c2                	cmp    %eax,%edx
80102f1f:	7d 71                	jge    80102f92 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f21:	a1 bc c0 11 80       	mov    0x8011c0bc,%eax
80102f26:	85 c0                	test   %eax,%eax
80102f28:	7e 75                	jle    80102f9f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f2a:	83 ec 0c             	sub    $0xc,%esp
80102f2d:	68 80 c0 11 80       	push   $0x8011c080
80102f32:	e8 89 16 00 00       	call   801045c0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f37:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f3a:	83 c4 10             	add    $0x10,%esp
80102f3d:	31 c0                	xor    %eax,%eax
80102f3f:	8b 15 c8 c0 11 80    	mov    0x8011c0c8,%edx
80102f45:	85 d2                	test   %edx,%edx
80102f47:	7f 0e                	jg     80102f57 <log_write+0x57>
80102f49:	eb 15                	jmp    80102f60 <log_write+0x60>
80102f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102f4f:	90                   	nop
80102f50:	83 c0 01             	add    $0x1,%eax
80102f53:	39 c2                	cmp    %eax,%edx
80102f55:	74 29                	je     80102f80 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f57:	39 0c 85 cc c0 11 80 	cmp    %ecx,-0x7fee3f34(,%eax,4)
80102f5e:	75 f0                	jne    80102f50 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102f60:	89 0c 85 cc c0 11 80 	mov    %ecx,-0x7fee3f34(,%eax,4)
  if (i == log.lh.n)
80102f67:	39 c2                	cmp    %eax,%edx
80102f69:	74 1c                	je     80102f87 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102f6b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102f6e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102f71:	c7 45 08 80 c0 11 80 	movl   $0x8011c080,0x8(%ebp)
}
80102f78:	c9                   	leave
  release(&log.lock);
80102f79:	e9 82 17 00 00       	jmp    80104700 <release>
80102f7e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80102f80:	89 0c 95 cc c0 11 80 	mov    %ecx,-0x7fee3f34(,%edx,4)
    log.lh.n++;
80102f87:	83 c2 01             	add    $0x1,%edx
80102f8a:	89 15 c8 c0 11 80    	mov    %edx,0x8011c0c8
80102f90:	eb d9                	jmp    80102f6b <log_write+0x6b>
    panic("too big a transaction");
80102f92:	83 ec 0c             	sub    $0xc,%esp
80102f95:	68 24 75 10 80       	push   $0x80107524
80102f9a:	e8 e1 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102f9f:	83 ec 0c             	sub    $0xc,%esp
80102fa2:	68 3a 75 10 80       	push   $0x8010753a
80102fa7:	e8 d4 d3 ff ff       	call   80100380 <panic>
80102fac:	66 90                	xchg   %ax,%ax
80102fae:	66 90                	xchg   %ax,%ax

80102fb0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	53                   	push   %ebx
80102fb4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102fb7:	e8 74 09 00 00       	call   80103930 <cpuid>
80102fbc:	89 c3                	mov    %eax,%ebx
80102fbe:	e8 6d 09 00 00       	call   80103930 <cpuid>
80102fc3:	83 ec 04             	sub    $0x4,%esp
80102fc6:	53                   	push   %ebx
80102fc7:	50                   	push   %eax
80102fc8:	68 55 75 10 80       	push   $0x80107555
80102fcd:	e8 de d6 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80102fd2:	e8 39 2a 00 00       	call   80105a10 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102fd7:	e8 f4 08 00 00       	call   801038d0 <mycpu>
80102fdc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102fde:	b8 01 00 00 00       	mov    $0x1,%eax
80102fe3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102fea:	e8 11 0c 00 00       	call   80103c00 <scheduler>
80102fef:	90                   	nop

80102ff0 <mpenter>:
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ff6:	e8 25 3b 00 00       	call   80106b20 <switchkvm>
  seginit();
80102ffb:	e8 90 3a 00 00       	call   80106a90 <seginit>
  lapicinit();
80103000:	e8 ab f7 ff ff       	call   801027b0 <lapicinit>
  mpmain();
80103005:	e8 a6 ff ff ff       	call   80102fb0 <mpmain>
8010300a:	66 90                	xchg   %ax,%ax
8010300c:	66 90                	xchg   %ax,%ax
8010300e:	66 90                	xchg   %ax,%ax

80103010 <main>:
{
80103010:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103014:	83 e4 f0             	and    $0xfffffff0,%esp
80103017:	ff 71 fc             	push   -0x4(%ecx)
8010301a:	55                   	push   %ebp
8010301b:	89 e5                	mov    %esp,%ebp
8010301d:	53                   	push   %ebx
8010301e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010301f:	83 ec 08             	sub    $0x8,%esp
80103022:	68 00 00 40 80       	push   $0x80400000
80103027:	68 b0 ff 11 80       	push   $0x8011ffb0
8010302c:	e8 5f f6 ff ff       	call   80102690 <kinit1>
  kvmalloc();      // kernel page table
80103031:	e8 aa 3f 00 00       	call   80106fe0 <kvmalloc>
  mpinit();        // detect other processors
80103036:	e8 85 01 00 00       	call   801031c0 <mpinit>
  lapicinit();     // interrupt controller
8010303b:	e8 70 f7 ff ff       	call   801027b0 <lapicinit>
  seginit();       // segment descriptors
80103040:	e8 4b 3a 00 00       	call   80106a90 <seginit>
  picinit();       // disable pic
80103045:	e8 86 03 00 00       	call   801033d0 <picinit>
  ioapicinit();    // another interrupt controller
8010304a:	e8 11 f4 ff ff       	call   80102460 <ioapicinit>
  consoleinit();   // console hardware
8010304f:	e8 3c da ff ff       	call   80100a90 <consoleinit>
  uartinit();      // serial port
80103054:	e8 a7 2c 00 00       	call   80105d00 <uartinit>
  pinit();         // process table
80103059:	e8 52 08 00 00       	call   801038b0 <pinit>
  tvinit();        // trap vectors
8010305e:	e8 2d 29 00 00       	call   80105990 <tvinit>
  binit();         // buffer cache
80103063:	e8 d8 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103068:	e8 f3 dd ff ff       	call   80100e60 <fileinit>
  ideinit();       // disk 
8010306d:	e8 ce f1 ff ff       	call   80102240 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103072:	83 c4 0c             	add    $0xc,%esp
80103075:	68 8a 00 00 00       	push   $0x8a
8010307a:	68 8c 94 10 80       	push   $0x8010948c
8010307f:	68 00 70 00 80       	push   $0x80007000
80103084:	e8 57 17 00 00       	call   801047e0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103089:	83 c4 10             	add    $0x10,%esp
8010308c:	69 05 64 c1 11 80 b0 	imul   $0xb0,0x8011c164,%eax
80103093:	00 00 00 
80103096:	05 80 c1 11 80       	add    $0x8011c180,%eax
8010309b:	3d 80 c1 11 80       	cmp    $0x8011c180,%eax
801030a0:	76 7e                	jbe    80103120 <main+0x110>
801030a2:	bb 80 c1 11 80       	mov    $0x8011c180,%ebx
801030a7:	eb 20                	jmp    801030c9 <main+0xb9>
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030b0:	69 05 64 c1 11 80 b0 	imul   $0xb0,0x8011c164,%eax
801030b7:	00 00 00 
801030ba:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801030c0:	05 80 c1 11 80       	add    $0x8011c180,%eax
801030c5:	39 c3                	cmp    %eax,%ebx
801030c7:	73 57                	jae    80103120 <main+0x110>
    if(c == mycpu())  // We've started already.
801030c9:	e8 02 08 00 00       	call   801038d0 <mycpu>
801030ce:	39 c3                	cmp    %eax,%ebx
801030d0:	74 de                	je     801030b0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801030d2:	e8 29 f6 ff ff       	call   80102700 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801030d7:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
801030da:	c7 05 f8 6f 00 80 f0 	movl   $0x80102ff0,0x80006ff8
801030e1:	2f 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801030e4:	c7 05 f4 6f 00 80 00 	movl   $0x108000,0x80006ff4
801030eb:	80 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801030ee:	05 00 10 00 00       	add    $0x1000,%eax
801030f3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801030f8:	0f b6 03             	movzbl (%ebx),%eax
801030fb:	68 00 70 00 00       	push   $0x7000
80103100:	50                   	push   %eax
80103101:	e8 fa f7 ff ff       	call   80102900 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103106:	83 c4 10             	add    $0x10,%esp
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103110:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103116:	85 c0                	test   %eax,%eax
80103118:	74 f6                	je     80103110 <main+0x100>
8010311a:	eb 94                	jmp    801030b0 <main+0xa0>
8010311c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103120:	83 ec 08             	sub    $0x8,%esp
80103123:	68 00 00 00 8e       	push   $0x8e000000
80103128:	68 00 00 40 80       	push   $0x80400000
8010312d:	e8 fe f4 ff ff       	call   80102630 <kinit2>
  userinit();      // first user process
80103132:	e8 49 08 00 00       	call   80103980 <userinit>
  mpmain();        // finish this processor's setup
80103137:	e8 74 fe ff ff       	call   80102fb0 <mpmain>
8010313c:	66 90                	xchg   %ax,%ax
8010313e:	66 90                	xchg   %ax,%ax

80103140 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103145:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010314b:	53                   	push   %ebx
  e = addr+len;
8010314c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010314f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103152:	39 de                	cmp    %ebx,%esi
80103154:	72 10                	jb     80103166 <mpsearch1+0x26>
80103156:	eb 50                	jmp    801031a8 <mpsearch1+0x68>
80103158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010315f:	90                   	nop
80103160:	89 fe                	mov    %edi,%esi
80103162:	39 df                	cmp    %ebx,%edi
80103164:	73 42                	jae    801031a8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103166:	83 ec 04             	sub    $0x4,%esp
80103169:	8d 7e 10             	lea    0x10(%esi),%edi
8010316c:	6a 04                	push   $0x4
8010316e:	68 69 75 10 80       	push   $0x80107569
80103173:	56                   	push   %esi
80103174:	e8 17 16 00 00       	call   80104790 <memcmp>
80103179:	83 c4 10             	add    $0x10,%esp
8010317c:	85 c0                	test   %eax,%eax
8010317e:	75 e0                	jne    80103160 <mpsearch1+0x20>
80103180:	89 f2                	mov    %esi,%edx
80103182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103188:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010318b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010318e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103190:	39 fa                	cmp    %edi,%edx
80103192:	75 f4                	jne    80103188 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103194:	84 c0                	test   %al,%al
80103196:	75 c8                	jne    80103160 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103198:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010319b:	89 f0                	mov    %esi,%eax
8010319d:	5b                   	pop    %ebx
8010319e:	5e                   	pop    %esi
8010319f:	5f                   	pop    %edi
801031a0:	5d                   	pop    %ebp
801031a1:	c3                   	ret
801031a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031ab:	31 f6                	xor    %esi,%esi
}
801031ad:	5b                   	pop    %ebx
801031ae:	89 f0                	mov    %esi,%eax
801031b0:	5e                   	pop    %esi
801031b1:	5f                   	pop    %edi
801031b2:	5d                   	pop    %ebp
801031b3:	c3                   	ret
801031b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031bf:	90                   	nop

801031c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801031c0:	55                   	push   %ebp
801031c1:	89 e5                	mov    %esp,%ebp
801031c3:	57                   	push   %edi
801031c4:	56                   	push   %esi
801031c5:	53                   	push   %ebx
801031c6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801031c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801031d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801031d7:	c1 e0 08             	shl    $0x8,%eax
801031da:	09 d0                	or     %edx,%eax
801031dc:	c1 e0 04             	shl    $0x4,%eax
801031df:	75 1b                	jne    801031fc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801031e1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801031e8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801031ef:	c1 e0 08             	shl    $0x8,%eax
801031f2:	09 d0                	or     %edx,%eax
801031f4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801031f7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801031fc:	ba 00 04 00 00       	mov    $0x400,%edx
80103201:	e8 3a ff ff ff       	call   80103140 <mpsearch1>
80103206:	89 c3                	mov    %eax,%ebx
80103208:	85 c0                	test   %eax,%eax
8010320a:	0f 84 50 01 00 00    	je     80103360 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103210:	8b 73 04             	mov    0x4(%ebx),%esi
80103213:	85 f6                	test   %esi,%esi
80103215:	0f 84 35 01 00 00    	je     80103350 <mpinit+0x190>
  if(memcmp(conf, "PCMP", 4) != 0)
8010321b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010321e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103224:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103227:	6a 04                	push   $0x4
80103229:	68 6e 75 10 80       	push   $0x8010756e
8010322e:	50                   	push   %eax
8010322f:	e8 5c 15 00 00       	call   80104790 <memcmp>
80103234:	83 c4 10             	add    $0x10,%esp
80103237:	85 c0                	test   %eax,%eax
80103239:	0f 85 11 01 00 00    	jne    80103350 <mpinit+0x190>
  if(conf->version != 1 && conf->version != 4)
8010323f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103246:	3c 01                	cmp    $0x1,%al
80103248:	74 08                	je     80103252 <mpinit+0x92>
8010324a:	3c 04                	cmp    $0x4,%al
8010324c:	0f 85 fe 00 00 00    	jne    80103350 <mpinit+0x190>
  if(sum((uchar*)conf, conf->length) != 0)
80103252:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103259:	66 85 d2             	test   %dx,%dx
8010325c:	74 22                	je     80103280 <mpinit+0xc0>
8010325e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103261:	89 f0                	mov    %esi,%eax
  sum = 0;
80103263:	31 d2                	xor    %edx,%edx
80103265:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103268:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010326f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103272:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103274:	39 c7                	cmp    %eax,%edi
80103276:	75 f0                	jne    80103268 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103278:	84 d2                	test   %dl,%dl
8010327a:	0f 85 d0 00 00 00    	jne    80103350 <mpinit+0x190>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103280:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103286:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103289:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010328c:	a3 7c c0 11 80       	mov    %eax,0x8011c07c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103291:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103298:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
8010329e:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032a3:	01 d7                	add    %edx,%edi
801032a5:	89 fa                	mov    %edi,%edx
801032a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032ae:	66 90                	xchg   %ax,%ax
801032b0:	39 d0                	cmp    %edx,%eax
801032b2:	73 15                	jae    801032c9 <mpinit+0x109>
    switch(*p){
801032b4:	0f b6 08             	movzbl (%eax),%ecx
801032b7:	80 f9 02             	cmp    $0x2,%cl
801032ba:	74 54                	je     80103310 <mpinit+0x150>
801032bc:	77 42                	ja     80103300 <mpinit+0x140>
801032be:	84 c9                	test   %cl,%cl
801032c0:	74 5e                	je     80103320 <mpinit+0x160>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801032c2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032c5:	39 d0                	cmp    %edx,%eax
801032c7:	72 eb                	jb     801032b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801032c9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801032cc:	85 f6                	test   %esi,%esi
801032ce:	0f 84 e1 00 00 00    	je     801033b5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801032d4:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801032d8:	74 15                	je     801032ef <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032da:	b8 70 00 00 00       	mov    $0x70,%eax
801032df:	ba 22 00 00 00       	mov    $0x22,%edx
801032e4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e5:	ba 23 00 00 00       	mov    $0x23,%edx
801032ea:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801032eb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032ee:	ee                   	out    %al,(%dx)
  }
}
801032ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032f2:	5b                   	pop    %ebx
801032f3:	5e                   	pop    %esi
801032f4:	5f                   	pop    %edi
801032f5:	5d                   	pop    %ebp
801032f6:	c3                   	ret
801032f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032fe:	66 90                	xchg   %ax,%ax
    switch(*p){
80103300:	83 e9 03             	sub    $0x3,%ecx
80103303:	80 f9 01             	cmp    $0x1,%cl
80103306:	76 ba                	jbe    801032c2 <mpinit+0x102>
80103308:	31 f6                	xor    %esi,%esi
8010330a:	eb a4                	jmp    801032b0 <mpinit+0xf0>
8010330c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103310:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103314:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103317:	88 0d 60 c1 11 80    	mov    %cl,0x8011c160
      continue;
8010331d:	eb 91                	jmp    801032b0 <mpinit+0xf0>
8010331f:	90                   	nop
      if(ncpu < NCPU) {
80103320:	8b 0d 64 c1 11 80    	mov    0x8011c164,%ecx
80103326:	83 f9 07             	cmp    $0x7,%ecx
80103329:	7f 19                	jg     80103344 <mpinit+0x184>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010332b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103331:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103335:	83 c1 01             	add    $0x1,%ecx
80103338:	89 0d 64 c1 11 80    	mov    %ecx,0x8011c164
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010333e:	88 9f 80 c1 11 80    	mov    %bl,-0x7fee3e80(%edi)
      p += sizeof(struct mpproc);
80103344:	83 c0 14             	add    $0x14,%eax
      continue;
80103347:	e9 64 ff ff ff       	jmp    801032b0 <mpinit+0xf0>
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103350:	83 ec 0c             	sub    $0xc,%esp
80103353:	68 73 75 10 80       	push   $0x80107573
80103358:	e8 23 d0 ff ff       	call   80100380 <panic>
8010335d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103360:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103365:	eb 13                	jmp    8010337a <mpinit+0x1ba>
80103367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010336e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103370:	89 f3                	mov    %esi,%ebx
80103372:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103378:	74 d6                	je     80103350 <mpinit+0x190>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010337a:	83 ec 04             	sub    $0x4,%esp
8010337d:	8d 73 10             	lea    0x10(%ebx),%esi
80103380:	6a 04                	push   $0x4
80103382:	68 69 75 10 80       	push   $0x80107569
80103387:	53                   	push   %ebx
80103388:	e8 03 14 00 00       	call   80104790 <memcmp>
8010338d:	83 c4 10             	add    $0x10,%esp
80103390:	85 c0                	test   %eax,%eax
80103392:	75 dc                	jne    80103370 <mpinit+0x1b0>
80103394:	89 da                	mov    %ebx,%edx
80103396:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010339d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033a0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033a3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033a6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033a8:	39 f2                	cmp    %esi,%edx
801033aa:	75 f4                	jne    801033a0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ac:	84 c0                	test   %al,%al
801033ae:	75 c0                	jne    80103370 <mpinit+0x1b0>
801033b0:	e9 5b fe ff ff       	jmp    80103210 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801033b5:	83 ec 0c             	sub    $0xc,%esp
801033b8:	68 8c 75 10 80       	push   $0x8010758c
801033bd:	e8 be cf ff ff       	call   80100380 <panic>
801033c2:	66 90                	xchg   %ax,%ax
801033c4:	66 90                	xchg   %ax,%ax
801033c6:	66 90                	xchg   %ax,%ax
801033c8:	66 90                	xchg   %ax,%ax
801033ca:	66 90                	xchg   %ax,%ax
801033cc:	66 90                	xchg   %ax,%ax
801033ce:	66 90                	xchg   %ax,%ax

801033d0 <picinit>:
801033d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801033d5:	ba 21 00 00 00       	mov    $0x21,%edx
801033da:	ee                   	out    %al,(%dx)
801033db:	ba a1 00 00 00       	mov    $0xa1,%edx
801033e0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801033e1:	c3                   	ret
801033e2:	66 90                	xchg   %ax,%ax
801033e4:	66 90                	xchg   %ax,%ax
801033e6:	66 90                	xchg   %ax,%ax
801033e8:	66 90                	xchg   %ax,%ax
801033ea:	66 90                	xchg   %ax,%ax
801033ec:	66 90                	xchg   %ax,%ax
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 0c             	sub    $0xc,%esp
801033f9:	8b 75 08             	mov    0x8(%ebp),%esi
801033fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ff:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103405:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010340b:	e8 70 da ff ff       	call   80100e80 <filealloc>
80103410:	89 06                	mov    %eax,(%esi)
80103412:	85 c0                	test   %eax,%eax
80103414:	0f 84 a5 00 00 00    	je     801034bf <pipealloc+0xcf>
8010341a:	e8 61 da ff ff       	call   80100e80 <filealloc>
8010341f:	89 07                	mov    %eax,(%edi)
80103421:	85 c0                	test   %eax,%eax
80103423:	0f 84 84 00 00 00    	je     801034ad <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103429:	e8 d2 f2 ff ff       	call   80102700 <kalloc>
8010342e:	89 c3                	mov    %eax,%ebx
80103430:	85 c0                	test   %eax,%eax
80103432:	0f 84 a0 00 00 00    	je     801034d8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103438:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010343f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103442:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103445:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010344c:	00 00 00 
  p->nwrite = 0;
8010344f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103456:	00 00 00 
  p->nread = 0;
80103459:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103460:	00 00 00 
  initlock(&p->lock, "pipe");
80103463:	68 ab 75 10 80       	push   $0x801075ab
80103468:	50                   	push   %eax
80103469:	e8 32 10 00 00       	call   801044a0 <initlock>
  (*f0)->type = FD_PIPE;
8010346e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103470:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103473:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103479:	8b 06                	mov    (%esi),%eax
8010347b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010347f:	8b 06                	mov    (%esi),%eax
80103481:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103485:	8b 06                	mov    (%esi),%eax
80103487:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010348a:	8b 07                	mov    (%edi),%eax
8010348c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103492:	8b 07                	mov    (%edi),%eax
80103494:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103498:	8b 07                	mov    (%edi),%eax
8010349a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010349e:	8b 07                	mov    (%edi),%eax
801034a0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801034a3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034a8:	5b                   	pop    %ebx
801034a9:	5e                   	pop    %esi
801034aa:	5f                   	pop    %edi
801034ab:	5d                   	pop    %ebp
801034ac:	c3                   	ret
  if(*f0)
801034ad:	8b 06                	mov    (%esi),%eax
801034af:	85 c0                	test   %eax,%eax
801034b1:	74 1e                	je     801034d1 <pipealloc+0xe1>
    fileclose(*f0);
801034b3:	83 ec 0c             	sub    $0xc,%esp
801034b6:	50                   	push   %eax
801034b7:	e8 84 da ff ff       	call   80100f40 <fileclose>
801034bc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034bf:	8b 07                	mov    (%edi),%eax
801034c1:	85 c0                	test   %eax,%eax
801034c3:	74 0c                	je     801034d1 <pipealloc+0xe1>
    fileclose(*f1);
801034c5:	83 ec 0c             	sub    $0xc,%esp
801034c8:	50                   	push   %eax
801034c9:	e8 72 da ff ff       	call   80100f40 <fileclose>
801034ce:	83 c4 10             	add    $0x10,%esp
  return -1;
801034d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034d6:	eb cd                	jmp    801034a5 <pipealloc+0xb5>
  if(*f0)
801034d8:	8b 06                	mov    (%esi),%eax
801034da:	85 c0                	test   %eax,%eax
801034dc:	75 d5                	jne    801034b3 <pipealloc+0xc3>
801034de:	eb df                	jmp    801034bf <pipealloc+0xcf>

801034e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	56                   	push   %esi
801034e4:	53                   	push   %ebx
801034e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034eb:	83 ec 0c             	sub    $0xc,%esp
801034ee:	53                   	push   %ebx
801034ef:	e8 cc 10 00 00       	call   801045c0 <acquire>
  if(writable){
801034f4:	83 c4 10             	add    $0x10,%esp
801034f7:	85 f6                	test   %esi,%esi
801034f9:	74 65                	je     80103560 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801034fb:	83 ec 0c             	sub    $0xc,%esp
801034fe:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103504:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010350b:	00 00 00 
    wakeup(&p->nread);
8010350e:	50                   	push   %eax
8010350f:	e8 cc 0b 00 00       	call   801040e0 <wakeup>
80103514:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103517:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010351d:	85 d2                	test   %edx,%edx
8010351f:	75 0a                	jne    8010352b <pipeclose+0x4b>
80103521:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103527:	85 c0                	test   %eax,%eax
80103529:	74 15                	je     80103540 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010352b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010352e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103531:	5b                   	pop    %ebx
80103532:	5e                   	pop    %esi
80103533:	5d                   	pop    %ebp
    release(&p->lock);
80103534:	e9 c7 11 00 00       	jmp    80104700 <release>
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103540:	83 ec 0c             	sub    $0xc,%esp
80103543:	53                   	push   %ebx
80103544:	e8 b7 11 00 00       	call   80104700 <release>
    kfree((char*)p);
80103549:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010354c:	83 c4 10             	add    $0x10,%esp
}
8010354f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103552:	5b                   	pop    %ebx
80103553:	5e                   	pop    %esi
80103554:	5d                   	pop    %ebp
    kfree((char*)p);
80103555:	e9 e6 ef ff ff       	jmp    80102540 <kfree>
8010355a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103560:	83 ec 0c             	sub    $0xc,%esp
80103563:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103569:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103570:	00 00 00 
    wakeup(&p->nwrite);
80103573:	50                   	push   %eax
80103574:	e8 67 0b 00 00       	call   801040e0 <wakeup>
80103579:	83 c4 10             	add    $0x10,%esp
8010357c:	eb 99                	jmp    80103517 <pipeclose+0x37>
8010357e:	66 90                	xchg   %ax,%ax

80103580 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	57                   	push   %edi
80103584:	56                   	push   %esi
80103585:	53                   	push   %ebx
80103586:	83 ec 28             	sub    $0x28,%esp
80103589:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010358c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010358f:	53                   	push   %ebx
80103590:	e8 2b 10 00 00       	call   801045c0 <acquire>
  for(i = 0; i < n; i++){
80103595:	83 c4 10             	add    $0x10,%esp
80103598:	85 ff                	test   %edi,%edi
8010359a:	0f 8e ce 00 00 00    	jle    8010366e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035a0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801035a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035a9:	89 7d 10             	mov    %edi,0x10(%ebp)
801035ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035af:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801035b2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035b5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035bb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035c1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035c7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801035cd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801035d0:	0f 85 b6 00 00 00    	jne    8010368c <pipewrite+0x10c>
801035d6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801035d9:	eb 3b                	jmp    80103616 <pipewrite+0x96>
801035db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035df:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
801035e0:	e8 6b 03 00 00       	call   80103950 <myproc>
801035e5:	8b 48 24             	mov    0x24(%eax),%ecx
801035e8:	85 c9                	test   %ecx,%ecx
801035ea:	75 34                	jne    80103620 <pipewrite+0xa0>
      wakeup(&p->nread);
801035ec:	83 ec 0c             	sub    $0xc,%esp
801035ef:	56                   	push   %esi
801035f0:	e8 eb 0a 00 00       	call   801040e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801035f5:	58                   	pop    %eax
801035f6:	5a                   	pop    %edx
801035f7:	53                   	push   %ebx
801035f8:	57                   	push   %edi
801035f9:	e8 22 0a 00 00       	call   80104020 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035fe:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103604:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010360a:	83 c4 10             	add    $0x10,%esp
8010360d:	05 00 02 00 00       	add    $0x200,%eax
80103612:	39 c2                	cmp    %eax,%edx
80103614:	75 2a                	jne    80103640 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103616:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010361c:	85 c0                	test   %eax,%eax
8010361e:	75 c0                	jne    801035e0 <pipewrite+0x60>
        release(&p->lock);
80103620:	83 ec 0c             	sub    $0xc,%esp
80103623:	53                   	push   %ebx
80103624:	e8 d7 10 00 00       	call   80104700 <release>
        return -1;
80103629:	83 c4 10             	add    $0x10,%esp
8010362c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103631:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103634:	5b                   	pop    %ebx
80103635:	5e                   	pop    %esi
80103636:	5f                   	pop    %edi
80103637:	5d                   	pop    %ebp
80103638:	c3                   	ret
80103639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103640:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103643:	8d 42 01             	lea    0x1(%edx),%eax
80103646:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010364c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010364f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103655:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103658:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010365c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103660:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103663:	39 c1                	cmp    %eax,%ecx
80103665:	0f 85 50 ff ff ff    	jne    801035bb <pipewrite+0x3b>
8010366b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010366e:	83 ec 0c             	sub    $0xc,%esp
80103671:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103677:	50                   	push   %eax
80103678:	e8 63 0a 00 00       	call   801040e0 <wakeup>
  release(&p->lock);
8010367d:	89 1c 24             	mov    %ebx,(%esp)
80103680:	e8 7b 10 00 00       	call   80104700 <release>
  return n;
80103685:	83 c4 10             	add    $0x10,%esp
80103688:	89 f8                	mov    %edi,%eax
8010368a:	eb a5                	jmp    80103631 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010368c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010368f:	eb b2                	jmp    80103643 <pipewrite+0xc3>
80103691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103698:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010369f:	90                   	nop

801036a0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	57                   	push   %edi
801036a4:	56                   	push   %esi
801036a5:	53                   	push   %ebx
801036a6:	83 ec 18             	sub    $0x18,%esp
801036a9:	8b 75 08             	mov    0x8(%ebp),%esi
801036ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036af:	56                   	push   %esi
801036b0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036b6:	e8 05 0f 00 00       	call   801045c0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036bb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036c1:	83 c4 10             	add    $0x10,%esp
801036c4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036ca:	74 2f                	je     801036fb <piperead+0x5b>
801036cc:	eb 37                	jmp    80103705 <piperead+0x65>
801036ce:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801036d0:	e8 7b 02 00 00       	call   80103950 <myproc>
801036d5:	8b 48 24             	mov    0x24(%eax),%ecx
801036d8:	85 c9                	test   %ecx,%ecx
801036da:	0f 85 80 00 00 00    	jne    80103760 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036e0:	83 ec 08             	sub    $0x8,%esp
801036e3:	56                   	push   %esi
801036e4:	53                   	push   %ebx
801036e5:	e8 36 09 00 00       	call   80104020 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ea:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
801036f0:	83 c4 10             	add    $0x10,%esp
801036f3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
801036f9:	75 0a                	jne    80103705 <piperead+0x65>
801036fb:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103701:	85 c0                	test   %eax,%eax
80103703:	75 cb                	jne    801036d0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103705:	8b 55 10             	mov    0x10(%ebp),%edx
80103708:	31 db                	xor    %ebx,%ebx
8010370a:	85 d2                	test   %edx,%edx
8010370c:	7f 20                	jg     8010372e <piperead+0x8e>
8010370e:	eb 2c                	jmp    8010373c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103710:	8d 48 01             	lea    0x1(%eax),%ecx
80103713:	25 ff 01 00 00       	and    $0x1ff,%eax
80103718:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010371e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103723:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103726:	83 c3 01             	add    $0x1,%ebx
80103729:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010372c:	74 0e                	je     8010373c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010372e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103734:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010373a:	75 d4                	jne    80103710 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010373c:	83 ec 0c             	sub    $0xc,%esp
8010373f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103745:	50                   	push   %eax
80103746:	e8 95 09 00 00       	call   801040e0 <wakeup>
  release(&p->lock);
8010374b:	89 34 24             	mov    %esi,(%esp)
8010374e:	e8 ad 0f 00 00       	call   80104700 <release>
  return i;
80103753:	83 c4 10             	add    $0x10,%esp
}
80103756:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103759:	89 d8                	mov    %ebx,%eax
8010375b:	5b                   	pop    %ebx
8010375c:	5e                   	pop    %esi
8010375d:	5f                   	pop    %edi
8010375e:	5d                   	pop    %ebp
8010375f:	c3                   	ret
      release(&p->lock);
80103760:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103763:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103768:	56                   	push   %esi
80103769:	e8 92 0f 00 00       	call   80104700 <release>
      return -1;
8010376e:	83 c4 10             	add    $0x10,%esp
}
80103771:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103774:	89 d8                	mov    %ebx,%eax
80103776:	5b                   	pop    %ebx
80103777:	5e                   	pop    %esi
80103778:	5f                   	pop    %edi
80103779:	5d                   	pop    %ebp
8010377a:	c3                   	ret
8010377b:	66 90                	xchg   %ax,%ax
8010377d:	66 90                	xchg   %ax,%ax
8010377f:	90                   	nop

80103780 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103784:	bb 34 c7 11 80       	mov    $0x8011c734,%ebx
{
80103789:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010378c:	68 00 c7 11 80       	push   $0x8011c700
80103791:	e8 2a 0e 00 00       	call   801045c0 <acquire>
80103796:	83 c4 10             	add    $0x10,%esp
80103799:	eb 14                	jmp    801037af <allocproc+0x2f>
8010379b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010379f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037a0:	83 eb 80             	sub    $0xffffff80,%ebx
801037a3:	81 fb 34 e7 11 80    	cmp    $0x8011e734,%ebx
801037a9:	0f 84 81 00 00 00    	je     80103830 <allocproc+0xb0>
    if(p->state == UNUSED)
801037af:	8b 43 0c             	mov    0xc(%ebx),%eax
801037b2:	85 c0                	test   %eax,%eax
801037b4:	75 ea                	jne    801037a0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037b6:	a1 04 90 10 80       	mov    0x80109004,%eax
  p->priority = 10;
  release(&ptable.lock);
801037bb:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037be:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->priority = 10;
801037c5:	c7 43 7c 0a 00 00 00 	movl   $0xa,0x7c(%ebx)
  p->pid = nextpid++;
801037cc:	8d 50 01             	lea    0x1(%eax),%edx
801037cf:	89 43 10             	mov    %eax,0x10(%ebx)
801037d2:	89 15 04 90 10 80    	mov    %edx,0x80109004
  release(&ptable.lock);
801037d8:	68 00 c7 11 80       	push   $0x8011c700
801037dd:	e8 1e 0f 00 00       	call   80104700 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801037e2:	e8 19 ef ff ff       	call   80102700 <kalloc>
801037e7:	83 c4 10             	add    $0x10,%esp
801037ea:	89 43 08             	mov    %eax,0x8(%ebx)
801037ed:	85 c0                	test   %eax,%eax
801037ef:	74 58                	je     80103849 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801037f1:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801037f7:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801037fa:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801037ff:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103802:	c7 40 14 7f 59 10 80 	movl   $0x8010597f,0x14(%eax)
  p->context = (struct context*)sp;
80103809:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010380c:	6a 14                	push   $0x14
8010380e:	6a 00                	push   $0x0
80103810:	50                   	push   %eax
80103811:	e8 3a 0f 00 00       	call   80104750 <memset>
  p->context->eip = (uint)forkret;
80103816:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103819:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010381c:	c7 40 10 60 38 10 80 	movl   $0x80103860,0x10(%eax)
}
80103823:	89 d8                	mov    %ebx,%eax
80103825:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103828:	c9                   	leave
80103829:	c3                   	ret
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80103830:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103833:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103835:	68 00 c7 11 80       	push   $0x8011c700
8010383a:	e8 c1 0e 00 00       	call   80104700 <release>
  return 0;
8010383f:	83 c4 10             	add    $0x10,%esp
}
80103842:	89 d8                	mov    %ebx,%eax
80103844:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103847:	c9                   	leave
80103848:	c3                   	ret
    p->state = UNUSED;
80103849:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103850:	31 db                	xor    %ebx,%ebx
80103852:	eb ee                	jmp    80103842 <allocproc+0xc2>
80103854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010385b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010385f:	90                   	nop

80103860 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103866:	68 00 c7 11 80       	push   $0x8011c700
8010386b:	e8 90 0e 00 00       	call   80104700 <release>

  if (first) {
80103870:	a1 00 90 10 80       	mov    0x80109000,%eax
80103875:	83 c4 10             	add    $0x10,%esp
80103878:	85 c0                	test   %eax,%eax
8010387a:	75 04                	jne    80103880 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010387c:	c9                   	leave
8010387d:	c3                   	ret
8010387e:	66 90                	xchg   %ax,%ax
    first = 0;
80103880:	c7 05 00 90 10 80 00 	movl   $0x0,0x80109000
80103887:	00 00 00 
    iinit(ROOTDEV);
8010388a:	83 ec 0c             	sub    $0xc,%esp
8010388d:	6a 01                	push   $0x1
8010388f:	e8 3c dd ff ff       	call   801015d0 <iinit>
    initlog(ROOTDEV);
80103894:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010389b:	e8 e0 f3 ff ff       	call   80102c80 <initlog>
}
801038a0:	83 c4 10             	add    $0x10,%esp
801038a3:	c9                   	leave
801038a4:	c3                   	ret
801038a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038b0 <pinit>:
{
801038b0:	55                   	push   %ebp
801038b1:	89 e5                	mov    %esp,%ebp
801038b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038b6:	68 b0 75 10 80       	push   $0x801075b0
801038bb:	68 00 c7 11 80       	push   $0x8011c700
801038c0:	e8 db 0b 00 00       	call   801044a0 <initlock>
}
801038c5:	83 c4 10             	add    $0x10,%esp
801038c8:	c9                   	leave
801038c9:	c3                   	ret
801038ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038d0 <mycpu>:
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	56                   	push   %esi
801038d4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801038d5:	9c                   	pushf
801038d6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801038d7:	f6 c4 02             	test   $0x2,%ah
801038da:	75 46                	jne    80103922 <mycpu+0x52>
  apicid = lapicid();
801038dc:	e8 cf ef ff ff       	call   801028b0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801038e1:	8b 35 64 c1 11 80    	mov    0x8011c164,%esi
801038e7:	85 f6                	test   %esi,%esi
801038e9:	7e 2a                	jle    80103915 <mycpu+0x45>
801038eb:	31 d2                	xor    %edx,%edx
801038ed:	eb 08                	jmp    801038f7 <mycpu+0x27>
801038ef:	90                   	nop
801038f0:	83 c2 01             	add    $0x1,%edx
801038f3:	39 f2                	cmp    %esi,%edx
801038f5:	74 1e                	je     80103915 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801038f7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801038fd:	0f b6 99 80 c1 11 80 	movzbl -0x7fee3e80(%ecx),%ebx
80103904:	39 c3                	cmp    %eax,%ebx
80103906:	75 e8                	jne    801038f0 <mycpu+0x20>
}
80103908:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010390b:	8d 81 80 c1 11 80    	lea    -0x7fee3e80(%ecx),%eax
}
80103911:	5b                   	pop    %ebx
80103912:	5e                   	pop    %esi
80103913:	5d                   	pop    %ebp
80103914:	c3                   	ret
  panic("unknown apicid\n");
80103915:	83 ec 0c             	sub    $0xc,%esp
80103918:	68 b7 75 10 80       	push   $0x801075b7
8010391d:	e8 5e ca ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103922:	83 ec 0c             	sub    $0xc,%esp
80103925:	68 e4 76 10 80       	push   $0x801076e4
8010392a:	e8 51 ca ff ff       	call   80100380 <panic>
8010392f:	90                   	nop

80103930 <cpuid>:
cpuid() {
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103936:	e8 95 ff ff ff       	call   801038d0 <mycpu>
}
8010393b:	c9                   	leave
  return mycpu()-cpus;
8010393c:	2d 80 c1 11 80       	sub    $0x8011c180,%eax
80103941:	c1 f8 04             	sar    $0x4,%eax
80103944:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010394a:	c3                   	ret
8010394b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010394f:	90                   	nop

80103950 <myproc>:
myproc(void) {
80103950:	55                   	push   %ebp
80103951:	89 e5                	mov    %esp,%ebp
80103953:	53                   	push   %ebx
80103954:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103957:	e8 14 0c 00 00       	call   80104570 <pushcli>
  c = mycpu();
8010395c:	e8 6f ff ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103961:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103967:	e8 34 0d 00 00       	call   801046a0 <popcli>
}
8010396c:	89 d8                	mov    %ebx,%eax
8010396e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103971:	c9                   	leave
80103972:	c3                   	ret
80103973:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010397a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103980 <userinit>:
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
80103984:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103987:	e8 f4 fd ff ff       	call   80103780 <allocproc>
8010398c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010398e:	a3 34 e7 11 80       	mov    %eax,0x8011e734
  if((p->pgdir = setupkvm()) == 0)
80103993:	e8 c8 35 00 00       	call   80106f60 <setupkvm>
80103998:	89 43 04             	mov    %eax,0x4(%ebx)
8010399b:	85 c0                	test   %eax,%eax
8010399d:	0f 84 bd 00 00 00    	je     80103a60 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039a3:	83 ec 04             	sub    $0x4,%esp
801039a6:	68 2c 00 00 00       	push   $0x2c
801039ab:	68 60 94 10 80       	push   $0x80109460
801039b0:	50                   	push   %eax
801039b1:	e8 8a 32 00 00       	call   80106c40 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039b6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039b9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039bf:	6a 4c                	push   $0x4c
801039c1:	6a 00                	push   $0x0
801039c3:	ff 73 18             	push   0x18(%ebx)
801039c6:	e8 85 0d 00 00       	call   80104750 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039cb:	8b 43 18             	mov    0x18(%ebx),%eax
801039ce:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039d3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039d6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039db:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039df:	8b 43 18             	mov    0x18(%ebx),%eax
801039e2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039e6:	8b 43 18             	mov    0x18(%ebx),%eax
801039e9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039ed:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801039f1:	8b 43 18             	mov    0x18(%ebx),%eax
801039f4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039f8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801039fc:	8b 43 18             	mov    0x18(%ebx),%eax
801039ff:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a06:	8b 43 18             	mov    0x18(%ebx),%eax
80103a09:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a10:	8b 43 18             	mov    0x18(%ebx),%eax
80103a13:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a1a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a1d:	6a 10                	push   $0x10
80103a1f:	68 e0 75 10 80       	push   $0x801075e0
80103a24:	50                   	push   %eax
80103a25:	e8 d6 0e 00 00       	call   80104900 <safestrcpy>
  p->cwd = namei("/");
80103a2a:	c7 04 24 e9 75 10 80 	movl   $0x801075e9,(%esp)
80103a31:	e8 ea e6 ff ff       	call   80102120 <namei>
80103a36:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103a39:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103a40:	e8 7b 0b 00 00       	call   801045c0 <acquire>
  p->state = RUNNABLE;
80103a45:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a4c:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103a53:	e8 a8 0c 00 00       	call   80104700 <release>
}
80103a58:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a5b:	83 c4 10             	add    $0x10,%esp
80103a5e:	c9                   	leave
80103a5f:	c3                   	ret
    panic("userinit: out of memory?");
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	68 c7 75 10 80       	push   $0x801075c7
80103a68:	e8 13 c9 ff ff       	call   80100380 <panic>
80103a6d:	8d 76 00             	lea    0x0(%esi),%esi

80103a70 <growproc>:
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	56                   	push   %esi
80103a74:	53                   	push   %ebx
80103a75:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a78:	e8 f3 0a 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103a7d:	e8 4e fe ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103a82:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a88:	e8 13 0c 00 00       	call   801046a0 <popcli>
  sz = curproc->sz;
80103a8d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103a8f:	85 f6                	test   %esi,%esi
80103a91:	7f 1d                	jg     80103ab0 <growproc+0x40>
  } else if(n < 0){
80103a93:	75 3b                	jne    80103ad0 <growproc+0x60>
  switchuvm(curproc);
80103a95:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103a98:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103a9a:	53                   	push   %ebx
80103a9b:	e8 90 30 00 00       	call   80106b30 <switchuvm>
  return 0;
80103aa0:	83 c4 10             	add    $0x10,%esp
80103aa3:	31 c0                	xor    %eax,%eax
}
80103aa5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103aa8:	5b                   	pop    %ebx
80103aa9:	5e                   	pop    %esi
80103aaa:	5d                   	pop    %ebp
80103aab:	c3                   	ret
80103aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ab0:	83 ec 04             	sub    $0x4,%esp
80103ab3:	01 c6                	add    %eax,%esi
80103ab5:	56                   	push   %esi
80103ab6:	50                   	push   %eax
80103ab7:	ff 73 04             	push   0x4(%ebx)
80103aba:	e8 d1 32 00 00       	call   80106d90 <allocuvm>
80103abf:	83 c4 10             	add    $0x10,%esp
80103ac2:	85 c0                	test   %eax,%eax
80103ac4:	75 cf                	jne    80103a95 <growproc+0x25>
      return -1;
80103ac6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103acb:	eb d8                	jmp    80103aa5 <growproc+0x35>
80103acd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ad0:	83 ec 04             	sub    $0x4,%esp
80103ad3:	01 c6                	add    %eax,%esi
80103ad5:	56                   	push   %esi
80103ad6:	50                   	push   %eax
80103ad7:	ff 73 04             	push   0x4(%ebx)
80103ada:	e8 d1 33 00 00       	call   80106eb0 <deallocuvm>
80103adf:	83 c4 10             	add    $0x10,%esp
80103ae2:	85 c0                	test   %eax,%eax
80103ae4:	75 af                	jne    80103a95 <growproc+0x25>
80103ae6:	eb de                	jmp    80103ac6 <growproc+0x56>
80103ae8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aef:	90                   	nop

80103af0 <fork>:
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	57                   	push   %edi
80103af4:	56                   	push   %esi
80103af5:	53                   	push   %ebx
80103af6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103af9:	e8 72 0a 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103afe:	e8 cd fd ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103b03:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b09:	e8 92 0b 00 00       	call   801046a0 <popcli>
  if((np = allocproc()) == 0){
80103b0e:	e8 6d fc ff ff       	call   80103780 <allocproc>
80103b13:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b16:	85 c0                	test   %eax,%eax
80103b18:	0f 84 d6 00 00 00    	je     80103bf4 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b1e:	83 ec 08             	sub    $0x8,%esp
80103b21:	ff 33                	push   (%ebx)
80103b23:	89 c7                	mov    %eax,%edi
80103b25:	ff 73 04             	push   0x4(%ebx)
80103b28:	e8 23 35 00 00       	call   80107050 <copyuvm>
80103b2d:	83 c4 10             	add    $0x10,%esp
80103b30:	89 47 04             	mov    %eax,0x4(%edi)
80103b33:	85 c0                	test   %eax,%eax
80103b35:	0f 84 9a 00 00 00    	je     80103bd5 <fork+0xe5>
  np->sz = curproc->sz;
80103b3b:	8b 03                	mov    (%ebx),%eax
80103b3d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b40:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103b42:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103b45:	89 c8                	mov    %ecx,%eax
80103b47:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103b4a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b4f:	8b 73 18             	mov    0x18(%ebx),%esi
80103b52:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b54:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b56:	8b 40 18             	mov    0x18(%eax),%eax
80103b59:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b60:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b64:	85 c0                	test   %eax,%eax
80103b66:	74 13                	je     80103b7b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b68:	83 ec 0c             	sub    $0xc,%esp
80103b6b:	50                   	push   %eax
80103b6c:	e8 7f d3 ff ff       	call   80100ef0 <filedup>
80103b71:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b74:	83 c4 10             	add    $0x10,%esp
80103b77:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b7b:	83 c6 01             	add    $0x1,%esi
80103b7e:	83 fe 10             	cmp    $0x10,%esi
80103b81:	75 dd                	jne    80103b60 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b83:	83 ec 0c             	sub    $0xc,%esp
80103b86:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b89:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103b8c:	e8 2f dc ff ff       	call   801017c0 <idup>
80103b91:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b94:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103b97:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b9a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b9d:	6a 10                	push   $0x10
80103b9f:	53                   	push   %ebx
80103ba0:	50                   	push   %eax
80103ba1:	e8 5a 0d 00 00       	call   80104900 <safestrcpy>
  pid = np->pid;
80103ba6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103ba9:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103bb0:	e8 0b 0a 00 00       	call   801045c0 <acquire>
  np->state = RUNNABLE;
80103bb5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103bbc:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103bc3:	e8 38 0b 00 00       	call   80104700 <release>
  return pid;
80103bc8:	83 c4 10             	add    $0x10,%esp
}
80103bcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bce:	89 d8                	mov    %ebx,%eax
80103bd0:	5b                   	pop    %ebx
80103bd1:	5e                   	pop    %esi
80103bd2:	5f                   	pop    %edi
80103bd3:	5d                   	pop    %ebp
80103bd4:	c3                   	ret
    kfree(np->kstack);
80103bd5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103bd8:	83 ec 0c             	sub    $0xc,%esp
80103bdb:	ff 73 08             	push   0x8(%ebx)
80103bde:	e8 5d e9 ff ff       	call   80102540 <kfree>
    np->kstack = 0;
80103be3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103bea:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103bed:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103bf4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103bf9:	eb d0                	jmp    80103bcb <fork+0xdb>
80103bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103bff:	90                   	nop

80103c00 <scheduler>:
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	57                   	push   %edi
80103c04:	56                   	push   %esi
80103c05:	53                   	push   %ebx
80103c06:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103c09:	e8 c2 fc ff ff       	call   801038d0 <mycpu>
  c->proc = 0;
80103c0e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c15:	00 00 00 
  struct cpu *c = mycpu();
80103c18:	89 c6                	mov    %eax,%esi
  int ran = 0; // CS 350/550: to solve the 100%-CPU-utilization-when-idling problem
80103c1a:	8d 78 04             	lea    0x4(%eax),%edi
80103c1d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103c20:	fb                   	sti
        acquire(&ptable.lock);
80103c21:	83 ec 0c             	sub    $0xc,%esp
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c24:	bb 34 c7 11 80       	mov    $0x8011c734,%ebx
        acquire(&ptable.lock);
80103c29:	68 00 c7 11 80       	push   $0x8011c700
80103c2e:	e8 8d 09 00 00       	call   801045c0 <acquire>
80103c33:	83 c4 10             	add    $0x10,%esp
        ran = 0;
80103c36:	31 c0                	xor    %eax,%eax
80103c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c3f:	90                   	nop
          if(p->state != RUNNABLE)
80103c40:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103c44:	75 38                	jne    80103c7e <scheduler+0x7e>
          switchuvm(p);
80103c46:	83 ec 0c             	sub    $0xc,%esp
          c->proc = p;
80103c49:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
          switchuvm(p);
80103c4f:	53                   	push   %ebx
80103c50:	e8 db 2e 00 00       	call   80106b30 <switchuvm>
          swtch(&(c->scheduler), p->context);
80103c55:	58                   	pop    %eax
80103c56:	5a                   	pop    %edx
80103c57:	ff 73 1c             	push   0x1c(%ebx)
80103c5a:	57                   	push   %edi
          p->state = RUNNING;
80103c5b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
          swtch(&(c->scheduler), p->context);
80103c62:	e8 f4 0c 00 00       	call   8010495b <swtch>
          switchkvm();
80103c67:	e8 b4 2e 00 00       	call   80106b20 <switchkvm>
          c->proc = 0;
80103c6c:	83 c4 10             	add    $0x10,%esp
          ran = 1;
80103c6f:	b8 01 00 00 00       	mov    $0x1,%eax
          c->proc = 0;
80103c74:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103c7b:	00 00 00 
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c7e:	83 eb 80             	sub    $0xffffff80,%ebx
80103c81:	81 fb 34 e7 11 80    	cmp    $0x8011e734,%ebx
80103c87:	75 b7                	jne    80103c40 <scheduler+0x40>
    release(&ptable.lock);
80103c89:	83 ec 0c             	sub    $0xc,%esp
80103c8c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c8f:	68 00 c7 11 80       	push   $0x8011c700
80103c94:	e8 67 0a 00 00       	call   80104700 <release>
    if (ran == 0){
80103c99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103c9c:	83 c4 10             	add    $0x10,%esp
80103c9f:	85 c0                	test   %eax,%eax
80103ca1:	0f 85 79 ff ff ff    	jne    80103c20 <scheduler+0x20>

// CS 350/550: to solve the 100%-CPU-utilization-when-idling problem - "hlt" instruction puts CPU to sleep
static inline void
halt()
{
    asm volatile("hlt" : : :"memory");
80103ca7:	f4                   	hlt
}
80103ca8:	e9 73 ff ff ff       	jmp    80103c20 <scheduler+0x20>
80103cad:	8d 76 00             	lea    0x0(%esi),%esi

80103cb0 <sched>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
  pushcli();
80103cb5:	e8 b6 08 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103cba:	e8 11 fc ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103cbf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cc5:	e8 d6 09 00 00       	call   801046a0 <popcli>
  if(!holding(&ptable.lock))
80103cca:	83 ec 0c             	sub    $0xc,%esp
80103ccd:	68 00 c7 11 80       	push   $0x8011c700
80103cd2:	e8 59 08 00 00       	call   80104530 <holding>
80103cd7:	83 c4 10             	add    $0x10,%esp
80103cda:	85 c0                	test   %eax,%eax
80103cdc:	74 4f                	je     80103d2d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103cde:	e8 ed fb ff ff       	call   801038d0 <mycpu>
80103ce3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cea:	75 68                	jne    80103d54 <sched+0xa4>
  if(p->state == RUNNING)
80103cec:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103cf0:	74 55                	je     80103d47 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103cf2:	9c                   	pushf
80103cf3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103cf4:	f6 c4 02             	test   $0x2,%ah
80103cf7:	75 41                	jne    80103d3a <sched+0x8a>
  intena = mycpu()->intena;
80103cf9:	e8 d2 fb ff ff       	call   801038d0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cfe:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103d01:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103d07:	e8 c4 fb ff ff       	call   801038d0 <mycpu>
80103d0c:	83 ec 08             	sub    $0x8,%esp
80103d0f:	ff 70 04             	push   0x4(%eax)
80103d12:	53                   	push   %ebx
80103d13:	e8 43 0c 00 00       	call   8010495b <swtch>
  mycpu()->intena = intena;
80103d18:	e8 b3 fb ff ff       	call   801038d0 <mycpu>
}
80103d1d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103d20:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d26:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d29:	5b                   	pop    %ebx
80103d2a:	5e                   	pop    %esi
80103d2b:	5d                   	pop    %ebp
80103d2c:	c3                   	ret
    panic("sched ptable.lock");
80103d2d:	83 ec 0c             	sub    $0xc,%esp
80103d30:	68 eb 75 10 80       	push   $0x801075eb
80103d35:	e8 46 c6 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103d3a:	83 ec 0c             	sub    $0xc,%esp
80103d3d:	68 17 76 10 80       	push   $0x80107617
80103d42:	e8 39 c6 ff ff       	call   80100380 <panic>
    panic("sched running");
80103d47:	83 ec 0c             	sub    $0xc,%esp
80103d4a:	68 09 76 10 80       	push   $0x80107609
80103d4f:	e8 2c c6 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103d54:	83 ec 0c             	sub    $0xc,%esp
80103d57:	68 fd 75 10 80       	push   $0x801075fd
80103d5c:	e8 1f c6 ff ff       	call   80100380 <panic>
80103d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d6f:	90                   	nop

80103d70 <exit>:
{
80103d70:	55                   	push   %ebp
80103d71:	89 e5                	mov    %esp,%ebp
80103d73:	57                   	push   %edi
80103d74:	56                   	push   %esi
80103d75:	53                   	push   %ebx
80103d76:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103d79:	e8 d2 fb ff ff       	call   80103950 <myproc>
  if(curproc == initproc)
80103d7e:	39 05 34 e7 11 80    	cmp    %eax,0x8011e734
80103d84:	0f 84 fd 00 00 00    	je     80103e87 <exit+0x117>
80103d8a:	89 c3                	mov    %eax,%ebx
80103d8c:	8d 70 28             	lea    0x28(%eax),%esi
80103d8f:	8d 78 68             	lea    0x68(%eax),%edi
80103d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103d98:	8b 06                	mov    (%esi),%eax
80103d9a:	85 c0                	test   %eax,%eax
80103d9c:	74 12                	je     80103db0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103d9e:	83 ec 0c             	sub    $0xc,%esp
80103da1:	50                   	push   %eax
80103da2:	e8 99 d1 ff ff       	call   80100f40 <fileclose>
      curproc->ofile[fd] = 0;
80103da7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103dad:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103db0:	83 c6 04             	add    $0x4,%esi
80103db3:	39 f7                	cmp    %esi,%edi
80103db5:	75 e1                	jne    80103d98 <exit+0x28>
  begin_op();
80103db7:	e8 64 ef ff ff       	call   80102d20 <begin_op>
  iput(curproc->cwd);
80103dbc:	83 ec 0c             	sub    $0xc,%esp
80103dbf:	ff 73 68             	push   0x68(%ebx)
80103dc2:	e8 59 db ff ff       	call   80101920 <iput>
  end_op();
80103dc7:	e8 c4 ef ff ff       	call   80102d90 <end_op>
  curproc->cwd = 0;
80103dcc:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103dd3:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103dda:	e8 e1 07 00 00       	call   801045c0 <acquire>
  wakeup1(curproc->parent);
80103ddf:	8b 53 14             	mov    0x14(%ebx),%edx
80103de2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103de5:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
80103dea:	eb 0e                	jmp    80103dfa <exit+0x8a>
80103dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103df0:	83 e8 80             	sub    $0xffffff80,%eax
80103df3:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80103df8:	74 1c                	je     80103e16 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103dfa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dfe:	75 f0                	jne    80103df0 <exit+0x80>
80103e00:	3b 50 20             	cmp    0x20(%eax),%edx
80103e03:	75 eb                	jne    80103df0 <exit+0x80>
      p->state = RUNNABLE;
80103e05:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e0c:	83 e8 80             	sub    $0xffffff80,%eax
80103e0f:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80103e14:	75 e4                	jne    80103dfa <exit+0x8a>
      p->parent = initproc;
80103e16:	8b 0d 34 e7 11 80    	mov    0x8011e734,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e1c:	ba 34 c7 11 80       	mov    $0x8011c734,%edx
80103e21:	eb 10                	jmp    80103e33 <exit+0xc3>
80103e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e27:	90                   	nop
80103e28:	83 ea 80             	sub    $0xffffff80,%edx
80103e2b:	81 fa 34 e7 11 80    	cmp    $0x8011e734,%edx
80103e31:	74 3b                	je     80103e6e <exit+0xfe>
    if(p->parent == curproc){
80103e33:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103e36:	75 f0                	jne    80103e28 <exit+0xb8>
      if(p->state == ZOMBIE)
80103e38:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103e3c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103e3f:	75 e7                	jne    80103e28 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e41:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
80103e46:	eb 12                	jmp    80103e5a <exit+0xea>
80103e48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e4f:	90                   	nop
80103e50:	83 e8 80             	sub    $0xffffff80,%eax
80103e53:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80103e58:	74 ce                	je     80103e28 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103e5a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103e5e:	75 f0                	jne    80103e50 <exit+0xe0>
80103e60:	3b 48 20             	cmp    0x20(%eax),%ecx
80103e63:	75 eb                	jne    80103e50 <exit+0xe0>
      p->state = RUNNABLE;
80103e65:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103e6c:	eb e2                	jmp    80103e50 <exit+0xe0>
  curproc->state = ZOMBIE;
80103e6e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103e75:	e8 36 fe ff ff       	call   80103cb0 <sched>
  panic("zombie exit");
80103e7a:	83 ec 0c             	sub    $0xc,%esp
80103e7d:	68 38 76 10 80       	push   $0x80107638
80103e82:	e8 f9 c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103e87:	83 ec 0c             	sub    $0xc,%esp
80103e8a:	68 2b 76 10 80       	push   $0x8010762b
80103e8f:	e8 ec c4 ff ff       	call   80100380 <panic>
80103e94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e9f:	90                   	nop

80103ea0 <wait>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	56                   	push   %esi
80103ea4:	53                   	push   %ebx
  pushcli();
80103ea5:	e8 c6 06 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103eaa:	e8 21 fa ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103eaf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103eb5:	e8 e6 07 00 00       	call   801046a0 <popcli>
  acquire(&ptable.lock);
80103eba:	83 ec 0c             	sub    $0xc,%esp
80103ebd:	68 00 c7 11 80       	push   $0x8011c700
80103ec2:	e8 f9 06 00 00       	call   801045c0 <acquire>
80103ec7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103eca:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ecc:	bb 34 c7 11 80       	mov    $0x8011c734,%ebx
80103ed1:	eb 10                	jmp    80103ee3 <wait+0x43>
80103ed3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ed7:	90                   	nop
80103ed8:	83 eb 80             	sub    $0xffffff80,%ebx
80103edb:	81 fb 34 e7 11 80    	cmp    $0x8011e734,%ebx
80103ee1:	74 1b                	je     80103efe <wait+0x5e>
      if(p->parent != curproc)
80103ee3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103ee6:	75 f0                	jne    80103ed8 <wait+0x38>
      if(p->state == ZOMBIE){
80103ee8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103eec:	74 62                	je     80103f50 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eee:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80103ef1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ef6:	81 fb 34 e7 11 80    	cmp    $0x8011e734,%ebx
80103efc:	75 e5                	jne    80103ee3 <wait+0x43>
    if(!havekids || curproc->killed){
80103efe:	85 c0                	test   %eax,%eax
80103f00:	0f 84 a0 00 00 00    	je     80103fa6 <wait+0x106>
80103f06:	8b 46 24             	mov    0x24(%esi),%eax
80103f09:	85 c0                	test   %eax,%eax
80103f0b:	0f 85 95 00 00 00    	jne    80103fa6 <wait+0x106>
  pushcli();
80103f11:	e8 5a 06 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103f16:	e8 b5 f9 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103f1b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f21:	e8 7a 07 00 00       	call   801046a0 <popcli>
  if(p == 0)
80103f26:	85 db                	test   %ebx,%ebx
80103f28:	0f 84 8f 00 00 00    	je     80103fbd <wait+0x11d>
  p->chan = chan;
80103f2e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103f31:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103f38:	e8 73 fd ff ff       	call   80103cb0 <sched>
  p->chan = 0;
80103f3d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103f44:	eb 84                	jmp    80103eca <wait+0x2a>
80103f46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f4d:	8d 76 00             	lea    0x0(%esi),%esi
        kfree(p->kstack);
80103f50:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103f53:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f56:	ff 73 08             	push   0x8(%ebx)
80103f59:	e8 e2 e5 ff ff       	call   80102540 <kfree>
        p->kstack = 0;
80103f5e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f65:	5a                   	pop    %edx
80103f66:	ff 73 04             	push   0x4(%ebx)
80103f69:	e8 72 2f 00 00       	call   80106ee0 <freevm>
        p->pid = 0;
80103f6e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f75:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f7c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f80:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f87:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f8e:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80103f95:	e8 66 07 00 00       	call   80104700 <release>
        return pid;
80103f9a:	83 c4 10             	add    $0x10,%esp
}
80103f9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fa0:	89 f0                	mov    %esi,%eax
80103fa2:	5b                   	pop    %ebx
80103fa3:	5e                   	pop    %esi
80103fa4:	5d                   	pop    %ebp
80103fa5:	c3                   	ret
      release(&ptable.lock);
80103fa6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103fa9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103fae:	68 00 c7 11 80       	push   $0x8011c700
80103fb3:	e8 48 07 00 00       	call   80104700 <release>
      return -1;
80103fb8:	83 c4 10             	add    $0x10,%esp
80103fbb:	eb e0                	jmp    80103f9d <wait+0xfd>
    panic("sleep");
80103fbd:	83 ec 0c             	sub    $0xc,%esp
80103fc0:	68 44 76 10 80       	push   $0x80107644
80103fc5:	e8 b6 c3 ff ff       	call   80100380 <panic>
80103fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fd0 <yield>:
{   
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	53                   	push   %ebx
80103fd4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fd7:	68 00 c7 11 80       	push   $0x8011c700
80103fdc:	e8 df 05 00 00       	call   801045c0 <acquire>
  pushcli();
80103fe1:	e8 8a 05 00 00       	call   80104570 <pushcli>
  c = mycpu();
80103fe6:	e8 e5 f8 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80103feb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ff1:	e8 aa 06 00 00       	call   801046a0 <popcli>
  myproc()->state = RUNNABLE;
80103ff6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103ffd:	e8 ae fc ff ff       	call   80103cb0 <sched>
  release(&ptable.lock);
80104002:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
80104009:	e8 f2 06 00 00       	call   80104700 <release>
}
8010400e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104011:	83 c4 10             	add    $0x10,%esp
80104014:	c9                   	leave
80104015:	c3                   	ret
80104016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010401d:	8d 76 00             	lea    0x0(%esi),%esi

80104020 <sleep>:
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	57                   	push   %edi
80104024:	56                   	push   %esi
80104025:	53                   	push   %ebx
80104026:	83 ec 0c             	sub    $0xc,%esp
80104029:	8b 7d 08             	mov    0x8(%ebp),%edi
8010402c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010402f:	e8 3c 05 00 00       	call   80104570 <pushcli>
  c = mycpu();
80104034:	e8 97 f8 ff ff       	call   801038d0 <mycpu>
  p = c->proc;
80104039:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010403f:	e8 5c 06 00 00       	call   801046a0 <popcli>
  if(p == 0)
80104044:	85 db                	test   %ebx,%ebx
80104046:	0f 84 87 00 00 00    	je     801040d3 <sleep+0xb3>
  if(lk == 0)
8010404c:	85 f6                	test   %esi,%esi
8010404e:	74 76                	je     801040c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104050:	81 fe 00 c7 11 80    	cmp    $0x8011c700,%esi
80104056:	74 50                	je     801040a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104058:	83 ec 0c             	sub    $0xc,%esp
8010405b:	68 00 c7 11 80       	push   $0x8011c700
80104060:	e8 5b 05 00 00       	call   801045c0 <acquire>
    release(lk);
80104065:	89 34 24             	mov    %esi,(%esp)
80104068:	e8 93 06 00 00       	call   80104700 <release>
  p->chan = chan;
8010406d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104070:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104077:	e8 34 fc ff ff       	call   80103cb0 <sched>
  p->chan = 0;
8010407c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104083:	c7 04 24 00 c7 11 80 	movl   $0x8011c700,(%esp)
8010408a:	e8 71 06 00 00       	call   80104700 <release>
    acquire(lk);
8010408f:	89 75 08             	mov    %esi,0x8(%ebp)
80104092:	83 c4 10             	add    $0x10,%esp
}
80104095:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104098:	5b                   	pop    %ebx
80104099:	5e                   	pop    %esi
8010409a:	5f                   	pop    %edi
8010409b:	5d                   	pop    %ebp
    acquire(lk);
8010409c:	e9 1f 05 00 00       	jmp    801045c0 <acquire>
801040a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
801040a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801040ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801040b2:	e8 f9 fb ff ff       	call   80103cb0 <sched>
  p->chan = 0;
801040b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801040be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040c1:	5b                   	pop    %ebx
801040c2:	5e                   	pop    %esi
801040c3:	5f                   	pop    %edi
801040c4:	5d                   	pop    %ebp
801040c5:	c3                   	ret
    panic("sleep without lk");
801040c6:	83 ec 0c             	sub    $0xc,%esp
801040c9:	68 4a 76 10 80       	push   $0x8010764a
801040ce:	e8 ad c2 ff ff       	call   80100380 <panic>
    panic("sleep");
801040d3:	83 ec 0c             	sub    $0xc,%esp
801040d6:	68 44 76 10 80       	push   $0x80107644
801040db:	e8 a0 c2 ff ff       	call   80100380 <panic>

801040e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	53                   	push   %ebx
801040e4:	83 ec 10             	sub    $0x10,%esp
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ea:	68 00 c7 11 80       	push   $0x8011c700
801040ef:	e8 cc 04 00 00       	call   801045c0 <acquire>
801040f4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040f7:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
801040fc:	eb 0c                	jmp    8010410a <wakeup+0x2a>
801040fe:	66 90                	xchg   %ax,%ax
80104100:	83 e8 80             	sub    $0xffffff80,%eax
80104103:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80104108:	74 1c                	je     80104126 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010410a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010410e:	75 f0                	jne    80104100 <wakeup+0x20>
80104110:	3b 58 20             	cmp    0x20(%eax),%ebx
80104113:	75 eb                	jne    80104100 <wakeup+0x20>
      p->state = RUNNABLE;
80104115:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010411c:	83 e8 80             	sub    $0xffffff80,%eax
8010411f:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80104124:	75 e4                	jne    8010410a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104126:	c7 45 08 00 c7 11 80 	movl   $0x8011c700,0x8(%ebp)
}
8010412d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104130:	c9                   	leave
  release(&ptable.lock);
80104131:	e9 ca 05 00 00       	jmp    80104700 <release>
80104136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010413d:	8d 76 00             	lea    0x0(%esi),%esi

80104140 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	53                   	push   %ebx
80104144:	83 ec 10             	sub    $0x10,%esp
80104147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010414a:	68 00 c7 11 80       	push   $0x8011c700
8010414f:	e8 6c 04 00 00       	call   801045c0 <acquire>
80104154:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104157:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
8010415c:	eb 0c                	jmp    8010416a <kill+0x2a>
8010415e:	66 90                	xchg   %ax,%ax
80104160:	83 e8 80             	sub    $0xffffff80,%eax
80104163:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80104168:	74 36                	je     801041a0 <kill+0x60>
    if(p->pid == pid){
8010416a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010416d:	75 f1                	jne    80104160 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010416f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104173:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010417a:	75 07                	jne    80104183 <kill+0x43>
        p->state = RUNNABLE;
8010417c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104183:	83 ec 0c             	sub    $0xc,%esp
80104186:	68 00 c7 11 80       	push   $0x8011c700
8010418b:	e8 70 05 00 00       	call   80104700 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104190:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104193:	83 c4 10             	add    $0x10,%esp
80104196:	31 c0                	xor    %eax,%eax
}
80104198:	c9                   	leave
80104199:	c3                   	ret
8010419a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
801041a0:	83 ec 0c             	sub    $0xc,%esp
801041a3:	68 00 c7 11 80       	push   $0x8011c700
801041a8:	e8 53 05 00 00       	call   80104700 <release>
}
801041ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801041b0:	83 c4 10             	add    $0x10,%esp
801041b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041b8:	c9                   	leave
801041b9:	c3                   	ret
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041c0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	57                   	push   %edi
801041c4:	56                   	push   %esi
801041c5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801041c8:	53                   	push   %ebx
801041c9:	bb a0 c7 11 80       	mov    $0x8011c7a0,%ebx
801041ce:	83 ec 3c             	sub    $0x3c,%esp
801041d1:	eb 24                	jmp    801041f7 <procdump+0x37>
801041d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041d7:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801041d8:	83 ec 0c             	sub    $0xc,%esp
801041db:	68 43 7a 10 80       	push   $0x80107a43
801041e0:	e8 cb c4 ff ff       	call   801006b0 <cprintf>
801041e5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e8:	83 eb 80             	sub    $0xffffff80,%ebx
801041eb:	81 fb a0 e7 11 80    	cmp    $0x8011e7a0,%ebx
801041f1:	0f 84 81 00 00 00    	je     80104278 <procdump+0xb8>
    if(p->state == UNUSED)
801041f7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041fa:	85 c0                	test   %eax,%eax
801041fc:	74 ea                	je     801041e8 <procdump+0x28>
      state = "???";
801041fe:	ba 5b 76 10 80       	mov    $0x8010765b,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104203:	83 f8 05             	cmp    $0x5,%eax
80104206:	77 11                	ja     80104219 <procdump+0x59>
80104208:	8b 14 85 2c 77 10 80 	mov    -0x7fef88d4(,%eax,4),%edx
      state = "???";
8010420f:	b8 5b 76 10 80       	mov    $0x8010765b,%eax
80104214:	85 d2                	test   %edx,%edx
80104216:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104219:	53                   	push   %ebx
8010421a:	52                   	push   %edx
8010421b:	ff 73 a4             	push   -0x5c(%ebx)
8010421e:	68 5f 76 10 80       	push   $0x8010765f
80104223:	e8 88 c4 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104228:	83 c4 10             	add    $0x10,%esp
8010422b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010422f:	75 a7                	jne    801041d8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104231:	83 ec 08             	sub    $0x8,%esp
80104234:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104237:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010423a:	50                   	push   %eax
8010423b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010423e:	8b 40 0c             	mov    0xc(%eax),%eax
80104241:	83 c0 08             	add    $0x8,%eax
80104244:	50                   	push   %eax
80104245:	e8 76 02 00 00       	call   801044c0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010424a:	83 c4 10             	add    $0x10,%esp
8010424d:	8d 76 00             	lea    0x0(%esi),%esi
80104250:	8b 17                	mov    (%edi),%edx
80104252:	85 d2                	test   %edx,%edx
80104254:	74 82                	je     801041d8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104256:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104259:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010425c:	52                   	push   %edx
8010425d:	68 e1 72 10 80       	push   $0x801072e1
80104262:	e8 49 c4 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104267:	83 c4 10             	add    $0x10,%esp
8010426a:	39 f7                	cmp    %esi,%edi
8010426c:	75 e2                	jne    80104250 <procdump+0x90>
8010426e:	e9 65 ff ff ff       	jmp    801041d8 <procdump+0x18>
80104273:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104277:	90                   	nop
  }
}
80104278:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010427b:	5b                   	pop    %ebx
8010427c:	5e                   	pop    %esi
8010427d:	5f                   	pop    %edi
8010427e:	5d                   	pop    %ebp
8010427f:	c3                   	ret

80104280 <cps>:


int
cps()
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	53                   	push   %ebx
80104284:	83 ec 10             	sub    $0x10,%esp
  asm volatile("sti");
80104287:	fb                   	sti
struct proc *p;
//Enables interrupts on this processor.
sti();

//Loop over process table looking for process with pid.
acquire(&ptable.lock);
80104288:	68 00 c7 11 80       	push   $0x8011c700
8010428d:	bb a0 c7 11 80       	mov    $0x8011c7a0,%ebx
80104292:	e8 29 03 00 00       	call   801045c0 <acquire>
cprintf("name \t pid \t state \t priority \n");
80104297:	c7 04 24 0c 77 10 80 	movl   $0x8010770c,(%esp)
8010429e:	e8 0d c4 ff ff       	call   801006b0 <cprintf>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042a3:	83 c4 10             	add    $0x10,%esp
801042a6:	eb 1d                	jmp    801042c5 <cps+0x45>
801042a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042af:	90                   	nop
  if(p->state == SLEEPING)
	  cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name,p->pid,p->priority);
	else if(p->state == RUNNING)
801042b0:	83 f8 04             	cmp    $0x4,%eax
801042b3:	74 53                	je     80104308 <cps+0x88>
 	  cprintf("%s \t %d \t RUNNING \t %d \n ", p->name,p->pid,p->priority);
	else if(p->state == RUNNABLE)
801042b5:	83 f8 03             	cmp    $0x3,%eax
801042b8:	74 66                	je     80104320 <cps+0xa0>
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042ba:	83 eb 80             	sub    $0xffffff80,%ebx
801042bd:	81 fb a0 e7 11 80    	cmp    $0x8011e7a0,%ebx
801042c3:	74 27                	je     801042ec <cps+0x6c>
  if(p->state == SLEEPING)
801042c5:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042c8:	83 f8 02             	cmp    $0x2,%eax
801042cb:	75 e3                	jne    801042b0 <cps+0x30>
	  cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name,p->pid,p->priority);
801042cd:	ff 73 10             	push   0x10(%ebx)
801042d0:	ff 73 a4             	push   -0x5c(%ebx)
801042d3:	53                   	push   %ebx
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042d4:	83 eb 80             	sub    $0xffffff80,%ebx
	  cprintf("%s \t %d \t SLEEPING \t %d \n ", p->name,p->pid,p->priority);
801042d7:	68 68 76 10 80       	push   $0x80107668
801042dc:	e8 cf c3 ff ff       	call   801006b0 <cprintf>
801042e1:	83 c4 10             	add    $0x10,%esp
for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e4:	81 fb a0 e7 11 80    	cmp    $0x8011e7a0,%ebx
801042ea:	75 d9                	jne    801042c5 <cps+0x45>
 	  cprintf("%s \t %d \t RUNNABLE \t %d \n ", p->name,p->pid,p->priority);
}
release(&ptable.lock);
801042ec:	83 ec 0c             	sub    $0xc,%esp
801042ef:	68 00 c7 11 80       	push   $0x8011c700
801042f4:	e8 07 04 00 00       	call   80104700 <release>
return 22;
}
801042f9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042fc:	b8 16 00 00 00       	mov    $0x16,%eax
80104301:	c9                   	leave
80104302:	c3                   	ret
80104303:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104307:	90                   	nop
 	  cprintf("%s \t %d \t RUNNING \t %d \n ", p->name,p->pid,p->priority);
80104308:	ff 73 10             	push   0x10(%ebx)
8010430b:	ff 73 a4             	push   -0x5c(%ebx)
8010430e:	53                   	push   %ebx
8010430f:	68 83 76 10 80       	push   $0x80107683
80104314:	e8 97 c3 ff ff       	call   801006b0 <cprintf>
80104319:	83 c4 10             	add    $0x10,%esp
8010431c:	eb 9c                	jmp    801042ba <cps+0x3a>
8010431e:	66 90                	xchg   %ax,%ax
 	  cprintf("%s \t %d \t RUNNABLE \t %d \n ", p->name,p->pid,p->priority);
80104320:	ff 73 10             	push   0x10(%ebx)
80104323:	ff 73 a4             	push   -0x5c(%ebx)
80104326:	53                   	push   %ebx
80104327:	68 9d 76 10 80       	push   $0x8010769d
8010432c:	e8 7f c3 ff ff       	call   801006b0 <cprintf>
80104331:	83 c4 10             	add    $0x10,%esp
80104334:	eb 84                	jmp    801042ba <cps+0x3a>
80104336:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010433d:	8d 76 00             	lea    0x0(%esi),%esi

80104340 <chpr>:

int
chpr(int pid, int priority)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 10             	sub    $0x10,%esp
80104347:	8b 5d 08             	mov    0x8(%ebp),%ebx
	struct proc *p;
	acquire(&ptable.lock);
8010434a:	68 00 c7 11 80       	push   $0x8011c700
8010434f:	e8 6c 02 00 00       	call   801045c0 <acquire>
80104354:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104357:	b8 34 c7 11 80       	mov    $0x8011c734,%eax
8010435c:	eb 0c                	jmp    8010436a <chpr+0x2a>
8010435e:	66 90                	xchg   %ax,%ax
80104360:	83 e8 80             	sub    $0xffffff80,%eax
80104363:	3d 34 e7 11 80       	cmp    $0x8011e734,%eax
80104368:	74 0b                	je     80104375 <chpr+0x35>
	  if(p->pid == pid){
8010436a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010436d:	75 f1                	jne    80104360 <chpr+0x20>
			p->priority = priority;
8010436f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104372:	89 50 7c             	mov    %edx,0x7c(%eax)
			break;
		}
	}
	release(&ptable.lock);
80104375:	83 ec 0c             	sub    $0xc,%esp
80104378:	68 00 c7 11 80       	push   $0x8011c700
8010437d:	e8 7e 03 00 00       	call   80104700 <release>
	return pid;
}
80104382:	89 d8                	mov    %ebx,%eax
80104384:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104387:	c9                   	leave
80104388:	c3                   	ret
80104389:	66 90                	xchg   %ax,%ax
8010438b:	66 90                	xchg   %ax,%ax
8010438d:	66 90                	xchg   %ax,%ax
8010438f:	90                   	nop

80104390 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	53                   	push   %ebx
80104394:	83 ec 0c             	sub    $0xc,%esp
80104397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010439a:	68 44 77 10 80       	push   $0x80107744
8010439f:	8d 43 04             	lea    0x4(%ebx),%eax
801043a2:	50                   	push   %eax
801043a3:	e8 f8 00 00 00       	call   801044a0 <initlock>
  lk->name = name;
801043a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801043ab:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801043b1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801043b4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801043bb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801043be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043c1:	c9                   	leave
801043c2:	c3                   	ret
801043c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043d0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	56                   	push   %esi
801043d4:	53                   	push   %ebx
801043d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043d8:	8d 73 04             	lea    0x4(%ebx),%esi
801043db:	83 ec 0c             	sub    $0xc,%esp
801043de:	56                   	push   %esi
801043df:	e8 dc 01 00 00       	call   801045c0 <acquire>
  while (lk->locked) {
801043e4:	8b 13                	mov    (%ebx),%edx
801043e6:	83 c4 10             	add    $0x10,%esp
801043e9:	85 d2                	test   %edx,%edx
801043eb:	74 16                	je     80104403 <acquiresleep+0x33>
801043ed:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801043f0:	83 ec 08             	sub    $0x8,%esp
801043f3:	56                   	push   %esi
801043f4:	53                   	push   %ebx
801043f5:	e8 26 fc ff ff       	call   80104020 <sleep>
  while (lk->locked) {
801043fa:	8b 03                	mov    (%ebx),%eax
801043fc:	83 c4 10             	add    $0x10,%esp
801043ff:	85 c0                	test   %eax,%eax
80104401:	75 ed                	jne    801043f0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104403:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104409:	e8 42 f5 ff ff       	call   80103950 <myproc>
8010440e:	8b 40 10             	mov    0x10(%eax),%eax
80104411:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104414:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104417:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010441a:	5b                   	pop    %ebx
8010441b:	5e                   	pop    %esi
8010441c:	5d                   	pop    %ebp
  release(&lk->lk);
8010441d:	e9 de 02 00 00       	jmp    80104700 <release>
80104422:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104430 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	56                   	push   %esi
80104434:	53                   	push   %ebx
80104435:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104438:	8d 73 04             	lea    0x4(%ebx),%esi
8010443b:	83 ec 0c             	sub    $0xc,%esp
8010443e:	56                   	push   %esi
8010443f:	e8 7c 01 00 00       	call   801045c0 <acquire>
  lk->locked = 0;
80104444:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010444a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104451:	89 1c 24             	mov    %ebx,(%esp)
80104454:	e8 87 fc ff ff       	call   801040e0 <wakeup>
  release(&lk->lk);
80104459:	89 75 08             	mov    %esi,0x8(%ebp)
8010445c:	83 c4 10             	add    $0x10,%esp
}
8010445f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104462:	5b                   	pop    %ebx
80104463:	5e                   	pop    %esi
80104464:	5d                   	pop    %ebp
  release(&lk->lk);
80104465:	e9 96 02 00 00       	jmp    80104700 <release>
8010446a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104470 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	56                   	push   %esi
80104474:	53                   	push   %ebx
80104475:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104478:	8d 5e 04             	lea    0x4(%esi),%ebx
8010447b:	83 ec 0c             	sub    $0xc,%esp
8010447e:	53                   	push   %ebx
8010447f:	e8 3c 01 00 00       	call   801045c0 <acquire>
  r = lk->locked;
80104484:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104486:	89 1c 24             	mov    %ebx,(%esp)
80104489:	e8 72 02 00 00       	call   80104700 <release>
  return r;
}
8010448e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104491:	89 f0                	mov    %esi,%eax
80104493:	5b                   	pop    %ebx
80104494:	5e                   	pop    %esi
80104495:	5d                   	pop    %ebp
80104496:	c3                   	ret
80104497:	66 90                	xchg   %ax,%ax
80104499:	66 90                	xchg   %ax,%ax
8010449b:	66 90                	xchg   %ax,%ax
8010449d:	66 90                	xchg   %ax,%ax
8010449f:	90                   	nop

801044a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801044a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801044a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801044af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801044b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801044b9:	5d                   	pop    %ebp
801044ba:	c3                   	ret
801044bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044bf:	90                   	nop

801044c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	53                   	push   %ebx
801044c4:	8b 45 08             	mov    0x8(%ebp),%eax
801044c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044ca:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044cd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801044d2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
801044d7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044dc:	76 10                	jbe    801044ee <getcallerpcs+0x2e>
801044de:	eb 28                	jmp    80104508 <getcallerpcs+0x48>
801044e0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044e6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044ec:	77 1a                	ja     80104508 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044ee:	8b 5a 04             	mov    0x4(%edx),%ebx
801044f1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801044f4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801044f7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801044f9:	83 f8 0a             	cmp    $0xa,%eax
801044fc:	75 e2                	jne    801044e0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801044fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104501:	c9                   	leave
80104502:	c3                   	ret
80104503:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104507:	90                   	nop
80104508:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010450b:	8d 51 28             	lea    0x28(%ecx),%edx
8010450e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104510:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104516:	83 c0 04             	add    $0x4,%eax
80104519:	39 d0                	cmp    %edx,%eax
8010451b:	75 f3                	jne    80104510 <getcallerpcs+0x50>
}
8010451d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104520:	c9                   	leave
80104521:	c3                   	ret
80104522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104530 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
80104533:	53                   	push   %ebx
80104534:	83 ec 04             	sub    $0x4,%esp
80104537:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
8010453a:	8b 02                	mov    (%edx),%eax
8010453c:	85 c0                	test   %eax,%eax
8010453e:	75 10                	jne    80104550 <holding+0x20>
}
80104540:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104543:	31 c0                	xor    %eax,%eax
80104545:	c9                   	leave
80104546:	c3                   	ret
80104547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010454e:	66 90                	xchg   %ax,%ax
  return lock->locked && lock->cpu == mycpu();
80104550:	8b 5a 08             	mov    0x8(%edx),%ebx
80104553:	e8 78 f3 ff ff       	call   801038d0 <mycpu>
80104558:	39 c3                	cmp    %eax,%ebx
}
8010455a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010455d:	c9                   	leave
  return lock->locked && lock->cpu == mycpu();
8010455e:	0f 94 c0             	sete   %al
80104561:	0f b6 c0             	movzbl %al,%eax
}
80104564:	c3                   	ret
80104565:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104570 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	53                   	push   %ebx
80104574:	83 ec 04             	sub    $0x4,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104577:	9c                   	pushf
80104578:	5b                   	pop    %ebx
  asm volatile("cli");
80104579:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010457a:	e8 51 f3 ff ff       	call   801038d0 <mycpu>
8010457f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104585:	85 c0                	test   %eax,%eax
80104587:	74 17                	je     801045a0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104589:	e8 42 f3 ff ff       	call   801038d0 <mycpu>
8010458e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104595:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104598:	c9                   	leave
80104599:	c3                   	ret
8010459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801045a0:	e8 2b f3 ff ff       	call   801038d0 <mycpu>
801045a5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801045ab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801045b1:	eb d6                	jmp    80104589 <pushcli+0x19>
801045b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045c0 <acquire>:
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	53                   	push   %ebx
801045c4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801045c7:	e8 a4 ff ff ff       	call   80104570 <pushcli>
  if(holding(lk))
801045cc:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
801045cf:	8b 02                	mov    (%edx),%eax
801045d1:	85 c0                	test   %eax,%eax
801045d3:	0f 85 9f 00 00 00    	jne    80104678 <acquire+0xb8>
  asm volatile("lock; xchgl %0, %1" :
801045d9:	b8 01 00 00 00       	mov    $0x1,%eax
801045de:	f0 87 02             	lock xchg %eax,(%edx)
801045e1:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
801045e6:	85 c0                	test   %eax,%eax
801045e8:	74 12                	je     801045fc <acquire+0x3c>
801045ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045f0:	8b 55 08             	mov    0x8(%ebp),%edx
801045f3:	89 c8                	mov    %ecx,%eax
801045f5:	f0 87 02             	lock xchg %eax,(%edx)
801045f8:	85 c0                	test   %eax,%eax
801045fa:	75 f4                	jne    801045f0 <acquire+0x30>
  __sync_synchronize();
801045fc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104601:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104604:	e8 c7 f2 ff ff       	call   801038d0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104609:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010460c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010460e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104611:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104617:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010461c:	77 32                	ja     80104650 <acquire+0x90>
  ebp = (uint*)v - 2;
8010461e:	89 e8                	mov    %ebp,%eax
80104620:	eb 14                	jmp    80104636 <acquire+0x76>
80104622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104628:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010462e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104634:	77 1a                	ja     80104650 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104636:	8b 58 04             	mov    0x4(%eax),%ebx
80104639:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010463d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104640:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104642:	83 fa 0a             	cmp    $0xa,%edx
80104645:	75 e1                	jne    80104628 <acquire+0x68>
}
80104647:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010464a:	c9                   	leave
8010464b:	c3                   	ret
8010464c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104650:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104654:	8d 51 34             	lea    0x34(%ecx),%edx
80104657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010465e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104660:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104666:	83 c0 04             	add    $0x4,%eax
80104669:	39 d0                	cmp    %edx,%eax
8010466b:	75 f3                	jne    80104660 <acquire+0xa0>
}
8010466d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104670:	c9                   	leave
80104671:	c3                   	ret
80104672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return lock->locked && lock->cpu == mycpu();
80104678:	8b 5a 08             	mov    0x8(%edx),%ebx
8010467b:	e8 50 f2 ff ff       	call   801038d0 <mycpu>
80104680:	39 c3                	cmp    %eax,%ebx
80104682:	74 0c                	je     80104690 <acquire+0xd0>
  while(xchg(&lk->locked, 1) != 0)
80104684:	8b 55 08             	mov    0x8(%ebp),%edx
80104687:	e9 4d ff ff ff       	jmp    801045d9 <acquire+0x19>
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("acquire");
80104690:	83 ec 0c             	sub    $0xc,%esp
80104693:	68 4f 77 10 80       	push   $0x8010774f
80104698:	e8 e3 bc ff ff       	call   80100380 <panic>
8010469d:	8d 76 00             	lea    0x0(%esi),%esi

801046a0 <popcli>:

void
popcli(void)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046a6:	9c                   	pushf
801046a7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046a8:	f6 c4 02             	test   $0x2,%ah
801046ab:	75 35                	jne    801046e2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801046ad:	e8 1e f2 ff ff       	call   801038d0 <mycpu>
801046b2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801046b9:	78 34                	js     801046ef <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046bb:	e8 10 f2 ff ff       	call   801038d0 <mycpu>
801046c0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801046c6:	85 d2                	test   %edx,%edx
801046c8:	74 06                	je     801046d0 <popcli+0x30>
    sti();
}
801046ca:	c9                   	leave
801046cb:	c3                   	ret
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046d0:	e8 fb f1 ff ff       	call   801038d0 <mycpu>
801046d5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046db:	85 c0                	test   %eax,%eax
801046dd:	74 eb                	je     801046ca <popcli+0x2a>
  asm volatile("sti");
801046df:	fb                   	sti
}
801046e0:	c9                   	leave
801046e1:	c3                   	ret
    panic("popcli - interruptible");
801046e2:	83 ec 0c             	sub    $0xc,%esp
801046e5:	68 57 77 10 80       	push   $0x80107757
801046ea:	e8 91 bc ff ff       	call   80100380 <panic>
    panic("popcli");
801046ef:	83 ec 0c             	sub    $0xc,%esp
801046f2:	68 6e 77 10 80       	push   $0x8010776e
801046f7:	e8 84 bc ff ff       	call   80100380 <panic>
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104700 <release>:
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
80104705:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104708:	8b 03                	mov    (%ebx),%eax
8010470a:	85 c0                	test   %eax,%eax
8010470c:	75 12                	jne    80104720 <release+0x20>
    panic("release");
8010470e:	83 ec 0c             	sub    $0xc,%esp
80104711:	68 75 77 10 80       	push   $0x80107775
80104716:	e8 65 bc ff ff       	call   80100380 <panic>
8010471b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010471f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104720:	8b 73 08             	mov    0x8(%ebx),%esi
80104723:	e8 a8 f1 ff ff       	call   801038d0 <mycpu>
80104728:	39 c6                	cmp    %eax,%esi
8010472a:	75 e2                	jne    8010470e <release+0xe>
  lk->pcs[0] = 0;
8010472c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104733:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
8010473a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010473f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104745:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
  popcli();
8010474b:	e9 50 ff ff ff       	jmp    801046a0 <popcli>

80104750 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	57                   	push   %edi
80104754:	8b 55 08             	mov    0x8(%ebp),%edx
80104757:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010475a:	89 d0                	mov    %edx,%eax
8010475c:	09 c8                	or     %ecx,%eax
8010475e:	a8 03                	test   $0x3,%al
80104760:	75 1e                	jne    80104780 <memset+0x30>
    c &= 0xFF;
80104762:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104766:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104769:	89 d7                	mov    %edx,%edi
8010476b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104771:	fc                   	cld
80104772:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104774:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104777:	89 d0                	mov    %edx,%eax
80104779:	c9                   	leave
8010477a:	c3                   	ret
8010477b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop
  asm volatile("cld; rep stosb" :
80104780:	8b 45 0c             	mov    0xc(%ebp),%eax
80104783:	89 d7                	mov    %edx,%edi
80104785:	fc                   	cld
80104786:	f3 aa                	rep stos %al,%es:(%edi)
80104788:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010478b:	89 d0                	mov    %edx,%eax
8010478d:	c9                   	leave
8010478e:	c3                   	ret
8010478f:	90                   	nop

80104790 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	56                   	push   %esi
80104794:	53                   	push   %ebx
80104795:	8b 75 10             	mov    0x10(%ebp),%esi
80104798:	8b 55 08             	mov    0x8(%ebp),%edx
8010479b:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010479e:	85 f6                	test   %esi,%esi
801047a0:	74 2e                	je     801047d0 <memcmp+0x40>
801047a2:	01 c6                	add    %eax,%esi
801047a4:	eb 14                	jmp    801047ba <memcmp+0x2a>
801047a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801047b0:	83 c0 01             	add    $0x1,%eax
801047b3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801047b6:	39 f0                	cmp    %esi,%eax
801047b8:	74 16                	je     801047d0 <memcmp+0x40>
    if(*s1 != *s2)
801047ba:	0f b6 0a             	movzbl (%edx),%ecx
801047bd:	0f b6 18             	movzbl (%eax),%ebx
801047c0:	38 d9                	cmp    %bl,%cl
801047c2:	74 ec                	je     801047b0 <memcmp+0x20>
      return *s1 - *s2;
801047c4:	0f b6 c1             	movzbl %cl,%eax
801047c7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801047c9:	5b                   	pop    %ebx
801047ca:	5e                   	pop    %esi
801047cb:	5d                   	pop    %ebp
801047cc:	c3                   	ret
801047cd:	8d 76 00             	lea    0x0(%esi),%esi
801047d0:	5b                   	pop    %ebx
  return 0;
801047d1:	31 c0                	xor    %eax,%eax
}
801047d3:	5e                   	pop    %esi
801047d4:	5d                   	pop    %ebp
801047d5:	c3                   	ret
801047d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047dd:	8d 76 00             	lea    0x0(%esi),%esi

801047e0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	57                   	push   %edi
801047e4:	56                   	push   %esi
801047e5:	8b 55 08             	mov    0x8(%ebp),%edx
801047e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801047eb:	8b 45 10             	mov    0x10(%ebp),%eax
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801047ee:	39 d6                	cmp    %edx,%esi
801047f0:	73 26                	jae    80104818 <memmove+0x38>
801047f2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
801047f5:	39 ca                	cmp    %ecx,%edx
801047f7:	73 1f                	jae    80104818 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801047f9:	85 c0                	test   %eax,%eax
801047fb:	74 0f                	je     8010480c <memmove+0x2c>
801047fd:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104800:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104804:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104807:	83 e8 01             	sub    $0x1,%eax
8010480a:	73 f4                	jae    80104800 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010480c:	5e                   	pop    %esi
8010480d:	89 d0                	mov    %edx,%eax
8010480f:	5f                   	pop    %edi
80104810:	5d                   	pop    %ebp
80104811:	c3                   	ret
80104812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104818:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010481b:	89 d7                	mov    %edx,%edi
8010481d:	85 c0                	test   %eax,%eax
8010481f:	74 eb                	je     8010480c <memmove+0x2c>
80104821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104828:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104829:	39 ce                	cmp    %ecx,%esi
8010482b:	75 fb                	jne    80104828 <memmove+0x48>
}
8010482d:	5e                   	pop    %esi
8010482e:	89 d0                	mov    %edx,%eax
80104830:	5f                   	pop    %edi
80104831:	5d                   	pop    %ebp
80104832:	c3                   	ret
80104833:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104840 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104840:	eb 9e                	jmp    801047e0 <memmove>
80104842:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104850 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	53                   	push   %ebx
80104854:	8b 55 10             	mov    0x10(%ebp),%edx
80104857:	8b 45 08             	mov    0x8(%ebp),%eax
8010485a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010485d:	85 d2                	test   %edx,%edx
8010485f:	75 16                	jne    80104877 <strncmp+0x27>
80104861:	eb 2d                	jmp    80104890 <strncmp+0x40>
80104863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104867:	90                   	nop
80104868:	3a 19                	cmp    (%ecx),%bl
8010486a:	75 12                	jne    8010487e <strncmp+0x2e>
    n--, p++, q++;
8010486c:	83 c0 01             	add    $0x1,%eax
8010486f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104872:	83 ea 01             	sub    $0x1,%edx
80104875:	74 19                	je     80104890 <strncmp+0x40>
80104877:	0f b6 18             	movzbl (%eax),%ebx
8010487a:	84 db                	test   %bl,%bl
8010487c:	75 ea                	jne    80104868 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010487e:	0f b6 00             	movzbl (%eax),%eax
80104881:	0f b6 11             	movzbl (%ecx),%edx
}
80104884:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104887:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104888:	29 d0                	sub    %edx,%eax
}
8010488a:	c3                   	ret
8010488b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010488f:	90                   	nop
80104890:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104893:	31 c0                	xor    %eax,%eax
}
80104895:	c9                   	leave
80104896:	c3                   	ret
80104897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010489e:	66 90                	xchg   %ax,%ax

801048a0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	57                   	push   %edi
801048a4:	56                   	push   %esi
801048a5:	53                   	push   %ebx
801048a6:	8b 75 08             	mov    0x8(%ebp),%esi
801048a9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801048ac:	89 f0                	mov    %esi,%eax
801048ae:	eb 15                	jmp    801048c5 <strncpy+0x25>
801048b0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801048b4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801048b7:	83 c0 01             	add    $0x1,%eax
801048ba:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801048be:	88 48 ff             	mov    %cl,-0x1(%eax)
801048c1:	84 c9                	test   %cl,%cl
801048c3:	74 13                	je     801048d8 <strncpy+0x38>
801048c5:	89 d3                	mov    %edx,%ebx
801048c7:	83 ea 01             	sub    $0x1,%edx
801048ca:	85 db                	test   %ebx,%ebx
801048cc:	7f e2                	jg     801048b0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
801048ce:	5b                   	pop    %ebx
801048cf:	89 f0                	mov    %esi,%eax
801048d1:	5e                   	pop    %esi
801048d2:	5f                   	pop    %edi
801048d3:	5d                   	pop    %ebp
801048d4:	c3                   	ret
801048d5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
801048d8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801048db:	83 e9 01             	sub    $0x1,%ecx
801048de:	85 d2                	test   %edx,%edx
801048e0:	74 ec                	je     801048ce <strncpy+0x2e>
801048e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
801048e8:	83 c0 01             	add    $0x1,%eax
801048eb:	89 ca                	mov    %ecx,%edx
801048ed:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
801048f1:	29 c2                	sub    %eax,%edx
801048f3:	85 d2                	test   %edx,%edx
801048f5:	7f f1                	jg     801048e8 <strncpy+0x48>
}
801048f7:	5b                   	pop    %ebx
801048f8:	89 f0                	mov    %esi,%eax
801048fa:	5e                   	pop    %esi
801048fb:	5f                   	pop    %edi
801048fc:	5d                   	pop    %ebp
801048fd:	c3                   	ret
801048fe:	66 90                	xchg   %ax,%ax

80104900 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	56                   	push   %esi
80104904:	53                   	push   %ebx
80104905:	8b 55 10             	mov    0x10(%ebp),%edx
80104908:	8b 75 08             	mov    0x8(%ebp),%esi
8010490b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010490e:	85 d2                	test   %edx,%edx
80104910:	7e 25                	jle    80104937 <safestrcpy+0x37>
80104912:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104916:	89 f2                	mov    %esi,%edx
80104918:	eb 16                	jmp    80104930 <safestrcpy+0x30>
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104920:	0f b6 08             	movzbl (%eax),%ecx
80104923:	83 c0 01             	add    $0x1,%eax
80104926:	83 c2 01             	add    $0x1,%edx
80104929:	88 4a ff             	mov    %cl,-0x1(%edx)
8010492c:	84 c9                	test   %cl,%cl
8010492e:	74 04                	je     80104934 <safestrcpy+0x34>
80104930:	39 d8                	cmp    %ebx,%eax
80104932:	75 ec                	jne    80104920 <safestrcpy+0x20>
    ;
  *s = 0;
80104934:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104937:	89 f0                	mov    %esi,%eax
80104939:	5b                   	pop    %ebx
8010493a:	5e                   	pop    %esi
8010493b:	5d                   	pop    %ebp
8010493c:	c3                   	ret
8010493d:	8d 76 00             	lea    0x0(%esi),%esi

80104940 <strlen>:

int
strlen(const char *s)
{
80104940:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104941:	31 c0                	xor    %eax,%eax
{
80104943:	89 e5                	mov    %esp,%ebp
80104945:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104948:	80 3a 00             	cmpb   $0x0,(%edx)
8010494b:	74 0c                	je     80104959 <strlen+0x19>
8010494d:	8d 76 00             	lea    0x0(%esi),%esi
80104950:	83 c0 01             	add    $0x1,%eax
80104953:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104957:	75 f7                	jne    80104950 <strlen+0x10>
    ;
  return n;
}
80104959:	5d                   	pop    %ebp
8010495a:	c3                   	ret

8010495b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010495b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010495f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104963:	55                   	push   %ebp
  pushl %ebx
80104964:	53                   	push   %ebx
  pushl %esi
80104965:	56                   	push   %esi
  pushl %edi
80104966:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104967:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104969:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010496b:	5f                   	pop    %edi
  popl %esi
8010496c:	5e                   	pop    %esi
  popl %ebx
8010496d:	5b                   	pop    %ebx
  popl %ebp
8010496e:	5d                   	pop    %ebp
  ret
8010496f:	c3                   	ret

80104970 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	83 ec 04             	sub    $0x4,%esp
80104977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010497a:	e8 d1 ef ff ff       	call   80103950 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010497f:	8b 00                	mov    (%eax),%eax
80104981:	39 c3                	cmp    %eax,%ebx
80104983:	73 1b                	jae    801049a0 <fetchint+0x30>
80104985:	8d 53 04             	lea    0x4(%ebx),%edx
80104988:	39 d0                	cmp    %edx,%eax
8010498a:	72 14                	jb     801049a0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010498c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010498f:	8b 13                	mov    (%ebx),%edx
80104991:	89 10                	mov    %edx,(%eax)
  return 0;
80104993:	31 c0                	xor    %eax,%eax
}
80104995:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104998:	c9                   	leave
80104999:	c3                   	ret
8010499a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801049a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049a5:	eb ee                	jmp    80104995 <fetchint+0x25>
801049a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	53                   	push   %ebx
801049b4:	83 ec 04             	sub    $0x4,%esp
801049b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801049ba:	e8 91 ef ff ff       	call   80103950 <myproc>

  if(addr >= curproc->sz)
801049bf:	3b 18                	cmp    (%eax),%ebx
801049c1:	73 2d                	jae    801049f0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801049c3:	8b 55 0c             	mov    0xc(%ebp),%edx
801049c6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801049c8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801049ca:	39 d3                	cmp    %edx,%ebx
801049cc:	73 22                	jae    801049f0 <fetchstr+0x40>
801049ce:	89 d8                	mov    %ebx,%eax
801049d0:	eb 0d                	jmp    801049df <fetchstr+0x2f>
801049d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049d8:	83 c0 01             	add    $0x1,%eax
801049db:	39 d0                	cmp    %edx,%eax
801049dd:	73 11                	jae    801049f0 <fetchstr+0x40>
    if(*s == 0)
801049df:	80 38 00             	cmpb   $0x0,(%eax)
801049e2:	75 f4                	jne    801049d8 <fetchstr+0x28>
      return s - *pp;
801049e4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801049e6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049e9:	c9                   	leave
801049ea:	c3                   	ret
801049eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049ef:	90                   	nop
801049f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801049f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801049f8:	c9                   	leave
801049f9:	c3                   	ret
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a00 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	56                   	push   %esi
80104a04:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a05:	e8 46 ef ff ff       	call   80103950 <myproc>
80104a0a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a0d:	8b 40 18             	mov    0x18(%eax),%eax
80104a10:	8b 40 44             	mov    0x44(%eax),%eax
80104a13:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a16:	e8 35 ef ff ff       	call   80103950 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a1b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a1e:	8b 00                	mov    (%eax),%eax
80104a20:	39 c6                	cmp    %eax,%esi
80104a22:	73 1c                	jae    80104a40 <argint+0x40>
80104a24:	8d 53 08             	lea    0x8(%ebx),%edx
80104a27:	39 d0                	cmp    %edx,%eax
80104a29:	72 15                	jb     80104a40 <argint+0x40>
  *ip = *(int*)(addr);
80104a2b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a2e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a31:	89 10                	mov    %edx,(%eax)
  return 0;
80104a33:	31 c0                	xor    %eax,%eax
}
80104a35:	5b                   	pop    %ebx
80104a36:	5e                   	pop    %esi
80104a37:	5d                   	pop    %ebp
80104a38:	c3                   	ret
80104a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a45:	eb ee                	jmp    80104a35 <argint+0x35>
80104a47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a4e:	66 90                	xchg   %ax,%ax

80104a50 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	56                   	push   %esi
80104a55:	53                   	push   %ebx
80104a56:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104a59:	e8 f2 ee ff ff       	call   80103950 <myproc>
80104a5e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a60:	e8 eb ee ff ff       	call   80103950 <myproc>
80104a65:	8b 55 08             	mov    0x8(%ebp),%edx
80104a68:	8b 40 18             	mov    0x18(%eax),%eax
80104a6b:	8b 40 44             	mov    0x44(%eax),%eax
80104a6e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a71:	e8 da ee ff ff       	call   80103950 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a76:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a79:	8b 00                	mov    (%eax),%eax
80104a7b:	39 c7                	cmp    %eax,%edi
80104a7d:	73 31                	jae    80104ab0 <argptr+0x60>
80104a7f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104a82:	39 c8                	cmp    %ecx,%eax
80104a84:	72 2a                	jb     80104ab0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a86:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104a89:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104a8c:	85 d2                	test   %edx,%edx
80104a8e:	78 20                	js     80104ab0 <argptr+0x60>
80104a90:	8b 16                	mov    (%esi),%edx
80104a92:	39 d0                	cmp    %edx,%eax
80104a94:	73 1a                	jae    80104ab0 <argptr+0x60>
80104a96:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a99:	01 c3                	add    %eax,%ebx
80104a9b:	39 da                	cmp    %ebx,%edx
80104a9d:	72 11                	jb     80104ab0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104a9f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104aa2:	89 02                	mov    %eax,(%edx)
  return 0;
80104aa4:	31 c0                	xor    %eax,%eax
}
80104aa6:	83 c4 0c             	add    $0xc,%esp
80104aa9:	5b                   	pop    %ebx
80104aaa:	5e                   	pop    %esi
80104aab:	5f                   	pop    %edi
80104aac:	5d                   	pop    %ebp
80104aad:	c3                   	ret
80104aae:	66 90                	xchg   %ax,%ax
    return -1;
80104ab0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ab5:	eb ef                	jmp    80104aa6 <argptr+0x56>
80104ab7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104abe:	66 90                	xchg   %ax,%ax

80104ac0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104ac0:	55                   	push   %ebp
80104ac1:	89 e5                	mov    %esp,%ebp
80104ac3:	56                   	push   %esi
80104ac4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ac5:	e8 86 ee ff ff       	call   80103950 <myproc>
80104aca:	8b 55 08             	mov    0x8(%ebp),%edx
80104acd:	8b 40 18             	mov    0x18(%eax),%eax
80104ad0:	8b 40 44             	mov    0x44(%eax),%eax
80104ad3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ad6:	e8 75 ee ff ff       	call   80103950 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104adb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ade:	8b 00                	mov    (%eax),%eax
80104ae0:	39 c6                	cmp    %eax,%esi
80104ae2:	73 44                	jae    80104b28 <argstr+0x68>
80104ae4:	8d 53 08             	lea    0x8(%ebx),%edx
80104ae7:	39 d0                	cmp    %edx,%eax
80104ae9:	72 3d                	jb     80104b28 <argstr+0x68>
  *ip = *(int*)(addr);
80104aeb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104aee:	e8 5d ee ff ff       	call   80103950 <myproc>
  if(addr >= curproc->sz)
80104af3:	3b 18                	cmp    (%eax),%ebx
80104af5:	73 31                	jae    80104b28 <argstr+0x68>
  *pp = (char*)addr;
80104af7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104afa:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104afc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104afe:	39 d3                	cmp    %edx,%ebx
80104b00:	73 26                	jae    80104b28 <argstr+0x68>
80104b02:	89 d8                	mov    %ebx,%eax
80104b04:	eb 11                	jmp    80104b17 <argstr+0x57>
80104b06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi
80104b10:	83 c0 01             	add    $0x1,%eax
80104b13:	39 d0                	cmp    %edx,%eax
80104b15:	73 11                	jae    80104b28 <argstr+0x68>
    if(*s == 0)
80104b17:	80 38 00             	cmpb   $0x0,(%eax)
80104b1a:	75 f4                	jne    80104b10 <argstr+0x50>
      return s - *pp;
80104b1c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104b1e:	5b                   	pop    %ebx
80104b1f:	5e                   	pop    %esi
80104b20:	5d                   	pop    %ebp
80104b21:	c3                   	ret
80104b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b28:	5b                   	pop    %ebx
    return -1;
80104b29:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b2e:	5e                   	pop    %esi
80104b2f:	5d                   	pop    %ebp
80104b30:	c3                   	ret
80104b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b3f:	90                   	nop

80104b40 <syscall>:
[SYS_chpr]  sys_chpr,
};

void
syscall(void)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	53                   	push   %ebx
80104b44:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104b47:	e8 04 ee ff ff       	call   80103950 <myproc>
80104b4c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104b4e:	8b 40 18             	mov    0x18(%eax),%eax
80104b51:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b54:	8d 50 ff             	lea    -0x1(%eax),%edx
80104b57:	83 fa 17             	cmp    $0x17,%edx
80104b5a:	77 24                	ja     80104b80 <syscall+0x40>
80104b5c:	8b 14 85 a0 77 10 80 	mov    -0x7fef8860(,%eax,4),%edx
80104b63:	85 d2                	test   %edx,%edx
80104b65:	74 19                	je     80104b80 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104b67:	ff d2                	call   *%edx
80104b69:	89 c2                	mov    %eax,%edx
80104b6b:	8b 43 18             	mov    0x18(%ebx),%eax
80104b6e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104b71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b74:	c9                   	leave
80104b75:	c3                   	ret
80104b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b7d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104b80:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104b81:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104b84:	50                   	push   %eax
80104b85:	ff 73 10             	push   0x10(%ebx)
80104b88:	68 7d 77 10 80       	push   $0x8010777d
80104b8d:	e8 1e bb ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
80104b92:	8b 43 18             	mov    0x18(%ebx),%eax
80104b95:	83 c4 10             	add    $0x10,%esp
80104b98:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104b9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ba2:	c9                   	leave
80104ba3:	c3                   	ret
80104ba4:	66 90                	xchg   %ax,%ax
80104ba6:	66 90                	xchg   %ax,%ax
80104ba8:	66 90                	xchg   %ax,%ax
80104baa:	66 90                	xchg   %ax,%ax
80104bac:	66 90                	xchg   %ax,%ax
80104bae:	66 90                	xchg   %ax,%ax

80104bb0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	57                   	push   %edi
80104bb4:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104bb5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104bb8:	53                   	push   %ebx
80104bb9:	83 ec 44             	sub    $0x44,%esp
80104bbc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104bbf:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104bc2:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104bc5:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104bc8:	57                   	push   %edi
80104bc9:	50                   	push   %eax
80104bca:	e8 71 d5 ff ff       	call   80102140 <nameiparent>
80104bcf:	83 c4 10             	add    $0x10,%esp
80104bd2:	85 c0                	test   %eax,%eax
80104bd4:	74 5e                	je     80104c34 <create+0x84>
    return 0;
  ilock(dp);
80104bd6:	83 ec 0c             	sub    $0xc,%esp
80104bd9:	89 c3                	mov    %eax,%ebx
80104bdb:	50                   	push   %eax
80104bdc:	e8 0f cc ff ff       	call   801017f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104be1:	83 c4 0c             	add    $0xc,%esp
80104be4:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104be7:	50                   	push   %eax
80104be8:	57                   	push   %edi
80104be9:	53                   	push   %ebx
80104bea:	e8 61 d1 ff ff       	call   80101d50 <dirlookup>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	89 c6                	mov    %eax,%esi
80104bf4:	85 c0                	test   %eax,%eax
80104bf6:	74 48                	je     80104c40 <create+0x90>
    iunlockput(dp);
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	53                   	push   %ebx
80104bfc:	e8 7f ce ff ff       	call   80101a80 <iunlockput>
    ilock(ip);
80104c01:	89 34 24             	mov    %esi,(%esp)
80104c04:	e8 e7 cb ff ff       	call   801017f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c09:	83 c4 10             	add    $0x10,%esp
80104c0c:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104c11:	75 15                	jne    80104c28 <create+0x78>
80104c13:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104c18:	75 0e                	jne    80104c28 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c1d:	89 f0                	mov    %esi,%eax
80104c1f:	5b                   	pop    %ebx
80104c20:	5e                   	pop    %esi
80104c21:	5f                   	pop    %edi
80104c22:	5d                   	pop    %ebp
80104c23:	c3                   	ret
80104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80104c28:	83 ec 0c             	sub    $0xc,%esp
80104c2b:	56                   	push   %esi
80104c2c:	e8 4f ce ff ff       	call   80101a80 <iunlockput>
    return 0;
80104c31:	83 c4 10             	add    $0x10,%esp
}
80104c34:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104c37:	31 f6                	xor    %esi,%esi
}
80104c39:	5b                   	pop    %ebx
80104c3a:	89 f0                	mov    %esi,%eax
80104c3c:	5e                   	pop    %esi
80104c3d:	5f                   	pop    %edi
80104c3e:	5d                   	pop    %ebp
80104c3f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104c40:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104c44:	83 ec 08             	sub    $0x8,%esp
80104c47:	50                   	push   %eax
80104c48:	ff 33                	push   (%ebx)
80104c4a:	e8 31 ca ff ff       	call   80101680 <ialloc>
80104c4f:	83 c4 10             	add    $0x10,%esp
80104c52:	89 c6                	mov    %eax,%esi
80104c54:	85 c0                	test   %eax,%eax
80104c56:	0f 84 bc 00 00 00    	je     80104d18 <create+0x168>
  ilock(ip);
80104c5c:	83 ec 0c             	sub    $0xc,%esp
80104c5f:	50                   	push   %eax
80104c60:	e8 8b cb ff ff       	call   801017f0 <ilock>
  ip->major = major;
80104c65:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104c69:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104c6d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104c71:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104c75:	b8 01 00 00 00       	mov    $0x1,%eax
80104c7a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104c7e:	89 34 24             	mov    %esi,(%esp)
80104c81:	e8 ba ca ff ff       	call   80101740 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104c86:	83 c4 10             	add    $0x10,%esp
80104c89:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104c8e:	74 30                	je     80104cc0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104c90:	83 ec 04             	sub    $0x4,%esp
80104c93:	ff 76 04             	push   0x4(%esi)
80104c96:	57                   	push   %edi
80104c97:	53                   	push   %ebx
80104c98:	e8 c3 d3 ff ff       	call   80102060 <dirlink>
80104c9d:	83 c4 10             	add    $0x10,%esp
80104ca0:	85 c0                	test   %eax,%eax
80104ca2:	78 67                	js     80104d0b <create+0x15b>
  iunlockput(dp);
80104ca4:	83 ec 0c             	sub    $0xc,%esp
80104ca7:	53                   	push   %ebx
80104ca8:	e8 d3 cd ff ff       	call   80101a80 <iunlockput>
  return ip;
80104cad:	83 c4 10             	add    $0x10,%esp
}
80104cb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cb3:	89 f0                	mov    %esi,%eax
80104cb5:	5b                   	pop    %ebx
80104cb6:	5e                   	pop    %esi
80104cb7:	5f                   	pop    %edi
80104cb8:	5d                   	pop    %ebp
80104cb9:	c3                   	ret
80104cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104cc0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104cc3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104cc8:	53                   	push   %ebx
80104cc9:	e8 72 ca ff ff       	call   80101740 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104cce:	83 c4 0c             	add    $0xc,%esp
80104cd1:	ff 76 04             	push   0x4(%esi)
80104cd4:	68 20 78 10 80       	push   $0x80107820
80104cd9:	56                   	push   %esi
80104cda:	e8 81 d3 ff ff       	call   80102060 <dirlink>
80104cdf:	83 c4 10             	add    $0x10,%esp
80104ce2:	85 c0                	test   %eax,%eax
80104ce4:	78 18                	js     80104cfe <create+0x14e>
80104ce6:	83 ec 04             	sub    $0x4,%esp
80104ce9:	ff 73 04             	push   0x4(%ebx)
80104cec:	68 1f 78 10 80       	push   $0x8010781f
80104cf1:	56                   	push   %esi
80104cf2:	e8 69 d3 ff ff       	call   80102060 <dirlink>
80104cf7:	83 c4 10             	add    $0x10,%esp
80104cfa:	85 c0                	test   %eax,%eax
80104cfc:	79 92                	jns    80104c90 <create+0xe0>
      panic("create dots");
80104cfe:	83 ec 0c             	sub    $0xc,%esp
80104d01:	68 13 78 10 80       	push   $0x80107813
80104d06:	e8 75 b6 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104d0b:	83 ec 0c             	sub    $0xc,%esp
80104d0e:	68 22 78 10 80       	push   $0x80107822
80104d13:	e8 68 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104d18:	83 ec 0c             	sub    $0xc,%esp
80104d1b:	68 04 78 10 80       	push   $0x80107804
80104d20:	e8 5b b6 ff ff       	call   80100380 <panic>
80104d25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d30 <sys_dup>:
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	56                   	push   %esi
80104d34:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104d35:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104d38:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d3b:	50                   	push   %eax
80104d3c:	6a 00                	push   $0x0
80104d3e:	e8 bd fc ff ff       	call   80104a00 <argint>
80104d43:	83 c4 10             	add    $0x10,%esp
80104d46:	85 c0                	test   %eax,%eax
80104d48:	78 36                	js     80104d80 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d4e:	77 30                	ja     80104d80 <sys_dup+0x50>
80104d50:	e8 fb eb ff ff       	call   80103950 <myproc>
80104d55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d58:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d5c:	85 f6                	test   %esi,%esi
80104d5e:	74 20                	je     80104d80 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104d60:	e8 eb eb ff ff       	call   80103950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104d65:	31 db                	xor    %ebx,%ebx
80104d67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d6e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80104d70:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d74:	85 d2                	test   %edx,%edx
80104d76:	74 18                	je     80104d90 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104d78:	83 c3 01             	add    $0x1,%ebx
80104d7b:	83 fb 10             	cmp    $0x10,%ebx
80104d7e:	75 f0                	jne    80104d70 <sys_dup+0x40>
}
80104d80:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d83:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104d88:	89 d8                	mov    %ebx,%eax
80104d8a:	5b                   	pop    %ebx
80104d8b:	5e                   	pop    %esi
80104d8c:	5d                   	pop    %ebp
80104d8d:	c3                   	ret
80104d8e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104d90:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104d93:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104d97:	56                   	push   %esi
80104d98:	e8 53 c1 ff ff       	call   80100ef0 <filedup>
  return fd;
80104d9d:	83 c4 10             	add    $0x10,%esp
}
80104da0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104da3:	89 d8                	mov    %ebx,%eax
80104da5:	5b                   	pop    %ebx
80104da6:	5e                   	pop    %esi
80104da7:	5d                   	pop    %ebp
80104da8:	c3                   	ret
80104da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104db0 <sys_read>:
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104db5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104db8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104dbb:	53                   	push   %ebx
80104dbc:	6a 00                	push   $0x0
80104dbe:	e8 3d fc ff ff       	call   80104a00 <argint>
80104dc3:	83 c4 10             	add    $0x10,%esp
80104dc6:	85 c0                	test   %eax,%eax
80104dc8:	78 5e                	js     80104e28 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104dca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104dce:	77 58                	ja     80104e28 <sys_read+0x78>
80104dd0:	e8 7b eb ff ff       	call   80103950 <myproc>
80104dd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104dd8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104ddc:	85 f6                	test   %esi,%esi
80104dde:	74 48                	je     80104e28 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104de0:	83 ec 08             	sub    $0x8,%esp
80104de3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104de6:	50                   	push   %eax
80104de7:	6a 02                	push   $0x2
80104de9:	e8 12 fc ff ff       	call   80104a00 <argint>
80104dee:	83 c4 10             	add    $0x10,%esp
80104df1:	85 c0                	test   %eax,%eax
80104df3:	78 33                	js     80104e28 <sys_read+0x78>
80104df5:	83 ec 04             	sub    $0x4,%esp
80104df8:	ff 75 f0             	push   -0x10(%ebp)
80104dfb:	53                   	push   %ebx
80104dfc:	6a 01                	push   $0x1
80104dfe:	e8 4d fc ff ff       	call   80104a50 <argptr>
80104e03:	83 c4 10             	add    $0x10,%esp
80104e06:	85 c0                	test   %eax,%eax
80104e08:	78 1e                	js     80104e28 <sys_read+0x78>
  return fileread(f, p, n);
80104e0a:	83 ec 04             	sub    $0x4,%esp
80104e0d:	ff 75 f0             	push   -0x10(%ebp)
80104e10:	ff 75 f4             	push   -0xc(%ebp)
80104e13:	56                   	push   %esi
80104e14:	e8 57 c2 ff ff       	call   80101070 <fileread>
80104e19:	83 c4 10             	add    $0x10,%esp
}
80104e1c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e1f:	5b                   	pop    %ebx
80104e20:	5e                   	pop    %esi
80104e21:	5d                   	pop    %ebp
80104e22:	c3                   	ret
80104e23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e27:	90                   	nop
    return -1;
80104e28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e2d:	eb ed                	jmp    80104e1c <sys_read+0x6c>
80104e2f:	90                   	nop

80104e30 <sys_write>:
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	56                   	push   %esi
80104e34:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e35:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104e38:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e3b:	53                   	push   %ebx
80104e3c:	6a 00                	push   $0x0
80104e3e:	e8 bd fb ff ff       	call   80104a00 <argint>
80104e43:	83 c4 10             	add    $0x10,%esp
80104e46:	85 c0                	test   %eax,%eax
80104e48:	78 5e                	js     80104ea8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e4e:	77 58                	ja     80104ea8 <sys_write+0x78>
80104e50:	e8 fb ea ff ff       	call   80103950 <myproc>
80104e55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e58:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e5c:	85 f6                	test   %esi,%esi
80104e5e:	74 48                	je     80104ea8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e60:	83 ec 08             	sub    $0x8,%esp
80104e63:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e66:	50                   	push   %eax
80104e67:	6a 02                	push   $0x2
80104e69:	e8 92 fb ff ff       	call   80104a00 <argint>
80104e6e:	83 c4 10             	add    $0x10,%esp
80104e71:	85 c0                	test   %eax,%eax
80104e73:	78 33                	js     80104ea8 <sys_write+0x78>
80104e75:	83 ec 04             	sub    $0x4,%esp
80104e78:	ff 75 f0             	push   -0x10(%ebp)
80104e7b:	53                   	push   %ebx
80104e7c:	6a 01                	push   $0x1
80104e7e:	e8 cd fb ff ff       	call   80104a50 <argptr>
80104e83:	83 c4 10             	add    $0x10,%esp
80104e86:	85 c0                	test   %eax,%eax
80104e88:	78 1e                	js     80104ea8 <sys_write+0x78>
  return filewrite(f, p, n);
80104e8a:	83 ec 04             	sub    $0x4,%esp
80104e8d:	ff 75 f0             	push   -0x10(%ebp)
80104e90:	ff 75 f4             	push   -0xc(%ebp)
80104e93:	56                   	push   %esi
80104e94:	e8 67 c2 ff ff       	call   80101100 <filewrite>
80104e99:	83 c4 10             	add    $0x10,%esp
}
80104e9c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e9f:	5b                   	pop    %ebx
80104ea0:	5e                   	pop    %esi
80104ea1:	5d                   	pop    %ebp
80104ea2:	c3                   	ret
80104ea3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ea7:	90                   	nop
    return -1;
80104ea8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ead:	eb ed                	jmp    80104e9c <sys_write+0x6c>
80104eaf:	90                   	nop

80104eb0 <sys_close>:
{
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	56                   	push   %esi
80104eb4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104eb5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104eb8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104ebb:	50                   	push   %eax
80104ebc:	6a 00                	push   $0x0
80104ebe:	e8 3d fb ff ff       	call   80104a00 <argint>
80104ec3:	83 c4 10             	add    $0x10,%esp
80104ec6:	85 c0                	test   %eax,%eax
80104ec8:	78 3e                	js     80104f08 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ece:	77 38                	ja     80104f08 <sys_close+0x58>
80104ed0:	e8 7b ea ff ff       	call   80103950 <myproc>
80104ed5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ed8:	8d 5a 08             	lea    0x8(%edx),%ebx
80104edb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104edf:	85 f6                	test   %esi,%esi
80104ee1:	74 25                	je     80104f08 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104ee3:	e8 68 ea ff ff       	call   80103950 <myproc>
  fileclose(f);
80104ee8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104eeb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104ef2:	00 
  fileclose(f);
80104ef3:	56                   	push   %esi
80104ef4:	e8 47 c0 ff ff       	call   80100f40 <fileclose>
  return 0;
80104ef9:	83 c4 10             	add    $0x10,%esp
80104efc:	31 c0                	xor    %eax,%eax
}
80104efe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f01:	5b                   	pop    %ebx
80104f02:	5e                   	pop    %esi
80104f03:	5d                   	pop    %ebp
80104f04:	c3                   	ret
80104f05:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f0d:	eb ef                	jmp    80104efe <sys_close+0x4e>
80104f0f:	90                   	nop

80104f10 <sys_fstat>:
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	56                   	push   %esi
80104f14:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f15:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f18:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f1b:	53                   	push   %ebx
80104f1c:	6a 00                	push   $0x0
80104f1e:	e8 dd fa ff ff       	call   80104a00 <argint>
80104f23:	83 c4 10             	add    $0x10,%esp
80104f26:	85 c0                	test   %eax,%eax
80104f28:	78 46                	js     80104f70 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f2a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f2e:	77 40                	ja     80104f70 <sys_fstat+0x60>
80104f30:	e8 1b ea ff ff       	call   80103950 <myproc>
80104f35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f38:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f3c:	85 f6                	test   %esi,%esi
80104f3e:	74 30                	je     80104f70 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f40:	83 ec 04             	sub    $0x4,%esp
80104f43:	6a 14                	push   $0x14
80104f45:	53                   	push   %ebx
80104f46:	6a 01                	push   $0x1
80104f48:	e8 03 fb ff ff       	call   80104a50 <argptr>
80104f4d:	83 c4 10             	add    $0x10,%esp
80104f50:	85 c0                	test   %eax,%eax
80104f52:	78 1c                	js     80104f70 <sys_fstat+0x60>
  return filestat(f, st);
80104f54:	83 ec 08             	sub    $0x8,%esp
80104f57:	ff 75 f4             	push   -0xc(%ebp)
80104f5a:	56                   	push   %esi
80104f5b:	e8 c0 c0 ff ff       	call   80101020 <filestat>
80104f60:	83 c4 10             	add    $0x10,%esp
}
80104f63:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f66:	5b                   	pop    %ebx
80104f67:	5e                   	pop    %esi
80104f68:	5d                   	pop    %ebp
80104f69:	c3                   	ret
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f75:	eb ec                	jmp    80104f63 <sys_fstat+0x53>
80104f77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f7e:	66 90                	xchg   %ax,%ax

80104f80 <sys_link>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	57                   	push   %edi
80104f84:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f85:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104f88:	53                   	push   %ebx
80104f89:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104f8c:	50                   	push   %eax
80104f8d:	6a 00                	push   $0x0
80104f8f:	e8 2c fb ff ff       	call   80104ac0 <argstr>
80104f94:	83 c4 10             	add    $0x10,%esp
80104f97:	85 c0                	test   %eax,%eax
80104f99:	0f 88 fb 00 00 00    	js     8010509a <sys_link+0x11a>
80104f9f:	83 ec 08             	sub    $0x8,%esp
80104fa2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104fa5:	50                   	push   %eax
80104fa6:	6a 01                	push   $0x1
80104fa8:	e8 13 fb ff ff       	call   80104ac0 <argstr>
80104fad:	83 c4 10             	add    $0x10,%esp
80104fb0:	85 c0                	test   %eax,%eax
80104fb2:	0f 88 e2 00 00 00    	js     8010509a <sys_link+0x11a>
  begin_op();
80104fb8:	e8 63 dd ff ff       	call   80102d20 <begin_op>
  if((ip = namei(old)) == 0){
80104fbd:	83 ec 0c             	sub    $0xc,%esp
80104fc0:	ff 75 d4             	push   -0x2c(%ebp)
80104fc3:	e8 58 d1 ff ff       	call   80102120 <namei>
80104fc8:	83 c4 10             	add    $0x10,%esp
80104fcb:	89 c3                	mov    %eax,%ebx
80104fcd:	85 c0                	test   %eax,%eax
80104fcf:	0f 84 df 00 00 00    	je     801050b4 <sys_link+0x134>
  ilock(ip);
80104fd5:	83 ec 0c             	sub    $0xc,%esp
80104fd8:	50                   	push   %eax
80104fd9:	e8 12 c8 ff ff       	call   801017f0 <ilock>
  if(ip->type == T_DIR){
80104fde:	83 c4 10             	add    $0x10,%esp
80104fe1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fe6:	0f 84 b5 00 00 00    	je     801050a1 <sys_link+0x121>
  iupdate(ip);
80104fec:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80104fef:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80104ff4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80104ff7:	53                   	push   %ebx
80104ff8:	e8 43 c7 ff ff       	call   80101740 <iupdate>
  iunlock(ip);
80104ffd:	89 1c 24             	mov    %ebx,(%esp)
80105000:	e8 cb c8 ff ff       	call   801018d0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105005:	58                   	pop    %eax
80105006:	5a                   	pop    %edx
80105007:	57                   	push   %edi
80105008:	ff 75 d0             	push   -0x30(%ebp)
8010500b:	e8 30 d1 ff ff       	call   80102140 <nameiparent>
80105010:	83 c4 10             	add    $0x10,%esp
80105013:	89 c6                	mov    %eax,%esi
80105015:	85 c0                	test   %eax,%eax
80105017:	74 5b                	je     80105074 <sys_link+0xf4>
  ilock(dp);
80105019:	83 ec 0c             	sub    $0xc,%esp
8010501c:	50                   	push   %eax
8010501d:	e8 ce c7 ff ff       	call   801017f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105022:	8b 03                	mov    (%ebx),%eax
80105024:	83 c4 10             	add    $0x10,%esp
80105027:	39 06                	cmp    %eax,(%esi)
80105029:	75 3d                	jne    80105068 <sys_link+0xe8>
8010502b:	83 ec 04             	sub    $0x4,%esp
8010502e:	ff 73 04             	push   0x4(%ebx)
80105031:	57                   	push   %edi
80105032:	56                   	push   %esi
80105033:	e8 28 d0 ff ff       	call   80102060 <dirlink>
80105038:	83 c4 10             	add    $0x10,%esp
8010503b:	85 c0                	test   %eax,%eax
8010503d:	78 29                	js     80105068 <sys_link+0xe8>
  iunlockput(dp);
8010503f:	83 ec 0c             	sub    $0xc,%esp
80105042:	56                   	push   %esi
80105043:	e8 38 ca ff ff       	call   80101a80 <iunlockput>
  iput(ip);
80105048:	89 1c 24             	mov    %ebx,(%esp)
8010504b:	e8 d0 c8 ff ff       	call   80101920 <iput>
  end_op();
80105050:	e8 3b dd ff ff       	call   80102d90 <end_op>
  return 0;
80105055:	83 c4 10             	add    $0x10,%esp
80105058:	31 c0                	xor    %eax,%eax
}
8010505a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010505d:	5b                   	pop    %ebx
8010505e:	5e                   	pop    %esi
8010505f:	5f                   	pop    %edi
80105060:	5d                   	pop    %ebp
80105061:	c3                   	ret
80105062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105068:	83 ec 0c             	sub    $0xc,%esp
8010506b:	56                   	push   %esi
8010506c:	e8 0f ca ff ff       	call   80101a80 <iunlockput>
    goto bad;
80105071:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105074:	83 ec 0c             	sub    $0xc,%esp
80105077:	53                   	push   %ebx
80105078:	e8 73 c7 ff ff       	call   801017f0 <ilock>
  ip->nlink--;
8010507d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105082:	89 1c 24             	mov    %ebx,(%esp)
80105085:	e8 b6 c6 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
8010508a:	89 1c 24             	mov    %ebx,(%esp)
8010508d:	e8 ee c9 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105092:	e8 f9 dc ff ff       	call   80102d90 <end_op>
  return -1;
80105097:	83 c4 10             	add    $0x10,%esp
    return -1;
8010509a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010509f:	eb b9                	jmp    8010505a <sys_link+0xda>
    iunlockput(ip);
801050a1:	83 ec 0c             	sub    $0xc,%esp
801050a4:	53                   	push   %ebx
801050a5:	e8 d6 c9 ff ff       	call   80101a80 <iunlockput>
    end_op();
801050aa:	e8 e1 dc ff ff       	call   80102d90 <end_op>
    return -1;
801050af:	83 c4 10             	add    $0x10,%esp
801050b2:	eb e6                	jmp    8010509a <sys_link+0x11a>
    end_op();
801050b4:	e8 d7 dc ff ff       	call   80102d90 <end_op>
    return -1;
801050b9:	eb df                	jmp    8010509a <sys_link+0x11a>
801050bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050bf:	90                   	nop

801050c0 <sys_unlink>:
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	57                   	push   %edi
801050c4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801050c5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801050c8:	53                   	push   %ebx
801050c9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801050cc:	50                   	push   %eax
801050cd:	6a 00                	push   $0x0
801050cf:	e8 ec f9 ff ff       	call   80104ac0 <argstr>
801050d4:	83 c4 10             	add    $0x10,%esp
801050d7:	85 c0                	test   %eax,%eax
801050d9:	0f 88 54 01 00 00    	js     80105233 <sys_unlink+0x173>
  begin_op();
801050df:	e8 3c dc ff ff       	call   80102d20 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801050e4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801050e7:	83 ec 08             	sub    $0x8,%esp
801050ea:	53                   	push   %ebx
801050eb:	ff 75 c0             	push   -0x40(%ebp)
801050ee:	e8 4d d0 ff ff       	call   80102140 <nameiparent>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801050f9:	85 c0                	test   %eax,%eax
801050fb:	0f 84 58 01 00 00    	je     80105259 <sys_unlink+0x199>
  ilock(dp);
80105101:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105104:	83 ec 0c             	sub    $0xc,%esp
80105107:	57                   	push   %edi
80105108:	e8 e3 c6 ff ff       	call   801017f0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010510d:	58                   	pop    %eax
8010510e:	5a                   	pop    %edx
8010510f:	68 20 78 10 80       	push   $0x80107820
80105114:	53                   	push   %ebx
80105115:	e8 16 cc ff ff       	call   80101d30 <namecmp>
8010511a:	83 c4 10             	add    $0x10,%esp
8010511d:	85 c0                	test   %eax,%eax
8010511f:	0f 84 fb 00 00 00    	je     80105220 <sys_unlink+0x160>
80105125:	83 ec 08             	sub    $0x8,%esp
80105128:	68 1f 78 10 80       	push   $0x8010781f
8010512d:	53                   	push   %ebx
8010512e:	e8 fd cb ff ff       	call   80101d30 <namecmp>
80105133:	83 c4 10             	add    $0x10,%esp
80105136:	85 c0                	test   %eax,%eax
80105138:	0f 84 e2 00 00 00    	je     80105220 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010513e:	83 ec 04             	sub    $0x4,%esp
80105141:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105144:	50                   	push   %eax
80105145:	53                   	push   %ebx
80105146:	57                   	push   %edi
80105147:	e8 04 cc ff ff       	call   80101d50 <dirlookup>
8010514c:	83 c4 10             	add    $0x10,%esp
8010514f:	89 c3                	mov    %eax,%ebx
80105151:	85 c0                	test   %eax,%eax
80105153:	0f 84 c7 00 00 00    	je     80105220 <sys_unlink+0x160>
  ilock(ip);
80105159:	83 ec 0c             	sub    $0xc,%esp
8010515c:	50                   	push   %eax
8010515d:	e8 8e c6 ff ff       	call   801017f0 <ilock>
  if(ip->nlink < 1)
80105162:	83 c4 10             	add    $0x10,%esp
80105165:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010516a:	0f 8e 0a 01 00 00    	jle    8010527a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105170:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105175:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105178:	74 66                	je     801051e0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010517a:	83 ec 04             	sub    $0x4,%esp
8010517d:	6a 10                	push   $0x10
8010517f:	6a 00                	push   $0x0
80105181:	57                   	push   %edi
80105182:	e8 c9 f5 ff ff       	call   80104750 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105187:	6a 10                	push   $0x10
80105189:	ff 75 c4             	push   -0x3c(%ebp)
8010518c:	57                   	push   %edi
8010518d:	ff 75 b4             	push   -0x4c(%ebp)
80105190:	e8 6b ca ff ff       	call   80101c00 <writei>
80105195:	83 c4 20             	add    $0x20,%esp
80105198:	83 f8 10             	cmp    $0x10,%eax
8010519b:	0f 85 cc 00 00 00    	jne    8010526d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
801051a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051a6:	0f 84 94 00 00 00    	je     80105240 <sys_unlink+0x180>
  iunlockput(dp);
801051ac:	83 ec 0c             	sub    $0xc,%esp
801051af:	ff 75 b4             	push   -0x4c(%ebp)
801051b2:	e8 c9 c8 ff ff       	call   80101a80 <iunlockput>
  ip->nlink--;
801051b7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051bc:	89 1c 24             	mov    %ebx,(%esp)
801051bf:	e8 7c c5 ff ff       	call   80101740 <iupdate>
  iunlockput(ip);
801051c4:	89 1c 24             	mov    %ebx,(%esp)
801051c7:	e8 b4 c8 ff ff       	call   80101a80 <iunlockput>
  end_op();
801051cc:	e8 bf db ff ff       	call   80102d90 <end_op>
  return 0;
801051d1:	83 c4 10             	add    $0x10,%esp
801051d4:	31 c0                	xor    %eax,%eax
}
801051d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051d9:	5b                   	pop    %ebx
801051da:	5e                   	pop    %esi
801051db:	5f                   	pop    %edi
801051dc:	5d                   	pop    %ebp
801051dd:	c3                   	ret
801051de:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801051e0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801051e4:	76 94                	jbe    8010517a <sys_unlink+0xba>
801051e6:	be 20 00 00 00       	mov    $0x20,%esi
801051eb:	eb 0b                	jmp    801051f8 <sys_unlink+0x138>
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
801051f0:	83 c6 10             	add    $0x10,%esi
801051f3:	3b 73 58             	cmp    0x58(%ebx),%esi
801051f6:	73 82                	jae    8010517a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051f8:	6a 10                	push   $0x10
801051fa:	56                   	push   %esi
801051fb:	57                   	push   %edi
801051fc:	53                   	push   %ebx
801051fd:	e8 fe c8 ff ff       	call   80101b00 <readi>
80105202:	83 c4 10             	add    $0x10,%esp
80105205:	83 f8 10             	cmp    $0x10,%eax
80105208:	75 56                	jne    80105260 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010520a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010520f:	74 df                	je     801051f0 <sys_unlink+0x130>
    iunlockput(ip);
80105211:	83 ec 0c             	sub    $0xc,%esp
80105214:	53                   	push   %ebx
80105215:	e8 66 c8 ff ff       	call   80101a80 <iunlockput>
    goto bad;
8010521a:	83 c4 10             	add    $0x10,%esp
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105220:	83 ec 0c             	sub    $0xc,%esp
80105223:	ff 75 b4             	push   -0x4c(%ebp)
80105226:	e8 55 c8 ff ff       	call   80101a80 <iunlockput>
  end_op();
8010522b:	e8 60 db ff ff       	call   80102d90 <end_op>
  return -1;
80105230:	83 c4 10             	add    $0x10,%esp
    return -1;
80105233:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105238:	eb 9c                	jmp    801051d6 <sys_unlink+0x116>
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105240:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105243:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105246:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010524b:	50                   	push   %eax
8010524c:	e8 ef c4 ff ff       	call   80101740 <iupdate>
80105251:	83 c4 10             	add    $0x10,%esp
80105254:	e9 53 ff ff ff       	jmp    801051ac <sys_unlink+0xec>
    end_op();
80105259:	e8 32 db ff ff       	call   80102d90 <end_op>
    return -1;
8010525e:	eb d3                	jmp    80105233 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105260:	83 ec 0c             	sub    $0xc,%esp
80105263:	68 44 78 10 80       	push   $0x80107844
80105268:	e8 13 b1 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010526d:	83 ec 0c             	sub    $0xc,%esp
80105270:	68 56 78 10 80       	push   $0x80107856
80105275:	e8 06 b1 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010527a:	83 ec 0c             	sub    $0xc,%esp
8010527d:	68 32 78 10 80       	push   $0x80107832
80105282:	e8 f9 b0 ff ff       	call   80100380 <panic>
80105287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010528e:	66 90                	xchg   %ax,%ax

80105290 <sys_open>:

int
sys_open(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105295:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105298:	53                   	push   %ebx
80105299:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010529c:	50                   	push   %eax
8010529d:	6a 00                	push   $0x0
8010529f:	e8 1c f8 ff ff       	call   80104ac0 <argstr>
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
801052a9:	0f 88 8e 00 00 00    	js     8010533d <sys_open+0xad>
801052af:	83 ec 08             	sub    $0x8,%esp
801052b2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052b5:	50                   	push   %eax
801052b6:	6a 01                	push   $0x1
801052b8:	e8 43 f7 ff ff       	call   80104a00 <argint>
801052bd:	83 c4 10             	add    $0x10,%esp
801052c0:	85 c0                	test   %eax,%eax
801052c2:	78 79                	js     8010533d <sys_open+0xad>
    return -1;

  begin_op();
801052c4:	e8 57 da ff ff       	call   80102d20 <begin_op>

  if(omode & O_CREATE){
801052c9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052cd:	75 79                	jne    80105348 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052cf:	83 ec 0c             	sub    $0xc,%esp
801052d2:	ff 75 e0             	push   -0x20(%ebp)
801052d5:	e8 46 ce ff ff       	call   80102120 <namei>
801052da:	83 c4 10             	add    $0x10,%esp
801052dd:	89 c6                	mov    %eax,%esi
801052df:	85 c0                	test   %eax,%eax
801052e1:	0f 84 7e 00 00 00    	je     80105365 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801052e7:	83 ec 0c             	sub    $0xc,%esp
801052ea:	50                   	push   %eax
801052eb:	e8 00 c5 ff ff       	call   801017f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052f0:	83 c4 10             	add    $0x10,%esp
801052f3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801052f8:	0f 84 ba 00 00 00    	je     801053b8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801052fe:	e8 7d bb ff ff       	call   80100e80 <filealloc>
80105303:	89 c7                	mov    %eax,%edi
80105305:	85 c0                	test   %eax,%eax
80105307:	74 23                	je     8010532c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105309:	e8 42 e6 ff ff       	call   80103950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010530e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105310:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105314:	85 d2                	test   %edx,%edx
80105316:	74 58                	je     80105370 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105318:	83 c3 01             	add    $0x1,%ebx
8010531b:	83 fb 10             	cmp    $0x10,%ebx
8010531e:	75 f0                	jne    80105310 <sys_open+0x80>
    if(f)
      fileclose(f);
80105320:	83 ec 0c             	sub    $0xc,%esp
80105323:	57                   	push   %edi
80105324:	e8 17 bc ff ff       	call   80100f40 <fileclose>
80105329:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010532c:	83 ec 0c             	sub    $0xc,%esp
8010532f:	56                   	push   %esi
80105330:	e8 4b c7 ff ff       	call   80101a80 <iunlockput>
    end_op();
80105335:	e8 56 da ff ff       	call   80102d90 <end_op>
    return -1;
8010533a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010533d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105342:	eb 65                	jmp    801053a9 <sys_open+0x119>
80105344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105348:	83 ec 0c             	sub    $0xc,%esp
8010534b:	31 c9                	xor    %ecx,%ecx
8010534d:	ba 02 00 00 00       	mov    $0x2,%edx
80105352:	6a 00                	push   $0x0
80105354:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105357:	e8 54 f8 ff ff       	call   80104bb0 <create>
    if(ip == 0){
8010535c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010535f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105361:	85 c0                	test   %eax,%eax
80105363:	75 99                	jne    801052fe <sys_open+0x6e>
      end_op();
80105365:	e8 26 da ff ff       	call   80102d90 <end_op>
      return -1;
8010536a:	eb d1                	jmp    8010533d <sys_open+0xad>
8010536c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105370:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105373:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105377:	56                   	push   %esi
80105378:	e8 53 c5 ff ff       	call   801018d0 <iunlock>
  end_op();
8010537d:	e8 0e da ff ff       	call   80102d90 <end_op>

  f->type = FD_INODE;
80105382:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105388:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010538b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010538e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105391:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105393:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010539a:	f7 d0                	not    %eax
8010539c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010539f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801053a2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053a5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801053a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053ac:	89 d8                	mov    %ebx,%eax
801053ae:	5b                   	pop    %ebx
801053af:	5e                   	pop    %esi
801053b0:	5f                   	pop    %edi
801053b1:	5d                   	pop    %ebp
801053b2:	c3                   	ret
801053b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053b7:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801053b8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053bb:	85 c9                	test   %ecx,%ecx
801053bd:	0f 84 3b ff ff ff    	je     801052fe <sys_open+0x6e>
801053c3:	e9 64 ff ff ff       	jmp    8010532c <sys_open+0x9c>
801053c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053cf:	90                   	nop

801053d0 <sys_mkdir>:

int
sys_mkdir(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053d6:	e8 45 d9 ff ff       	call   80102d20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053db:	83 ec 08             	sub    $0x8,%esp
801053de:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053e1:	50                   	push   %eax
801053e2:	6a 00                	push   $0x0
801053e4:	e8 d7 f6 ff ff       	call   80104ac0 <argstr>
801053e9:	83 c4 10             	add    $0x10,%esp
801053ec:	85 c0                	test   %eax,%eax
801053ee:	78 30                	js     80105420 <sys_mkdir+0x50>
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	31 c9                	xor    %ecx,%ecx
801053f5:	ba 01 00 00 00       	mov    $0x1,%edx
801053fa:	6a 00                	push   $0x0
801053fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053ff:	e8 ac f7 ff ff       	call   80104bb0 <create>
80105404:	83 c4 10             	add    $0x10,%esp
80105407:	85 c0                	test   %eax,%eax
80105409:	74 15                	je     80105420 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010540b:	83 ec 0c             	sub    $0xc,%esp
8010540e:	50                   	push   %eax
8010540f:	e8 6c c6 ff ff       	call   80101a80 <iunlockput>
  end_op();
80105414:	e8 77 d9 ff ff       	call   80102d90 <end_op>
  return 0;
80105419:	83 c4 10             	add    $0x10,%esp
8010541c:	31 c0                	xor    %eax,%eax
}
8010541e:	c9                   	leave
8010541f:	c3                   	ret
    end_op();
80105420:	e8 6b d9 ff ff       	call   80102d90 <end_op>
    return -1;
80105425:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010542a:	c9                   	leave
8010542b:	c3                   	ret
8010542c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105430 <sys_mknod>:

int
sys_mknod(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105436:	e8 e5 d8 ff ff       	call   80102d20 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010543b:	83 ec 08             	sub    $0x8,%esp
8010543e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105441:	50                   	push   %eax
80105442:	6a 00                	push   $0x0
80105444:	e8 77 f6 ff ff       	call   80104ac0 <argstr>
80105449:	83 c4 10             	add    $0x10,%esp
8010544c:	85 c0                	test   %eax,%eax
8010544e:	78 60                	js     801054b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105450:	83 ec 08             	sub    $0x8,%esp
80105453:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105456:	50                   	push   %eax
80105457:	6a 01                	push   $0x1
80105459:	e8 a2 f5 ff ff       	call   80104a00 <argint>
  if((argstr(0, &path)) < 0 ||
8010545e:	83 c4 10             	add    $0x10,%esp
80105461:	85 c0                	test   %eax,%eax
80105463:	78 4b                	js     801054b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105465:	83 ec 08             	sub    $0x8,%esp
80105468:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010546b:	50                   	push   %eax
8010546c:	6a 02                	push   $0x2
8010546e:	e8 8d f5 ff ff       	call   80104a00 <argint>
     argint(1, &major) < 0 ||
80105473:	83 c4 10             	add    $0x10,%esp
80105476:	85 c0                	test   %eax,%eax
80105478:	78 36                	js     801054b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010547a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010547e:	83 ec 0c             	sub    $0xc,%esp
80105481:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105485:	ba 03 00 00 00       	mov    $0x3,%edx
8010548a:	50                   	push   %eax
8010548b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010548e:	e8 1d f7 ff ff       	call   80104bb0 <create>
     argint(2, &minor) < 0 ||
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	74 16                	je     801054b0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010549a:	83 ec 0c             	sub    $0xc,%esp
8010549d:	50                   	push   %eax
8010549e:	e8 dd c5 ff ff       	call   80101a80 <iunlockput>
  end_op();
801054a3:	e8 e8 d8 ff ff       	call   80102d90 <end_op>
  return 0;
801054a8:	83 c4 10             	add    $0x10,%esp
801054ab:	31 c0                	xor    %eax,%eax
}
801054ad:	c9                   	leave
801054ae:	c3                   	ret
801054af:	90                   	nop
    end_op();
801054b0:	e8 db d8 ff ff       	call   80102d90 <end_op>
    return -1;
801054b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054ba:	c9                   	leave
801054bb:	c3                   	ret
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_chdir>:

int
sys_chdir(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	56                   	push   %esi
801054c4:	53                   	push   %ebx
801054c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801054c8:	e8 83 e4 ff ff       	call   80103950 <myproc>
801054cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801054cf:	e8 4c d8 ff ff       	call   80102d20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054d4:	83 ec 08             	sub    $0x8,%esp
801054d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054da:	50                   	push   %eax
801054db:	6a 00                	push   $0x0
801054dd:	e8 de f5 ff ff       	call   80104ac0 <argstr>
801054e2:	83 c4 10             	add    $0x10,%esp
801054e5:	85 c0                	test   %eax,%eax
801054e7:	78 77                	js     80105560 <sys_chdir+0xa0>
801054e9:	83 ec 0c             	sub    $0xc,%esp
801054ec:	ff 75 f4             	push   -0xc(%ebp)
801054ef:	e8 2c cc ff ff       	call   80102120 <namei>
801054f4:	83 c4 10             	add    $0x10,%esp
801054f7:	89 c3                	mov    %eax,%ebx
801054f9:	85 c0                	test   %eax,%eax
801054fb:	74 63                	je     80105560 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801054fd:	83 ec 0c             	sub    $0xc,%esp
80105500:	50                   	push   %eax
80105501:	e8 ea c2 ff ff       	call   801017f0 <ilock>
  if(ip->type != T_DIR){
80105506:	83 c4 10             	add    $0x10,%esp
80105509:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010550e:	75 30                	jne    80105540 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105510:	83 ec 0c             	sub    $0xc,%esp
80105513:	53                   	push   %ebx
80105514:	e8 b7 c3 ff ff       	call   801018d0 <iunlock>
  iput(curproc->cwd);
80105519:	58                   	pop    %eax
8010551a:	ff 76 68             	push   0x68(%esi)
8010551d:	e8 fe c3 ff ff       	call   80101920 <iput>
  end_op();
80105522:	e8 69 d8 ff ff       	call   80102d90 <end_op>
  curproc->cwd = ip;
80105527:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010552a:	83 c4 10             	add    $0x10,%esp
8010552d:	31 c0                	xor    %eax,%eax
}
8010552f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105532:	5b                   	pop    %ebx
80105533:	5e                   	pop    %esi
80105534:	5d                   	pop    %ebp
80105535:	c3                   	ret
80105536:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010553d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105540:	83 ec 0c             	sub    $0xc,%esp
80105543:	53                   	push   %ebx
80105544:	e8 37 c5 ff ff       	call   80101a80 <iunlockput>
    end_op();
80105549:	e8 42 d8 ff ff       	call   80102d90 <end_op>
    return -1;
8010554e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105551:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105556:	eb d7                	jmp    8010552f <sys_chdir+0x6f>
80105558:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555f:	90                   	nop
    end_op();
80105560:	e8 2b d8 ff ff       	call   80102d90 <end_op>
    return -1;
80105565:	eb ea                	jmp    80105551 <sys_chdir+0x91>
80105567:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010556e:	66 90                	xchg   %ax,%ax

80105570 <sys_exec>:

int
sys_exec(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105575:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010557b:	53                   	push   %ebx
8010557c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105582:	50                   	push   %eax
80105583:	6a 00                	push   $0x0
80105585:	e8 36 f5 ff ff       	call   80104ac0 <argstr>
8010558a:	83 c4 10             	add    $0x10,%esp
8010558d:	85 c0                	test   %eax,%eax
8010558f:	0f 88 87 00 00 00    	js     8010561c <sys_exec+0xac>
80105595:	83 ec 08             	sub    $0x8,%esp
80105598:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010559e:	50                   	push   %eax
8010559f:	6a 01                	push   $0x1
801055a1:	e8 5a f4 ff ff       	call   80104a00 <argint>
801055a6:	83 c4 10             	add    $0x10,%esp
801055a9:	85 c0                	test   %eax,%eax
801055ab:	78 6f                	js     8010561c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801055ad:	83 ec 04             	sub    $0x4,%esp
801055b0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801055b6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801055b8:	68 80 00 00 00       	push   $0x80
801055bd:	6a 00                	push   $0x0
801055bf:	56                   	push   %esi
801055c0:	e8 8b f1 ff ff       	call   80104750 <memset>
801055c5:	83 c4 10             	add    $0x10,%esp
801055c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055cf:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055d0:	83 ec 08             	sub    $0x8,%esp
801055d3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801055d9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801055e0:	50                   	push   %eax
801055e1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055e7:	01 f8                	add    %edi,%eax
801055e9:	50                   	push   %eax
801055ea:	e8 81 f3 ff ff       	call   80104970 <fetchint>
801055ef:	83 c4 10             	add    $0x10,%esp
801055f2:	85 c0                	test   %eax,%eax
801055f4:	78 26                	js     8010561c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801055f6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801055fc:	85 c0                	test   %eax,%eax
801055fe:	74 30                	je     80105630 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105600:	83 ec 08             	sub    $0x8,%esp
80105603:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105606:	52                   	push   %edx
80105607:	50                   	push   %eax
80105608:	e8 a3 f3 ff ff       	call   801049b0 <fetchstr>
8010560d:	83 c4 10             	add    $0x10,%esp
80105610:	85 c0                	test   %eax,%eax
80105612:	78 08                	js     8010561c <sys_exec+0xac>
  for(i=0;; i++){
80105614:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105617:	83 fb 20             	cmp    $0x20,%ebx
8010561a:	75 b4                	jne    801055d0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010561c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010561f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105624:	5b                   	pop    %ebx
80105625:	5e                   	pop    %esi
80105626:	5f                   	pop    %edi
80105627:	5d                   	pop    %ebp
80105628:	c3                   	ret
80105629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105630:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105637:	00 00 00 00 
  return exec(path, argv);
8010563b:	83 ec 08             	sub    $0x8,%esp
8010563e:	56                   	push   %esi
8010563f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105645:	e8 96 b4 ff ff       	call   80100ae0 <exec>
8010564a:	83 c4 10             	add    $0x10,%esp
}
8010564d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105650:	5b                   	pop    %ebx
80105651:	5e                   	pop    %esi
80105652:	5f                   	pop    %edi
80105653:	5d                   	pop    %ebp
80105654:	c3                   	ret
80105655:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105660 <sys_pipe>:

int
sys_pipe(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105665:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105668:	53                   	push   %ebx
80105669:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010566c:	6a 08                	push   $0x8
8010566e:	50                   	push   %eax
8010566f:	6a 00                	push   $0x0
80105671:	e8 da f3 ff ff       	call   80104a50 <argptr>
80105676:	83 c4 10             	add    $0x10,%esp
80105679:	85 c0                	test   %eax,%eax
8010567b:	0f 88 8b 00 00 00    	js     8010570c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105681:	83 ec 08             	sub    $0x8,%esp
80105684:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105687:	50                   	push   %eax
80105688:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010568b:	50                   	push   %eax
8010568c:	e8 5f dd ff ff       	call   801033f0 <pipealloc>
80105691:	83 c4 10             	add    $0x10,%esp
80105694:	85 c0                	test   %eax,%eax
80105696:	78 74                	js     8010570c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105698:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010569b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010569d:	e8 ae e2 ff ff       	call   80103950 <myproc>
    if(curproc->ofile[fd] == 0){
801056a2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056a6:	85 f6                	test   %esi,%esi
801056a8:	74 16                	je     801056c0 <sys_pipe+0x60>
801056aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801056b0:	83 c3 01             	add    $0x1,%ebx
801056b3:	83 fb 10             	cmp    $0x10,%ebx
801056b6:	74 3d                	je     801056f5 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
801056b8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056bc:	85 f6                	test   %esi,%esi
801056be:	75 f0                	jne    801056b0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801056c0:	8d 73 08             	lea    0x8(%ebx),%esi
801056c3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801056ca:	e8 81 e2 ff ff       	call   80103950 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801056cf:	31 d2                	xor    %edx,%edx
801056d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056d8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056dc:	85 c9                	test   %ecx,%ecx
801056de:	74 38                	je     80105718 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
801056e0:	83 c2 01             	add    $0x1,%edx
801056e3:	83 fa 10             	cmp    $0x10,%edx
801056e6:	75 f0                	jne    801056d8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801056e8:	e8 63 e2 ff ff       	call   80103950 <myproc>
801056ed:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801056f4:	00 
    fileclose(rf);
801056f5:	83 ec 0c             	sub    $0xc,%esp
801056f8:	ff 75 e0             	push   -0x20(%ebp)
801056fb:	e8 40 b8 ff ff       	call   80100f40 <fileclose>
    fileclose(wf);
80105700:	58                   	pop    %eax
80105701:	ff 75 e4             	push   -0x1c(%ebp)
80105704:	e8 37 b8 ff ff       	call   80100f40 <fileclose>
    return -1;
80105709:	83 c4 10             	add    $0x10,%esp
    return -1;
8010570c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105711:	eb 16                	jmp    80105729 <sys_pipe+0xc9>
80105713:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105717:	90                   	nop
      curproc->ofile[fd] = f;
80105718:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010571c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010571f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105721:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105724:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105727:	31 c0                	xor    %eax,%eax
}
80105729:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010572c:	5b                   	pop    %ebx
8010572d:	5e                   	pop    %esi
8010572e:	5f                   	pop    %edi
8010572f:	5d                   	pop    %ebp
80105730:	c3                   	ret
80105731:	66 90                	xchg   %ax,%ax
80105733:	66 90                	xchg   %ax,%ax
80105735:	66 90                	xchg   %ax,%ax
80105737:	66 90                	xchg   %ax,%ax
80105739:	66 90                	xchg   %ax,%ax
8010573b:	66 90                	xchg   %ax,%ax
8010573d:	66 90                	xchg   %ax,%ax
8010573f:	90                   	nop

80105740 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105740:	e9 ab e3 ff ff       	jmp    80103af0 <fork>
80105745:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105750 <sys_exit>:
}

int
sys_exit(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	83 ec 08             	sub    $0x8,%esp
  exit();
80105756:	e8 15 e6 ff ff       	call   80103d70 <exit>
  return 0;  // not reached
}
8010575b:	31 c0                	xor    %eax,%eax
8010575d:	c9                   	leave
8010575e:	c3                   	ret
8010575f:	90                   	nop

80105760 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105760:	e9 3b e7 ff ff       	jmp    80103ea0 <wait>
80105765:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010576c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105770 <sys_kill>:
}

int
sys_kill(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105776:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105779:	50                   	push   %eax
8010577a:	6a 00                	push   $0x0
8010577c:	e8 7f f2 ff ff       	call   80104a00 <argint>
80105781:	83 c4 10             	add    $0x10,%esp
80105784:	85 c0                	test   %eax,%eax
80105786:	78 18                	js     801057a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105788:	83 ec 0c             	sub    $0xc,%esp
8010578b:	ff 75 f4             	push   -0xc(%ebp)
8010578e:	e8 ad e9 ff ff       	call   80104140 <kill>
80105793:	83 c4 10             	add    $0x10,%esp
}
80105796:	c9                   	leave
80105797:	c3                   	ret
80105798:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010579f:	90                   	nop
801057a0:	c9                   	leave
    return -1;
801057a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057a6:	c3                   	ret
801057a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057ae:	66 90                	xchg   %ax,%ax

801057b0 <sys_getpid>:

int
sys_getpid(void)
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801057b6:	e8 95 e1 ff ff       	call   80103950 <myproc>
801057bb:	8b 40 10             	mov    0x10(%eax),%eax
}
801057be:	c9                   	leave
801057bf:	c3                   	ret

801057c0 <sys_sbrk>:

int
sys_sbrk(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057c4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057c7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057ca:	50                   	push   %eax
801057cb:	6a 00                	push   $0x0
801057cd:	e8 2e f2 ff ff       	call   80104a00 <argint>
801057d2:	83 c4 10             	add    $0x10,%esp
801057d5:	85 c0                	test   %eax,%eax
801057d7:	78 27                	js     80105800 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801057d9:	e8 72 e1 ff ff       	call   80103950 <myproc>
  if(growproc(n) < 0)
801057de:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801057e1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801057e3:	ff 75 f4             	push   -0xc(%ebp)
801057e6:	e8 85 e2 ff ff       	call   80103a70 <growproc>
801057eb:	83 c4 10             	add    $0x10,%esp
801057ee:	85 c0                	test   %eax,%eax
801057f0:	78 0e                	js     80105800 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801057f2:	89 d8                	mov    %ebx,%eax
801057f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057f7:	c9                   	leave
801057f8:	c3                   	ret
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105800:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105805:	eb eb                	jmp    801057f2 <sys_sbrk+0x32>
80105807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010580e:	66 90                	xchg   %ax,%ax

80105810 <sys_sleep>:

int
sys_sleep(void)
{
80105810:	55                   	push   %ebp
80105811:	89 e5                	mov    %esp,%ebp
80105813:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105814:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105817:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010581a:	50                   	push   %eax
8010581b:	6a 00                	push   $0x0
8010581d:	e8 de f1 ff ff       	call   80104a00 <argint>
80105822:	83 c4 10             	add    $0x10,%esp
80105825:	85 c0                	test   %eax,%eax
80105827:	78 64                	js     8010588d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105829:	83 ec 0c             	sub    $0xc,%esp
8010582c:	68 60 e7 11 80       	push   $0x8011e760
80105831:	e8 8a ed ff ff       	call   801045c0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105836:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105839:	8b 1d 40 e7 11 80    	mov    0x8011e740,%ebx
  while(ticks - ticks0 < n){
8010583f:	83 c4 10             	add    $0x10,%esp
80105842:	85 d2                	test   %edx,%edx
80105844:	75 2b                	jne    80105871 <sys_sleep+0x61>
80105846:	eb 58                	jmp    801058a0 <sys_sleep+0x90>
80105848:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105850:	83 ec 08             	sub    $0x8,%esp
80105853:	68 60 e7 11 80       	push   $0x8011e760
80105858:	68 40 e7 11 80       	push   $0x8011e740
8010585d:	e8 be e7 ff ff       	call   80104020 <sleep>
  while(ticks - ticks0 < n){
80105862:	a1 40 e7 11 80       	mov    0x8011e740,%eax
80105867:	83 c4 10             	add    $0x10,%esp
8010586a:	29 d8                	sub    %ebx,%eax
8010586c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010586f:	73 2f                	jae    801058a0 <sys_sleep+0x90>
    if(myproc()->killed){
80105871:	e8 da e0 ff ff       	call   80103950 <myproc>
80105876:	8b 40 24             	mov    0x24(%eax),%eax
80105879:	85 c0                	test   %eax,%eax
8010587b:	74 d3                	je     80105850 <sys_sleep+0x40>
      release(&tickslock);
8010587d:	83 ec 0c             	sub    $0xc,%esp
80105880:	68 60 e7 11 80       	push   $0x8011e760
80105885:	e8 76 ee ff ff       	call   80104700 <release>
      return -1;
8010588a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
8010588d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105895:	c9                   	leave
80105896:	c3                   	ret
80105897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010589e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
801058a0:	83 ec 0c             	sub    $0xc,%esp
801058a3:	68 60 e7 11 80       	push   $0x8011e760
801058a8:	e8 53 ee ff ff       	call   80104700 <release>
}
801058ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
801058b0:	83 c4 10             	add    $0x10,%esp
801058b3:	31 c0                	xor    %eax,%eax
}
801058b5:	c9                   	leave
801058b6:	c3                   	ret
801058b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058be:	66 90                	xchg   %ax,%ax

801058c0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	53                   	push   %ebx
801058c4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801058c7:	68 60 e7 11 80       	push   $0x8011e760
801058cc:	e8 ef ec ff ff       	call   801045c0 <acquire>
  xticks = ticks;
801058d1:	8b 1d 40 e7 11 80    	mov    0x8011e740,%ebx
  release(&tickslock);
801058d7:	c7 04 24 60 e7 11 80 	movl   $0x8011e760,(%esp)
801058de:	e8 1d ee ff ff       	call   80104700 <release>
  return xticks;
}
801058e3:	89 d8                	mov    %ebx,%eax
801058e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058e8:	c9                   	leave
801058e9:	c3                   	ret
801058ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801058f0 <sys_shutdown>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801058f0:	b8 00 20 00 00       	mov    $0x2000,%eax
801058f5:	ba 04 b0 ff ff       	mov    $0xffffb004,%edx
801058fa:	66 ef                	out    %ax,(%dx)
801058fc:	ba 04 06 00 00       	mov    $0x604,%edx
80105901:	66 ef                	out    %ax,(%dx)
  /* Either of the following will work. Does not harm to put them together. */
  outw(0xB004, 0x0|0x2000); // working for old qemu
  outw(0x604, 0x0|0x2000); // working for newer qemu
  
  return 0;
}
80105903:	31 c0                	xor    %eax,%eax
80105905:	c3                   	ret
80105906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010590d:	8d 76 00             	lea    0x0(%esi),%esi

80105910 <sys_cps>:

int
sys_cps(void)
{
  return cps();
80105910:	e9 6b e9 ff ff       	jmp    80104280 <cps>
80105915:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010591c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105920 <sys_chpr>:
}

int
sys_chpr(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 20             	sub    $0x20,%esp
  int pid, pr;
  if(argint(0, &pid) < 0)
80105926:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105929:	50                   	push   %eax
8010592a:	6a 00                	push   $0x0
8010592c:	e8 cf f0 ff ff       	call   80104a00 <argint>
80105931:	83 c4 10             	add    $0x10,%esp
80105934:	85 c0                	test   %eax,%eax
80105936:	78 28                	js     80105960 <sys_chpr+0x40>
    return -1;
  if(argint(1, &pr) < 0)
80105938:	83 ec 08             	sub    $0x8,%esp
8010593b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010593e:	50                   	push   %eax
8010593f:	6a 01                	push   $0x1
80105941:	e8 ba f0 ff ff       	call   80104a00 <argint>
80105946:	83 c4 10             	add    $0x10,%esp
80105949:	85 c0                	test   %eax,%eax
8010594b:	78 13                	js     80105960 <sys_chpr+0x40>
    return -1;

  return chpr(pid, pr);
8010594d:	83 ec 08             	sub    $0x8,%esp
80105950:	ff 75 f4             	push   -0xc(%ebp)
80105953:	ff 75 f0             	push   -0x10(%ebp)
80105956:	e8 e5 e9 ff ff       	call   80104340 <chpr>
8010595b:	83 c4 10             	add    $0x10,%esp
}
8010595e:	c9                   	leave
8010595f:	c3                   	ret
80105960:	c9                   	leave
    return -1;
80105961:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105966:	c3                   	ret

80105967 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105967:	1e                   	push   %ds
  pushl %es
80105968:	06                   	push   %es
  pushl %fs
80105969:	0f a0                	push   %fs
  pushl %gs
8010596b:	0f a8                	push   %gs
  pushal
8010596d:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010596e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105972:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105974:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105976:	54                   	push   %esp
  call trap
80105977:	e8 c4 00 00 00       	call   80105a40 <trap>
  addl $4, %esp
8010597c:	83 c4 04             	add    $0x4,%esp

8010597f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010597f:	61                   	popa
  popl %gs
80105980:	0f a9                	pop    %gs
  popl %fs
80105982:	0f a1                	pop    %fs
  popl %es
80105984:	07                   	pop    %es
  popl %ds
80105985:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105986:	83 c4 08             	add    $0x8,%esp
  iret
80105989:	cf                   	iret
8010598a:	66 90                	xchg   %ax,%ax
8010598c:	66 90                	xchg   %ax,%ax
8010598e:	66 90                	xchg   %ax,%ax

80105990 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105990:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105991:	31 c0                	xor    %eax,%eax
{
80105993:	89 e5                	mov    %esp,%ebp
80105995:	83 ec 08             	sub    $0x8,%esp
80105998:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010599f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801059a0:	8b 14 85 08 90 10 80 	mov    -0x7fef6ff8(,%eax,4),%edx
801059a7:	c7 04 c5 a2 e7 11 80 	movl   $0x8e000008,-0x7fee185e(,%eax,8)
801059ae:	08 00 00 8e 
801059b2:	66 89 14 c5 a0 e7 11 	mov    %dx,-0x7fee1860(,%eax,8)
801059b9:	80 
801059ba:	c1 ea 10             	shr    $0x10,%edx
801059bd:	66 89 14 c5 a6 e7 11 	mov    %dx,-0x7fee185a(,%eax,8)
801059c4:	80 
  for(i = 0; i < 256; i++)
801059c5:	83 c0 01             	add    $0x1,%eax
801059c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801059cd:	75 d1                	jne    801059a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059cf:	a1 08 91 10 80       	mov    0x80109108,%eax

  initlock(&tickslock, "time");
801059d4:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801059d7:	c7 05 a2 e9 11 80 08 	movl   $0xef000008,0x8011e9a2
801059de:	00 00 ef 
801059e1:	66 a3 a0 e9 11 80    	mov    %ax,0x8011e9a0
801059e7:	c1 e8 10             	shr    $0x10,%eax
801059ea:	66 a3 a6 e9 11 80    	mov    %ax,0x8011e9a6
  initlock(&tickslock, "time");
801059f0:	68 65 78 10 80       	push   $0x80107865
801059f5:	68 60 e7 11 80       	push   $0x8011e760
801059fa:	e8 a1 ea ff ff       	call   801044a0 <initlock>
}
801059ff:	83 c4 10             	add    $0x10,%esp
80105a02:	c9                   	leave
80105a03:	c3                   	ret
80105a04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a0f:	90                   	nop

80105a10 <idtinit>:

void
idtinit(void)
{
80105a10:	55                   	push   %ebp
  pd[0] = size-1;
80105a11:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105a16:	89 e5                	mov    %esp,%ebp
80105a18:	83 ec 10             	sub    $0x10,%esp
80105a1b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105a1f:	b8 a0 e7 11 80       	mov    $0x8011e7a0,%eax
80105a24:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105a28:	c1 e8 10             	shr    $0x10,%eax
80105a2b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105a2f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105a32:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105a35:	c9                   	leave
80105a36:	c3                   	ret
80105a37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a3e:	66 90                	xchg   %ax,%ax

80105a40 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	57                   	push   %edi
80105a44:	56                   	push   %esi
80105a45:	53                   	push   %ebx
80105a46:	83 ec 1c             	sub    $0x1c,%esp
80105a49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105a4c:	8b 43 30             	mov    0x30(%ebx),%eax
80105a4f:	83 f8 40             	cmp    $0x40,%eax
80105a52:	0f 84 68 01 00 00    	je     80105bc0 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105a58:	83 e8 20             	sub    $0x20,%eax
80105a5b:	83 f8 1f             	cmp    $0x1f,%eax
80105a5e:	0f 87 8c 00 00 00    	ja     80105af0 <trap+0xb0>
80105a64:	ff 24 85 0c 79 10 80 	jmp    *-0x7fef86f4(,%eax,4)
80105a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a6f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105a70:	e8 5b c8 ff ff       	call   801022d0 <ideintr>
    lapiceoi();
80105a75:	e8 56 ce ff ff       	call   801028d0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a7a:	e8 d1 de ff ff       	call   80103950 <myproc>
80105a7f:	85 c0                	test   %eax,%eax
80105a81:	74 1d                	je     80105aa0 <trap+0x60>
80105a83:	e8 c8 de ff ff       	call   80103950 <myproc>
80105a88:	8b 50 24             	mov    0x24(%eax),%edx
80105a8b:	85 d2                	test   %edx,%edx
80105a8d:	74 11                	je     80105aa0 <trap+0x60>
80105a8f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a93:	83 e0 03             	and    $0x3,%eax
80105a96:	66 83 f8 03          	cmp    $0x3,%ax
80105a9a:	0f 84 e8 01 00 00    	je     80105c88 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105aa0:	e8 ab de ff ff       	call   80103950 <myproc>
80105aa5:	85 c0                	test   %eax,%eax
80105aa7:	74 0f                	je     80105ab8 <trap+0x78>
80105aa9:	e8 a2 de ff ff       	call   80103950 <myproc>
80105aae:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105ab2:	0f 84 b8 00 00 00    	je     80105b70 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ab8:	e8 93 de ff ff       	call   80103950 <myproc>
80105abd:	85 c0                	test   %eax,%eax
80105abf:	74 1d                	je     80105ade <trap+0x9e>
80105ac1:	e8 8a de ff ff       	call   80103950 <myproc>
80105ac6:	8b 40 24             	mov    0x24(%eax),%eax
80105ac9:	85 c0                	test   %eax,%eax
80105acb:	74 11                	je     80105ade <trap+0x9e>
80105acd:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105ad1:	83 e0 03             	and    $0x3,%eax
80105ad4:	66 83 f8 03          	cmp    $0x3,%ax
80105ad8:	0f 84 0f 01 00 00    	je     80105bed <trap+0x1ad>
    exit();
}
80105ade:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ae1:	5b                   	pop    %ebx
80105ae2:	5e                   	pop    %esi
80105ae3:	5f                   	pop    %edi
80105ae4:	5d                   	pop    %ebp
80105ae5:	c3                   	ret
80105ae6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aed:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80105af0:	e8 5b de ff ff       	call   80103950 <myproc>
80105af5:	8b 7b 38             	mov    0x38(%ebx),%edi
80105af8:	85 c0                	test   %eax,%eax
80105afa:	0f 84 a2 01 00 00    	je     80105ca2 <trap+0x262>
80105b00:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105b04:	0f 84 98 01 00 00    	je     80105ca2 <trap+0x262>
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105b0a:	0f 20 d1             	mov    %cr2,%ecx
80105b0d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b10:	e8 1b de ff ff       	call   80103930 <cpuid>
80105b15:	8b 73 30             	mov    0x30(%ebx),%esi
80105b18:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105b1b:	8b 43 34             	mov    0x34(%ebx),%eax
80105b1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105b21:	e8 2a de ff ff       	call   80103950 <myproc>
80105b26:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105b29:	e8 22 de ff ff       	call   80103950 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b2e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105b31:	51                   	push   %ecx
80105b32:	57                   	push   %edi
80105b33:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105b36:	52                   	push   %edx
80105b37:	ff 75 e4             	push   -0x1c(%ebp)
80105b3a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105b3b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105b3e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105b41:	56                   	push   %esi
80105b42:	ff 70 10             	push   0x10(%eax)
80105b45:	68 c8 78 10 80       	push   $0x801078c8
80105b4a:	e8 61 ab ff ff       	call   801006b0 <cprintf>
    myproc()->killed = 1;
80105b4f:	83 c4 20             	add    $0x20,%esp
80105b52:	e8 f9 dd ff ff       	call   80103950 <myproc>
80105b57:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b5e:	e8 ed dd ff ff       	call   80103950 <myproc>
80105b63:	85 c0                	test   %eax,%eax
80105b65:	0f 85 18 ff ff ff    	jne    80105a83 <trap+0x43>
80105b6b:	e9 30 ff ff ff       	jmp    80105aa0 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80105b70:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b74:	0f 85 3e ff ff ff    	jne    80105ab8 <trap+0x78>
    yield();
80105b7a:	e8 51 e4 ff ff       	call   80103fd0 <yield>
80105b7f:	e9 34 ff ff ff       	jmp    80105ab8 <trap+0x78>
80105b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b88:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b8b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b8f:	e8 9c dd ff ff       	call   80103930 <cpuid>
80105b94:	57                   	push   %edi
80105b95:	56                   	push   %esi
80105b96:	50                   	push   %eax
80105b97:	68 70 78 10 80       	push   $0x80107870
80105b9c:	e8 0f ab ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80105ba1:	e8 2a cd ff ff       	call   801028d0 <lapiceoi>
    break;
80105ba6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ba9:	e8 a2 dd ff ff       	call   80103950 <myproc>
80105bae:	85 c0                	test   %eax,%eax
80105bb0:	0f 85 cd fe ff ff    	jne    80105a83 <trap+0x43>
80105bb6:	e9 e5 fe ff ff       	jmp    80105aa0 <trap+0x60>
80105bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bbf:	90                   	nop
    if(myproc()->killed)
80105bc0:	e8 8b dd ff ff       	call   80103950 <myproc>
80105bc5:	8b 70 24             	mov    0x24(%eax),%esi
80105bc8:	85 f6                	test   %esi,%esi
80105bca:	0f 85 c8 00 00 00    	jne    80105c98 <trap+0x258>
    myproc()->tf = tf;
80105bd0:	e8 7b dd ff ff       	call   80103950 <myproc>
80105bd5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105bd8:	e8 63 ef ff ff       	call   80104b40 <syscall>
    if(myproc()->killed)
80105bdd:	e8 6e dd ff ff       	call   80103950 <myproc>
80105be2:	8b 48 24             	mov    0x24(%eax),%ecx
80105be5:	85 c9                	test   %ecx,%ecx
80105be7:	0f 84 f1 fe ff ff    	je     80105ade <trap+0x9e>
}
80105bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bf0:	5b                   	pop    %ebx
80105bf1:	5e                   	pop    %esi
80105bf2:	5f                   	pop    %edi
80105bf3:	5d                   	pop    %ebp
      exit();
80105bf4:	e9 77 e1 ff ff       	jmp    80103d70 <exit>
80105bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105c00:	e8 4b 02 00 00       	call   80105e50 <uartintr>
    lapiceoi();
80105c05:	e8 c6 cc ff ff       	call   801028d0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c0a:	e8 41 dd ff ff       	call   80103950 <myproc>
80105c0f:	85 c0                	test   %eax,%eax
80105c11:	0f 85 6c fe ff ff    	jne    80105a83 <trap+0x43>
80105c17:	e9 84 fe ff ff       	jmp    80105aa0 <trap+0x60>
80105c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105c20:	e8 6b cb ff ff       	call   80102790 <kbdintr>
    lapiceoi();
80105c25:	e8 a6 cc ff ff       	call   801028d0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c2a:	e8 21 dd ff ff       	call   80103950 <myproc>
80105c2f:	85 c0                	test   %eax,%eax
80105c31:	0f 85 4c fe ff ff    	jne    80105a83 <trap+0x43>
80105c37:	e9 64 fe ff ff       	jmp    80105aa0 <trap+0x60>
80105c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105c40:	e8 eb dc ff ff       	call   80103930 <cpuid>
80105c45:	85 c0                	test   %eax,%eax
80105c47:	0f 85 28 fe ff ff    	jne    80105a75 <trap+0x35>
      acquire(&tickslock);
80105c4d:	83 ec 0c             	sub    $0xc,%esp
80105c50:	68 60 e7 11 80       	push   $0x8011e760
80105c55:	e8 66 e9 ff ff       	call   801045c0 <acquire>
      ticks++;
80105c5a:	83 05 40 e7 11 80 01 	addl   $0x1,0x8011e740
      wakeup(&ticks);
80105c61:	c7 04 24 40 e7 11 80 	movl   $0x8011e740,(%esp)
80105c68:	e8 73 e4 ff ff       	call   801040e0 <wakeup>
      release(&tickslock);
80105c6d:	c7 04 24 60 e7 11 80 	movl   $0x8011e760,(%esp)
80105c74:	e8 87 ea ff ff       	call   80104700 <release>
80105c79:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105c7c:	e9 f4 fd ff ff       	jmp    80105a75 <trap+0x35>
80105c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105c88:	e8 e3 e0 ff ff       	call   80103d70 <exit>
80105c8d:	e9 0e fe ff ff       	jmp    80105aa0 <trap+0x60>
80105c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c98:	e8 d3 e0 ff ff       	call   80103d70 <exit>
80105c9d:	e9 2e ff ff ff       	jmp    80105bd0 <trap+0x190>
80105ca2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105ca5:	e8 86 dc ff ff       	call   80103930 <cpuid>
80105caa:	83 ec 0c             	sub    $0xc,%esp
80105cad:	56                   	push   %esi
80105cae:	57                   	push   %edi
80105caf:	50                   	push   %eax
80105cb0:	ff 73 30             	push   0x30(%ebx)
80105cb3:	68 94 78 10 80       	push   $0x80107894
80105cb8:	e8 f3 a9 ff ff       	call   801006b0 <cprintf>
      panic("trap");
80105cbd:	83 c4 14             	add    $0x14,%esp
80105cc0:	68 6a 78 10 80       	push   $0x8010786a
80105cc5:	e8 b6 a6 ff ff       	call   80100380 <panic>
80105cca:	66 90                	xchg   %ax,%ax
80105ccc:	66 90                	xchg   %ax,%ax
80105cce:	66 90                	xchg   %ax,%ax

80105cd0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105cd0:	a1 a0 ef 11 80       	mov    0x8011efa0,%eax
80105cd5:	85 c0                	test   %eax,%eax
80105cd7:	74 17                	je     80105cf0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cd9:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105cde:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105cdf:	a8 01                	test   $0x1,%al
80105ce1:	74 0d                	je     80105cf0 <uartgetc+0x20>
80105ce3:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ce8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105ce9:	0f b6 c0             	movzbl %al,%eax
80105cec:	c3                   	ret
80105ced:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105cf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cf5:	c3                   	ret
80105cf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cfd:	8d 76 00             	lea    0x0(%esi),%esi

80105d00 <uartinit>:
{
80105d00:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d01:	31 c9                	xor    %ecx,%ecx
80105d03:	89 c8                	mov    %ecx,%eax
80105d05:	89 e5                	mov    %esp,%ebp
80105d07:	57                   	push   %edi
80105d08:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105d0d:	56                   	push   %esi
80105d0e:	89 fa                	mov    %edi,%edx
80105d10:	53                   	push   %ebx
80105d11:	83 ec 1c             	sub    $0x1c,%esp
80105d14:	ee                   	out    %al,(%dx)
80105d15:	be fb 03 00 00       	mov    $0x3fb,%esi
80105d1a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105d1f:	89 f2                	mov    %esi,%edx
80105d21:	ee                   	out    %al,(%dx)
80105d22:	b8 0c 00 00 00       	mov    $0xc,%eax
80105d27:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d2c:	ee                   	out    %al,(%dx)
80105d2d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105d32:	89 c8                	mov    %ecx,%eax
80105d34:	89 da                	mov    %ebx,%edx
80105d36:	ee                   	out    %al,(%dx)
80105d37:	b8 03 00 00 00       	mov    $0x3,%eax
80105d3c:	89 f2                	mov    %esi,%edx
80105d3e:	ee                   	out    %al,(%dx)
80105d3f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105d44:	89 c8                	mov    %ecx,%eax
80105d46:	ee                   	out    %al,(%dx)
80105d47:	b8 01 00 00 00       	mov    $0x1,%eax
80105d4c:	89 da                	mov    %ebx,%edx
80105d4e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d4f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d54:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105d55:	3c ff                	cmp    $0xff,%al
80105d57:	0f 84 7c 00 00 00    	je     80105dd9 <uartinit+0xd9>
  uart = 1;
80105d5d:	c7 05 a0 ef 11 80 01 	movl   $0x1,0x8011efa0
80105d64:	00 00 00 
80105d67:	89 fa                	mov    %edi,%edx
80105d69:	ec                   	in     (%dx),%al
80105d6a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d6f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d70:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d73:	bf 8c 79 10 80       	mov    $0x8010798c,%edi
80105d78:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105d7d:	6a 00                	push   $0x0
80105d7f:	6a 04                	push   $0x4
80105d81:	e8 7a c7 ff ff       	call   80102500 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105d86:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
80105d8a:	83 c4 10             	add    $0x10,%esp
80105d8d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105d90:	a1 a0 ef 11 80       	mov    0x8011efa0,%eax
80105d95:	85 c0                	test   %eax,%eax
80105d97:	74 32                	je     80105dcb <uartinit+0xcb>
80105d99:	89 f2                	mov    %esi,%edx
80105d9b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d9c:	a8 20                	test   $0x20,%al
80105d9e:	75 21                	jne    80105dc1 <uartinit+0xc1>
80105da0:	bb 80 00 00 00       	mov    $0x80,%ebx
80105da5:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105da8:	83 ec 0c             	sub    $0xc,%esp
80105dab:	6a 0a                	push   $0xa
80105dad:	e8 3e cb ff ff       	call   801028f0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105db2:	83 c4 10             	add    $0x10,%esp
80105db5:	83 eb 01             	sub    $0x1,%ebx
80105db8:	74 07                	je     80105dc1 <uartinit+0xc1>
80105dba:	89 f2                	mov    %esi,%edx
80105dbc:	ec                   	in     (%dx),%al
80105dbd:	a8 20                	test   $0x20,%al
80105dbf:	74 e7                	je     80105da8 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105dc1:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dc6:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105dca:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105dcb:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105dcf:	83 c7 01             	add    $0x1,%edi
80105dd2:	88 45 e7             	mov    %al,-0x19(%ebp)
80105dd5:	84 c0                	test   %al,%al
80105dd7:	75 b7                	jne    80105d90 <uartinit+0x90>
}
80105dd9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ddc:	5b                   	pop    %ebx
80105ddd:	5e                   	pop    %esi
80105dde:	5f                   	pop    %edi
80105ddf:	5d                   	pop    %ebp
80105de0:	c3                   	ret
80105de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105def:	90                   	nop

80105df0 <uartputc>:
  if(!uart)
80105df0:	a1 a0 ef 11 80       	mov    0x8011efa0,%eax
80105df5:	85 c0                	test   %eax,%eax
80105df7:	74 4f                	je     80105e48 <uartputc+0x58>
{
80105df9:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105dfa:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105dff:	89 e5                	mov    %esp,%ebp
80105e01:	56                   	push   %esi
80105e02:	53                   	push   %ebx
80105e03:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e04:	a8 20                	test   $0x20,%al
80105e06:	75 29                	jne    80105e31 <uartputc+0x41>
80105e08:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e0d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105e18:	83 ec 0c             	sub    $0xc,%esp
80105e1b:	6a 0a                	push   $0xa
80105e1d:	e8 ce ca ff ff       	call   801028f0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e22:	83 c4 10             	add    $0x10,%esp
80105e25:	83 eb 01             	sub    $0x1,%ebx
80105e28:	74 07                	je     80105e31 <uartputc+0x41>
80105e2a:	89 f2                	mov    %esi,%edx
80105e2c:	ec                   	in     (%dx),%al
80105e2d:	a8 20                	test   $0x20,%al
80105e2f:	74 e7                	je     80105e18 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e31:	8b 45 08             	mov    0x8(%ebp),%eax
80105e34:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e39:	ee                   	out    %al,(%dx)
}
80105e3a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105e3d:	5b                   	pop    %ebx
80105e3e:	5e                   	pop    %esi
80105e3f:	5d                   	pop    %ebp
80105e40:	c3                   	ret
80105e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e48:	c3                   	ret
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e50 <uartintr>:

void
uartintr(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105e56:	68 d0 5c 10 80       	push   $0x80105cd0
80105e5b:	e8 60 aa ff ff       	call   801008c0 <consoleintr>
}
80105e60:	83 c4 10             	add    $0x10,%esp
80105e63:	c9                   	leave
80105e64:	c3                   	ret

80105e65 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105e65:	6a 00                	push   $0x0
  pushl $0
80105e67:	6a 00                	push   $0x0
  jmp alltraps
80105e69:	e9 f9 fa ff ff       	jmp    80105967 <alltraps>

80105e6e <vector1>:
.globl vector1
vector1:
  pushl $0
80105e6e:	6a 00                	push   $0x0
  pushl $1
80105e70:	6a 01                	push   $0x1
  jmp alltraps
80105e72:	e9 f0 fa ff ff       	jmp    80105967 <alltraps>

80105e77 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e77:	6a 00                	push   $0x0
  pushl $2
80105e79:	6a 02                	push   $0x2
  jmp alltraps
80105e7b:	e9 e7 fa ff ff       	jmp    80105967 <alltraps>

80105e80 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e80:	6a 00                	push   $0x0
  pushl $3
80105e82:	6a 03                	push   $0x3
  jmp alltraps
80105e84:	e9 de fa ff ff       	jmp    80105967 <alltraps>

80105e89 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $4
80105e8b:	6a 04                	push   $0x4
  jmp alltraps
80105e8d:	e9 d5 fa ff ff       	jmp    80105967 <alltraps>

80105e92 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e92:	6a 00                	push   $0x0
  pushl $5
80105e94:	6a 05                	push   $0x5
  jmp alltraps
80105e96:	e9 cc fa ff ff       	jmp    80105967 <alltraps>

80105e9b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e9b:	6a 00                	push   $0x0
  pushl $6
80105e9d:	6a 06                	push   $0x6
  jmp alltraps
80105e9f:	e9 c3 fa ff ff       	jmp    80105967 <alltraps>

80105ea4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105ea4:	6a 00                	push   $0x0
  pushl $7
80105ea6:	6a 07                	push   $0x7
  jmp alltraps
80105ea8:	e9 ba fa ff ff       	jmp    80105967 <alltraps>

80105ead <vector8>:
.globl vector8
vector8:
  pushl $8
80105ead:	6a 08                	push   $0x8
  jmp alltraps
80105eaf:	e9 b3 fa ff ff       	jmp    80105967 <alltraps>

80105eb4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105eb4:	6a 00                	push   $0x0
  pushl $9
80105eb6:	6a 09                	push   $0x9
  jmp alltraps
80105eb8:	e9 aa fa ff ff       	jmp    80105967 <alltraps>

80105ebd <vector10>:
.globl vector10
vector10:
  pushl $10
80105ebd:	6a 0a                	push   $0xa
  jmp alltraps
80105ebf:	e9 a3 fa ff ff       	jmp    80105967 <alltraps>

80105ec4 <vector11>:
.globl vector11
vector11:
  pushl $11
80105ec4:	6a 0b                	push   $0xb
  jmp alltraps
80105ec6:	e9 9c fa ff ff       	jmp    80105967 <alltraps>

80105ecb <vector12>:
.globl vector12
vector12:
  pushl $12
80105ecb:	6a 0c                	push   $0xc
  jmp alltraps
80105ecd:	e9 95 fa ff ff       	jmp    80105967 <alltraps>

80105ed2 <vector13>:
.globl vector13
vector13:
  pushl $13
80105ed2:	6a 0d                	push   $0xd
  jmp alltraps
80105ed4:	e9 8e fa ff ff       	jmp    80105967 <alltraps>

80105ed9 <vector14>:
.globl vector14
vector14:
  pushl $14
80105ed9:	6a 0e                	push   $0xe
  jmp alltraps
80105edb:	e9 87 fa ff ff       	jmp    80105967 <alltraps>

80105ee0 <vector15>:
.globl vector15
vector15:
  pushl $0
80105ee0:	6a 00                	push   $0x0
  pushl $15
80105ee2:	6a 0f                	push   $0xf
  jmp alltraps
80105ee4:	e9 7e fa ff ff       	jmp    80105967 <alltraps>

80105ee9 <vector16>:
.globl vector16
vector16:
  pushl $0
80105ee9:	6a 00                	push   $0x0
  pushl $16
80105eeb:	6a 10                	push   $0x10
  jmp alltraps
80105eed:	e9 75 fa ff ff       	jmp    80105967 <alltraps>

80105ef2 <vector17>:
.globl vector17
vector17:
  pushl $17
80105ef2:	6a 11                	push   $0x11
  jmp alltraps
80105ef4:	e9 6e fa ff ff       	jmp    80105967 <alltraps>

80105ef9 <vector18>:
.globl vector18
vector18:
  pushl $0
80105ef9:	6a 00                	push   $0x0
  pushl $18
80105efb:	6a 12                	push   $0x12
  jmp alltraps
80105efd:	e9 65 fa ff ff       	jmp    80105967 <alltraps>

80105f02 <vector19>:
.globl vector19
vector19:
  pushl $0
80105f02:	6a 00                	push   $0x0
  pushl $19
80105f04:	6a 13                	push   $0x13
  jmp alltraps
80105f06:	e9 5c fa ff ff       	jmp    80105967 <alltraps>

80105f0b <vector20>:
.globl vector20
vector20:
  pushl $0
80105f0b:	6a 00                	push   $0x0
  pushl $20
80105f0d:	6a 14                	push   $0x14
  jmp alltraps
80105f0f:	e9 53 fa ff ff       	jmp    80105967 <alltraps>

80105f14 <vector21>:
.globl vector21
vector21:
  pushl $0
80105f14:	6a 00                	push   $0x0
  pushl $21
80105f16:	6a 15                	push   $0x15
  jmp alltraps
80105f18:	e9 4a fa ff ff       	jmp    80105967 <alltraps>

80105f1d <vector22>:
.globl vector22
vector22:
  pushl $0
80105f1d:	6a 00                	push   $0x0
  pushl $22
80105f1f:	6a 16                	push   $0x16
  jmp alltraps
80105f21:	e9 41 fa ff ff       	jmp    80105967 <alltraps>

80105f26 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f26:	6a 00                	push   $0x0
  pushl $23
80105f28:	6a 17                	push   $0x17
  jmp alltraps
80105f2a:	e9 38 fa ff ff       	jmp    80105967 <alltraps>

80105f2f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f2f:	6a 00                	push   $0x0
  pushl $24
80105f31:	6a 18                	push   $0x18
  jmp alltraps
80105f33:	e9 2f fa ff ff       	jmp    80105967 <alltraps>

80105f38 <vector25>:
.globl vector25
vector25:
  pushl $0
80105f38:	6a 00                	push   $0x0
  pushl $25
80105f3a:	6a 19                	push   $0x19
  jmp alltraps
80105f3c:	e9 26 fa ff ff       	jmp    80105967 <alltraps>

80105f41 <vector26>:
.globl vector26
vector26:
  pushl $0
80105f41:	6a 00                	push   $0x0
  pushl $26
80105f43:	6a 1a                	push   $0x1a
  jmp alltraps
80105f45:	e9 1d fa ff ff       	jmp    80105967 <alltraps>

80105f4a <vector27>:
.globl vector27
vector27:
  pushl $0
80105f4a:	6a 00                	push   $0x0
  pushl $27
80105f4c:	6a 1b                	push   $0x1b
  jmp alltraps
80105f4e:	e9 14 fa ff ff       	jmp    80105967 <alltraps>

80105f53 <vector28>:
.globl vector28
vector28:
  pushl $0
80105f53:	6a 00                	push   $0x0
  pushl $28
80105f55:	6a 1c                	push   $0x1c
  jmp alltraps
80105f57:	e9 0b fa ff ff       	jmp    80105967 <alltraps>

80105f5c <vector29>:
.globl vector29
vector29:
  pushl $0
80105f5c:	6a 00                	push   $0x0
  pushl $29
80105f5e:	6a 1d                	push   $0x1d
  jmp alltraps
80105f60:	e9 02 fa ff ff       	jmp    80105967 <alltraps>

80105f65 <vector30>:
.globl vector30
vector30:
  pushl $0
80105f65:	6a 00                	push   $0x0
  pushl $30
80105f67:	6a 1e                	push   $0x1e
  jmp alltraps
80105f69:	e9 f9 f9 ff ff       	jmp    80105967 <alltraps>

80105f6e <vector31>:
.globl vector31
vector31:
  pushl $0
80105f6e:	6a 00                	push   $0x0
  pushl $31
80105f70:	6a 1f                	push   $0x1f
  jmp alltraps
80105f72:	e9 f0 f9 ff ff       	jmp    80105967 <alltraps>

80105f77 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f77:	6a 00                	push   $0x0
  pushl $32
80105f79:	6a 20                	push   $0x20
  jmp alltraps
80105f7b:	e9 e7 f9 ff ff       	jmp    80105967 <alltraps>

80105f80 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f80:	6a 00                	push   $0x0
  pushl $33
80105f82:	6a 21                	push   $0x21
  jmp alltraps
80105f84:	e9 de f9 ff ff       	jmp    80105967 <alltraps>

80105f89 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f89:	6a 00                	push   $0x0
  pushl $34
80105f8b:	6a 22                	push   $0x22
  jmp alltraps
80105f8d:	e9 d5 f9 ff ff       	jmp    80105967 <alltraps>

80105f92 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f92:	6a 00                	push   $0x0
  pushl $35
80105f94:	6a 23                	push   $0x23
  jmp alltraps
80105f96:	e9 cc f9 ff ff       	jmp    80105967 <alltraps>

80105f9b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f9b:	6a 00                	push   $0x0
  pushl $36
80105f9d:	6a 24                	push   $0x24
  jmp alltraps
80105f9f:	e9 c3 f9 ff ff       	jmp    80105967 <alltraps>

80105fa4 <vector37>:
.globl vector37
vector37:
  pushl $0
80105fa4:	6a 00                	push   $0x0
  pushl $37
80105fa6:	6a 25                	push   $0x25
  jmp alltraps
80105fa8:	e9 ba f9 ff ff       	jmp    80105967 <alltraps>

80105fad <vector38>:
.globl vector38
vector38:
  pushl $0
80105fad:	6a 00                	push   $0x0
  pushl $38
80105faf:	6a 26                	push   $0x26
  jmp alltraps
80105fb1:	e9 b1 f9 ff ff       	jmp    80105967 <alltraps>

80105fb6 <vector39>:
.globl vector39
vector39:
  pushl $0
80105fb6:	6a 00                	push   $0x0
  pushl $39
80105fb8:	6a 27                	push   $0x27
  jmp alltraps
80105fba:	e9 a8 f9 ff ff       	jmp    80105967 <alltraps>

80105fbf <vector40>:
.globl vector40
vector40:
  pushl $0
80105fbf:	6a 00                	push   $0x0
  pushl $40
80105fc1:	6a 28                	push   $0x28
  jmp alltraps
80105fc3:	e9 9f f9 ff ff       	jmp    80105967 <alltraps>

80105fc8 <vector41>:
.globl vector41
vector41:
  pushl $0
80105fc8:	6a 00                	push   $0x0
  pushl $41
80105fca:	6a 29                	push   $0x29
  jmp alltraps
80105fcc:	e9 96 f9 ff ff       	jmp    80105967 <alltraps>

80105fd1 <vector42>:
.globl vector42
vector42:
  pushl $0
80105fd1:	6a 00                	push   $0x0
  pushl $42
80105fd3:	6a 2a                	push   $0x2a
  jmp alltraps
80105fd5:	e9 8d f9 ff ff       	jmp    80105967 <alltraps>

80105fda <vector43>:
.globl vector43
vector43:
  pushl $0
80105fda:	6a 00                	push   $0x0
  pushl $43
80105fdc:	6a 2b                	push   $0x2b
  jmp alltraps
80105fde:	e9 84 f9 ff ff       	jmp    80105967 <alltraps>

80105fe3 <vector44>:
.globl vector44
vector44:
  pushl $0
80105fe3:	6a 00                	push   $0x0
  pushl $44
80105fe5:	6a 2c                	push   $0x2c
  jmp alltraps
80105fe7:	e9 7b f9 ff ff       	jmp    80105967 <alltraps>

80105fec <vector45>:
.globl vector45
vector45:
  pushl $0
80105fec:	6a 00                	push   $0x0
  pushl $45
80105fee:	6a 2d                	push   $0x2d
  jmp alltraps
80105ff0:	e9 72 f9 ff ff       	jmp    80105967 <alltraps>

80105ff5 <vector46>:
.globl vector46
vector46:
  pushl $0
80105ff5:	6a 00                	push   $0x0
  pushl $46
80105ff7:	6a 2e                	push   $0x2e
  jmp alltraps
80105ff9:	e9 69 f9 ff ff       	jmp    80105967 <alltraps>

80105ffe <vector47>:
.globl vector47
vector47:
  pushl $0
80105ffe:	6a 00                	push   $0x0
  pushl $47
80106000:	6a 2f                	push   $0x2f
  jmp alltraps
80106002:	e9 60 f9 ff ff       	jmp    80105967 <alltraps>

80106007 <vector48>:
.globl vector48
vector48:
  pushl $0
80106007:	6a 00                	push   $0x0
  pushl $48
80106009:	6a 30                	push   $0x30
  jmp alltraps
8010600b:	e9 57 f9 ff ff       	jmp    80105967 <alltraps>

80106010 <vector49>:
.globl vector49
vector49:
  pushl $0
80106010:	6a 00                	push   $0x0
  pushl $49
80106012:	6a 31                	push   $0x31
  jmp alltraps
80106014:	e9 4e f9 ff ff       	jmp    80105967 <alltraps>

80106019 <vector50>:
.globl vector50
vector50:
  pushl $0
80106019:	6a 00                	push   $0x0
  pushl $50
8010601b:	6a 32                	push   $0x32
  jmp alltraps
8010601d:	e9 45 f9 ff ff       	jmp    80105967 <alltraps>

80106022 <vector51>:
.globl vector51
vector51:
  pushl $0
80106022:	6a 00                	push   $0x0
  pushl $51
80106024:	6a 33                	push   $0x33
  jmp alltraps
80106026:	e9 3c f9 ff ff       	jmp    80105967 <alltraps>

8010602b <vector52>:
.globl vector52
vector52:
  pushl $0
8010602b:	6a 00                	push   $0x0
  pushl $52
8010602d:	6a 34                	push   $0x34
  jmp alltraps
8010602f:	e9 33 f9 ff ff       	jmp    80105967 <alltraps>

80106034 <vector53>:
.globl vector53
vector53:
  pushl $0
80106034:	6a 00                	push   $0x0
  pushl $53
80106036:	6a 35                	push   $0x35
  jmp alltraps
80106038:	e9 2a f9 ff ff       	jmp    80105967 <alltraps>

8010603d <vector54>:
.globl vector54
vector54:
  pushl $0
8010603d:	6a 00                	push   $0x0
  pushl $54
8010603f:	6a 36                	push   $0x36
  jmp alltraps
80106041:	e9 21 f9 ff ff       	jmp    80105967 <alltraps>

80106046 <vector55>:
.globl vector55
vector55:
  pushl $0
80106046:	6a 00                	push   $0x0
  pushl $55
80106048:	6a 37                	push   $0x37
  jmp alltraps
8010604a:	e9 18 f9 ff ff       	jmp    80105967 <alltraps>

8010604f <vector56>:
.globl vector56
vector56:
  pushl $0
8010604f:	6a 00                	push   $0x0
  pushl $56
80106051:	6a 38                	push   $0x38
  jmp alltraps
80106053:	e9 0f f9 ff ff       	jmp    80105967 <alltraps>

80106058 <vector57>:
.globl vector57
vector57:
  pushl $0
80106058:	6a 00                	push   $0x0
  pushl $57
8010605a:	6a 39                	push   $0x39
  jmp alltraps
8010605c:	e9 06 f9 ff ff       	jmp    80105967 <alltraps>

80106061 <vector58>:
.globl vector58
vector58:
  pushl $0
80106061:	6a 00                	push   $0x0
  pushl $58
80106063:	6a 3a                	push   $0x3a
  jmp alltraps
80106065:	e9 fd f8 ff ff       	jmp    80105967 <alltraps>

8010606a <vector59>:
.globl vector59
vector59:
  pushl $0
8010606a:	6a 00                	push   $0x0
  pushl $59
8010606c:	6a 3b                	push   $0x3b
  jmp alltraps
8010606e:	e9 f4 f8 ff ff       	jmp    80105967 <alltraps>

80106073 <vector60>:
.globl vector60
vector60:
  pushl $0
80106073:	6a 00                	push   $0x0
  pushl $60
80106075:	6a 3c                	push   $0x3c
  jmp alltraps
80106077:	e9 eb f8 ff ff       	jmp    80105967 <alltraps>

8010607c <vector61>:
.globl vector61
vector61:
  pushl $0
8010607c:	6a 00                	push   $0x0
  pushl $61
8010607e:	6a 3d                	push   $0x3d
  jmp alltraps
80106080:	e9 e2 f8 ff ff       	jmp    80105967 <alltraps>

80106085 <vector62>:
.globl vector62
vector62:
  pushl $0
80106085:	6a 00                	push   $0x0
  pushl $62
80106087:	6a 3e                	push   $0x3e
  jmp alltraps
80106089:	e9 d9 f8 ff ff       	jmp    80105967 <alltraps>

8010608e <vector63>:
.globl vector63
vector63:
  pushl $0
8010608e:	6a 00                	push   $0x0
  pushl $63
80106090:	6a 3f                	push   $0x3f
  jmp alltraps
80106092:	e9 d0 f8 ff ff       	jmp    80105967 <alltraps>

80106097 <vector64>:
.globl vector64
vector64:
  pushl $0
80106097:	6a 00                	push   $0x0
  pushl $64
80106099:	6a 40                	push   $0x40
  jmp alltraps
8010609b:	e9 c7 f8 ff ff       	jmp    80105967 <alltraps>

801060a0 <vector65>:
.globl vector65
vector65:
  pushl $0
801060a0:	6a 00                	push   $0x0
  pushl $65
801060a2:	6a 41                	push   $0x41
  jmp alltraps
801060a4:	e9 be f8 ff ff       	jmp    80105967 <alltraps>

801060a9 <vector66>:
.globl vector66
vector66:
  pushl $0
801060a9:	6a 00                	push   $0x0
  pushl $66
801060ab:	6a 42                	push   $0x42
  jmp alltraps
801060ad:	e9 b5 f8 ff ff       	jmp    80105967 <alltraps>

801060b2 <vector67>:
.globl vector67
vector67:
  pushl $0
801060b2:	6a 00                	push   $0x0
  pushl $67
801060b4:	6a 43                	push   $0x43
  jmp alltraps
801060b6:	e9 ac f8 ff ff       	jmp    80105967 <alltraps>

801060bb <vector68>:
.globl vector68
vector68:
  pushl $0
801060bb:	6a 00                	push   $0x0
  pushl $68
801060bd:	6a 44                	push   $0x44
  jmp alltraps
801060bf:	e9 a3 f8 ff ff       	jmp    80105967 <alltraps>

801060c4 <vector69>:
.globl vector69
vector69:
  pushl $0
801060c4:	6a 00                	push   $0x0
  pushl $69
801060c6:	6a 45                	push   $0x45
  jmp alltraps
801060c8:	e9 9a f8 ff ff       	jmp    80105967 <alltraps>

801060cd <vector70>:
.globl vector70
vector70:
  pushl $0
801060cd:	6a 00                	push   $0x0
  pushl $70
801060cf:	6a 46                	push   $0x46
  jmp alltraps
801060d1:	e9 91 f8 ff ff       	jmp    80105967 <alltraps>

801060d6 <vector71>:
.globl vector71
vector71:
  pushl $0
801060d6:	6a 00                	push   $0x0
  pushl $71
801060d8:	6a 47                	push   $0x47
  jmp alltraps
801060da:	e9 88 f8 ff ff       	jmp    80105967 <alltraps>

801060df <vector72>:
.globl vector72
vector72:
  pushl $0
801060df:	6a 00                	push   $0x0
  pushl $72
801060e1:	6a 48                	push   $0x48
  jmp alltraps
801060e3:	e9 7f f8 ff ff       	jmp    80105967 <alltraps>

801060e8 <vector73>:
.globl vector73
vector73:
  pushl $0
801060e8:	6a 00                	push   $0x0
  pushl $73
801060ea:	6a 49                	push   $0x49
  jmp alltraps
801060ec:	e9 76 f8 ff ff       	jmp    80105967 <alltraps>

801060f1 <vector74>:
.globl vector74
vector74:
  pushl $0
801060f1:	6a 00                	push   $0x0
  pushl $74
801060f3:	6a 4a                	push   $0x4a
  jmp alltraps
801060f5:	e9 6d f8 ff ff       	jmp    80105967 <alltraps>

801060fa <vector75>:
.globl vector75
vector75:
  pushl $0
801060fa:	6a 00                	push   $0x0
  pushl $75
801060fc:	6a 4b                	push   $0x4b
  jmp alltraps
801060fe:	e9 64 f8 ff ff       	jmp    80105967 <alltraps>

80106103 <vector76>:
.globl vector76
vector76:
  pushl $0
80106103:	6a 00                	push   $0x0
  pushl $76
80106105:	6a 4c                	push   $0x4c
  jmp alltraps
80106107:	e9 5b f8 ff ff       	jmp    80105967 <alltraps>

8010610c <vector77>:
.globl vector77
vector77:
  pushl $0
8010610c:	6a 00                	push   $0x0
  pushl $77
8010610e:	6a 4d                	push   $0x4d
  jmp alltraps
80106110:	e9 52 f8 ff ff       	jmp    80105967 <alltraps>

80106115 <vector78>:
.globl vector78
vector78:
  pushl $0
80106115:	6a 00                	push   $0x0
  pushl $78
80106117:	6a 4e                	push   $0x4e
  jmp alltraps
80106119:	e9 49 f8 ff ff       	jmp    80105967 <alltraps>

8010611e <vector79>:
.globl vector79
vector79:
  pushl $0
8010611e:	6a 00                	push   $0x0
  pushl $79
80106120:	6a 4f                	push   $0x4f
  jmp alltraps
80106122:	e9 40 f8 ff ff       	jmp    80105967 <alltraps>

80106127 <vector80>:
.globl vector80
vector80:
  pushl $0
80106127:	6a 00                	push   $0x0
  pushl $80
80106129:	6a 50                	push   $0x50
  jmp alltraps
8010612b:	e9 37 f8 ff ff       	jmp    80105967 <alltraps>

80106130 <vector81>:
.globl vector81
vector81:
  pushl $0
80106130:	6a 00                	push   $0x0
  pushl $81
80106132:	6a 51                	push   $0x51
  jmp alltraps
80106134:	e9 2e f8 ff ff       	jmp    80105967 <alltraps>

80106139 <vector82>:
.globl vector82
vector82:
  pushl $0
80106139:	6a 00                	push   $0x0
  pushl $82
8010613b:	6a 52                	push   $0x52
  jmp alltraps
8010613d:	e9 25 f8 ff ff       	jmp    80105967 <alltraps>

80106142 <vector83>:
.globl vector83
vector83:
  pushl $0
80106142:	6a 00                	push   $0x0
  pushl $83
80106144:	6a 53                	push   $0x53
  jmp alltraps
80106146:	e9 1c f8 ff ff       	jmp    80105967 <alltraps>

8010614b <vector84>:
.globl vector84
vector84:
  pushl $0
8010614b:	6a 00                	push   $0x0
  pushl $84
8010614d:	6a 54                	push   $0x54
  jmp alltraps
8010614f:	e9 13 f8 ff ff       	jmp    80105967 <alltraps>

80106154 <vector85>:
.globl vector85
vector85:
  pushl $0
80106154:	6a 00                	push   $0x0
  pushl $85
80106156:	6a 55                	push   $0x55
  jmp alltraps
80106158:	e9 0a f8 ff ff       	jmp    80105967 <alltraps>

8010615d <vector86>:
.globl vector86
vector86:
  pushl $0
8010615d:	6a 00                	push   $0x0
  pushl $86
8010615f:	6a 56                	push   $0x56
  jmp alltraps
80106161:	e9 01 f8 ff ff       	jmp    80105967 <alltraps>

80106166 <vector87>:
.globl vector87
vector87:
  pushl $0
80106166:	6a 00                	push   $0x0
  pushl $87
80106168:	6a 57                	push   $0x57
  jmp alltraps
8010616a:	e9 f8 f7 ff ff       	jmp    80105967 <alltraps>

8010616f <vector88>:
.globl vector88
vector88:
  pushl $0
8010616f:	6a 00                	push   $0x0
  pushl $88
80106171:	6a 58                	push   $0x58
  jmp alltraps
80106173:	e9 ef f7 ff ff       	jmp    80105967 <alltraps>

80106178 <vector89>:
.globl vector89
vector89:
  pushl $0
80106178:	6a 00                	push   $0x0
  pushl $89
8010617a:	6a 59                	push   $0x59
  jmp alltraps
8010617c:	e9 e6 f7 ff ff       	jmp    80105967 <alltraps>

80106181 <vector90>:
.globl vector90
vector90:
  pushl $0
80106181:	6a 00                	push   $0x0
  pushl $90
80106183:	6a 5a                	push   $0x5a
  jmp alltraps
80106185:	e9 dd f7 ff ff       	jmp    80105967 <alltraps>

8010618a <vector91>:
.globl vector91
vector91:
  pushl $0
8010618a:	6a 00                	push   $0x0
  pushl $91
8010618c:	6a 5b                	push   $0x5b
  jmp alltraps
8010618e:	e9 d4 f7 ff ff       	jmp    80105967 <alltraps>

80106193 <vector92>:
.globl vector92
vector92:
  pushl $0
80106193:	6a 00                	push   $0x0
  pushl $92
80106195:	6a 5c                	push   $0x5c
  jmp alltraps
80106197:	e9 cb f7 ff ff       	jmp    80105967 <alltraps>

8010619c <vector93>:
.globl vector93
vector93:
  pushl $0
8010619c:	6a 00                	push   $0x0
  pushl $93
8010619e:	6a 5d                	push   $0x5d
  jmp alltraps
801061a0:	e9 c2 f7 ff ff       	jmp    80105967 <alltraps>

801061a5 <vector94>:
.globl vector94
vector94:
  pushl $0
801061a5:	6a 00                	push   $0x0
  pushl $94
801061a7:	6a 5e                	push   $0x5e
  jmp alltraps
801061a9:	e9 b9 f7 ff ff       	jmp    80105967 <alltraps>

801061ae <vector95>:
.globl vector95
vector95:
  pushl $0
801061ae:	6a 00                	push   $0x0
  pushl $95
801061b0:	6a 5f                	push   $0x5f
  jmp alltraps
801061b2:	e9 b0 f7 ff ff       	jmp    80105967 <alltraps>

801061b7 <vector96>:
.globl vector96
vector96:
  pushl $0
801061b7:	6a 00                	push   $0x0
  pushl $96
801061b9:	6a 60                	push   $0x60
  jmp alltraps
801061bb:	e9 a7 f7 ff ff       	jmp    80105967 <alltraps>

801061c0 <vector97>:
.globl vector97
vector97:
  pushl $0
801061c0:	6a 00                	push   $0x0
  pushl $97
801061c2:	6a 61                	push   $0x61
  jmp alltraps
801061c4:	e9 9e f7 ff ff       	jmp    80105967 <alltraps>

801061c9 <vector98>:
.globl vector98
vector98:
  pushl $0
801061c9:	6a 00                	push   $0x0
  pushl $98
801061cb:	6a 62                	push   $0x62
  jmp alltraps
801061cd:	e9 95 f7 ff ff       	jmp    80105967 <alltraps>

801061d2 <vector99>:
.globl vector99
vector99:
  pushl $0
801061d2:	6a 00                	push   $0x0
  pushl $99
801061d4:	6a 63                	push   $0x63
  jmp alltraps
801061d6:	e9 8c f7 ff ff       	jmp    80105967 <alltraps>

801061db <vector100>:
.globl vector100
vector100:
  pushl $0
801061db:	6a 00                	push   $0x0
  pushl $100
801061dd:	6a 64                	push   $0x64
  jmp alltraps
801061df:	e9 83 f7 ff ff       	jmp    80105967 <alltraps>

801061e4 <vector101>:
.globl vector101
vector101:
  pushl $0
801061e4:	6a 00                	push   $0x0
  pushl $101
801061e6:	6a 65                	push   $0x65
  jmp alltraps
801061e8:	e9 7a f7 ff ff       	jmp    80105967 <alltraps>

801061ed <vector102>:
.globl vector102
vector102:
  pushl $0
801061ed:	6a 00                	push   $0x0
  pushl $102
801061ef:	6a 66                	push   $0x66
  jmp alltraps
801061f1:	e9 71 f7 ff ff       	jmp    80105967 <alltraps>

801061f6 <vector103>:
.globl vector103
vector103:
  pushl $0
801061f6:	6a 00                	push   $0x0
  pushl $103
801061f8:	6a 67                	push   $0x67
  jmp alltraps
801061fa:	e9 68 f7 ff ff       	jmp    80105967 <alltraps>

801061ff <vector104>:
.globl vector104
vector104:
  pushl $0
801061ff:	6a 00                	push   $0x0
  pushl $104
80106201:	6a 68                	push   $0x68
  jmp alltraps
80106203:	e9 5f f7 ff ff       	jmp    80105967 <alltraps>

80106208 <vector105>:
.globl vector105
vector105:
  pushl $0
80106208:	6a 00                	push   $0x0
  pushl $105
8010620a:	6a 69                	push   $0x69
  jmp alltraps
8010620c:	e9 56 f7 ff ff       	jmp    80105967 <alltraps>

80106211 <vector106>:
.globl vector106
vector106:
  pushl $0
80106211:	6a 00                	push   $0x0
  pushl $106
80106213:	6a 6a                	push   $0x6a
  jmp alltraps
80106215:	e9 4d f7 ff ff       	jmp    80105967 <alltraps>

8010621a <vector107>:
.globl vector107
vector107:
  pushl $0
8010621a:	6a 00                	push   $0x0
  pushl $107
8010621c:	6a 6b                	push   $0x6b
  jmp alltraps
8010621e:	e9 44 f7 ff ff       	jmp    80105967 <alltraps>

80106223 <vector108>:
.globl vector108
vector108:
  pushl $0
80106223:	6a 00                	push   $0x0
  pushl $108
80106225:	6a 6c                	push   $0x6c
  jmp alltraps
80106227:	e9 3b f7 ff ff       	jmp    80105967 <alltraps>

8010622c <vector109>:
.globl vector109
vector109:
  pushl $0
8010622c:	6a 00                	push   $0x0
  pushl $109
8010622e:	6a 6d                	push   $0x6d
  jmp alltraps
80106230:	e9 32 f7 ff ff       	jmp    80105967 <alltraps>

80106235 <vector110>:
.globl vector110
vector110:
  pushl $0
80106235:	6a 00                	push   $0x0
  pushl $110
80106237:	6a 6e                	push   $0x6e
  jmp alltraps
80106239:	e9 29 f7 ff ff       	jmp    80105967 <alltraps>

8010623e <vector111>:
.globl vector111
vector111:
  pushl $0
8010623e:	6a 00                	push   $0x0
  pushl $111
80106240:	6a 6f                	push   $0x6f
  jmp alltraps
80106242:	e9 20 f7 ff ff       	jmp    80105967 <alltraps>

80106247 <vector112>:
.globl vector112
vector112:
  pushl $0
80106247:	6a 00                	push   $0x0
  pushl $112
80106249:	6a 70                	push   $0x70
  jmp alltraps
8010624b:	e9 17 f7 ff ff       	jmp    80105967 <alltraps>

80106250 <vector113>:
.globl vector113
vector113:
  pushl $0
80106250:	6a 00                	push   $0x0
  pushl $113
80106252:	6a 71                	push   $0x71
  jmp alltraps
80106254:	e9 0e f7 ff ff       	jmp    80105967 <alltraps>

80106259 <vector114>:
.globl vector114
vector114:
  pushl $0
80106259:	6a 00                	push   $0x0
  pushl $114
8010625b:	6a 72                	push   $0x72
  jmp alltraps
8010625d:	e9 05 f7 ff ff       	jmp    80105967 <alltraps>

80106262 <vector115>:
.globl vector115
vector115:
  pushl $0
80106262:	6a 00                	push   $0x0
  pushl $115
80106264:	6a 73                	push   $0x73
  jmp alltraps
80106266:	e9 fc f6 ff ff       	jmp    80105967 <alltraps>

8010626b <vector116>:
.globl vector116
vector116:
  pushl $0
8010626b:	6a 00                	push   $0x0
  pushl $116
8010626d:	6a 74                	push   $0x74
  jmp alltraps
8010626f:	e9 f3 f6 ff ff       	jmp    80105967 <alltraps>

80106274 <vector117>:
.globl vector117
vector117:
  pushl $0
80106274:	6a 00                	push   $0x0
  pushl $117
80106276:	6a 75                	push   $0x75
  jmp alltraps
80106278:	e9 ea f6 ff ff       	jmp    80105967 <alltraps>

8010627d <vector118>:
.globl vector118
vector118:
  pushl $0
8010627d:	6a 00                	push   $0x0
  pushl $118
8010627f:	6a 76                	push   $0x76
  jmp alltraps
80106281:	e9 e1 f6 ff ff       	jmp    80105967 <alltraps>

80106286 <vector119>:
.globl vector119
vector119:
  pushl $0
80106286:	6a 00                	push   $0x0
  pushl $119
80106288:	6a 77                	push   $0x77
  jmp alltraps
8010628a:	e9 d8 f6 ff ff       	jmp    80105967 <alltraps>

8010628f <vector120>:
.globl vector120
vector120:
  pushl $0
8010628f:	6a 00                	push   $0x0
  pushl $120
80106291:	6a 78                	push   $0x78
  jmp alltraps
80106293:	e9 cf f6 ff ff       	jmp    80105967 <alltraps>

80106298 <vector121>:
.globl vector121
vector121:
  pushl $0
80106298:	6a 00                	push   $0x0
  pushl $121
8010629a:	6a 79                	push   $0x79
  jmp alltraps
8010629c:	e9 c6 f6 ff ff       	jmp    80105967 <alltraps>

801062a1 <vector122>:
.globl vector122
vector122:
  pushl $0
801062a1:	6a 00                	push   $0x0
  pushl $122
801062a3:	6a 7a                	push   $0x7a
  jmp alltraps
801062a5:	e9 bd f6 ff ff       	jmp    80105967 <alltraps>

801062aa <vector123>:
.globl vector123
vector123:
  pushl $0
801062aa:	6a 00                	push   $0x0
  pushl $123
801062ac:	6a 7b                	push   $0x7b
  jmp alltraps
801062ae:	e9 b4 f6 ff ff       	jmp    80105967 <alltraps>

801062b3 <vector124>:
.globl vector124
vector124:
  pushl $0
801062b3:	6a 00                	push   $0x0
  pushl $124
801062b5:	6a 7c                	push   $0x7c
  jmp alltraps
801062b7:	e9 ab f6 ff ff       	jmp    80105967 <alltraps>

801062bc <vector125>:
.globl vector125
vector125:
  pushl $0
801062bc:	6a 00                	push   $0x0
  pushl $125
801062be:	6a 7d                	push   $0x7d
  jmp alltraps
801062c0:	e9 a2 f6 ff ff       	jmp    80105967 <alltraps>

801062c5 <vector126>:
.globl vector126
vector126:
  pushl $0
801062c5:	6a 00                	push   $0x0
  pushl $126
801062c7:	6a 7e                	push   $0x7e
  jmp alltraps
801062c9:	e9 99 f6 ff ff       	jmp    80105967 <alltraps>

801062ce <vector127>:
.globl vector127
vector127:
  pushl $0
801062ce:	6a 00                	push   $0x0
  pushl $127
801062d0:	6a 7f                	push   $0x7f
  jmp alltraps
801062d2:	e9 90 f6 ff ff       	jmp    80105967 <alltraps>

801062d7 <vector128>:
.globl vector128
vector128:
  pushl $0
801062d7:	6a 00                	push   $0x0
  pushl $128
801062d9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801062de:	e9 84 f6 ff ff       	jmp    80105967 <alltraps>

801062e3 <vector129>:
.globl vector129
vector129:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $129
801062e5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801062ea:	e9 78 f6 ff ff       	jmp    80105967 <alltraps>

801062ef <vector130>:
.globl vector130
vector130:
  pushl $0
801062ef:	6a 00                	push   $0x0
  pushl $130
801062f1:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801062f6:	e9 6c f6 ff ff       	jmp    80105967 <alltraps>

801062fb <vector131>:
.globl vector131
vector131:
  pushl $0
801062fb:	6a 00                	push   $0x0
  pushl $131
801062fd:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106302:	e9 60 f6 ff ff       	jmp    80105967 <alltraps>

80106307 <vector132>:
.globl vector132
vector132:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $132
80106309:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010630e:	e9 54 f6 ff ff       	jmp    80105967 <alltraps>

80106313 <vector133>:
.globl vector133
vector133:
  pushl $0
80106313:	6a 00                	push   $0x0
  pushl $133
80106315:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010631a:	e9 48 f6 ff ff       	jmp    80105967 <alltraps>

8010631f <vector134>:
.globl vector134
vector134:
  pushl $0
8010631f:	6a 00                	push   $0x0
  pushl $134
80106321:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106326:	e9 3c f6 ff ff       	jmp    80105967 <alltraps>

8010632b <vector135>:
.globl vector135
vector135:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $135
8010632d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106332:	e9 30 f6 ff ff       	jmp    80105967 <alltraps>

80106337 <vector136>:
.globl vector136
vector136:
  pushl $0
80106337:	6a 00                	push   $0x0
  pushl $136
80106339:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010633e:	e9 24 f6 ff ff       	jmp    80105967 <alltraps>

80106343 <vector137>:
.globl vector137
vector137:
  pushl $0
80106343:	6a 00                	push   $0x0
  pushl $137
80106345:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010634a:	e9 18 f6 ff ff       	jmp    80105967 <alltraps>

8010634f <vector138>:
.globl vector138
vector138:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $138
80106351:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106356:	e9 0c f6 ff ff       	jmp    80105967 <alltraps>

8010635b <vector139>:
.globl vector139
vector139:
  pushl $0
8010635b:	6a 00                	push   $0x0
  pushl $139
8010635d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106362:	e9 00 f6 ff ff       	jmp    80105967 <alltraps>

80106367 <vector140>:
.globl vector140
vector140:
  pushl $0
80106367:	6a 00                	push   $0x0
  pushl $140
80106369:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010636e:	e9 f4 f5 ff ff       	jmp    80105967 <alltraps>

80106373 <vector141>:
.globl vector141
vector141:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $141
80106375:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010637a:	e9 e8 f5 ff ff       	jmp    80105967 <alltraps>

8010637f <vector142>:
.globl vector142
vector142:
  pushl $0
8010637f:	6a 00                	push   $0x0
  pushl $142
80106381:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106386:	e9 dc f5 ff ff       	jmp    80105967 <alltraps>

8010638b <vector143>:
.globl vector143
vector143:
  pushl $0
8010638b:	6a 00                	push   $0x0
  pushl $143
8010638d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106392:	e9 d0 f5 ff ff       	jmp    80105967 <alltraps>

80106397 <vector144>:
.globl vector144
vector144:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $144
80106399:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010639e:	e9 c4 f5 ff ff       	jmp    80105967 <alltraps>

801063a3 <vector145>:
.globl vector145
vector145:
  pushl $0
801063a3:	6a 00                	push   $0x0
  pushl $145
801063a5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801063aa:	e9 b8 f5 ff ff       	jmp    80105967 <alltraps>

801063af <vector146>:
.globl vector146
vector146:
  pushl $0
801063af:	6a 00                	push   $0x0
  pushl $146
801063b1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801063b6:	e9 ac f5 ff ff       	jmp    80105967 <alltraps>

801063bb <vector147>:
.globl vector147
vector147:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $147
801063bd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801063c2:	e9 a0 f5 ff ff       	jmp    80105967 <alltraps>

801063c7 <vector148>:
.globl vector148
vector148:
  pushl $0
801063c7:	6a 00                	push   $0x0
  pushl $148
801063c9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801063ce:	e9 94 f5 ff ff       	jmp    80105967 <alltraps>

801063d3 <vector149>:
.globl vector149
vector149:
  pushl $0
801063d3:	6a 00                	push   $0x0
  pushl $149
801063d5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801063da:	e9 88 f5 ff ff       	jmp    80105967 <alltraps>

801063df <vector150>:
.globl vector150
vector150:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $150
801063e1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801063e6:	e9 7c f5 ff ff       	jmp    80105967 <alltraps>

801063eb <vector151>:
.globl vector151
vector151:
  pushl $0
801063eb:	6a 00                	push   $0x0
  pushl $151
801063ed:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801063f2:	e9 70 f5 ff ff       	jmp    80105967 <alltraps>

801063f7 <vector152>:
.globl vector152
vector152:
  pushl $0
801063f7:	6a 00                	push   $0x0
  pushl $152
801063f9:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801063fe:	e9 64 f5 ff ff       	jmp    80105967 <alltraps>

80106403 <vector153>:
.globl vector153
vector153:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $153
80106405:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010640a:	e9 58 f5 ff ff       	jmp    80105967 <alltraps>

8010640f <vector154>:
.globl vector154
vector154:
  pushl $0
8010640f:	6a 00                	push   $0x0
  pushl $154
80106411:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106416:	e9 4c f5 ff ff       	jmp    80105967 <alltraps>

8010641b <vector155>:
.globl vector155
vector155:
  pushl $0
8010641b:	6a 00                	push   $0x0
  pushl $155
8010641d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106422:	e9 40 f5 ff ff       	jmp    80105967 <alltraps>

80106427 <vector156>:
.globl vector156
vector156:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $156
80106429:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010642e:	e9 34 f5 ff ff       	jmp    80105967 <alltraps>

80106433 <vector157>:
.globl vector157
vector157:
  pushl $0
80106433:	6a 00                	push   $0x0
  pushl $157
80106435:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010643a:	e9 28 f5 ff ff       	jmp    80105967 <alltraps>

8010643f <vector158>:
.globl vector158
vector158:
  pushl $0
8010643f:	6a 00                	push   $0x0
  pushl $158
80106441:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106446:	e9 1c f5 ff ff       	jmp    80105967 <alltraps>

8010644b <vector159>:
.globl vector159
vector159:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $159
8010644d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106452:	e9 10 f5 ff ff       	jmp    80105967 <alltraps>

80106457 <vector160>:
.globl vector160
vector160:
  pushl $0
80106457:	6a 00                	push   $0x0
  pushl $160
80106459:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010645e:	e9 04 f5 ff ff       	jmp    80105967 <alltraps>

80106463 <vector161>:
.globl vector161
vector161:
  pushl $0
80106463:	6a 00                	push   $0x0
  pushl $161
80106465:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010646a:	e9 f8 f4 ff ff       	jmp    80105967 <alltraps>

8010646f <vector162>:
.globl vector162
vector162:
  pushl $0
8010646f:	6a 00                	push   $0x0
  pushl $162
80106471:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106476:	e9 ec f4 ff ff       	jmp    80105967 <alltraps>

8010647b <vector163>:
.globl vector163
vector163:
  pushl $0
8010647b:	6a 00                	push   $0x0
  pushl $163
8010647d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106482:	e9 e0 f4 ff ff       	jmp    80105967 <alltraps>

80106487 <vector164>:
.globl vector164
vector164:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $164
80106489:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010648e:	e9 d4 f4 ff ff       	jmp    80105967 <alltraps>

80106493 <vector165>:
.globl vector165
vector165:
  pushl $0
80106493:	6a 00                	push   $0x0
  pushl $165
80106495:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010649a:	e9 c8 f4 ff ff       	jmp    80105967 <alltraps>

8010649f <vector166>:
.globl vector166
vector166:
  pushl $0
8010649f:	6a 00                	push   $0x0
  pushl $166
801064a1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801064a6:	e9 bc f4 ff ff       	jmp    80105967 <alltraps>

801064ab <vector167>:
.globl vector167
vector167:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $167
801064ad:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801064b2:	e9 b0 f4 ff ff       	jmp    80105967 <alltraps>

801064b7 <vector168>:
.globl vector168
vector168:
  pushl $0
801064b7:	6a 00                	push   $0x0
  pushl $168
801064b9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801064be:	e9 a4 f4 ff ff       	jmp    80105967 <alltraps>

801064c3 <vector169>:
.globl vector169
vector169:
  pushl $0
801064c3:	6a 00                	push   $0x0
  pushl $169
801064c5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
801064ca:	e9 98 f4 ff ff       	jmp    80105967 <alltraps>

801064cf <vector170>:
.globl vector170
vector170:
  pushl $0
801064cf:	6a 00                	push   $0x0
  pushl $170
801064d1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801064d6:	e9 8c f4 ff ff       	jmp    80105967 <alltraps>

801064db <vector171>:
.globl vector171
vector171:
  pushl $0
801064db:	6a 00                	push   $0x0
  pushl $171
801064dd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801064e2:	e9 80 f4 ff ff       	jmp    80105967 <alltraps>

801064e7 <vector172>:
.globl vector172
vector172:
  pushl $0
801064e7:	6a 00                	push   $0x0
  pushl $172
801064e9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801064ee:	e9 74 f4 ff ff       	jmp    80105967 <alltraps>

801064f3 <vector173>:
.globl vector173
vector173:
  pushl $0
801064f3:	6a 00                	push   $0x0
  pushl $173
801064f5:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801064fa:	e9 68 f4 ff ff       	jmp    80105967 <alltraps>

801064ff <vector174>:
.globl vector174
vector174:
  pushl $0
801064ff:	6a 00                	push   $0x0
  pushl $174
80106501:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106506:	e9 5c f4 ff ff       	jmp    80105967 <alltraps>

8010650b <vector175>:
.globl vector175
vector175:
  pushl $0
8010650b:	6a 00                	push   $0x0
  pushl $175
8010650d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106512:	e9 50 f4 ff ff       	jmp    80105967 <alltraps>

80106517 <vector176>:
.globl vector176
vector176:
  pushl $0
80106517:	6a 00                	push   $0x0
  pushl $176
80106519:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010651e:	e9 44 f4 ff ff       	jmp    80105967 <alltraps>

80106523 <vector177>:
.globl vector177
vector177:
  pushl $0
80106523:	6a 00                	push   $0x0
  pushl $177
80106525:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010652a:	e9 38 f4 ff ff       	jmp    80105967 <alltraps>

8010652f <vector178>:
.globl vector178
vector178:
  pushl $0
8010652f:	6a 00                	push   $0x0
  pushl $178
80106531:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106536:	e9 2c f4 ff ff       	jmp    80105967 <alltraps>

8010653b <vector179>:
.globl vector179
vector179:
  pushl $0
8010653b:	6a 00                	push   $0x0
  pushl $179
8010653d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106542:	e9 20 f4 ff ff       	jmp    80105967 <alltraps>

80106547 <vector180>:
.globl vector180
vector180:
  pushl $0
80106547:	6a 00                	push   $0x0
  pushl $180
80106549:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010654e:	e9 14 f4 ff ff       	jmp    80105967 <alltraps>

80106553 <vector181>:
.globl vector181
vector181:
  pushl $0
80106553:	6a 00                	push   $0x0
  pushl $181
80106555:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010655a:	e9 08 f4 ff ff       	jmp    80105967 <alltraps>

8010655f <vector182>:
.globl vector182
vector182:
  pushl $0
8010655f:	6a 00                	push   $0x0
  pushl $182
80106561:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106566:	e9 fc f3 ff ff       	jmp    80105967 <alltraps>

8010656b <vector183>:
.globl vector183
vector183:
  pushl $0
8010656b:	6a 00                	push   $0x0
  pushl $183
8010656d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106572:	e9 f0 f3 ff ff       	jmp    80105967 <alltraps>

80106577 <vector184>:
.globl vector184
vector184:
  pushl $0
80106577:	6a 00                	push   $0x0
  pushl $184
80106579:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010657e:	e9 e4 f3 ff ff       	jmp    80105967 <alltraps>

80106583 <vector185>:
.globl vector185
vector185:
  pushl $0
80106583:	6a 00                	push   $0x0
  pushl $185
80106585:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010658a:	e9 d8 f3 ff ff       	jmp    80105967 <alltraps>

8010658f <vector186>:
.globl vector186
vector186:
  pushl $0
8010658f:	6a 00                	push   $0x0
  pushl $186
80106591:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106596:	e9 cc f3 ff ff       	jmp    80105967 <alltraps>

8010659b <vector187>:
.globl vector187
vector187:
  pushl $0
8010659b:	6a 00                	push   $0x0
  pushl $187
8010659d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801065a2:	e9 c0 f3 ff ff       	jmp    80105967 <alltraps>

801065a7 <vector188>:
.globl vector188
vector188:
  pushl $0
801065a7:	6a 00                	push   $0x0
  pushl $188
801065a9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801065ae:	e9 b4 f3 ff ff       	jmp    80105967 <alltraps>

801065b3 <vector189>:
.globl vector189
vector189:
  pushl $0
801065b3:	6a 00                	push   $0x0
  pushl $189
801065b5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801065ba:	e9 a8 f3 ff ff       	jmp    80105967 <alltraps>

801065bf <vector190>:
.globl vector190
vector190:
  pushl $0
801065bf:	6a 00                	push   $0x0
  pushl $190
801065c1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
801065c6:	e9 9c f3 ff ff       	jmp    80105967 <alltraps>

801065cb <vector191>:
.globl vector191
vector191:
  pushl $0
801065cb:	6a 00                	push   $0x0
  pushl $191
801065cd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801065d2:	e9 90 f3 ff ff       	jmp    80105967 <alltraps>

801065d7 <vector192>:
.globl vector192
vector192:
  pushl $0
801065d7:	6a 00                	push   $0x0
  pushl $192
801065d9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801065de:	e9 84 f3 ff ff       	jmp    80105967 <alltraps>

801065e3 <vector193>:
.globl vector193
vector193:
  pushl $0
801065e3:	6a 00                	push   $0x0
  pushl $193
801065e5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801065ea:	e9 78 f3 ff ff       	jmp    80105967 <alltraps>

801065ef <vector194>:
.globl vector194
vector194:
  pushl $0
801065ef:	6a 00                	push   $0x0
  pushl $194
801065f1:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801065f6:	e9 6c f3 ff ff       	jmp    80105967 <alltraps>

801065fb <vector195>:
.globl vector195
vector195:
  pushl $0
801065fb:	6a 00                	push   $0x0
  pushl $195
801065fd:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106602:	e9 60 f3 ff ff       	jmp    80105967 <alltraps>

80106607 <vector196>:
.globl vector196
vector196:
  pushl $0
80106607:	6a 00                	push   $0x0
  pushl $196
80106609:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010660e:	e9 54 f3 ff ff       	jmp    80105967 <alltraps>

80106613 <vector197>:
.globl vector197
vector197:
  pushl $0
80106613:	6a 00                	push   $0x0
  pushl $197
80106615:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010661a:	e9 48 f3 ff ff       	jmp    80105967 <alltraps>

8010661f <vector198>:
.globl vector198
vector198:
  pushl $0
8010661f:	6a 00                	push   $0x0
  pushl $198
80106621:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106626:	e9 3c f3 ff ff       	jmp    80105967 <alltraps>

8010662b <vector199>:
.globl vector199
vector199:
  pushl $0
8010662b:	6a 00                	push   $0x0
  pushl $199
8010662d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106632:	e9 30 f3 ff ff       	jmp    80105967 <alltraps>

80106637 <vector200>:
.globl vector200
vector200:
  pushl $0
80106637:	6a 00                	push   $0x0
  pushl $200
80106639:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010663e:	e9 24 f3 ff ff       	jmp    80105967 <alltraps>

80106643 <vector201>:
.globl vector201
vector201:
  pushl $0
80106643:	6a 00                	push   $0x0
  pushl $201
80106645:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010664a:	e9 18 f3 ff ff       	jmp    80105967 <alltraps>

8010664f <vector202>:
.globl vector202
vector202:
  pushl $0
8010664f:	6a 00                	push   $0x0
  pushl $202
80106651:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106656:	e9 0c f3 ff ff       	jmp    80105967 <alltraps>

8010665b <vector203>:
.globl vector203
vector203:
  pushl $0
8010665b:	6a 00                	push   $0x0
  pushl $203
8010665d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106662:	e9 00 f3 ff ff       	jmp    80105967 <alltraps>

80106667 <vector204>:
.globl vector204
vector204:
  pushl $0
80106667:	6a 00                	push   $0x0
  pushl $204
80106669:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010666e:	e9 f4 f2 ff ff       	jmp    80105967 <alltraps>

80106673 <vector205>:
.globl vector205
vector205:
  pushl $0
80106673:	6a 00                	push   $0x0
  pushl $205
80106675:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010667a:	e9 e8 f2 ff ff       	jmp    80105967 <alltraps>

8010667f <vector206>:
.globl vector206
vector206:
  pushl $0
8010667f:	6a 00                	push   $0x0
  pushl $206
80106681:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106686:	e9 dc f2 ff ff       	jmp    80105967 <alltraps>

8010668b <vector207>:
.globl vector207
vector207:
  pushl $0
8010668b:	6a 00                	push   $0x0
  pushl $207
8010668d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106692:	e9 d0 f2 ff ff       	jmp    80105967 <alltraps>

80106697 <vector208>:
.globl vector208
vector208:
  pushl $0
80106697:	6a 00                	push   $0x0
  pushl $208
80106699:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010669e:	e9 c4 f2 ff ff       	jmp    80105967 <alltraps>

801066a3 <vector209>:
.globl vector209
vector209:
  pushl $0
801066a3:	6a 00                	push   $0x0
  pushl $209
801066a5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801066aa:	e9 b8 f2 ff ff       	jmp    80105967 <alltraps>

801066af <vector210>:
.globl vector210
vector210:
  pushl $0
801066af:	6a 00                	push   $0x0
  pushl $210
801066b1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801066b6:	e9 ac f2 ff ff       	jmp    80105967 <alltraps>

801066bb <vector211>:
.globl vector211
vector211:
  pushl $0
801066bb:	6a 00                	push   $0x0
  pushl $211
801066bd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801066c2:	e9 a0 f2 ff ff       	jmp    80105967 <alltraps>

801066c7 <vector212>:
.globl vector212
vector212:
  pushl $0
801066c7:	6a 00                	push   $0x0
  pushl $212
801066c9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801066ce:	e9 94 f2 ff ff       	jmp    80105967 <alltraps>

801066d3 <vector213>:
.globl vector213
vector213:
  pushl $0
801066d3:	6a 00                	push   $0x0
  pushl $213
801066d5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801066da:	e9 88 f2 ff ff       	jmp    80105967 <alltraps>

801066df <vector214>:
.globl vector214
vector214:
  pushl $0
801066df:	6a 00                	push   $0x0
  pushl $214
801066e1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801066e6:	e9 7c f2 ff ff       	jmp    80105967 <alltraps>

801066eb <vector215>:
.globl vector215
vector215:
  pushl $0
801066eb:	6a 00                	push   $0x0
  pushl $215
801066ed:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801066f2:	e9 70 f2 ff ff       	jmp    80105967 <alltraps>

801066f7 <vector216>:
.globl vector216
vector216:
  pushl $0
801066f7:	6a 00                	push   $0x0
  pushl $216
801066f9:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801066fe:	e9 64 f2 ff ff       	jmp    80105967 <alltraps>

80106703 <vector217>:
.globl vector217
vector217:
  pushl $0
80106703:	6a 00                	push   $0x0
  pushl $217
80106705:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010670a:	e9 58 f2 ff ff       	jmp    80105967 <alltraps>

8010670f <vector218>:
.globl vector218
vector218:
  pushl $0
8010670f:	6a 00                	push   $0x0
  pushl $218
80106711:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106716:	e9 4c f2 ff ff       	jmp    80105967 <alltraps>

8010671b <vector219>:
.globl vector219
vector219:
  pushl $0
8010671b:	6a 00                	push   $0x0
  pushl $219
8010671d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106722:	e9 40 f2 ff ff       	jmp    80105967 <alltraps>

80106727 <vector220>:
.globl vector220
vector220:
  pushl $0
80106727:	6a 00                	push   $0x0
  pushl $220
80106729:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010672e:	e9 34 f2 ff ff       	jmp    80105967 <alltraps>

80106733 <vector221>:
.globl vector221
vector221:
  pushl $0
80106733:	6a 00                	push   $0x0
  pushl $221
80106735:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010673a:	e9 28 f2 ff ff       	jmp    80105967 <alltraps>

8010673f <vector222>:
.globl vector222
vector222:
  pushl $0
8010673f:	6a 00                	push   $0x0
  pushl $222
80106741:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106746:	e9 1c f2 ff ff       	jmp    80105967 <alltraps>

8010674b <vector223>:
.globl vector223
vector223:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $223
8010674d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106752:	e9 10 f2 ff ff       	jmp    80105967 <alltraps>

80106757 <vector224>:
.globl vector224
vector224:
  pushl $0
80106757:	6a 00                	push   $0x0
  pushl $224
80106759:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010675e:	e9 04 f2 ff ff       	jmp    80105967 <alltraps>

80106763 <vector225>:
.globl vector225
vector225:
  pushl $0
80106763:	6a 00                	push   $0x0
  pushl $225
80106765:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010676a:	e9 f8 f1 ff ff       	jmp    80105967 <alltraps>

8010676f <vector226>:
.globl vector226
vector226:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $226
80106771:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106776:	e9 ec f1 ff ff       	jmp    80105967 <alltraps>

8010677b <vector227>:
.globl vector227
vector227:
  pushl $0
8010677b:	6a 00                	push   $0x0
  pushl $227
8010677d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106782:	e9 e0 f1 ff ff       	jmp    80105967 <alltraps>

80106787 <vector228>:
.globl vector228
vector228:
  pushl $0
80106787:	6a 00                	push   $0x0
  pushl $228
80106789:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010678e:	e9 d4 f1 ff ff       	jmp    80105967 <alltraps>

80106793 <vector229>:
.globl vector229
vector229:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $229
80106795:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010679a:	e9 c8 f1 ff ff       	jmp    80105967 <alltraps>

8010679f <vector230>:
.globl vector230
vector230:
  pushl $0
8010679f:	6a 00                	push   $0x0
  pushl $230
801067a1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801067a6:	e9 bc f1 ff ff       	jmp    80105967 <alltraps>

801067ab <vector231>:
.globl vector231
vector231:
  pushl $0
801067ab:	6a 00                	push   $0x0
  pushl $231
801067ad:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801067b2:	e9 b0 f1 ff ff       	jmp    80105967 <alltraps>

801067b7 <vector232>:
.globl vector232
vector232:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $232
801067b9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801067be:	e9 a4 f1 ff ff       	jmp    80105967 <alltraps>

801067c3 <vector233>:
.globl vector233
vector233:
  pushl $0
801067c3:	6a 00                	push   $0x0
  pushl $233
801067c5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801067ca:	e9 98 f1 ff ff       	jmp    80105967 <alltraps>

801067cf <vector234>:
.globl vector234
vector234:
  pushl $0
801067cf:	6a 00                	push   $0x0
  pushl $234
801067d1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801067d6:	e9 8c f1 ff ff       	jmp    80105967 <alltraps>

801067db <vector235>:
.globl vector235
vector235:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $235
801067dd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801067e2:	e9 80 f1 ff ff       	jmp    80105967 <alltraps>

801067e7 <vector236>:
.globl vector236
vector236:
  pushl $0
801067e7:	6a 00                	push   $0x0
  pushl $236
801067e9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801067ee:	e9 74 f1 ff ff       	jmp    80105967 <alltraps>

801067f3 <vector237>:
.globl vector237
vector237:
  pushl $0
801067f3:	6a 00                	push   $0x0
  pushl $237
801067f5:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801067fa:	e9 68 f1 ff ff       	jmp    80105967 <alltraps>

801067ff <vector238>:
.globl vector238
vector238:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $238
80106801:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106806:	e9 5c f1 ff ff       	jmp    80105967 <alltraps>

8010680b <vector239>:
.globl vector239
vector239:
  pushl $0
8010680b:	6a 00                	push   $0x0
  pushl $239
8010680d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106812:	e9 50 f1 ff ff       	jmp    80105967 <alltraps>

80106817 <vector240>:
.globl vector240
vector240:
  pushl $0
80106817:	6a 00                	push   $0x0
  pushl $240
80106819:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010681e:	e9 44 f1 ff ff       	jmp    80105967 <alltraps>

80106823 <vector241>:
.globl vector241
vector241:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $241
80106825:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010682a:	e9 38 f1 ff ff       	jmp    80105967 <alltraps>

8010682f <vector242>:
.globl vector242
vector242:
  pushl $0
8010682f:	6a 00                	push   $0x0
  pushl $242
80106831:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106836:	e9 2c f1 ff ff       	jmp    80105967 <alltraps>

8010683b <vector243>:
.globl vector243
vector243:
  pushl $0
8010683b:	6a 00                	push   $0x0
  pushl $243
8010683d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106842:	e9 20 f1 ff ff       	jmp    80105967 <alltraps>

80106847 <vector244>:
.globl vector244
vector244:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $244
80106849:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010684e:	e9 14 f1 ff ff       	jmp    80105967 <alltraps>

80106853 <vector245>:
.globl vector245
vector245:
  pushl $0
80106853:	6a 00                	push   $0x0
  pushl $245
80106855:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010685a:	e9 08 f1 ff ff       	jmp    80105967 <alltraps>

8010685f <vector246>:
.globl vector246
vector246:
  pushl $0
8010685f:	6a 00                	push   $0x0
  pushl $246
80106861:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106866:	e9 fc f0 ff ff       	jmp    80105967 <alltraps>

8010686b <vector247>:
.globl vector247
vector247:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $247
8010686d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106872:	e9 f0 f0 ff ff       	jmp    80105967 <alltraps>

80106877 <vector248>:
.globl vector248
vector248:
  pushl $0
80106877:	6a 00                	push   $0x0
  pushl $248
80106879:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010687e:	e9 e4 f0 ff ff       	jmp    80105967 <alltraps>

80106883 <vector249>:
.globl vector249
vector249:
  pushl $0
80106883:	6a 00                	push   $0x0
  pushl $249
80106885:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010688a:	e9 d8 f0 ff ff       	jmp    80105967 <alltraps>

8010688f <vector250>:
.globl vector250
vector250:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $250
80106891:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106896:	e9 cc f0 ff ff       	jmp    80105967 <alltraps>

8010689b <vector251>:
.globl vector251
vector251:
  pushl $0
8010689b:	6a 00                	push   $0x0
  pushl $251
8010689d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801068a2:	e9 c0 f0 ff ff       	jmp    80105967 <alltraps>

801068a7 <vector252>:
.globl vector252
vector252:
  pushl $0
801068a7:	6a 00                	push   $0x0
  pushl $252
801068a9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801068ae:	e9 b4 f0 ff ff       	jmp    80105967 <alltraps>

801068b3 <vector253>:
.globl vector253
vector253:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $253
801068b5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801068ba:	e9 a8 f0 ff ff       	jmp    80105967 <alltraps>

801068bf <vector254>:
.globl vector254
vector254:
  pushl $0
801068bf:	6a 00                	push   $0x0
  pushl $254
801068c1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801068c6:	e9 9c f0 ff ff       	jmp    80105967 <alltraps>

801068cb <vector255>:
.globl vector255
vector255:
  pushl $0
801068cb:	6a 00                	push   $0x0
  pushl $255
801068cd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801068d2:	e9 90 f0 ff ff       	jmp    80105967 <alltraps>
801068d7:	66 90                	xchg   %ax,%ax
801068d9:	66 90                	xchg   %ax,%ax
801068db:	66 90                	xchg   %ax,%ax
801068dd:	66 90                	xchg   %ax,%ax
801068df:	90                   	nop

801068e0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	57                   	push   %edi
801068e4:	56                   	push   %esi
801068e5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801068e6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801068ec:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801068f2:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
801068f5:	39 d3                	cmp    %edx,%ebx
801068f7:	73 56                	jae    8010694f <deallocuvm.part.0+0x6f>
801068f9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801068fc:	89 c6                	mov    %eax,%esi
801068fe:	89 d7                	mov    %edx,%edi
80106900:	eb 12                	jmp    80106914 <deallocuvm.part.0+0x34>
80106902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106908:	83 c2 01             	add    $0x1,%edx
8010690b:	89 d3                	mov    %edx,%ebx
8010690d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106910:	39 fb                	cmp    %edi,%ebx
80106912:	73 38                	jae    8010694c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106914:	89 da                	mov    %ebx,%edx
80106916:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106919:	8b 04 96             	mov    (%esi,%edx,4),%eax
8010691c:	a8 01                	test   $0x1,%al
8010691e:	74 e8                	je     80106908 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106920:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106922:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106927:	c1 e9 0a             	shr    $0xa,%ecx
8010692a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106930:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106937:	85 c0                	test   %eax,%eax
80106939:	74 cd                	je     80106908 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
8010693b:	8b 10                	mov    (%eax),%edx
8010693d:	f6 c2 01             	test   $0x1,%dl
80106940:	75 1e                	jne    80106960 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106942:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106948:	39 fb                	cmp    %edi,%ebx
8010694a:	72 c8                	jb     80106914 <deallocuvm.part.0+0x34>
8010694c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
8010694f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106952:	89 c8                	mov    %ecx,%eax
80106954:	5b                   	pop    %ebx
80106955:	5e                   	pop    %esi
80106956:	5f                   	pop    %edi
80106957:	5d                   	pop    %ebp
80106958:	c3                   	ret
80106959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106960:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106966:	74 26                	je     8010698e <deallocuvm.part.0+0xae>
      kfree(v);
80106968:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010696b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106971:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106974:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010697a:	52                   	push   %edx
8010697b:	e8 c0 bb ff ff       	call   80102540 <kfree>
      *pte = 0;
80106980:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106983:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106986:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010698c:	eb 82                	jmp    80106910 <deallocuvm.part.0+0x30>
        panic("kfree");
8010698e:	83 ec 0c             	sub    $0xc,%esp
80106991:	68 06 75 10 80       	push   $0x80107506
80106996:	e8 e5 99 ff ff       	call   80100380 <panic>
8010699b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010699f:	90                   	nop

801069a0 <mappages>:
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	57                   	push   %edi
801069a4:	56                   	push   %esi
801069a5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801069a6:	89 d3                	mov    %edx,%ebx
801069a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801069ae:	83 ec 1c             	sub    $0x1c,%esp
801069b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801069b4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801069b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069c0:	8b 45 08             	mov    0x8(%ebp),%eax
801069c3:	29 d8                	sub    %ebx,%eax
801069c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069c8:	eb 3f                	jmp    80106a09 <mappages+0x69>
801069ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801069d0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801069d7:	c1 ea 0a             	shr    $0xa,%edx
801069da:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801069e0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801069e7:	85 c0                	test   %eax,%eax
801069e9:	74 75                	je     80106a60 <mappages+0xc0>
    if(*pte & PTE_P)
801069eb:	f6 00 01             	testb  $0x1,(%eax)
801069ee:	0f 85 86 00 00 00    	jne    80106a7a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801069f4:	0b 75 0c             	or     0xc(%ebp),%esi
801069f7:	83 ce 01             	or     $0x1,%esi
801069fa:	89 30                	mov    %esi,(%eax)
    if(a == last)
801069fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801069ff:	39 c3                	cmp    %eax,%ebx
80106a01:	74 6d                	je     80106a70 <mappages+0xd0>
    a += PGSIZE;
80106a03:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106a09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106a0c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106a0f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106a12:	89 d8                	mov    %ebx,%eax
80106a14:	c1 e8 16             	shr    $0x16,%eax
80106a17:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106a1a:	8b 07                	mov    (%edi),%eax
80106a1c:	a8 01                	test   $0x1,%al
80106a1e:	75 b0                	jne    801069d0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106a20:	e8 db bc ff ff       	call   80102700 <kalloc>
80106a25:	85 c0                	test   %eax,%eax
80106a27:	74 37                	je     80106a60 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106a29:	83 ec 04             	sub    $0x4,%esp
80106a2c:	68 00 10 00 00       	push   $0x1000
80106a31:	6a 00                	push   $0x0
80106a33:	50                   	push   %eax
80106a34:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106a37:	e8 14 dd ff ff       	call   80104750 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a3c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106a3f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106a42:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106a48:	83 c8 07             	or     $0x7,%eax
80106a4b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106a4d:	89 d8                	mov    %ebx,%eax
80106a4f:	c1 e8 0a             	shr    $0xa,%eax
80106a52:	25 fc 0f 00 00       	and    $0xffc,%eax
80106a57:	01 d0                	add    %edx,%eax
80106a59:	eb 90                	jmp    801069eb <mappages+0x4b>
80106a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a5f:	90                   	nop
}
80106a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106a63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106a68:	5b                   	pop    %ebx
80106a69:	5e                   	pop    %esi
80106a6a:	5f                   	pop    %edi
80106a6b:	5d                   	pop    %ebp
80106a6c:	c3                   	ret
80106a6d:	8d 76 00             	lea    0x0(%esi),%esi
80106a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a73:	31 c0                	xor    %eax,%eax
}
80106a75:	5b                   	pop    %ebx
80106a76:	5e                   	pop    %esi
80106a77:	5f                   	pop    %edi
80106a78:	5d                   	pop    %ebp
80106a79:	c3                   	ret
      panic("remap");
80106a7a:	83 ec 0c             	sub    $0xc,%esp
80106a7d:	68 94 79 10 80       	push   $0x80107994
80106a82:	e8 f9 98 ff ff       	call   80100380 <panic>
80106a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a8e:	66 90                	xchg   %ax,%ax

80106a90 <seginit>:
{
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a96:	e8 95 ce ff ff       	call   80103930 <cpuid>
  pd[0] = size-1;
80106a9b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106aa0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106aa6:	c7 80 f8 c1 11 80 ff 	movl   $0xffff,-0x7fee3e08(%eax)
80106aad:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ab0:	c7 80 00 c2 11 80 ff 	movl   $0xffff,-0x7fee3e00(%eax)
80106ab7:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106aba:	c7 80 08 c2 11 80 ff 	movl   $0xffff,-0x7fee3df8(%eax)
80106ac1:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ac4:	c7 80 10 c2 11 80 ff 	movl   $0xffff,-0x7fee3df0(%eax)
80106acb:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106ace:	c7 80 fc c1 11 80 00 	movl   $0xcf9a00,-0x7fee3e04(%eax)
80106ad5:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106ad8:	c7 80 04 c2 11 80 00 	movl   $0xcf9200,-0x7fee3dfc(%eax)
80106adf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ae2:	c7 80 0c c2 11 80 00 	movl   $0xcffa00,-0x7fee3df4(%eax)
80106ae9:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106aec:	c7 80 14 c2 11 80 00 	movl   $0xcff200,-0x7fee3dec(%eax)
80106af3:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106af6:	05 f0 c1 11 80       	add    $0x8011c1f0,%eax
80106afb:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106aff:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106b03:	c1 e8 10             	shr    $0x10,%eax
80106b06:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106b0a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106b0d:	0f 01 10             	lgdtl  (%eax)
}
80106b10:	c9                   	leave
80106b11:	c3                   	ret
80106b12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b20 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106b20:	a1 a4 ef 11 80       	mov    0x8011efa4,%eax
80106b25:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b2a:	0f 22 d8             	mov    %eax,%cr3
}
80106b2d:	c3                   	ret
80106b2e:	66 90                	xchg   %ax,%ax

80106b30 <switchuvm>:
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	57                   	push   %edi
80106b34:	56                   	push   %esi
80106b35:	53                   	push   %ebx
80106b36:	83 ec 1c             	sub    $0x1c,%esp
80106b39:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106b3c:	85 f6                	test   %esi,%esi
80106b3e:	0f 84 cb 00 00 00    	je     80106c0f <switchuvm+0xdf>
  if(p->kstack == 0)
80106b44:	8b 46 08             	mov    0x8(%esi),%eax
80106b47:	85 c0                	test   %eax,%eax
80106b49:	0f 84 da 00 00 00    	je     80106c29 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106b4f:	8b 46 04             	mov    0x4(%esi),%eax
80106b52:	85 c0                	test   %eax,%eax
80106b54:	0f 84 c2 00 00 00    	je     80106c1c <switchuvm+0xec>
  pushcli();
80106b5a:	e8 11 da ff ff       	call   80104570 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b5f:	e8 6c cd ff ff       	call   801038d0 <mycpu>
80106b64:	89 c3                	mov    %eax,%ebx
80106b66:	e8 65 cd ff ff       	call   801038d0 <mycpu>
80106b6b:	89 c7                	mov    %eax,%edi
80106b6d:	e8 5e cd ff ff       	call   801038d0 <mycpu>
80106b72:	83 c7 08             	add    $0x8,%edi
80106b75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b78:	e8 53 cd ff ff       	call   801038d0 <mycpu>
80106b7d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b80:	ba 67 00 00 00       	mov    $0x67,%edx
80106b85:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106b8c:	83 c0 08             	add    $0x8,%eax
80106b8f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b96:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b9b:	83 c1 08             	add    $0x8,%ecx
80106b9e:	c1 e8 18             	shr    $0x18,%eax
80106ba1:	c1 e9 10             	shr    $0x10,%ecx
80106ba4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106baa:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106bb0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106bb5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bbc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106bc1:	e8 0a cd ff ff       	call   801038d0 <mycpu>
80106bc6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106bcd:	e8 fe cc ff ff       	call   801038d0 <mycpu>
80106bd2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106bd6:	8b 5e 08             	mov    0x8(%esi),%ebx
80106bd9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bdf:	e8 ec cc ff ff       	call   801038d0 <mycpu>
80106be4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106be7:	e8 e4 cc ff ff       	call   801038d0 <mycpu>
80106bec:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106bf0:	b8 28 00 00 00       	mov    $0x28,%eax
80106bf5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106bf8:	8b 46 04             	mov    0x4(%esi),%eax
80106bfb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c00:	0f 22 d8             	mov    %eax,%cr3
}
80106c03:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c06:	5b                   	pop    %ebx
80106c07:	5e                   	pop    %esi
80106c08:	5f                   	pop    %edi
80106c09:	5d                   	pop    %ebp
  popcli();
80106c0a:	e9 91 da ff ff       	jmp    801046a0 <popcli>
    panic("switchuvm: no process");
80106c0f:	83 ec 0c             	sub    $0xc,%esp
80106c12:	68 9a 79 10 80       	push   $0x8010799a
80106c17:	e8 64 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106c1c:	83 ec 0c             	sub    $0xc,%esp
80106c1f:	68 c5 79 10 80       	push   $0x801079c5
80106c24:	e8 57 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106c29:	83 ec 0c             	sub    $0xc,%esp
80106c2c:	68 b0 79 10 80       	push   $0x801079b0
80106c31:	e8 4a 97 ff ff       	call   80100380 <panic>
80106c36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c3d:	8d 76 00             	lea    0x0(%esi),%esi

80106c40 <inituvm>:
{
80106c40:	55                   	push   %ebp
80106c41:	89 e5                	mov    %esp,%ebp
80106c43:	57                   	push   %edi
80106c44:	56                   	push   %esi
80106c45:	53                   	push   %ebx
80106c46:	83 ec 1c             	sub    $0x1c,%esp
80106c49:	8b 45 08             	mov    0x8(%ebp),%eax
80106c4c:	8b 75 10             	mov    0x10(%ebp),%esi
80106c4f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106c52:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106c55:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106c5b:	77 49                	ja     80106ca6 <inituvm+0x66>
  mem = kalloc();
80106c5d:	e8 9e ba ff ff       	call   80102700 <kalloc>
  memset(mem, 0, PGSIZE);
80106c62:	83 ec 04             	sub    $0x4,%esp
80106c65:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106c6a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106c6c:	6a 00                	push   $0x0
80106c6e:	50                   	push   %eax
80106c6f:	e8 dc da ff ff       	call   80104750 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c74:	58                   	pop    %eax
80106c75:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c7b:	5a                   	pop    %edx
80106c7c:	6a 06                	push   $0x6
80106c7e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c83:	31 d2                	xor    %edx,%edx
80106c85:	50                   	push   %eax
80106c86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c89:	e8 12 fd ff ff       	call   801069a0 <mappages>
  memmove(mem, init, sz);
80106c8e:	89 75 10             	mov    %esi,0x10(%ebp)
80106c91:	83 c4 10             	add    $0x10,%esp
80106c94:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c97:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c9a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c9d:	5b                   	pop    %ebx
80106c9e:	5e                   	pop    %esi
80106c9f:	5f                   	pop    %edi
80106ca0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106ca1:	e9 3a db ff ff       	jmp    801047e0 <memmove>
    panic("inituvm: more than a page");
80106ca6:	83 ec 0c             	sub    $0xc,%esp
80106ca9:	68 d9 79 10 80       	push   $0x801079d9
80106cae:	e8 cd 96 ff ff       	call   80100380 <panic>
80106cb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106cc0 <loaduvm>:
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	57                   	push   %edi
80106cc4:	56                   	push   %esi
80106cc5:	53                   	push   %ebx
80106cc6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106cc9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106ccc:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106ccf:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106cd5:	0f 85 a2 00 00 00    	jne    80106d7d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106cdb:	85 ff                	test   %edi,%edi
80106cdd:	74 7d                	je     80106d5c <loaduvm+0x9c>
80106cdf:	90                   	nop
  pde = &pgdir[PDX(va)];
80106ce0:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106ce3:	8b 55 08             	mov    0x8(%ebp),%edx
80106ce6:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106ce8:	89 c1                	mov    %eax,%ecx
80106cea:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106ced:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106cf0:	f6 c1 01             	test   $0x1,%cl
80106cf3:	75 13                	jne    80106d08 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106cf5:	83 ec 0c             	sub    $0xc,%esp
80106cf8:	68 f3 79 10 80       	push   $0x801079f3
80106cfd:	e8 7e 96 ff ff       	call   80100380 <panic>
80106d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106d08:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106d0b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106d11:	25 fc 0f 00 00       	and    $0xffc,%eax
80106d16:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106d1d:	85 c9                	test   %ecx,%ecx
80106d1f:	74 d4                	je     80106cf5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106d21:	89 fb                	mov    %edi,%ebx
80106d23:	b8 00 10 00 00       	mov    $0x1000,%eax
80106d28:	29 f3                	sub    %esi,%ebx
80106d2a:	39 c3                	cmp    %eax,%ebx
80106d2c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d2f:	53                   	push   %ebx
80106d30:	8b 45 14             	mov    0x14(%ebp),%eax
80106d33:	01 f0                	add    %esi,%eax
80106d35:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106d36:	8b 01                	mov    (%ecx),%eax
80106d38:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106d3d:	05 00 00 00 80       	add    $0x80000000,%eax
80106d42:	50                   	push   %eax
80106d43:	ff 75 10             	push   0x10(%ebp)
80106d46:	e8 b5 ad ff ff       	call   80101b00 <readi>
80106d4b:	83 c4 10             	add    $0x10,%esp
80106d4e:	39 d8                	cmp    %ebx,%eax
80106d50:	75 1e                	jne    80106d70 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106d52:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d58:	39 fe                	cmp    %edi,%esi
80106d5a:	72 84                	jb     80106ce0 <loaduvm+0x20>
}
80106d5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106d5f:	31 c0                	xor    %eax,%eax
}
80106d61:	5b                   	pop    %ebx
80106d62:	5e                   	pop    %esi
80106d63:	5f                   	pop    %edi
80106d64:	5d                   	pop    %ebp
80106d65:	c3                   	ret
80106d66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d6d:	8d 76 00             	lea    0x0(%esi),%esi
80106d70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106d73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d78:	5b                   	pop    %ebx
80106d79:	5e                   	pop    %esi
80106d7a:	5f                   	pop    %edi
80106d7b:	5d                   	pop    %ebp
80106d7c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106d7d:	83 ec 0c             	sub    $0xc,%esp
80106d80:	68 94 7a 10 80       	push   $0x80107a94
80106d85:	e8 f6 95 ff ff       	call   80100380 <panic>
80106d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d90 <allocuvm>:
{
80106d90:	55                   	push   %ebp
80106d91:	89 e5                	mov    %esp,%ebp
80106d93:	57                   	push   %edi
80106d94:	56                   	push   %esi
80106d95:	53                   	push   %ebx
80106d96:	83 ec 1c             	sub    $0x1c,%esp
80106d99:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106d9c:	85 f6                	test   %esi,%esi
80106d9e:	0f 88 98 00 00 00    	js     80106e3c <allocuvm+0xac>
80106da4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106da6:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106da9:	0f 82 a1 00 00 00    	jb     80106e50 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106daf:	8b 45 0c             	mov    0xc(%ebp),%eax
80106db2:	05 ff 0f 00 00       	add    $0xfff,%eax
80106db7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106dbc:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106dbe:	39 f0                	cmp    %esi,%eax
80106dc0:	0f 83 8d 00 00 00    	jae    80106e53 <allocuvm+0xc3>
80106dc6:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106dc9:	eb 44                	jmp    80106e0f <allocuvm+0x7f>
80106dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106dcf:	90                   	nop
    memset(mem, 0, PGSIZE);
80106dd0:	83 ec 04             	sub    $0x4,%esp
80106dd3:	68 00 10 00 00       	push   $0x1000
80106dd8:	6a 00                	push   $0x0
80106dda:	50                   	push   %eax
80106ddb:	e8 70 d9 ff ff       	call   80104750 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106de0:	58                   	pop    %eax
80106de1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106de7:	5a                   	pop    %edx
80106de8:	6a 06                	push   $0x6
80106dea:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106def:	89 fa                	mov    %edi,%edx
80106df1:	50                   	push   %eax
80106df2:	8b 45 08             	mov    0x8(%ebp),%eax
80106df5:	e8 a6 fb ff ff       	call   801069a0 <mappages>
80106dfa:	83 c4 10             	add    $0x10,%esp
80106dfd:	85 c0                	test   %eax,%eax
80106dff:	78 5f                	js     80106e60 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80106e01:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e07:	39 f7                	cmp    %esi,%edi
80106e09:	0f 83 89 00 00 00    	jae    80106e98 <allocuvm+0x108>
    mem = kalloc();
80106e0f:	e8 ec b8 ff ff       	call   80102700 <kalloc>
80106e14:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106e16:	85 c0                	test   %eax,%eax
80106e18:	75 b6                	jne    80106dd0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106e1a:	83 ec 0c             	sub    $0xc,%esp
80106e1d:	68 11 7a 10 80       	push   $0x80107a11
80106e22:	e8 89 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106e27:	83 c4 10             	add    $0x10,%esp
80106e2a:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e2d:	74 0d                	je     80106e3c <allocuvm+0xac>
80106e2f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e32:	8b 45 08             	mov    0x8(%ebp),%eax
80106e35:	89 f2                	mov    %esi,%edx
80106e37:	e8 a4 fa ff ff       	call   801068e0 <deallocuvm.part.0>
    return 0;
80106e3c:	31 d2                	xor    %edx,%edx
}
80106e3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e41:	89 d0                	mov    %edx,%eax
80106e43:	5b                   	pop    %ebx
80106e44:	5e                   	pop    %esi
80106e45:	5f                   	pop    %edi
80106e46:	5d                   	pop    %ebp
80106e47:	c3                   	ret
80106e48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e4f:	90                   	nop
    return oldsz;
80106e50:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80106e53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e56:	89 d0                	mov    %edx,%eax
80106e58:	5b                   	pop    %ebx
80106e59:	5e                   	pop    %esi
80106e5a:	5f                   	pop    %edi
80106e5b:	5d                   	pop    %ebp
80106e5c:	c3                   	ret
80106e5d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106e60:	83 ec 0c             	sub    $0xc,%esp
80106e63:	68 29 7a 10 80       	push   $0x80107a29
80106e68:	e8 43 98 ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80106e6d:	83 c4 10             	add    $0x10,%esp
80106e70:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e73:	74 0d                	je     80106e82 <allocuvm+0xf2>
80106e75:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e78:	8b 45 08             	mov    0x8(%ebp),%eax
80106e7b:	89 f2                	mov    %esi,%edx
80106e7d:	e8 5e fa ff ff       	call   801068e0 <deallocuvm.part.0>
      kfree(mem);
80106e82:	83 ec 0c             	sub    $0xc,%esp
80106e85:	53                   	push   %ebx
80106e86:	e8 b5 b6 ff ff       	call   80102540 <kfree>
      return 0;
80106e8b:	83 c4 10             	add    $0x10,%esp
    return 0;
80106e8e:	31 d2                	xor    %edx,%edx
80106e90:	eb ac                	jmp    80106e3e <allocuvm+0xae>
80106e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e98:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80106e9b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e9e:	5b                   	pop    %ebx
80106e9f:	5e                   	pop    %esi
80106ea0:	89 d0                	mov    %edx,%eax
80106ea2:	5f                   	pop    %edi
80106ea3:	5d                   	pop    %ebp
80106ea4:	c3                   	ret
80106ea5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106eb0 <deallocuvm>:
{
80106eb0:	55                   	push   %ebp
80106eb1:	89 e5                	mov    %esp,%ebp
80106eb3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106eb6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106eb9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106ebc:	39 d1                	cmp    %edx,%ecx
80106ebe:	73 10                	jae    80106ed0 <deallocuvm+0x20>
}
80106ec0:	5d                   	pop    %ebp
80106ec1:	e9 1a fa ff ff       	jmp    801068e0 <deallocuvm.part.0>
80106ec6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ecd:	8d 76 00             	lea    0x0(%esi),%esi
80106ed0:	89 d0                	mov    %edx,%eax
80106ed2:	5d                   	pop    %ebp
80106ed3:	c3                   	ret
80106ed4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106edb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106edf:	90                   	nop

80106ee0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ee0:	55                   	push   %ebp
80106ee1:	89 e5                	mov    %esp,%ebp
80106ee3:	57                   	push   %edi
80106ee4:	56                   	push   %esi
80106ee5:	53                   	push   %ebx
80106ee6:	83 ec 0c             	sub    $0xc,%esp
80106ee9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106eec:	85 f6                	test   %esi,%esi
80106eee:	74 59                	je     80106f49 <freevm+0x69>
  if(newsz >= oldsz)
80106ef0:	31 c9                	xor    %ecx,%ecx
80106ef2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106ef7:	89 f0                	mov    %esi,%eax
80106ef9:	89 f3                	mov    %esi,%ebx
80106efb:	e8 e0 f9 ff ff       	call   801068e0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106f00:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106f06:	eb 0f                	jmp    80106f17 <freevm+0x37>
80106f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f0f:	90                   	nop
80106f10:	83 c3 04             	add    $0x4,%ebx
80106f13:	39 fb                	cmp    %edi,%ebx
80106f15:	74 23                	je     80106f3a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106f17:	8b 03                	mov    (%ebx),%eax
80106f19:	a8 01                	test   $0x1,%al
80106f1b:	74 f3                	je     80106f10 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106f22:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106f25:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106f28:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106f2d:	50                   	push   %eax
80106f2e:	e8 0d b6 ff ff       	call   80102540 <kfree>
80106f33:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106f36:	39 fb                	cmp    %edi,%ebx
80106f38:	75 dd                	jne    80106f17 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106f3a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106f3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f40:	5b                   	pop    %ebx
80106f41:	5e                   	pop    %esi
80106f42:	5f                   	pop    %edi
80106f43:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106f44:	e9 f7 b5 ff ff       	jmp    80102540 <kfree>
    panic("freevm: no pgdir");
80106f49:	83 ec 0c             	sub    $0xc,%esp
80106f4c:	68 45 7a 10 80       	push   $0x80107a45
80106f51:	e8 2a 94 ff ff       	call   80100380 <panic>
80106f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106f5d:	8d 76 00             	lea    0x0(%esi),%esi

80106f60 <setupkvm>:
{
80106f60:	55                   	push   %ebp
80106f61:	89 e5                	mov    %esp,%ebp
80106f63:	56                   	push   %esi
80106f64:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106f65:	e8 96 b7 ff ff       	call   80102700 <kalloc>
80106f6a:	85 c0                	test   %eax,%eax
80106f6c:	74 5e                	je     80106fcc <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
80106f6e:	83 ec 04             	sub    $0x4,%esp
80106f71:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f73:	bb 20 94 10 80       	mov    $0x80109420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f78:	68 00 10 00 00       	push   $0x1000
80106f7d:	6a 00                	push   $0x0
80106f7f:	50                   	push   %eax
80106f80:	e8 cb d7 ff ff       	call   80104750 <memset>
80106f85:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106f88:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f8b:	83 ec 08             	sub    $0x8,%esp
80106f8e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f91:	8b 13                	mov    (%ebx),%edx
80106f93:	ff 73 0c             	push   0xc(%ebx)
80106f96:	50                   	push   %eax
80106f97:	29 c1                	sub    %eax,%ecx
80106f99:	89 f0                	mov    %esi,%eax
80106f9b:	e8 00 fa ff ff       	call   801069a0 <mappages>
80106fa0:	83 c4 10             	add    $0x10,%esp
80106fa3:	85 c0                	test   %eax,%eax
80106fa5:	78 19                	js     80106fc0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106fa7:	83 c3 10             	add    $0x10,%ebx
80106faa:	81 fb 60 94 10 80    	cmp    $0x80109460,%ebx
80106fb0:	75 d6                	jne    80106f88 <setupkvm+0x28>
}
80106fb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106fb5:	89 f0                	mov    %esi,%eax
80106fb7:	5b                   	pop    %ebx
80106fb8:	5e                   	pop    %esi
80106fb9:	5d                   	pop    %ebp
80106fba:	c3                   	ret
80106fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106fbf:	90                   	nop
      freevm(pgdir);
80106fc0:	83 ec 0c             	sub    $0xc,%esp
80106fc3:	56                   	push   %esi
80106fc4:	e8 17 ff ff ff       	call   80106ee0 <freevm>
      return 0;
80106fc9:	83 c4 10             	add    $0x10,%esp
}
80106fcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106fcf:	31 f6                	xor    %esi,%esi
}
80106fd1:	89 f0                	mov    %esi,%eax
80106fd3:	5b                   	pop    %ebx
80106fd4:	5e                   	pop    %esi
80106fd5:	5d                   	pop    %ebp
80106fd6:	c3                   	ret
80106fd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fde:	66 90                	xchg   %ax,%ax

80106fe0 <kvmalloc>:
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106fe6:	e8 75 ff ff ff       	call   80106f60 <setupkvm>
80106feb:	a3 a4 ef 11 80       	mov    %eax,0x8011efa4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ff0:	05 00 00 00 80       	add    $0x80000000,%eax
80106ff5:	0f 22 d8             	mov    %eax,%cr3
}
80106ff8:	c9                   	leave
80106ff9:	c3                   	ret
80106ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107000 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	83 ec 08             	sub    $0x8,%esp
80107006:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107009:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010700c:	89 c1                	mov    %eax,%ecx
8010700e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107011:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107014:	f6 c2 01             	test   $0x1,%dl
80107017:	75 17                	jne    80107030 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107019:	83 ec 0c             	sub    $0xc,%esp
8010701c:	68 56 7a 10 80       	push   $0x80107a56
80107021:	e8 5a 93 ff ff       	call   80100380 <panic>
80107026:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010702d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107030:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107033:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107039:	25 fc 0f 00 00       	and    $0xffc,%eax
8010703e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107045:	85 c0                	test   %eax,%eax
80107047:	74 d0                	je     80107019 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107049:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010704c:	c9                   	leave
8010704d:	c3                   	ret
8010704e:	66 90                	xchg   %ax,%ax

80107050 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
80107056:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107059:	e8 02 ff ff ff       	call   80106f60 <setupkvm>
8010705e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107061:	85 c0                	test   %eax,%eax
80107063:	0f 84 dd 00 00 00    	je     80107146 <copyuvm+0xf6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107069:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010706c:	85 c9                	test   %ecx,%ecx
8010706e:	0f 84 b3 00 00 00    	je     80107127 <copyuvm+0xd7>
80107074:	31 f6                	xor    %esi,%esi
80107076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010707d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107080:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107083:	89 f0                	mov    %esi,%eax
80107085:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107088:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010708b:	a8 01                	test   $0x1,%al
8010708d:	75 11                	jne    801070a0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010708f:	83 ec 0c             	sub    $0xc,%esp
80107092:	68 60 7a 10 80       	push   $0x80107a60
80107097:	e8 e4 92 ff ff       	call   80100380 <panic>
8010709c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801070a0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801070a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801070a7:	c1 ea 0a             	shr    $0xa,%edx
801070aa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801070b0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801070b7:	85 c0                	test   %eax,%eax
801070b9:	74 d4                	je     8010708f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801070bb:	8b 18                	mov    (%eax),%ebx
801070bd:	f6 c3 01             	test   $0x1,%bl
801070c0:	0f 84 92 00 00 00    	je     80107158 <copyuvm+0x108>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801070c6:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801070c8:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    pa = PTE_ADDR(*pte);
801070ce:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801070d4:	e8 27 b6 ff ff       	call   80102700 <kalloc>
801070d9:	85 c0                	test   %eax,%eax
801070db:	74 5b                	je     80107138 <copyuvm+0xe8>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801070dd:	83 ec 04             	sub    $0x4,%esp
801070e0:	81 c7 00 00 00 80    	add    $0x80000000,%edi
801070e6:	68 00 10 00 00       	push   $0x1000
801070eb:	57                   	push   %edi
801070ec:	50                   	push   %eax
801070ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070f0:	e8 eb d6 ff ff       	call   801047e0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
801070f5:	58                   	pop    %eax
801070f6:	5a                   	pop    %edx
801070f7:	53                   	push   %ebx
801070f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801070fb:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107100:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107106:	52                   	push   %edx
80107107:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010710a:	89 f2                	mov    %esi,%edx
8010710c:	e8 8f f8 ff ff       	call   801069a0 <mappages>
80107111:	83 c4 10             	add    $0x10,%esp
80107114:	85 c0                	test   %eax,%eax
80107116:	78 20                	js     80107138 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107118:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010711e:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107121:	0f 82 59 ff ff ff    	jb     80107080 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107127:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010712a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010712d:	5b                   	pop    %ebx
8010712e:	5e                   	pop    %esi
8010712f:	5f                   	pop    %edi
80107130:	5d                   	pop    %ebp
80107131:	c3                   	ret
80107132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(d);
80107138:	83 ec 0c             	sub    $0xc,%esp
8010713b:	ff 75 e0             	push   -0x20(%ebp)
8010713e:	e8 9d fd ff ff       	call   80106ee0 <freevm>
  return 0;
80107143:	83 c4 10             	add    $0x10,%esp
    return 0;
80107146:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
8010714d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107150:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107153:	5b                   	pop    %ebx
80107154:	5e                   	pop    %esi
80107155:	5f                   	pop    %edi
80107156:	5d                   	pop    %ebp
80107157:	c3                   	ret
      panic("copyuvm: page not present");
80107158:	83 ec 0c             	sub    $0xc,%esp
8010715b:	68 7a 7a 10 80       	push   $0x80107a7a
80107160:	e8 1b 92 ff ff       	call   80100380 <panic>
80107165:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010716c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107170 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107176:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107179:	89 c1                	mov    %eax,%ecx
8010717b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010717e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107181:	f6 c2 01             	test   $0x1,%dl
80107184:	0f 84 00 01 00 00    	je     8010728a <uva2ka.cold>
  return &pgtab[PTX(va)];
8010718a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010718d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107193:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107194:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107199:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
801071a0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801071a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801071a7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801071aa:	05 00 00 00 80       	add    $0x80000000,%eax
801071af:	83 fa 05             	cmp    $0x5,%edx
801071b2:	ba 00 00 00 00       	mov    $0x0,%edx
801071b7:	0f 45 c2             	cmovne %edx,%eax
}
801071ba:	c3                   	ret
801071bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071bf:	90                   	nop

801071c0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801071c0:	55                   	push   %ebp
801071c1:	89 e5                	mov    %esp,%ebp
801071c3:	57                   	push   %edi
801071c4:	56                   	push   %esi
801071c5:	53                   	push   %ebx
801071c6:	83 ec 0c             	sub    $0xc,%esp
801071c9:	8b 75 14             	mov    0x14(%ebp),%esi
801071cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801071cf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801071d2:	85 f6                	test   %esi,%esi
801071d4:	75 51                	jne    80107227 <copyout+0x67>
801071d6:	e9 a5 00 00 00       	jmp    80107280 <copyout+0xc0>
801071db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071df:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
801071e0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801071e6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
801071ec:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801071f2:	74 75                	je     80107269 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
801071f4:	89 fb                	mov    %edi,%ebx
801071f6:	29 c3                	sub    %eax,%ebx
801071f8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801071fe:	39 f3                	cmp    %esi,%ebx
80107200:	0f 47 de             	cmova  %esi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107203:	29 f8                	sub    %edi,%eax
80107205:	83 ec 04             	sub    $0x4,%esp
80107208:	01 c1                	add    %eax,%ecx
8010720a:	53                   	push   %ebx
8010720b:	52                   	push   %edx
8010720c:	89 55 10             	mov    %edx,0x10(%ebp)
8010720f:	51                   	push   %ecx
80107210:	e8 cb d5 ff ff       	call   801047e0 <memmove>
    len -= n;
    buf += n;
80107215:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107218:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010721e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107221:	01 da                	add    %ebx,%edx
  while(len > 0){
80107223:	29 de                	sub    %ebx,%esi
80107225:	74 59                	je     80107280 <copyout+0xc0>
  if(*pde & PTE_P){
80107227:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010722a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010722c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010722e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107231:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107237:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010723a:	f6 c1 01             	test   $0x1,%cl
8010723d:	0f 84 4e 00 00 00    	je     80107291 <copyout.cold>
  return &pgtab[PTX(va)];
80107243:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107245:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010724b:	c1 eb 0c             	shr    $0xc,%ebx
8010724e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107254:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010725b:	89 d9                	mov    %ebx,%ecx
8010725d:	83 e1 05             	and    $0x5,%ecx
80107260:	83 f9 05             	cmp    $0x5,%ecx
80107263:	0f 84 77 ff ff ff    	je     801071e0 <copyout+0x20>
  }
  return 0;
}
80107269:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010726c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107271:	5b                   	pop    %ebx
80107272:	5e                   	pop    %esi
80107273:	5f                   	pop    %edi
80107274:	5d                   	pop    %ebp
80107275:	c3                   	ret
80107276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010727d:	8d 76 00             	lea    0x0(%esi),%esi
80107280:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107283:	31 c0                	xor    %eax,%eax
}
80107285:	5b                   	pop    %ebx
80107286:	5e                   	pop    %esi
80107287:	5f                   	pop    %edi
80107288:	5d                   	pop    %ebp
80107289:	c3                   	ret

8010728a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
8010728a:	a1 00 00 00 00       	mov    0x0,%eax
8010728f:	0f 0b                	ud2

80107291 <copyout.cold>:
80107291:	a1 00 00 00 00       	mov    0x0,%eax
80107296:	0f 0b                	ud2
