# Makefile rules generated by CB
CC	= gcc
CFLAGS	= -Wall -g
BUILD	= ch-1 ch-2

all:	$(BUILD)

clean:
	/bin/rm -f $(BUILD) *.o core a.out

args.o:	args.c
ch-1:	ch-1.o args.o
ch-1.o:	ch-1.c args.h
ch-2:	ch-2.o args.o csvsplit.o slist.o
ch-2.o:	ch-2.c args.h csvsplit.h slist.h
csvsplit.o:	csvsplit.c csvsplit.h
slist.o:	slist.c csvsplit.h slist.h

