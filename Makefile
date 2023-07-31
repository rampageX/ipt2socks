CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -O2 -pthread
LIBS = -lm
SRCS = ipt2socks.c lrucache.c netutils.c protocol.c
OBJS = $(SRCS:.c=.o)
MAIN = ipt2socks
DESTDIR = /usr/local/bin

EVCFLAGS = -O2 -fno-strict-aliasing
EVSRCFILE = libev/ev.c
EVOBJFILE = ev.o

.PHONY: all install clean

all: $(MAIN)

install: $(MAIN)
	mkdir -p $(DESTDIR)
	install -m 0755 $(MAIN) $(DESTDIR)

clean:
	$(RM) *.o $(MAIN)

$(MAIN): $(EVOBJFILE) $(OBJS)
	$(CC) $(CFLAGS) -s -o $(MAIN) $(OBJS) $(EVOBJFILE) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

$(EVOBJFILE): $(EVSRCFILE)
	$(CC) $(EVCFLAGS) -c $(EVSRCFILE) -o $(EVOBJFILE)
