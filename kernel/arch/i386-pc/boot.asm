MBOOT_PAGE_ALIGN equ 1<<0
MBOOT_MEM_INFO equ 1<<1
MBOOT_USE_GFX equ 1<<2
MBOOT_HEADER_MAGIC equ 0x1BADB002
MBOOT_HEADER_FLAGS equ MBOOT_PAGE_ALIGN | MBOOT_MEM_INFO | MBOOT_USE_GFX
MBOOT_CHECKSUM equ -(MBOOT_HEADER_MAGIC + MBOOT_HEADER_FLAGS)


[BITS 32]		; Bootloaders that work with the multiboot protocol will load our kernel's executable at a 32-bit
				; mode.

section .multiboot
align 4
	dd MBOOT_HEADER_MAGIC
	dd MBOOT_HEADER_FLAGS
	dd MBOOT_CHECKSUM
	dd 0x00000000
	dd 0x00000000
	dd 0x00000000
	dd 0x00000000
	dd 0x00000000
	dd 0x00000000
	dd 1024
	dd 768
	dd 32

section .bss	; Here we set up a 16KiB stack that is aligned by 16 bytes.
align 16
stack_bottom:
resb 16384		; Let's set up some space which is 16KiB in size. We later use this as the stack.
stack_top:

[GLOBAL _start]	; Let's declare the kernel's entry point as global, so that the linker can see it.
[EXTERN kmain]	; Let's declare the kernel's main function as external, so that we can call it from here.

section .text

_start:
	mov esp, stack_top

	push eax
	push ebx	; Pass a pointer to the multiboot data structure as an argument.

	cli			; Disable interrupts.
	call kmain	; Call the kernel's actual main function.

	cli
	hlt