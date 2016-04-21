GCC = g++
CFLAGS = -lrt -g -O2
RM = rm -f
TARGET = aname
OBJS = countcreate countlock countunlock cpnamesem cpunnamesem fcreate\
	flockupdate fread funlockupdate mapfromfile mqcreate mqgetattr\
	mqreceive mqsend mqsetattr mqunlink shmfrommem shmfrommemRW pipe signal 
$(TARGET):$(OBJS)
$(OBJS):%:%.cpp
	$(GCC) $(CFLAGS) -o $@ $<
clean:
	$(RM) $(OBJS)
