GCC = g++
CFLAGS = -lrt -g -O2
RM = rm -f
TARGET = aname
OBJS = datainit nickclient nickserver batchclient
$(TARGET):$(OBJS)
$(OBJS):%:%.cpp
	$(GCC) $(CFLAGS) -o $@ $<
clean:
	$(RM) $(OBJS)
