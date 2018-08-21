.PHONY: all clean

all: DiscordianDate

DiscordianDate.c: DiscordianDate.py
	cython --embed-positions --line-directives --embed -3 \
		--capi-reexport-cincludes DiscordianDate.py

DiscordianDate.o: DiscordianDate.c
	gcc -O3 -c -o DiscordianDate.o -I/usr/include/python3.6m DiscordianDate.c

DiscordianDate: DiscordianDate.o
	gcc -O3 -o DiscordianDate -L/usr/lib DiscordianDate.o -lpython3.6m

clean:
	rm -f DiscordianDate DiscordianDate.o DiscordianDate.c
