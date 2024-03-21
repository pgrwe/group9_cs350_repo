#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "x86.h"
#include "proc.h"
#include "spinlock.h"


#define STRIDE_TOTAL_TICKETS 100

struct {
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;


void stride_scheduling_policy(void)
{
  struct proc *p;
  int n = 0;
  int ticket_p = 0;

//First we count the ACTIVE processes
  //acquire(&ptable.lock);
  //Reasoning behind acquire and release: These methods ensure EXCLUSIVE access to the process table. Essentially, they prevent race conditions, which is good for synchronization.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  //Loop through running processes
  {
    //If the process state is running or runnable, increment our process counter n
    if(p->state == RUNNABLE || p->state ==RUNNING)
    {
      n++;
    }
  }

  if(n != 0) 
  {
  ticket_p = STRIDE_TOTAL_TICKETS / n; //Here we calculate the tickets per process. Of course, we make sure that n is not 0 b/c we don't want to divide by 0.
  }

  //Now we destribute tickets and recalc stride for each of our active processes.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->state == RUNNABLE || p->state ==RUNNING)
    {
      p->tickets = ticket_p;
      p->pass = 0; //Reset the pass value
      p->stride = (STRIDE_TOTAL_TICKETS * 10) / p->tickets; //Recalculate stride
    }
  }

 // release(&ptable.lock);

}

int winner = 0;
int schedPolicy = 0;


static struct proc *initproc;

int nextpid = 1;
int sched_trace_enabled = 0; // ZYF: for OS CPU/process project
int sched_trace_counter = 0; // ZYF: counter for print formatting
extern void forkret(void);
extern void trapret(void);

static void wakeup1(void *chan);

int tickets_owned(int pid)
{
  struct proc *p;
  acquire(&ptable.lock); //This line prevents race conditions when accessing/modifying our process table.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) //Here, we iterate over all the processes in the process table. ptable.proc is the start of the array, and NPROC is the MAX number of processes in the system
  {
    if(p->pid == pid) //Check if current process has the PID we are looking for
    {
      release(&ptable.lock);
      return p->tickets; //Return number of tickets
    }
  }
  release(&ptable.lock);
  return -1; //If PID is not found, return -1
}

int transfer_tickets(int pid, int tickets)
{
    struct proc *p;
    struct proc *current_p = myproc();
    /* acquire(&ptable.lock); */
 
    // check for negative tickets
    if (tickets < 0 )
    { 
        /* release(&ptable.lock); */
        return -1; 
    }
    // too many tickets to transfer
    if(p->tickets - 1 > tickets)
    {    
        /* release(&ptable.lock); */
        return -2;
    }

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
    {
        if (p->state == RUNNING || p->state == RUNNABLE)
        {
            if(p->pid == pid) 
            {
            current_p->tickets -= tickets;
            /* p->tickets += tickets; */
            current_p->stride = (STRIDE_TOTAL_TICKETS * 10)/current_p->tickets;
            /* p->stride = (STRIDE_TOTAL_TICKETS * 10)/p->tickets; */
            return current_p->tickets;
            }
        }
    }
    // pid not found
    /* release(&ptable.lock); */
    return -3; 
}


void
pinit(void)
{
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
}

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
  }
  panic("unknown apicid\n");
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
  struct cpu *c;
  struct proc *p;
  pushcli();
  c = mycpu();
  p = c->proc;
  popcli();
  return p;
}

//PAGEBREAK: 32
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
  p->tf->es = p->tf->ds;
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);

  p->state = RUNNABLE;

  release(&ptable.lock);
}

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
  switchuvm(curproc);
  return 0;
}

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
  // this is the core logic for the "fork" kernel function. This logic is performed by the PARENT process and does the forking
  int i, pid;
  struct proc *np; // child process (new process)
  struct proc *curproc = myproc(); // parent process

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
  }

  // Copy process state from proc (i.e. parent process)
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0; // RECALL: %eax is the return value of a function. Essentially, by doing %eax=0, we are causing the child process'
              // return value to be 0 so that when fork() returns to the child, the return value is 0 
              // Notice we don't change proc->tf->eax. We don't want to change the return value of the parent! 

  for(i = 0; i < NOFILE; i++) // copy all of the parent's open file descriptors to child
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);

  safestrcpy(np->name, curproc->name, sizeof(curproc->name)); // copies parent process name to the child

  pid = np->pid;

  // the process table (ptable) contains information about all the processes in the system
  acquire(&ptable.lock);  // lock the ptable so that nobody else can access it while we are marking this child process
  np->state = RUNNABLE; // here, we are marking the child process as RUNNABLE, meaning it is ready to be scheduled by the CPU scheduler
                        // whichever process runs is now dependent on the scheduler, as both processes are done and ready
  stride_scheduling_policy();                      // to execute their code
  release(&ptable.lock); // unlock the ptable 


  // at this point, the parent process is STILL running this fork() core logic code. So we can make the parent yield to the child before
  // the parent returns  

  if (winner == 1) yield(); // if winner = 1, we want the child to go first, so the parent must now yield 

  return pid;
} //this is my fork function where would I put it
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
  iput(curproc->cwd);
  end_op();
  curproc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  stride_scheduling_policy(); 
  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
  sched();
  panic("zombie exit");
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}

//PAGEBREAK: 42
// Per-CPU process scheduler.
// Each CPU calls scheduler() after setting itself up.
// Scheduler never returns.  It loops, doing:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.

void
scheduler(void)
{
  struct proc *p;
  struct cpu *c = mycpu();
  c->proc = 0;
  
  int ran = 0; // CS 350/550: to solve the 100%-CPU-utilization-when-idling problem
  for(;;){
    // Enable interrupts on this processor.
    sti();

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        ran = 0;
        struct proc *new_proc;
        int min_proc_value = 1000;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
          if(p->state != RUNNABLE)
            continue;

          if(p->pass < min_proc_value)
          {
            new_proc = p;
            min_proc_value = p->pass;
          }
        }
        if(new_proc)
        {
        p = new_proc; // Here we set p to the process with the lowest value
        p->pass += p->stride; //add process's stride to pass
        ran = 1;
      
          // Switch to chosen process.  It is the process's job
          // to release ptable.lock and then reacquire it
          // before jumping back to us.
          c->proc = p;
          switchuvm(p);
          p->state = RUNNING;

          swtch(&(c->scheduler), p->context);
          switchkvm();

          // Process is done running for now.
          // It should have changed its p->state before coming back.
          c->proc = 0;
    }
    release(&ptable.lock);

    if (ran == 0){
        halt();
    }
  }
}



// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state. Saves and restores
// intena because intena is a property of this
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
  swtch(&p->context, mycpu()->scheduler);
  mycpu()->intena = intena;
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
  if (sched_trace_enabled)
  {
    cprintf("%d", myproc()->pid);
    
    sched_trace_counter++;
    if (sched_trace_counter % 20 == 0)
    {
      cprintf("\n");
    }
    else
    {
      cprintf(" - ");
    }
  }
    
  acquire(&ptable.lock);  //DOC: yieldlock
  myproc()->state = RUNNABLE;
  sched();
  release(&ptable.lock);
}

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");

  // Must acquire ptable.lock in order to
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
  p->state = SLEEPING;
  //stride_scheduling_policy();

  sched();

  // Tidy up.
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}

//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
  struct proc *p;
  //int call_stride = 0;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
  {
    if(p->state == SLEEPING && p->chan == chan)
    {
      p->state = RUNNABLE;
     // call_stride = 1;
    }
   /// if(call_stride == 1)
   // {
   // stride_scheduling_policy();
   // }
  }
}


// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
}

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}

//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
  static char *states[] = {
  [UNUSED]    "unused",
  [EMBRYO]    "embryo",
  [SLEEPING]  "sleep ",
  [RUNNABLE]  "runble",
  [RUNNING]   "run   ",
  [ZOMBIE]    "zombie"
  };
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
