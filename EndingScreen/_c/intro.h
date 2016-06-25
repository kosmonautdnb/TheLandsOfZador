//--------------------------------------------------------------------------//
// iq / rgba  .  tiny codes  .  2008                                        //
//--------------------------------------------------------------------------//

#ifndef _INTRO_H_
#define _INTRO_H_

void intro_init( void );
void intro_do( unsigned int *buffer, long time );

void save();

extern float mousePosX;
extern float mousePosY;
extern bool mouseButtonL;
extern bool mouseButtonR;

#endif
