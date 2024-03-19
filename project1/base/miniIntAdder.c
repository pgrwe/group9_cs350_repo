#include "types.h"
#include "stat.h"
#include "user.h"

void miniIntAdder(int num1, int *num2) 
{
    miniIntAdder_sysCall(num1, num2); // make the system call by invoking the user space wrapper function of the system call
}


int main (int argc, char *argv[]) {
    // this is a typical user mode function that's going to call the user space wrapper function
    int num1 = atoi(argv[1]);
    int num2 = atoi(argv[2]);
    // make sure we are only taking in 2 arguments
    if (argc != 3) { // making sure we have 3 arguments: ./miniIntAdder <int1> <int2>
        printf(1, "Please enter in the format: ./miniIntAdder <int1> <int2>. Only ints, nothing else!\n");
        return -1;
    }

    // extract the numbers and make sure they are float
    // int num1, num2; 
    // int success1 = sscanf(argv[1], "%d", &num1); // sscanf will take the first string arg and save it as a float to num1. 
    // int success2 = sscanf(argv[2], "%d", &num2);

    // if ((success1 != 1) || (success2 != 1)) { 
    //     // if any of these are not 1, it means that string argument did not contain a float
    //     printf(1, "Please enter in the format: ./miniIntAdder <int1> <int2>. Only ints, nothing else!\n");
    //     return -1;
    // }

    miniIntAdder(num1, num2); // make the system call by invoking the user space wrapper function of the system call

}