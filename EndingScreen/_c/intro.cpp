//--------------------------------------------------------------------------//
// iq / rgba  .  tiny codes  .  2008                                        //
//--------------------------------------------------------------------------//
#include "windows.h"
#include <math.h>
#include "utils.h"
#include "fp.h"
#include "config.h"
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <string>
#include <vector>
#include "png.h"
#include "setup.h"

#define PI 3.14159f

#define SXRES 320
#define SYRES 200
#define Log(fmt,...) {char buffer[1000];sprintf(buffer,fmt, ##__VA_ARGS__);OutputDebugStringA(buffer);OutputDebugStringA("\n");}

int frameCounter = 0;
unsigned char screenBuffer[SXRES*SYRES];

unsigned int palette[256];

float mousePosX;
float mousePosY;
bool mouseButtonL;
bool mouseButtonR;

unsigned char getColor(int color) 
{
	int r = color & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	int lastDelta = 10000*10000;
	int ri = 0;
	unsigned int colorEnabled[16] = {1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1};

	for (int i = 0; i < 128; ++i) 
	{
		int cr = (palette[i]>>16) & 255;
		int cg = (palette[i]>>8) & 255;
		int cb = palette[i] & 255;
		int dr = cr - r;
		int dg = cg - g;
		int db = cb - b;
		int d = dr * dr + dg * dg + db * db;

		if (d < lastDelta && (colorEnabled[i & 15] != 0)) 
		{
			lastDelta = d;
			ri = i;
		}
	}
	if ((ri & 0x0f)==0x00)
		ri = 0;
	return ri;
}

unsigned char getColor2(int color) 
{
	int r = color & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	int lastDelta = 10000*10000;
	int ri = 0;
	unsigned int colorEnabled[16] = {1,0,1,1,1,1,1,1, 1,1,1,1,1,1,1,1};

	for (int i = 0; i < 128; ++i) 
	{
		int cr = (palette[i]>>16) & 255;
		int cg = (palette[i]>>8) & 255;
		int cb = palette[i] & 255;
		int dr = cr - r;
		int dg = cg - g;
		int db = cb - b;
		int d = dr * dr + dg * dg + db * db;

		if (d < lastDelta && (colorEnabled[i & 15] != 0)) 
		{
			lastDelta = d;
			ri = i;
		}
	}
	if ((ri & 0x0f)==0x00)
		ri = 0;
	return ri;
}

unsigned char getColor8(int color) 
{
	int b = color & 255;
	int g = (color>>8) & 255;
	int r = (color>>16) & 255;
	int lastDelta = 10000*10000;
	int ri = 0;
	unsigned int colorEnabled[16] = {1,1,1,1,1,1,1,1, 0,0,0,0,0,0,0,0};

	for (int i = 0; i < 128; ++i) 
	{
		int cr = (palette[i]>>16) & 255;
		int cg = (palette[i]>>8) & 255;
		int cb = palette[i] & 255;
		int dr = cr - r;
		int dg = cg - g;
		int db = cb - b;
		int d = dr * dr + dg * dg + db * db;

		if (d < lastDelta && (colorEnabled[i & 15] != 0)) 
		{
			lastDelta = d;
			ri = i;
		}
	}
	if ((ri & 0x0f)==0x00)
		ri = 0;
	return ri;
}

unsigned char getColorFloat(float r,float g,float b)
{
	int ri = (int)(r * 255.f);
	int gi = (int)(g * 255.f);
	int bi = (int)(b * 255.f);
	if (ri < 0) ri = 0;
	if (gi < 0) gi = 0;
	if (bi < 0) bi = 0;
	if (ri > 255) ri = 255;
	if (gi > 255) gi = 255;
	if (bi > 255) bi = 255;
	return getColor(ri|(gi<<8)|(bi<<16));
}

#define MAXWIDTH 4096
#define MAXHEIGHT 4096

unsigned char bmpBuffer2[MAXWIDTH * MAXHEIGHT * 4 + 0x36];
int picture[MAXWIDTH*MAXHEIGHT];
int pictureS[MAXWIDTH*MAXHEIGHT];
int pictureWidth;
int pictureHeight;

extern "C"
{
#if defined(HAVE_LIBPNG) && defined(HAVE_LIBZ)
#  include <zlib.h>
#  ifdef HAVE_PNG_H
#    include <png.h>
#  else
#    include <libpng/png.h>
#  endif // HAVE_PNG_H
#endif // HAVE_LIBPNG && HAVE_LIBZ
}


/**
  The constructor loads the named PNG image from the given png filename.
  <P>The destructor free all memory and server resources that are used by
  the image.
*/
void LoadPNG(const char *png) // I - File to read
{
  int		i;			// Looping var
  FILE		*fp;			// File pointer
  int		channels;		// Number of color channels
  png_structp	pp;			// PNG read pointer
  png_infop	info;			// PNG info pointers
  png_bytep	*rows;			// PNG row pointers


  // Open the PNG file...
  if ((fp = fopen(png, "rb")) == NULL) return;

  // Setup the PNG data structures...
  pp   = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
  info = png_create_info_struct(pp);

  if (setjmp(pp->jmpbuf))
  {
	  int debug = 1;
	  return;
  }

  // Initialize the PNG read "engine"...
  png_init_io(pp, fp);

  // Get the image dimensions and convert to grayscale or RGB...
  png_read_info(pp, info);

  if (info->color_type == PNG_COLOR_TYPE_PALETTE)
    png_set_expand(pp);

  if (info->color_type & PNG_COLOR_MASK_COLOR)
    channels = 3;
  else
    channels = 1;

  if ((info->color_type & PNG_COLOR_MASK_ALPHA) || info->num_trans)
    channels ++;

  int w = (int)(info->width);
  int h = (int)(info->height);
  int d = channels;
  pictureWidth = w;
  pictureHeight = h;

  if (info->bit_depth < 8)
  {
    png_set_packing(pp);
    png_set_expand(pp);
  }
  else if (info->bit_depth == 16)
    png_set_strip_16(pp);

#  if defined(HAVE_PNG_GET_VALID) && defined(HAVE_PNG_SET_TRNS_TO_ALPHA)
  // Handle transparency...
  if (png_get_valid(pp, info, PNG_INFO_tRNS))
    png_set_tRNS_to_alpha(pp);
#  endif // HAVE_PNG_GET_VALID && HAVE_PNG_SET_TRNS_TO_ALPHA

  unsigned char *array = (unsigned char *)pictureS;

  // Allocate pointers...
  rows = new png_bytep[h];

  for (i = 0; i < h; i ++)
    rows[i] = (png_bytep)(array + i * w * d); // we flip it

  // Read the image, handling interlacing as needed...
  for (i = png_set_interlace_handling(pp); i > 0; i --)
    png_read_rows(pp, rows, NULL, h);

#ifdef WIN32
  // Some Windows graphics drivers don't honor transparency when RGB == white
  if (channels == 4) 
  {
    // Convert RGB to 0 when alpha == 0...
    unsigned char *ptr = (unsigned char *)array;
    for (i = w * h; i > 0; i --, ptr += 4)
      if (!ptr[3]) ptr[0] = ptr[1] = ptr[2] = 0;
  }
#endif // WIN32

  if (channels == 3)
  {
	  unsigned char *array2 = new unsigned char[pictureWidth * pictureHeight * 4];
	  for (int i = w * h - 1; i >= 0; --i)
	  {
		  array2[i*4+0] = array[i*3+0];
		  array2[i*4+1] = array[i*3+1];
		  array2[i*4+2] = array[i*3+2];
		  array2[i*4+3] = 255;
	  }
	  memcpy(array, array2, w * h * 4);
	  delete[] array2;
  }

  // Free memory and return...
  delete[] rows;

  png_read_end(pp, info);
  png_destroy_read_struct(&pp, &info, NULL);

  fclose(fp);
}

unsigned int pictureWriteOut[MAXWIDTH*MAXHEIGHT];

void abort_(const char * s, ...)
{
        va_list args;
        va_start(args, s);
        vfprintf(stderr, s, args);
        fprintf(stderr, "\n");
        va_end(args);
        abort();
}

void savePNG(const char* file_name)
{
	png_structp png_ptr;
	png_infop info_ptr;

	/* create file */
    FILE *fp = fopen(file_name, "wb");
    if (!fp)
            abort_("[write_png_file] File %s could not be opened for writing", file_name);


    /* initialize stuff */
    png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);

    if (!png_ptr)
            abort_("[write_png_file] png_create_write_struct failed");

    info_ptr = png_create_info_struct(png_ptr);
    if (!info_ptr)
            abort_("[write_png_file] png_create_info_struct failed");

    if (setjmp(png_jmpbuf(png_ptr)))
            abort_("[write_png_file] Error during init_io");

    png_init_io(png_ptr, fp);

    /* write header */
    if (setjmp(png_jmpbuf(png_ptr)))
            abort_("[write_png_file] Error during writing header");

	png_set_IHDR(png_ptr, info_ptr, pictureWidth, pictureHeight,
					8, PNG_COLOR_TYPE_RGBA, PNG_INTERLACE_NONE,
                    PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);

    png_write_info(png_ptr, info_ptr);


    /* write bytes */
    if (setjmp(png_jmpbuf(png_ptr)))
            abort_("[write_png_file] Error during writing bytes");

	png_bytep * row_pointers;
		
	unsigned char *array = new unsigned char[pictureWidth * pictureHeight * 4];
	for (int i = pictureWidth * pictureHeight; i >= 0; --i)
	{
		array[i*4+0] = ((unsigned char*)pictureWriteOut)[i*4+0];
		array[i*4+1] = ((unsigned char*)pictureWriteOut)[i*4+1];
		array[i*4+2] = ((unsigned char*)pictureWriteOut)[i*4+2];
		array[i*4+3] = ((unsigned char*)pictureWriteOut)[i*4+3];
	}


	// Allocate pointers...
	row_pointers = new png_bytep[pictureHeight];

	for (int i = 0; i < pictureHeight; i ++)
		row_pointers[i] = (png_bytep)(array + (i) * pictureWidth * 4); // we flip it

	png_write_image(png_ptr, row_pointers);

    /* end write */
    if (setjmp(png_jmpbuf(png_ptr)))
            abort_("[write_png_file] Error during end of write");
	
    png_write_end(png_ptr, NULL);

    /* cleanup heap allocation */
    free(row_pointers);

    fclose(fp);
}

void LoadBMP(char *name)
{
	FILE *in;
	in = fopen(name, "rb");
	fseek(in, 0, SEEK_END);
	int FileSize = ftell(in);
	fseek(in, 0, SEEK_SET);
	fread(bmpBuffer2, FileSize, 1, in ) ;
	fclose (in);

	pictureWidth  = bmpBuffer2[0x12] +  (bmpBuffer2[0x13]<<8) + (bmpBuffer2[0x14]<<16) + (bmpBuffer2[0x15]<<24);
	pictureHeight = bmpBuffer2[0x16] +  (bmpBuffer2[0x17]<<8) + (bmpBuffer2[0x18]<<16) + (bmpBuffer2[0x19]<<24);

	for (int y = 0; y < pictureHeight; ++y)
	for (int x = 0; x < pictureWidth; ++x)
	{
		int y2 = pictureHeight - y - 1;
		int b = bmpBuffer2[(x + y2 * pictureWidth) * 4 + 0x36 + 0+1+16];
		int g = bmpBuffer2[(x + y2 * pictureWidth) * 4 + 0x36 + 1+1+16];
		int r = bmpBuffer2[(x + y2 * pictureWidth) * 4 + 0x36 + 2+1+16];
		int a = bmpBuffer2[(x + y2 * pictureWidth) * 4 + 0x36 + 3+1+16];
		pictureS[x + y * pictureWidth] = r + (g << 8) + (b << 16);
	}
}

void setPixel(int x, int y, int c)
{
	if (((unsigned int)x < 320) && ((unsigned int)y < 200))
	{
		screenBuffer[x+y*320] = c;
		pictureWriteOut[x+y*pictureWidth] = c ? 0xffffffff : 0xff000000;
	}
}

void exportGlobals()
{
	FILE *out = fopen((globalOutputDirPrefix+"globals.inc").c_str(),"w");
	fclose(out);
}

void convertAndSaveFont()
{
	int fontCharCount = 32 * 3;

	LoadPNG((globalWorkingDirPrefix + "gamefont.png").c_str());
	FILE *out = fopen((globalOutputDirPrefix + "gamefont.bin").c_str(),"wb");
	for (int i = 0; i < fontCharCount; ++i)
	{
		int xi = i % 32;
		int yi = i / 32;
		
		for (int y = 0; y < 8; ++y)
		{
			unsigned char c = 0;
			for (int x = 0; x < 8; ++x)
			{
				int pix = pictureS[(x+xi*8)+(y+yi*8)*pictureWidth];
				if ((pix & 255) > 100)
					c |= 1 << (7-x);
			}
			fwrite(&c,1,1,out);
		}
	}
	fclose(out);
}

int nearestColor(unsigned char plus4col, unsigned char *plus4cols)
{
	int color = palette[plus4col];
	int r = color & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	int lastDelta = 10000*10000;
	int ri = 0;
	for (int i = 0; i < 4; ++i) 
	{
		if (plus4cols[i] != -1)
		{
			int cr = (palette[plus4cols[i]]) & 255;
			int cg = (palette[plus4cols[i]]>>8) & 255;
			int cb = (palette[plus4cols[i]]>>16) & 255;
			int dr = cr - r;
			int dg = cg - g;
			int db = cb - b;
			int d = dr * dr + dg * dg + db * db;
			if (d < lastDelta) 
			{
			  lastDelta = d;
			  ri = i;
			}
		}
  }
  return ri;
}


void convertSideBar()
{
	LoadPNG((globalWorkingDirPrefix + "sidebar.png").c_str());
	FILE *out = fopen((globalOutputDirPrefix + "sidebar.bin").c_str(),"wb");
	FILE *out2 = fopen((globalOutputDirPrefix + "sidebar2.bin").c_str(),"wb");
	for (int x2 = 0; x2 < 6; ++x2)
	{
		for (int y = 0; y < 32; ++y)
		{
			unsigned char c = 0;
			unsigned char c2 = 0;
			for (int x = 0; x < 4; ++x)
			{
				int col = pictureS[(x+x2*4)+y*pictureWidth];
				unsigned char p4cols[4] = {0x00,0x79,0x31,0x01};
				int p4col = getColor(col);
				int pix = nearestColor(p4col,p4cols);
				c |= pix << (6-x*2);
				c2 |= pix << (x*2);
			}
			fwrite(&c,1,1,out);
			fwrite(&c2,1,1,out2);
		}
	}
	fclose(out2);
	fclose(out);
}

char *text[] = {
	"                           ",
	" Kate looks up to the skies",
	"                           ",
	"  of Zador. She knows she  ",
	"                           ",
	" will be leaving Zador for ",
	"                           ",
	"       some time now.      ",
	"                           ",
	"     The spellstone of     ",
	"                           ",
	"the ancients is in her left",
	"                           ",
	" hand. She hears a voice.  ",
	"                           ",
	" Yes, she knows this voice.",
	"                           ",
	"  Zordan is laughing and   ",
	"                           ",
	"     points to the two     ",
	"                           ",
	"  spaceships in front of   ",
	"                           ",
	"         them both.        ",
	"                           ",
	"This appears to be the only",
	"                           ",
	"         quest left.       ",
	"                           ",
	"  But perhaps this is a    ",
	"                           ",
	"  story for another game.  ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"coding:                    ",
	"                           ",
	"    Stefan Mader           ",
	"                           ",
	"                           ",
	"                           ",
	"gfx:                       ",
	"                           ",
	"    Rainer M�hr            ",
	"                           ",
	"    Luca Carrafiello       ",
	"                           ",
	"    Helge Vogt             ",
	"                           ",
	"                           ",
	"                           ",
	"ingame gfx:                ",
	"                           ",
	"    Stefan Mader           ",
	"                           ",
	"                           ",
	"                           ",
	"music:                     ",
	"                           ",
	"    Luca Carrafiello       ",
	"                           ",
	"    Ronny Kr�ger           ",
	"                           ",
	"    Ingo Jache             ",
	"                           ",
	"                           ",
	"                           ",
	"16x16 font:                ",
	"                           ",
	"    Cougar/Sanity (reduced)",
	"                           ",
	"                           ",
	"                           ",
	"framework & player:        ",
	"                           ",
	"    Ingo Jache             ",
	"                           ",
	"                           ",
	"                           ",
	"native speaker:            ",
	"                           ",
	"    Lena Kilkka            ",
	"                           ",
	"with help from:            ",
	"                           ",
	"    Thomas Mann            ",
	"                           ",
	"                           ",
	"                           ",
	"loader:                    ",
	"                           ",
	"    Gunnar Ruthenberg      ",
	"                           ",
	"                           ",
	"                           ",
	"and additional help by:    ",
	"                           ",
	"    Andre Fedorow          ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"     The lands of Zador    ",
	"                           ",
	"      was recorded in      ",
	"                           ",
	"         TED Vision        ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"          see you          ",
	"                           ",
	"   in the next production  ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"      have a nice time     ",
	"                           ",
	"                           ",
	"                           ",
	"        best wishes        ",
	"                           ",
	"                           ",
	"                           ",
	" and remember Kate in Zador",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"       copyright by        ",
	"                           ",
	"     Bauknecht in 2016     ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	"                           ",
	NULL
};


void exportText()
{
	char *textRemap = " !\"#$\%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_�abcdefghijklmnopqrstuvwxyz�|���";

	int baseChar = 0;

	char *currentLineText = NULL;
	int currentLine = 0;

	FILE *out = fopen((globalOutputDirPrefix + "text.inc").c_str(),"w");
	do
	{
		currentLineText = text[currentLine];
		char writeOut[28];
		for (int i = 0; i < 28; ++i)
			writeOut[i] = baseChar; // space

		int j = 0;
		while(currentLineText[j] != NULL && j < 28)
		{
			char toLookFor = currentLineText[j];
				
			// remap it
			char *check = textRemap;
			do
			{
				if (*check == toLookFor)
				{
					writeOut[j] = (check-textRemap) + baseChar; 
					break;
				}
				check++;
			} while (*check != NULL);
			++j;
		};

		fprintf(out,"\tdc.b %d",writeOut[0]);
		for (int i = 1; i < 28; ++i)
			fprintf(out,",%d",writeOut[i]);
		fprintf(out,"; One Line\n");

		currentLine++;
	} while (text[currentLine] != NULL);
	fprintf(out,"\tdc.b $ff");
	fclose(out);
}

void save()
{
}

void intro_init( void )
{
	setupWithCommandLine();
	FILE *in = fopen((dataDirPrefix + "PLU4COLORS.bin").c_str(),"rb");
	fread(palette,1,1024,in);
	fclose(in);
	for (int i = 0; i < 256; ++i)
		palette[i] = ((palette[i] >> 16) & 255) + ((palette[i] & 0xff)<<16) + (palette[i] & 0xff00)+0xff000000;
	frameCounter = 0;

	exportGlobals();
	convertAndSaveFont();
	convertSideBar();
	exportText();
}

bool levelMode = true;

void intro_do( unsigned int *buffer, long itime )
{ 
	float secs = (float)itime / 1000.f;
	float frame = secs * 60.f / 1.f;
	int iFrame = (int)frame;
	static int lFrame = iFrame;


	for( int i=0; i<XRES*YRES; i++ )
	{
		int x = ((i % XRES)*SXRES/XRES);
		int y = ((i / XRES)*SYRES/YRES);
		buffer[i] = palette[screenBuffer[x+y*160*2]];
	}

	frameCounter++;
	lFrame = iFrame;
}
