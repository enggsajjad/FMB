/** 
 * Hardware crystal frequency in Hz.
 * Adjust \b DELAY_XTAL to match hardware.
 * \hideinitializer
 */
#define DELAY_XTAL       11059000

// Delay routine timing parameters
#define DELAY_CPU_CLOCK  DELAY_XTAL / 12      // 8051 clock rate (X1 mode)
#define DELAY_CONST      9.114584e-5          // Delay routine constant
#define DELAY_MULTPLR    (unsigned char)(DELAY_CONST * DELAY_CPU_CLOCK)

/*****************************************************************************
 *
 *                           Public Function Prototypes
 *
 *****************************************************************************/

/** 
 * Millisecond software delay function.
 * Implements a software timing loop based delay with millisecond precision.
 * See 'Usage' for notes regarding upper bounds on the delay period that may
 * be generated.
 * \param count The number of milliseconds to delay as an \b unsigned \b int.
 * \return -
 */
/*****************************************************************************
 *
 *                              delay_ms()
 *
 *****************************************************************************/
void delay_ms(volatile unsigned int count)
{

    for(count *= DELAY_MULTPLR; count > 0; count--) continue;

    return;
}


/** @} */

