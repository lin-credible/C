##USAGE
```
> make
gcc -c input.c
gcc -c avg.c
gcc input.o avg.o main.c -o main.out
> ./main.out input
10000
30000
0
40000, 2
> ./main.out avg
50000, 2
avg=25000.00
> ./main.out input | ./main.out avg
10000
30000
0
avg=20000.00
```
