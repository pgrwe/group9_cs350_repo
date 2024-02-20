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
sys_mkdir2_xv6(void) {
  // this is the actual KERNEL function that is run after the mkdir2_xv6 system call! The system call jump table has a pointer to this function
  
  char *directoryName1; // these are "strings" that will hold the directory names from user space
  char *directoryName2; 

  if (argstr(0, &directoryName1) < 0 || argstr(1, &directoryName2) < 0) { // argstr takes two arguments: (<argIndex>, <placeToStore>)
    return -1; // if any of the argstr returns <0, this means that something bad happened 
  }
  if (mkdir(directoryName1) < 0 || mkdir(directoryName2) < 0) { // mkdir takes one argument: the name of the directory which is a string
    return -1;  // if it returns <0, something bad happened
  }

}