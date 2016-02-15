CC=gcc
CFLAGS=-Wall -O3
LDFLAGS=-pthread -lm
TARGET=a
SRCS:=$(wildcard *.c)
OBJS=$(SRCS:.c=.o)
DEPS=$(SRCS:.c=.dep)
RM=rm -f
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ -lm
%.dep:%.c
	$(SHELL) -c '$(CC) -MM $< > $@'
-include $(DEPS)
clean:
	$(RM) $(TARGET) $(DEPS) $(OBJS)
