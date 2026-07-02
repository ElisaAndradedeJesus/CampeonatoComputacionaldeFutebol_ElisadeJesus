CC = gcc
CFLAGS = -Wall -Wextra -I include

SRC = main.c src/*.c
OUT = programa

.PHONY: all compile run clean reset-bd

all: clean compile run

compile:
	$(CC) $(CFLAGS) $(SRC) -o $(OUT)

run:
	./$(OUT)

clean:
	rm -f $(OUT)

reset-bd:
	cp BD/backupBD.csv BD/bd_partidas.csv