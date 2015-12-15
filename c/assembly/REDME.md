```
shell>gcc -g -c hello.c
shell>objdump -d -M intel -S hello.o

hello.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <main>:
#include <stdio.h>

int main(void){
   0:   55                      push   rbp
   1:   48 89 e5                mov    rbp,rsp
    printf("Hello world!\n");
   4:   bf 00 00 00 00          mov    edi,0x0
   9:   e8 00 00 00 00          call   e <main+0xe>
    return 0;
   e:   b8 00 00 00 00          mov    eax,0x0
}
  13:   c9                      leave  
  14:   c3                      ret    
```

