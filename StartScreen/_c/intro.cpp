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
	}
}

void exportGlobals()
{
	FILE *out = fopen((globalOutputDirPrefix+"globals.inc").c_str(),"w");
	fclose(out);
}

unsigned char xfont[0x800];

void buildFont()
{
	/*
	FILE *in = fopen((globalWorkingDirPrefix + "old_english_xy.64c").c_str(),"rb");
	//FILE *in = fopen((globalWorkingDirPrefix + "minas_gundur.64c").c_str(),"rb");
	fread(xfont,1,2,in);
	fread(xfont,1,0x800,in);
	fclose(in);
	FILE *out = fopen((globalOutputDirPrefix + "bigfont.bin").c_str(),"wb");
	for (int i = 0; i < 64; ++i)
	{
		for (int y2 = 0; y2 < 2; ++y2)
		for (int x2 = 0; x2 < 2; ++x2)
		for (int y3 = 0; y3 < 8; ++y3)
		{
			unsigned char writeOut = 0;
			for (int x3 = 0; x3 < 8; x3+=2)
			{
				int x = x3 + x2 * 8;
				int y = y3 + y2 * 8;

				int pix1 = (xfont[(y & 7)+((x / 8) & 1)*8+((y / 8) & 1)*16+i*32] >> (7-(x & 7))) & 1;
				int pix2 = (xfont[(y & 7)+(((x+1) / 8) & 1)*8+((y / 8) & 1)*16+i*32] >> (7-((x+1) & 7))) & 1;
				int pix = pix1 + pix2 * 2;
				int cols[4] = {0x00,0x39,0x55,0x71};
				if (pix != 0)
					pix -= cos(y/7.f*3.14159f)*1*1.5;
				if (pix > 3)
					pix = 3;
				if (pix < 0)
					pix = 0;
				writeOut |= pix << (6-x3);
				pix = cols[pix & 3];
				setPixel((i & 15)*16+x,y + i / 16 * 16,pix);
				setPixel((i & 15)*16+x+1,y + i / 16 * 16,pix);
			}
			fwrite(&writeOut,1,1,out);
		}
	}
	fclose(out);
	*/
	//LoadPNG((globalWorkingDirPrefix + "font5.png").c_str());
	LoadPNG((globalWorkingDirPrefix + "fontused.png").c_str());
	FILE *out = fopen((globalOutputDirPrefix + "bigfont.bin").c_str(),"wb");
	for (int i = 0; i < 64; ++i)
	{
		for (int y2 = 0; y2 < 2; ++y2)
		for (int x2 = 0; x2 < 2; ++x2)
		for (int y3 = 0; y3 < 8; ++y3)
		{
			unsigned char writeOut = 0;
			for (int x3 = 0; x3 < 8; x3+=2)
			{
				int x = x3 + x2 * 8 + (i % 20)*16;
				int y = y3 + y2 * 8 + (i / 20)*16;

				//int rgb = pictureS[x+y*pictureWidth];
				//int grey = ((rgb & 255)+((rgb>>8)&255)+((rgb>>16)&255))/3;
				//int pix1 = grey*6/255;
				//int pix2 = (grey*6+128)/255;
				//
				//int pix = (x3 / 2 + y3) & 1 ? pix1 : pix2;
				//
				//if (pix > 3)
				//	pix = 3;
				//if (pix < 0)
				//	pix = 0;
				//
				//int c = pix * 256 / 4;

				int rgb = pictureS[x/2+y*pictureWidth];
				int pix = (rgb & 255) * 5 / 256;

				//pictureWriteOut[x/2 + y * (pictureWidth/2)] = c | (c << 8) | (c << 16) | 0xff000000;
				writeOut |= pix << (6-x3);

				int cols[4] = {0x00,0x33,0x53,0x73};
				pix = cols[pix & 3];
				setPixel(x,y,pix);
				setPixel(x+1,y,pix);
			}
			fwrite(&writeOut,1,1,out);
		}
	}
	fclose(out);
	pictureWidth /= 2;
	//savePNG((globalWorkingDirPrefix + "fontused.png").c_str());
}

int nearestColor(int plus4col, int *plus4cols)
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
  //if (ri == 0) ri = 0x2D;
  return ri;
}

int getBlack0(unsigned int col)
{
	//if ((col & 15) == 0)
	//	col = 0;
	return col;
}

int GetFotoColor(unsigned int col)
{
	int searchcol = ((col>>16) & 255)+(col & (255<<8))+((col & 255)<<16);
	int c  = getColor(searchcol);
	return getBlack0(c);
}

void exportLogo(const char *name)
{
	LoadPNG(name);
	int dr = 0;
	int dg = 0;
	int db = 0;
	for (int i = 0; i < pictureWidth * pictureHeight; ++i)
	{
		int col = pictureS[i];
		int r = col & 255;
		int g = (col>>8) & 255;
		int b = (col>>16) & 255;
		/*
		float grey = (r + g + b) / 3.f;
		float sat = 0.5f;
		r = (int)((float)(r - grey) * sat + grey);
		g = (int)((float)(g - grey) * sat + grey);
		b = (int)((float)(b - grey) * sat + grey);
		r *= 0.75f;
		g *= 0.75f;
		*/
		//r += dr;
		//g += dg;
		//b += db;
		if (r < 0) r = 0;
		if (r > 255) r = 255;
		if (g < 0) g = 0;
		if (g > 255) g = 255;
		if (b < 0) b = 0;
		if (b > 255) b = 255;
		int col2 = getColor2(r|(g<<8)|(b<<16));
		//int r2 = palette[col2] & 255;
		//int g2 = (palette[col2]>>8) & 255;
		//int b2 = (palette[col2]>>16) & 255;
		//dr = r - r2;
		//dg = g - g2;
		//db = b - b2 = 1;
		pictureS[i] = col2;
	}

	int frontColor = 0x09;//pictureS[0];
	int backColor = 0x00;//pictureS[1];

	int farbCount[0x100];

	FILE *bitmap = fopen((globalOutputDirPrefix + "logoPicture.bin").c_str(),"wb");
	FILE *lumram = fopen((globalOutputDirPrefix + "logoPictureLumi.bin").c_str(),"wb");
	FILE *colram = fopen((globalOutputDirPrefix + "logoPictureColi.bin").c_str(),"wb");

	int yadd = -2;

	int sizy = 11;
	int startY = 0;
	int endY = startY + sizy;

	for (int y = startY; y < endY; ++y)
	for (int x = 0; x < pictureWidth / 4; ++x)
	{
		for (int i = 0; i < 0x100; ++i)
			farbCount[i] = 0;
		for (int y2 = 0; y2 < 8; ++y2)
		for (int x2 = 0; x2 < 4; ++x2)
		{
			int yp = (y*8+y2+yadd);
			if ((yp >= 0) && (yp < pictureHeight))
			{
				int col = pictureS[x*4+x2+yp*pictureWidth];
				farbCount[getBlack0(col)]++;
			}
		}

		// die zwei meisten farben
		int mostcolor0 = -1;
		int mostcolor1 = -1;
		for (int i = 0; i < 0x100; ++i)
		{
			if (getBlack0(i) != getBlack0(backColor) && getBlack0(i) != getBlack0(frontColor))
				if ( ((farbCount[getBlack0(i)] != 0)&&(mostcolor0==-1)) || ((mostcolor0!=-1) && farbCount[mostcolor0]<farbCount[getBlack0(i)]))
					mostcolor0 = i;
		}
		for (int i = 0; i < 0x100; ++i)
		{
			if (getBlack0(i) != getBlack0(backColor) && getBlack0(i) != getBlack0(frontColor) && i != mostcolor0)
				if (((farbCount[getBlack0(i)] != 0)&&(mostcolor1==-1)) || ((mostcolor1!=-1) && (farbCount[mostcolor1]<farbCount[getBlack0(i)])))
					mostcolor1 = i;
		}

		if (mostcolor0 == -1)
			mostcolor0 = 0x31;
		if (mostcolor1 == -1)
			mostcolor1 = 0x51;

		if ((mostcolor0 & 0xf0) > (mostcolor1 & 0xf0))
		{
			int temp = mostcolor0;
			mostcolor0 = mostcolor1;
			mostcolor1 = temp;
		}

		int cs[4];
		cs[0] = backColor;
		cs[1] = mostcolor0;
		cs[2] = mostcolor1;
		cs[3] = frontColor;
		for (int y2 = 0; y2 < 8; ++y2)
		{
			unsigned char byt = 0;
			for (int x2 = 0; x2 < 4; ++x2)
			{
				int yp = (y*8+y2+yadd);
				int col = 0;
				if ((yp >= 0) && (yp < pictureHeight))
					col = pictureS[x*4+x2+yp*pictureWidth];
				int bt = nearestColor(col,cs);
				unsigned int pal = palette[cs[bt]];
				pictureWriteOut[x*4+x2+(y*8+y2)*pictureWidth] = 0xff000000 | ((pal>>16) & 255) | (((pal>>0) & 255)<<16) | (pal & 0x0000ff00);
				byt |= bt << (6 - x2 * 2);
			}
			fwrite(&byt,1,1,bitmap);
		}

		unsigned char lum = ((mostcolor0>>4) & 0x0f) | (mostcolor1 & 0xf0);
		unsigned char col = ((mostcolor0<<4) & 0xf0) | (mostcolor1 & 0x0f);
		fwrite(&lum,1,1,lumram);
		fwrite(&col,1,1,colram);
	}
	fclose(bitmap);
	fclose(lumram);
	fclose(colram);

	savePNG((globalWorkingDirPrefix + "rendered.png").c_str());

	FILE *out = fopen((globalOutputDirPrefix + "logoPictureConstants.inc").c_str(),"w");
	fprintf(out, "logoFrontColor equ %d\n",frontColor);
	fprintf(out, "logoBackColor  equ %d\n",backColor);
	fclose(out);
}

const char *text[] =
{
	" BAUKNECHT PRESENTS ",
	"--------------------",
	" THE LANDS OF ZADOR ",
	"   A NEW GAME FOR   ",
	"     THE PLUS/4     ",
	"----  IN  2016  ----",
	"                    ",
	"  BROUGHT TO YOU BY ",
	"                    ",
	"      PSYTRONIK     ",
	"                    ",
	"                    ",
	"--------------------",
	"  WE INVITE YOU TO  ",
	"JUMP INTO A SPLENDID",
	"   COLORFUL WORLD   ",
	"   AND SAVE ZADOR   ",
	"--------------------",
	"--------------------",
	"   BRING THE LAST   ",
	"  KNOWN SPELLSTONE  ",
	"TO THE WORLD OF AZUR",
	"  AND RETURN PEACE  ",
	"----  TO ZADOR  ----",
	NULL,
	"PLEASE ENTER THE SIX",
	"  LETTER LEVELCODE  ",
	"       ......       ",
	"                    ",
	"                    ",
	"                    ",
	NULL,
	"   PLEASE SELECT    ",
	"  THE SKILL LEVEL   ",
	"                    ",
	"       EASY         ",
	"       MEDIUM       ",
	"       HARD         ",
	NULL,
	"                    ",
	"   DO YOU WANT TO:  ",
	"                    ",
	"   START A NEW GAME ",
	"   ENTER LEVELCODE  ",
	"                    ",
	NULL,
	NULL
};

void saveText()
{
	//char *remapArray = "@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_ !\"§$\%&'()*+,-./012345679:;<=>?";
	char *remapArray = "ABCDEFGHIJKLMNOPQRSTUVWXYZ 1234567890!?':,;.ö()-*öö/ä";
	char *colortable2 = "8923b923892389238923892389138923892389238923892339238";
	char *colortable = "893cf98c89ac893c893c893c8913893c893c893c893c893cc33c8";

	unsigned char letterMap[256];
	memset(letterMap,0,256);
	unsigned char *rem = (unsigned char*)remapArray;
	while (*rem != 0) 
	{
		letterMap[*rem] = (unsigned char*)rem - (unsigned char*)remapArray;
		rem++;
	};

	FILE *out = fopen((globalOutputDirPrefix + "letterMap.bin").c_str(),"wb");
	fwrite(letterMap,1,256,out);
	fclose(out);

	int curLine = 0;
	int curText = 0;
	do
	{
		char buffer[1024];
		sprintf(buffer,(globalOutputDirPrefix + "text%d.bin").c_str(),curText);
		FILE *out = fopen(buffer,"wb");
		while(text[curLine] != NULL)
		{
			unsigned char writeOut[20];
			bool notEndline = true;
			for (int i = 0; i < 20; ++i)
			{
				int chr = ' ';
				if (notEndline)
				{
					int chr2 = text[curLine][i];
					if (chr2 == 0)
						notEndline = false;
					else
						chr = chr2;
				}
				char *remap=remapArray;
				while(*remap != NULL)
				{
					if (chr == *remap)
					{
						chr = remap - remapArray;
						break;
					}
					remap++;
				};
				writeOut[i] = chr;
			}
			fwrite(writeOut,1,20,out);
			curLine++;
		}
		unsigned char c255 = 255;
		fwrite(&c255,1,1,out);
		fclose(out);
		curLine++;
		curText++;
	} while (text[curLine] != NULL);

	out = fopen((globalOutputDirPrefix + "colortable1.bin").c_str(),"wb");
	char *color=colortable;
	while(*color != NULL)
	{
		unsigned char col = 0x01;
		if (*color >= '0' && *color <= '9') col = *color - '0';
		if (*color >= 'a' && *color <= 'f') col = *color - 'a' + 10;
		if (*color >= 'A' && *color <= 'F') col = *color - 'A' + 10;
		col |= 0x20;
		fwrite(&col,1,1,out);
		*color++;
	}
	fclose(out);
	out = fopen((globalOutputDirPrefix + "colortable2.bin").c_str(),"wb");
	color=colortable;
	while(*color != NULL)
	{
		unsigned char col = 0x01;
		if (*color >= '0' && *color <= '9') col = *color - '0';
		if (*color >= 'a' && *color <= 'f') col = *color - 'a' + 10;
		if (*color >= 'A' && *color <= 'F') col = *color - 'A' + 10;
		col |= 0x50;
		fwrite(&col,1,1,out);
		*color++;
	}
	fclose(out);

	out = fopen((globalOutputDirPrefix + "colortable12.bin").c_str(),"wb");
	color=colortable2;
	while(*color != NULL)
	{
		unsigned char col = 0x01;
		if (*color >= '0' && *color <= '9') col = *color - '0';
		if (*color >= 'a' && *color <= 'f') col = *color - 'a' + 10;
		if (*color >= 'A' && *color <= 'F') col = *color - 'A' + 10;
		col |= 0x20;
		fwrite(&col,1,1,out);
		*color++;
	}
	fclose(out);
	out = fopen((globalOutputDirPrefix + "colortable22.bin").c_str(),"wb");
	color=colortable2;
	while(*color != NULL)
	{
		unsigned char col = 0x01;
		if (*color >= '0' && *color <= '9') col = *color - '0';
		if (*color >= 'a' && *color <= 'f') col = *color - 'a' + 10;
		if (*color >= 'A' && *color <= 'F') col = *color - 'A' + 10;
		col |= 0x50;
		fwrite(&col,1,1,out);
		*color++;
	}
	fclose(out);
}

void exportTables()
{
	FILE *out = fopen((globalOutputDirPrefix + "andtable.bin").c_str(),"wb");
	for (int i = 0; i < 256; ++i)
	{
		unsigned int c = 0;
		for (int j = 0; j < 4; ++j)
		{
			int mask = ((i>>(j*2)) & 3);
			if (mask==0)
				c |= 3<<(j*2);
			else
				c |= mask<<(j*2);
		}
		fwrite(&c,1,1,out);
	}
	fclose(out);

	out = fopen((globalOutputDirPrefix + "oratable.bin").c_str(),"wb");
	for (int i = 0; i < 256; ++i)
	{
		unsigned char c = 0;
		c = ((i/4) & 3) << (6-(i & 3)*2);
		fwrite(&c,1,1,out);
	}
	fclose(out);
}

struct DOT
{
	unsigned char xlopos,xloadd;
	unsigned char xpos,xadd;
	unsigned char yposlo,yposhi;
	unsigned char color;
};

void exportdotaddtable()
{
	const int DOTCOUNT = 120;
	DOT dots[DOTCOUNT];
	
	int upperline = 86*0;
	for (int i = 0; i < DOTCOUNT; ++i)
	{
		int ypos = rand() % 200;
		int xadd = (rand() % 675);
		int yaddr = (ypos &  7) + ypos / 8 * 320 + 0x2000;
		DOT &d = dots[i];
		d.xlopos = 0;
		d.xpos = rand() % 160;
		d.xloadd = xadd & 255;
		d.xadd = xadd / 256;
		d.yposlo = yaddr & 255;
		d.yposhi = (yaddr / 256);
		d.color = xadd * 4 / 675 + (rand() & 1);
		if (d.color < 1) d.color = 1;
		if (d.color > 3) d.color = 3;
		d.color *= 4;
	}
	FILE *out = fopen((globalOutputDirPrefix + "dotspecs.inc").c_str(),"w");

	fprintf(out,"\nDOTLOXPOS dc.b %d",dots[0].xlopos);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].xlopos); else fprintf(out,",%d",dots[i].xlopos);}
	fprintf(out,"\nDOTLOXADD dc.b %d",dots[0].xloadd);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].xloadd); else fprintf(out,",%d",dots[i].xloadd);}

	fprintf(out,"\nDOTXPOS dc.b %d",dots[0].xpos);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].xpos); else fprintf(out,",%d",dots[i].xpos);}
	fprintf(out,"\nDOTXADD dc.b %d",dots[0].xadd);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].xadd); else fprintf(out,",%d",dots[i].xadd);}

	fprintf(out,"\nDOTYPOSLO dc.b %d",dots[0].yposlo);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].yposlo); else fprintf(out,",%d",dots[i].yposlo);}
	fprintf(out,"\nDOTYPOSHI dc.b %d",dots[0].yposhi);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].yposhi); else fprintf(out,",%d",dots[i].yposhi);}

	fprintf(out,"\nDOTCOLOR dc.b %d",dots[0].color);
	for (int i = 1; i < DOTCOUNT; ++i) {if ((i & 15)==15) fprintf(out,"\n\t dc.b %d",dots[i].color); else fprintf(out,",%d",dots[i].color);}

	fclose(out);
}

void exportMask()
{
#define MASKCOUNT 4
	FILE *out = fopen((globalOutputDirPrefix + "mask.bin").c_str(),"wb");
	for (int i = 0; i < MASKCOUNT; ++i)
	{
		for (int y2 = 0; y2 < 2; ++y2)
		for (int x2 = 0; x2 < 2; ++x2)
		for (int y = 0; y < 8; ++y)
		{
			unsigned char c = 0;
			for (int x = 0; x < 8; x += 2)
			{
				int pix = 0;
				float rx = ((x2 * 8 + x)-7.5)/8.f;
				float ry = ((y2 * 8 + y)-7.5)/8.f;
				float d = sqrt(rx*rx+ry*ry)/sqrt(2.f);
				d += (float)(MASKCOUNT-1-i) / (MASKCOUNT-1);
				if (d < 1)
					pix = 3;
				else
					pix = 0;
				c |= pix << (6-x);
			}
			fwrite(&c,1,1,out);
		}
	}
	fclose(out);
}

void exportLogoFadeinTables()
{
#define TABSIZE (40*10)
	unsigned short randtab[TABSIZE];
	int randtabpos = 0;

	for (int i = 0; i < TABSIZE; ++i)
	{
		randtab[i] = i * 8;
	}

	for (int j = 0; j < 256; ++j)
	{
		int t1 = rand() % TABSIZE;
		int t2 = rand() % TABSIZE;
		int t = randtab[t1];
		randtab[t1] = randtab[t2];
		randtab[t2] = t;
	}


	FILE *out = fopen((globalOutputDirPrefix + "randtablogo.bin").c_str(),"wb");
	fwrite(randtab,1,TABSIZE*sizeof(unsigned short),out);
	fclose(out);
}

void buildOverFadeRandomTable()
{
#define LINES 5
	unsigned char overFadeTable[40*LINES];

	for (int y = 0; y < LINES; ++y)
	for (int x = 0; x < 40; ++x)
	{
		overFadeTable[x+y*40] = (39-x);
	}

	// pertub
	for (int i = 0; i < 40*LINES*8; ++i)
	{
		int ypos = rand() % LINES;
		int xpos = rand() % 40;
		int move = rand() % 2;
		if (xpos + move < 40)
		{
			int pos = xpos + ypos * 40;
			int t = overFadeTable[pos];
			overFadeTable[pos] = overFadeTable[pos + move];
			overFadeTable[pos + move] = t;
		}
	}

	FILE *out = fopen((globalOutputDirPrefix + "randomtable.bin").c_str(),"wb");
	fwrite(overFadeTable,1,40*LINES,out);
	fclose(out);
}

void buildFadeOutStuff()
{
	buildOverFadeRandomTable();
	unsigned char forty[256];
	for (int x = 0; x < 256; ++x)
	{
		int y = sin((x % 40)/40.f*PI*2.5f)*10;
		forty[x] = ((x / 40) % 5)+y;//((x+1) % 25);
	}

	for (int i = 0; i < 256; ++i)
	{
		int switch1 = rand(); 
		int switch2 = switch1 + (rand() & 1);
		switch1 &= 255;
		switch2 &= 255;
		int temp = forty[switch1];
		forty[switch1] = forty[switch2];
		forty[switch2] = temp;
	}
	FILE *out = fopen((globalOutputDirPrefix + "fortyline.bin").c_str(),"wb");
	fwrite(forty,1,256,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix + "dectable.bin").c_str(),"wb");
	for (int i = 0; i < 256; ++i)
	{
		int x1 = i & 15;
		int x2 = i>>4;
		x1 -= 1;
		x2 -= 1;
		bool nulltile = false;
		if ((x1 < 0) && (x2 < 0))
			nulltile = true;
		if (x1 < 0) x1 = 0;
		if (x2 < 0) x2 = 0;
		unsigned char c = (x1 & 15) | (x2 << 4);
		if (nulltile)
			c |= 0x80;
		fwrite(&c,1,1,out);		
	}
	fclose(out);

	out = fopen((globalOutputDirPrefix + "bitconverttable.bin").c_str(),"wb");
	for (int i = 0; i < 256; ++i)
	{
		unsigned char c = i;
		for (int x = 0; x < 4; ++x)
		{
			if (((c>>(6-x*2)) & 3)==3)
			{
				c = c & (~(3<<(6-x*2)));
				c |= 1<<(6-x*2);
			}
			if (((c>>(6-x*2)) & 3)==0)
			{
				c = c & (~(3<<(6-x*2)));
				c |= 2<<(6-x*2);
			}
		}
		fwrite(&c,1,1,out);		
	}
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
	pictureWidth = 256;
	pictureHeight = 64;
	buildFont();
	exportLogo((globalWorkingDirPrefix + "Zador_logo.png").c_str());
	saveText();
	exportTables();
	exportdotaddtable();
	exportMask();
	exportLogoFadeinTables();
	buildFadeOutStuff();
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
