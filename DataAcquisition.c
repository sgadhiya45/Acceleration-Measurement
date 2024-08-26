/*
 * DataAcquisition.c
 *
 * Created: Aug. 2022, Sumit Gadhiya
 *
 * Program skeleton for the experiments in maritime systems laboratory of embedded system design. 
 */ 

#define F_CPU 16000000

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "fifo.h"
#include "uart.h"
#include "dataio.h"
#include "timer0interupt.h"

volatile uint16_t intnum=0;
volatile uint8_t *bufcounter;

void InitialiseHardware(void)
{
	sei();							// enables interrupts by setting the global interrupt mask
	AdcInit();						// initializes the a/d converter
	bufcounter = uart_init(19200);	// initializes the UART for the given baudrate
	PortInit();						// initializes the port settings
	StartTimer0Interrupt();			// timer 0 interrupt for 15 ms
}

int main(void)
{
	char Text[64];
	uint16_t ADCValue;
	uint16_t index=0;

	InitialiseHardware(); 
	sprintf( Text,"\r\nHello World\r\n");
	uart_puts (Text); _delay_ms(1000);
	
	while(1)
    {
		TogglePortD(7);
		index++;
		ADCValue=ReadChannel(6);
		sprintf( Text,"Examples: %d %d %d %d %d\r\n",index,ADCValue,ReadPortD(3),ReadPortD(4),intnum);
		uart_puts (Text); _delay_ms(1000);
    }
}

ISR(TIMER0_COMP_vect)
{
	intnum++;
}