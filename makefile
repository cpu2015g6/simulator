CC=gcc
CFLAGS=-Wall -O2
LDFLAGS=-pthread -lm
TARGET=a
SRCS:=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
DEPS=$(SRCS:.c=.dep)
RM=rm -f
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^
%.dep:%.c
	$(SHELL) -c '$(CC) -MM $< > $@'
-include $(DEPS)
clean:
	$(RM) $(TARGET) $(DEPS) $(OBJS)
