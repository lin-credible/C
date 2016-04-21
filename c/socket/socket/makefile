GCC = g++
CFLAGS = -lrt -g -O2
RM = rm -f
TARGET = aname
OBJS = calculateclient calculateserver client daemonserver epoll_server\
	mutil mutilserver poll_client select_client server thread\
	threadserver udpclient udpserver 
$(TARGET):$(OBJS)
$(OBJS):%:%.cpp
	$(GCC) $(CFLAGS) -o $@ $<
clean:
	$(RM) $(OBJS)
