#include <stdint.h>

#include "multiboot.h"

#if !defined(__i386__)
#error "386UX kernel must be built using a cross-compiler that targets the i386 architecture!"
#endif

void kmain(uint32_t magic, multiboot_t *multiboot)
{
	return;
}