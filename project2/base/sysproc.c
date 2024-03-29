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
sys_fork_winner_syscall(void) 
{
  // this is the kernel code/function for our new system call, fork_winner
  int value = 0; 
  if (argint(0, &value) < 0) {
    return -1; // if there's something wrong with our retrieval of the argument passed in to the user space wrapper routine, exit
  }
  // if no error....
  winner = value;
  return 0;
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

int sys_shutdown(void)
{
  /* Either of the following will work. Does not harm to put them together. */
  outw(0xB004, 0x0|0x2000); // working for old qemu
  outw(0x604, 0x0|0x2000); // working for newer qemu
  
  return 0;
}

extern int sched_trace_enabled;
extern int sched_trace_counter;
int sys_enable_sched_trace(void)
{
  if (argint(0, &sched_trace_enabled) < 0)
  {
    cprintf("enable_sched_trace() failed!\n");
  }
  
  sched_trace_counter = 0;

  return 0;
}

int sys_tickets_owned_syscall(void)
{
  int pid; //Store the PID argument that is passed to the sys call
  if(argint(0, &pid) < 0) //Read the first arg passed to the syscall. This will be the PID of the process whose PID we are looking for. If we don't find it, return -1 as an error.
  {
    return -1;
  }
  return tickets_owned(pid); // this will call the actual core logic function in proc.c to handle this operation
}

int sys_transfer_tickets_syscall(void)
{
   int pid, tickets;
   if (argint(0, &pid) < 0) 
   {
       return -1;
   }
   if (argint(1, &tickets) < 0) 
   {
       return -1;
   }
   return transfer_tickets(pid, tickets);
}

int sys_set_sched_syscall(void) {
  // this is the actual kernel function of the set_sched_syscall system call
  int userChoice = 0; // this variable will hold what the user passed in to this system call's user space wrapper function
  if (argint(0, &userChoice) < 0) {
    return -1; // if we have some error while obtaining the value the user passed in from the user space wrapper func, return -1
  }
  // if no error
  schedPolicy = userChoice; // we initialize the global variable in proc.h that's going to be used to determine the scheduler 
  return 0;
}
