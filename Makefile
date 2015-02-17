FLAGS=-std=gnu99
OPTFLAGS=-O3 -g
DBGFLAGS=-O0 -g
GLIB_FLAGS=`pkg-config --cflags glib-2.0`
GLIB_LDFLAGS=`pkg-config --libs glib-2.0`

msp430-emu: main.c emu.h
	$(CC) $(FLAGS) $(OPTFLAGS) $(GLIB_FLAGS) $< gdbstub.c -o $@ $(GLIB_LDFLAGS)

msp430-sym: main.c emu.h gdbstub.c
	$(CC) $(FLAGS) $(OPTFLAGS) $(GLIB_FLAGS) -DSYMBOLIC=1 $< gdbstub.c -o $@ $(GLIB_LDFLAGS)

check: check_instr
	./check_instr

check_instr: check_instr.c main.c emu.h
	$(CC) $(DBGFLAGS) $(FLAGS) $(GLIB_FLAGS) -DSYMBOLIC=1 -DEMU_CHECK $< main.c -lcheck $(GLIB_LDFLAGS) -o $@

clean:
	rm -f check_instr msp430-sym msp430-emu
