all: scrap-site scrap-system

CC = gcc
CFLAGS = -Wall $(shell xml2-config --cflags) -ggdb3 -O0
LIBS = $(shell xml2-config --libs)

scrap-site: scrap-site.c
	$(CC) -o scrap-site scrap-site.c $(CFLAGS) $(LIBS)

scrap-system: scrap-system.c
	$(CC) -o scrap-system scrap-system.c $(CFLAGS) $(LIBS)

clean:
	rm -f scrap-site scrap-system
