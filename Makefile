CC = clang
LD = ld.lld
AS = nasm
CFLAGS = -target i386-unknown-none-gnu -std=gnu99 -ffreestanding -I. -nostdlib
ASFLAGS = -felf
LDFLAGS = -Tkernel/arch/i386-pc/ld-i386-pc.ld -nostdlib

SRCS := $(wildcard kernel/*.c)
ASMS := $(wildcard kernel/*.asm)
ARCH_SRCS := $(wildcard kernel/arch/i386-pc/*.c)
ARCH_ASMS := $(wildcard kernel/arch/i386-pc/*.asm)
OBJS := $(SRCS:.c=.o) $(ASMS:.asm=.o) $(ARCH_SRCS:.c=.o) $(ARCH_ASMS:.asm=.o)

all: kernel.bin

kernel.bin: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f kernel/*.o kernel/arch/i386-pc/*.o kernel.bin
