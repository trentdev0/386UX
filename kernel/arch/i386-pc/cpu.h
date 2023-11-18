#pragma once

#include <stdint.h>

/*
 *	These are the basic functions for messing with i386's I/O ports. They're used to write
 *	basic drivers.
 */

static inline void outb(uint16_t port, uint8_t value)
{
	asm volatile("outb %0, %1" : : "a"(value), "Nd"(port));
}

static inline uint8_t inb(uint16_t port)
{
	uint8_t return_value;
	asm volatile("inb %1, %0" : "=a"(return_value) : "Nd"(port));
	return return_value;
}

static inline void outw(uint16_t port, uint16_t value)
{
	asm volatile("outw %0, %1" : : "a"(value), "Nd"(port));
}

static inline uint16_t inw(uint16_t port)
{
	uint16_t return_value;
	asm volatile("inw %1, %0" : "=a"(return_value) : "Nd"(port));
	return return_value;
}

static inline void outl(uint16_t port, uint32_t value)
{
	asm volatile("outl %0, %1" : : "a"(value), "Nd"(port));
}

static inline uint32_t inl(uint16_t port)
{
	uint32_t return_value;
	asm volatile("inl %1, %0" : "=a"(return_value) : "Nd"(port));
	return return_value;
}

/*
 *	These are basic functions related to the CPU's execution. They include the control of whether interrupts
 *	are enabled, disabled, or if CPU execution is paused.
 */

static inline void hlt()
{
	asm("hlt");
}

static inline void cli()
{
	asm("cli");
}

static inline void sti();
{
	asm("sti");
}