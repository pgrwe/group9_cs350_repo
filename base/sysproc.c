#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// shutdown the virtual machine
int
sys_shutdown_xv6(void)
{
  outw(0xB004, 0x0|0x2000);
  outw(0x604, 0x0|0x2000);
  return 0;
}

int
sys_exit2_proc(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  cprintf("Exit status: %d\n", n);
  exit();
  return 0;  // not reached
}

int
sys_miniIntAdder_sysCall(void) {
  int num1 = 0;
  int num2;
  if (argint(0, &num1) < 0 || argint(1, &num2) < 0) { // trying to save the arguments to num1 and num2 respectively
    return -1; // if the getting of the arguments failed, return -1
  }
  cprintf("The sum of the two numbers is: %d\n", num1+num2);
  return 0;
}

sys_uptime2_sysCall(void)
{
  int n;
  uint xticks;

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);

  if(n == 1){
    return xticks;
  } else if(n == 2){
    return xticks / 100;
  } else if(n == 3){
    return xticks / 100 / 60;
  } else {
    return -1;
  }
}