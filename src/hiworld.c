/*

'Hello World' 

$Header: /cvsroot/hpgcc/examples/hiworld.c,v 1.3 2005/03/31 10:30:01 alborowski Exp $



*/


#define TINY_PRINTF

#include <hpgcc49.h> //the standard HP lib

int main(void) {

    clear_screen(); //clear the screen

    printf("Hello, World!!"); //prints "hello world"

    WAIT_CANCEL; //loop until ON pressed

}
