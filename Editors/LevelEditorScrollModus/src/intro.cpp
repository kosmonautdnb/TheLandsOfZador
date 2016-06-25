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

#define TILE_ROWS 14
#define Log(fmt,...) {char buffer[1000];sprintf(buffer,fmt, ##__VA_ARGS__);OutputDebugStringA(buffer);OutputDebugStringA("\n");}

#define UNDO_BUFFER_SIZE 64

int frameCounter = 0;
#define RXRES (160 * 2)
#define RYRES (200 * 2)
unsigned char screenBuffer[RXRES*RYRES];

unsigned int palette[256];

float mousePosX;
float mousePosY;
bool mouseButtonL;
bool mouseButtonR;

int enemySpriteImage[64];
int enemyTypeForKey[20]; 

int tileRandom = 0;
int randTab[256];

int activeOverlay = 0;

struct FRAME
{
	int firstSpriteFrame;
	int spriteFrameCount;
	std::string name;
	int xsize,ysize;
};

std::vector<FRAME> frames;

struct ENEMY
{
	std::string name;
	int firstSpriteFrame;
	int xstart,ystart;
	int xend,yend;
	std::string initFunction;
	std::string handleFunction;
	int hitPoints;
	int specialEnemyType;
};

std::vector<ENEMY> enemies;

ENEMY getEnemy(const char *name)
{
	int i;
	for (i = 0; i < enemies.size(); ++i)
	{
		std::string name2 = enemies[i].name;
		if (name2 == name)
			return enemies[i];
	}
	return ENEMY();
}

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
	if ((ri & 0x0f) == 0)
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

class VectorSprite
{
public:
	std::string name;
	unsigned char xsize;
	unsigned char ysize;
	std::vector<unsigned char> imageData;
	unsigned char pixxadd;
	unsigned char pixyadd;
	bool onlyWhite;
	unsigned char realxsize;
	bool doubleSize;
	int sourceX,sourceY;

	unsigned int *picture;
	int pictureWidth;
	int pictureHeight;
};

class SpriteDesc
{
public:
	SpriteDesc();
	SpriteDesc(std::string name, int _x, int _y, int _w, int _h, bool _doubleSize = false) {fileName = name; x=_x; y=_y; w=_w; h=_h;doubleSize = _doubleSize;}
	std::string fileName;
	int x,y;
	int w,h;
	bool doubleSize;
};

#define VSPRITE_YMAX 32
#define VSPRITE_XMAX 16

std::vector<VectorSprite> vsprites;

std::string currentVectorSpriteName;



bool getMaskBool(int color)
{
	/*
	if (currentVectorSpriteName.find("clara",0)!=currentVectorSpriteName.npos)
	{
		int r = (color>>0) & 255;
		int g = (color>>8) & 255;
		int b = (color>>16) & 255;
		bool red = false;

		if ((r<150)&&(g>150)&&(b>150))
			red = true;
		return !red;
	}
	*/

	int r = (color>>0) & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	bool red = false;
	if (r > 200 && g < 200 && b < 200)
		red = true;

	return !red;
}

bool getGreyBool(int color)
{
	/*
	if (currentVectorSpriteName.find("clara",0)!=currentVectorSpriteName.npos)
	{
		int r = (color>>0) & 255;
		int g = (color>>8) & 255;
		int b = (color>>16) & 255;
		bool red = false;

		if ((r<150)&&(g>150)&&(b>150))
			red = true;
		return !red;
	}
	*/

	int r = (color>>0) & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	bool red = false;
	if (r > 120 && g > 120 && b > 120 && r < 140 && g < 140 && b < 140)
		red = true;

	return red;
}

bool getWhiteBool(int color)
{
	/*
	if (currentVectorSpriteName.find("clara",0)!=currentVectorSpriteName.npos)
	{
		int r = (color>>0) & 255;
		int g = (color>>8) & 255;
		int b = (color>>16) & 255;
		bool red = false;

		if (r>180)
			red = true;
		return red;
	}
	*/

	int r = (color>>0) & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	bool yeah = false;
	if (r > 200 && g > 200 && b > 200)
		yeah = true;

	return yeah;
}

void scaleImage(int toxres,int toyres)
{
	int *dest = new int[toxres*toyres];

	for (int y = 0; y < toyres; ++y)
	for (int x = 0; x < toxres; ++x)
	{
		dest[x+y*toxres] = pictureS[x*pictureWidth/toxres+(y*pictureHeight/toyres)*pictureWidth];
	}

	pictureWidth = toxres;
	pictureHeight = toyres;
	memcpy(pictureS,dest,toxres*toyres*sizeof(int));

	delete dest;
}

void getArea(int xp, int yp, int toxres,int toyres, bool isDoubleSize)
{
	int *dest = new int[toxres*toyres];

	for (int y = 0; y < toyres; ++y)
	for (int x = 0; x < toxres; ++x)
	{
		bool isNull = false;
		if (x >= pictureWidth || y >= pictureHeight)
			isNull = true;

		if (!isDoubleSize)
			dest[x+y*toxres] = isNull ? 0xff0000ff : pictureS[(x+xp)+(y+yp)*pictureWidth];
		else
			dest[x+y*toxres] = isNull ? 0xff0000ff : pictureS[(x+xp)*2+(y+yp)*pictureWidth];
	}

	pictureWidth = toxres;
	pictureHeight = toyres;
	memcpy(pictureS,dest,toxres*toyres*sizeof(int));

	delete dest;
}

void addVectorSprite(SpriteDesc desc)
{
	VectorSprite sprite;

	LoadPNG(desc.fileName.c_str()); // perhaps scale the picture here
	getArea(desc.x,desc.y,desc.w,desc.h,desc.doubleSize);
	sprite.name = desc.fileName;
	sprite.pictureWidth = pictureWidth;
	sprite.pictureHeight = pictureHeight;
	sprite.picture = new unsigned int[pictureWidth*pictureHeight];
	sprite.sourceX = desc.x;
	sprite.sourceY = desc.y;
	sprite.doubleSize = desc.doubleSize;
	memcpy(sprite.picture, pictureS, pictureWidth * pictureHeight * sizeof(int));
	vsprites.push_back(sprite);
}

void reprocessImage(VectorSprite &sprite)
{
	LoadPNG(sprite.name.c_str()); // perhaps scale the picture here
	for(int i = 0; i < pictureWidth * pictureHeight; ++i)
		pictureWriteOut[i] = pictureS[i];
	for (int y = 0; y < sprite.pictureHeight; ++y)
	for (int x = 0; x < sprite.pictureWidth; ++x)
	{
		int xp = x + sprite.sourceX;
		int yp = y + sprite.sourceY;
		if (sprite.doubleSize)
		{
			pictureWriteOut[(xp*2)+0+yp*pictureWidth] = sprite.picture[x+y*sprite.pictureWidth] | 0xff000000;
			pictureWriteOut[(xp*2)+1+yp*pictureWidth] = sprite.picture[x+y*sprite.pictureWidth] | 0xff000000;
		}
		else
			pictureWriteOut[xp+yp*pictureWidth] = sprite.picture[x+y*sprite.pictureWidth] | 0xff000000;
	}
	std::string name = sprite.name;
	savePNG(name.c_str());
}

void convertVectorSprite(VectorSprite &sprite)
{
	currentVectorSpriteName = sprite.name;

	int minX = 1000;
	int minY = 1000;
	int maxX = 0;
	int maxY = 0;
	for (int y = 0; y < sprite.pictureHeight; ++y)
	for (int x = 0; x < sprite.pictureWidth; ++x)
	{
		if (getMaskBool(sprite.picture[x+y*sprite.pictureWidth])||getWhiteBool(sprite.picture[x+y*sprite.pictureWidth]))
		{
			if (x < minX)
				minX = x;
			if (y < minY)
				minY = y;
			if (x > maxX)
				maxX = x;
			if (y > maxY)
				maxY = y;
		}
	}
	maxX++;
	maxY++;

	if (minX == 1000) minX = 0;
	if (minY == 1000) minY = 0;
	sprite.pixxadd = minX;
	sprite.pixyadd = minY;
	int xsize	= (int)(maxX-minX);
	int ysize	= (int)(maxY-minY);
	if (ysize > VSPRITE_YMAX)
		ysize = VSPRITE_YMAX;
	if (xsize > VSPRITE_XMAX)
		xsize = VSPRITE_XMAX;
	sprite.xsize	= xsize;
	sprite.ysize	= ysize;
	sprite.realxsize = sprite.pictureWidth;
	int rightMoveBit	= 0x80;
	int endMarker		= 0xff;
	int clearLineMarker	= 0xfe;
	bool lastHasMoveRight = false;
	bool lastWasClearLine = false;
	bool hasWhite = false;
	bool onlyWhite = true;
	sprite.imageData.clear();

	for (int x = 0; x < xsize; ++x)
	{
			for (int y = 0; y < ysize; ++y)
			{
				int col = sprite.picture[(x+minX)+(y+minY)*sprite.pictureWidth];
				bool maskBit = getMaskBool(col);
				bool whiteBit = getWhiteBool(col);
				if ((!whiteBit)&&(maskBit))
					onlyWhite = false;
			}
	}


	for (int x = 0; x < xsize; ++x)
	{
			bool lastMaskBit = false;
			bool lastWhiteBit = false;

			bool atleastOneChange = false;
			for (int y = 0; y < ysize; ++y)
			{
				int col = sprite.picture[(x+minX)+(y+minY)*sprite.pictureWidth];

				bool maskBit = getMaskBool(col);
				if (maskBit != lastMaskBit)
				{
					atleastOneChange = true;
					int topush = y; // Paint below into eor buffer
					if (lastHasMoveRight)
					{
						topush |= rightMoveBit;
						lastHasMoveRight = false;
					}
					sprite.imageData.push_back(topush);
					lastMaskBit = maskBit;
				}

				bool whiteBit = getWhiteBool(col);
				if (!onlyWhite)
				if (whiteBit != lastWhiteBit)
				{
					hasWhite = true;
					// its the white points on the black mask
					atleastOneChange = true;
					unsigned int EOR_WHITE_ADDER = 8 + 32; // also in asm
					int topush = y + EOR_WHITE_ADDER;
					if (lastHasMoveRight)
					{
						topush |= rightMoveBit;
						lastHasMoveRight = false;
					}
					sprite.imageData.push_back(topush);
					lastWhiteBit = whiteBit;
				}
//				if ((!whiteBit)&&(maskBit))
//					onlyWhite = false;
			}
			lastHasMoveRight = true;
			if (!atleastOneChange)
			{
				sprite.imageData.push_back(clearLineMarker);
			}
	}
	sprite.imageData.push_back(endMarker);
	sprite.onlyWhite = onlyWhite;
	//Log("sprite:%s flags:%s xsize:%d ysize:%d dataBytes:%d\n",desc.fileName.c_str(),(sprite.onlyWhite ? "onlyWhite" : "blackwhite"), xsize,ysize,sprite.imageData.size());
}

#define VSPRITE_MAX 48
void exportVectorSprites()
{
	FILE *out = fopen((spritesOutputDirPrefix+"vsprites.inc").c_str(),"wb");
	fprintf(out,"VSPRITE_ADR\n");
	for (int i = 0; i < vsprites.size(); ++i)
	{
		fprintf(out,"\tdc.b <VSPRITE%d\n",i);
		fprintf(out,"\tdc.b >VSPRITE%d\n",i);
	}
	fprintf(out,"VSPRITECOUNT = %d\n",vsprites.size());
	for (int i = 0; i < vsprites.size(); ++i)
	{
		VectorSprite sprite = vsprites[i];
		if (sprite.imageData.size() + 7 > 255)
		{
			while(1);
		}
		fprintf(out,";----------------------------------\n");
		fprintf(out,"VSPRITE%d ; <%s>\n",i,sprite.name.c_str());
		int combinedxaddyaddflags = 0;
		combinedxaddyaddflags |= sprite.pixxadd & 7;
		combinedxaddyaddflags |= (sprite.pixyadd & 15)<<3;
		combinedxaddyaddflags |= (sprite.onlyWhite ? 1 : 0)<<7;


		//fprintf(out,"\tdc.b %d\t,%d \t;xdisplayadd, ydisplayadd\n", sprite.pixxadd,sprite.pixyadd);
		fprintf(out,"\tdc.b %d ;xdisplayadd, ydisplayadd,flags\n",combinedxaddyaddflags);
		fprintf(out,"\tdc.b %d\t,%d \t;xsize, ysize\n", sprite.xsize,sprite.ysize);
		//int flags = sprite.onlyWhite ? 1 : 0;
		//fprintf(out,"\tdc.b %d ; flags\n",flags);
		fprintf(out,"\tdc.b %d ; windowxsize (realxsize)\n",sprite.realxsize);
		fprintf(out,"\tdc.b %d",sprite.imageData[0]);
		for (int j = 1; j < sprite.imageData.size(); ++j)
		{
			if ((j & 15) == 15)
				fprintf(out,"\n\tdc.b %d",sprite.imageData[j]);
			else
				fprintf(out,",%d",sprite.imageData[j]);
		}
		fprintf(out,"\t;<%d>\n",sprite.imageData.size());
	}
	fprintf(out,";----------------------------------\n");
	fclose(out);
}

void exportNormalSprites()
{
	FILE *out = fopen((spritesOutputDirPrefix+"sprites.inc").c_str(),"wb");
	fprintf(out,"SPRITES_ADR\n");
	for (int i = 0; i < vsprites.size(); ++i)
	{
		fprintf(out,"\tdc.b <SPRITE%d\n",i);
		fprintf(out,"\tdc.b >SPRITE%d\n",i);
	}
	fprintf(out,"SPRITESCOUNT = %d\n",vsprites.size());
	for (int i = 0; i < vsprites.size(); ++i)
	{
		VectorSprite sprite = vsprites[i];
		if (sprite.imageData.size() + 7 > 255)
		{
			while(1);
		}
		fprintf(out,";----------------------------------\n");
		fprintf(out,"SPRITE%d ; <%s>\n",i,sprite.name.c_str());
		int xsize = ((sprite.xsize+3)/4);
		if (xsize > 7)
			xsize = 7;
		if (xsize <= 0)
			xsize = 1;
		int ysize = sprite.ysize;
		if (ysize > 31)
			ysize = 32;
		if (ysize <= 0)
			ysize = 1;
		int xadd = sprite.pixxadd;
		if (xadd > 7)
			xadd = 7;
		if (xadd <= 0)
			xadd = 0;
		int yadd = sprite.pixyadd;
		if (yadd > 31)
			yadd = 31;
		if (yadd <= 0)
			yadd = 0;
		int xsizeDelta = xsize * 4 - sprite.xsize;
		int flipadd = sprite.realxsize-(sprite.xsize+sprite.pixxadd)+3-xsizeDelta; // dunno

		fprintf(out,"\tdc.b %d ; ysize31<%d>,xsize7<%d>\n",(ysize & 31)+(xsize<<5),ysize,xsize);
		fprintf(out,"\tdc.b %d ; yadd31<%d>,xadd7<%d>\n",xadd+(yadd<<3),yadd,xadd);
		fprintf(out,"\tdc.b %d ; flipadd\n",flipadd,flipadd);
		fprintf(out,"\tdc.b ");
		for (int x2 = 0; x2 < xsize; ++x2)
		for (int y2 = 0; y2 < ysize; ++y2)
		{
			unsigned char writechar = 0;
			for (int x = 0; x < 4; ++x)
			{
				int pixel = 0;
				if ((x2 * 4 + x < sprite.xsize) && (y2 < sprite.pictureHeight))
				{
					int color = sprite.picture[(x2 * 4 + x+xadd) + (y2 +yadd)* sprite.pictureWidth];
					bool mask = getMaskBool(color);
					bool white = getWhiteBool(color);
					bool grey = getGreyBool(color);
					if (!mask)
						pixel = 0;
					else
					if (white)
						pixel = 3;
					else
					if (grey)
						pixel = 2;
					else
						pixel = 1;
				}
				writechar |= pixel << (6 - x * 2);
			}
			fprintf(out,"%d",writechar);
			if ((x2 == (xsize-1)) && (y2 == (ysize-1)))
				fprintf(out,";<%d>\n",xsize*ysize);
			else
				fprintf(out,",");
		}
	}
	fprintf(out,";----------------------------------\n");
	fclose(out);
}

void registerVectorSprites(std::vector<SpriteDesc> sprites)
{
	for (int i = 0; i < sprites.size(); ++i)
	{
		addVectorSprite(sprites[i]);
	}
}


void convertVectorSprites()
{
	for (int i = 0; i < vsprites.size(); ++i)
	{
		convertVectorSprite(vsprites[i]);
	}
}

void reprocessVectorSpriteImages()
{
	// die 0 wird nicht gemacht, da ist irgendein komischer bug
	for (int i = 0; i < vsprites.size(); ++i)
	{
		reprocessImage(vsprites[i]);
	}
}

void saveVectorSprites()
{
	for(int i = 0; i < vsprites.size(); ++i)
	{
		char buffer[256];
		sprintf(buffer, (checkingDirPrefix + "vsprite%04d.png").c_str(),i);
		pictureWidth	= vsprites[i].pictureWidth;
		pictureHeight	= vsprites[i].pictureHeight;
		for (int j = 0; j < pictureWidth * pictureHeight; ++j)
		{
			int c = vsprites[i].picture[j];
			pictureWriteOut[j] = c;		
		}
		savePNG(buffer);
	}
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
  //if (ri == 0) ri = 0x2D;
	return ri;
}

int getBlack0(unsigned int col)
{
	if ((col & 15) == 0)
		col = 0;
	return col;
}

int GetFotoColor(unsigned int col)
{
	int searchcol = ((col>>16) & 255)+(col & (255<<8))+((col & 255)<<16);
	int c = getColor(searchcol);
	return getBlack0(c);
}

void ConvertPNG(const char *name, const char *binName)
{
	LoadPNG(name);
	//memset(pictureS,0,pictureWidth*pictureHeight*sizeof(int));
	int dr = 0;
	int dg = 0;
	int db = 0;
	for (int i = 0; i < pictureWidth * pictureHeight; ++i)
	{
		int col = pictureS[i];
		int r = col & 255;
		int g = (col>>8) & 255;
		int b = (col>>16) & 255;
		int col2 = getColor(r|(g<<8)|(b<<16));
		pictureS[i] = getBlack0(col2 & 127);
	}

	int backColor = backgroundColor;
	int frontColor = foregroundColor;

	int farbCount[0x100];

	FILE *bitmap = fopen(binName,"wb");
	FILE *lumram = fopen("lumi.bin","wb");
	FILE *colram = fopen("coli.bin","wb");

	int sizy = 25;
	int startY = (25-sizy)/2*0+0;
	int endY = startY + sizy;

	for (int y = startY; y < endY; ++y)
	for (int x = 0; x < pictureWidth / 4; ++x)
	{
		for (int i = 0; i < 0x100; ++i)
			farbCount[i] = 0;
		for (int y2 = 0; y2 < 8; ++y2)
		for (int x2 = 0; x2 < 4; ++x2)
		{
			int col = pictureS[x*4+x2+(y*8+y2)*pictureWidth];
			farbCount[col]++;
		}

		// die zwei meisten farben
		int mostcolor0 = -1;
		int mostcolor1 = -1;
		for (int i = 0; i < 0x100; ++i)
		{
			if (i != backColor && i != frontColor)
				if ((farbCount[i] != 0)&&(mostcolor0==-1||(farbCount[mostcolor0]<farbCount[i])))
					mostcolor0 = i;
		}
		for (int i = 0; i < 0x100; ++i)
		{
			if (i != backColor && i != frontColor && i != mostcolor0)
				if ((farbCount[i] != 0)&&(mostcolor1==-1||(farbCount[mostcolor1]<farbCount[i])))
					mostcolor1 = i;
		}

		unsigned char cs[4];
		cs[0] = backColor;
		cs[1] = mostcolor0;
		cs[2] = mostcolor1;
		cs[3] = frontColor;
		for (int y2 = 0; y2 < 8; ++y2)
		{
			unsigned char byt = 0;
			for (int x2 = 0; x2 < 4; ++x2)
			{
				int col = pictureS[x*4+x2+(y*8+y2)*pictureWidth];
				int bt = nearestColor(col,cs);
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

	FILE *out = fopen("constants.inc","w");
	fprintf(out, "frontColor equ %d\n",frontColor);
	fprintf(out, "backColor  equ %d\n",backColor);
	fclose(out);
}

#define LEVELSIZEX 40
#define LEVELSIZEY 64 // 4k

int playerStartX,playerStartY;

#define LAYERCOUNT 16
unsigned char layerOn[LAYERCOUNT];
unsigned char layers[LAYERCOUNT*LEVELSIZEX*LEVELSIZEY];

struct STATE
{
	unsigned char levelFont[0x800];
	unsigned char levelFontCol1[0x100];
	unsigned char levelFontCol2[0x100];
	unsigned char levelFontFlags[0x100];
	unsigned char level4Map[LEVELSIZEX*LEVELSIZEY];
	unsigned char tileMap[16*256]; // 4k
	unsigned char enemyNr[LEVELSIZEX*4*LEVELSIZEY*4];
	unsigned char enemySpecial[LEVELSIZEX*4*LEVELSIZEY*4];
};

STATE curState;
STATE checkState;

unsigned char selectedChar = 0;
unsigned char selectedTile = 0;
unsigned char paintColor = 0;
unsigned char vidMemColor1 = 0;
unsigned char vidMemColor2 = 0;

int levelScrollPosX;
int levelScrollPosY;

#define FONTXPOS 161
#define FONTYPOS 1

#define FLAGSXPOS 161
#define FLAGSYPOS 150
#define FLAGSXSCALE 10
#define FLAGSYSCALE 18

#define LEVELXPOS 0
#define LEVELYPOS 0

#define TILESXPOS 1
#define TILESYPOS 201

#define CHARXPOS (242)
#define CHARYPOS 1
#define CHARXSCALE 16
#define CHARYSCALE 16

#define CHARCOLORSXPOS 242
#define CHARCOLORSYPOS 130
#define CHARCOLORSXSCALE 16
#define CHARCOLORSYSCALE 18

#define TILEXPOS 97
#define TILEYPOS 248
#define TILEXSCALE 4
#define TILEYSCALE 4

#define PALETTEXPOS 161
#define PALETTEYPOS 170
#define PALETTEXSCALE 8
#define PALETTEYSCALE 8

#define MAPXPOS 164
#define MAPYPOS 240
#define MAPXSCALE 70
#define MAPYSCALE (140*3/4)

unsigned char tileToCopy = 0;
unsigned char charToCopy = 0;

int curUndoPoint = 0;
#define MAXUNDOPOINTS 128
STATE undoPoints[MAXUNDOPOINTS];

unsigned char gradient[256];

int backgroundColor2(int y,int x,int color1, int color2)
{
	y /= 1;
	x /= 1;
	int color = color1;
	if ((y+x) & 1)
		color = color2;

	return color;
}

void undo()
{
	curUndoPoint--;
	if (curUndoPoint<0)
		curUndoPoint += MAXUNDOPOINTS;
	curState = undoPoints[curUndoPoint];
}

void redo()
{
	curUndoPoint++;
	curUndoPoint %= MAXUNDOPOINTS;
	curState = undoPoints[curUndoPoint];
}

void saveState()
{
	checkState = curState;
}

void newUndoPoint()
{
	curUndoPoint++;
	curUndoPoint %= MAXUNDOPOINTS;
	undoPoints[curUndoPoint] = curState;
}

void checkStateUpdateAndMakeUndoPointIfRequired()
{
	if (memcmp(&checkState,&curState,sizeof(STATE)) != 0)
	{
		newUndoPoint();
	}
}

void copyTile(unsigned char sourceTile, unsigned char destTile)
{
	memcpy(&curState.tileMap[destTile*16],&curState.tileMap[sourceTile*16],16);
}

void swapTile(unsigned char sourceTile, unsigned char destTile)
{
	unsigned char temp[16];
	memcpy(&temp[0],&curState.tileMap[sourceTile*16],16);
	memcpy(&curState.tileMap[sourceTile*16],&curState.tileMap[destTile*16],16);
	memcpy(&curState.tileMap[destTile*16],&temp[0],16);
	for (int i = 0; i < LEVELSIZEX*LEVELSIZEY; ++i)
	{
		if (curState.level4Map[i] == sourceTile)
		{
			curState.level4Map[i] = destTile;
		}
		else
		if (curState.level4Map[i] == destTile)
		{
			curState.level4Map[i] = sourceTile;
		}
		for (int j = 0; j < LAYERCOUNT; ++j)
		{
			if (layers[j*LEVELSIZEX*LEVELSIZEY+i] == sourceTile)
			{
				layers[j*LEVELSIZEX*LEVELSIZEY+i] = destTile;
			}
			else
			if (layers[j*LEVELSIZEX*LEVELSIZEY+i] == destTile)
			{
				layers[j*LEVELSIZEX*LEVELSIZEY+i] = sourceTile;
			}
		}
	}
}

void swap(unsigned char *t1, unsigned char *t2)
{
	unsigned char t = *t1;
	*t1 = *t2;
	*t2 = t;
}

void copyChar(unsigned char sourceChar, unsigned char destChar)
{
	memcpy(&curState.levelFont[destChar*8],&curState.levelFont[sourceChar*8],8);
	curState.levelFontCol1[destChar]		= curState.levelFontCol1[sourceChar];
	curState.levelFontCol2[destChar]		= curState.levelFontCol2[sourceChar];
	curState.levelFontFlags[destChar]	= curState.levelFontFlags[sourceChar];
}

void swapChar(unsigned char sourceChar, unsigned char destChar)
{
	unsigned char temp[8];
	memcpy(&temp[0],&curState.levelFont[sourceChar*8],8);
	memcpy(&curState.levelFont[sourceChar*8],&curState.levelFont[destChar*8],8);
	memcpy(&curState.levelFont[destChar*8],&temp[0],8);
	swap(&curState.levelFontCol1[destChar],&curState.levelFontCol1[sourceChar]);
	swap(&curState.levelFontCol2[destChar],&curState.levelFontCol2[sourceChar]);
	swap(&curState.levelFontFlags[destChar],&curState.levelFontFlags[sourceChar]);
	for (int i = 0; i < 16 * 256; ++i)
	{
		if (curState.tileMap[i] == sourceChar)
			curState.tileMap[i] = destChar;
		else
		if (curState.tileMap[i] == destChar)
			curState.tileMap[i] = sourceChar;
	}
}

void flipCharX(unsigned char charToFlip)
{
	unsigned char temp[8];
	for (int y = 0; y < 8; y++)
	{
		int c = 0;
		for (int x = 0; x < 4; ++x)
		{
			int pix = (curState.levelFont[charToFlip*8+y] >> (6-x*2)) & 3;
			c |= pix << (x*2);
		}
		curState.levelFont[charToFlip*8+y] = c;
	}
}

void flipCharY(unsigned char charToFlip)
{
	unsigned char temp[8];
	for (int y = 0; y < 4; y++)
	{
		int t = curState.levelFont[charToFlip*8+y];
		curState.levelFont[charToFlip*8+y] = curState.levelFont[charToFlip*8+7-y];
		curState.levelFont[charToFlip*8+7-y] = t;
	}
}

int mapxy(int x, int y)
{
	return x * LEVELSIZEY + y;
}

int enemyxy(int x, int y)
{
	return x * (LEVELSIZEY * 4) + y;
}

int tilexy(int x, int y)
{
	return x * 4 + y;
}

void drawLevel()
{
	for (int y = 0; y < 25; ++y)
	for (int x = 0; x < 40; ++x)
	{
		int c = curState.level4Map[mapxy((((x+levelScrollPosX)/4) % LEVELSIZEX),(((y+levelScrollPosY)/4) % LEVELSIZEY))];
		int d = curState.tileMap[tilexy(((x+levelScrollPosX) & 3),((y+levelScrollPosY) & 3))+c*16]; 
		bool isTransparent = false;
		if (activeOverlay > 0)
		{
			isTransparent = true;
			int layerElement = layers[LEVELSIZEX*LEVELSIZEY*(activeOverlay-1) + (mapxy((((x+levelScrollPosX)/4) % LEVELSIZEX),(((y+levelScrollPosY)/4) % LEVELSIZEY)))];
			if (layerElement != 0)
			{
				isTransparent = false;
				d = curState.tileMap[tilexy(((x+levelScrollPosX) & 3),((y+levelScrollPosY) & 3))+layerElement*16]; 
			}
		}

		for (int y2 = 0; y2 < 8; ++y2)
		{
			int backgroundColorGradient = gradient[((y*8 + y2)/4+levelScrollPosY/2) & 255];
			for (int x2 = 0; x2 < 4; ++x2)
			{
				int e = (curState.levelFont[d*8+y2]>>(6-x2*2)) & 3;
				int f = 0;
				switch(e)
				{
				case 0: f = backgroundColorGradient; break;
				case 1: f = curState.levelFontCol1[d]; break;
				case 2: f = curState.levelFontCol2[d]; break;
				case 3: f = foregroundColor; break;
				}
				screenBuffer[x*4+x2+(y*8+y2)*RXRES+LEVELXPOS+LEVELYPOS*RXRES] = f;
				if (isTransparent)
				{
					if ((x2 + y2) & 1)
						screenBuffer[x*4+x2+(y*8+y2)*RXRES+LEVELXPOS+LEVELYPOS*RXRES] = 0;
				}
			}
		}
	}
}

void drawFont()
{
	for (int y = 0; y < 16; ++y)
	for (int x = 0; x < 16; ++x)
	{
		int d = x+y*16; 
		for (int y2 = 0; y2 < 8; ++y2)
		{
			for (int x2 = 0; x2 < 4; ++x2)
			{
				int e = (curState.levelFont[d*8+y2]>>(6-x2*2)) & 3;
				int f = 0;
				switch(e)
				{
				case 0: f = backgroundColor2(y2+y*8,x2+x*4,curState.levelFontCol1[d],curState.levelFontCol2[d]); break;
				case 1: f = curState.levelFontCol1[d]; break;
				case 2: f = curState.levelFontCol2[d]; break;
				case 3: f = foregroundColor; break;
				}
				screenBuffer[x*5+x2+(y*9+y2)*RXRES+FONTXPOS+FONTYPOS*RXRES] = f;
			}
			if (d == selectedChar)
			{
				screenBuffer[x*5+4+(y*9+y2)*RXRES+FONTXPOS+FONTYPOS*RXRES] = 0x71;
				screenBuffer[x*5-1+(y*9+y2)*RXRES+FONTXPOS+FONTYPOS*RXRES] = 0x71;
			}
		}
	}
}

void drawTiles()
{
	for (int y = 0; y < 10; ++y)
	for (int x = 0; x < 16; ++x)
	{
		int c = x + y * 16;
		for (int y2 = 0; y2 < 10; ++y2)
		{
			for (int x2 = 0; x2 < 10/2; ++x2)
			{
				int xp2 = x2 * 4 * 4 / (10/2);
				int yp2 = y2 * 8 * 4 / (10);
				int d = curState.tileMap[c * 16 + tilexy(((xp2/4) & 3),((yp2/8) & 3))];
			
				int px = xp2 & 3;
				int py = yp2 & 7;

				int e = (curState.levelFont[d*8+py]>>(6-px*2)) & 3;
				int f = 0;
				switch(e)
				{
				case 0: f = backgroundColor2(y2+y*10,x2+x*10/2,curState.levelFontCol1[d],curState.levelFontCol2[d]); break;
				case 1: f = curState.levelFontCol1[d]; break;
				case 2: f = curState.levelFontCol2[d]; break;
				case 3: f = foregroundColor; break;
				}
				screenBuffer[x*6+x2+(y*11+y2)*RXRES+TILESXPOS+TILESYPOS*RXRES] = f;
			}
			if (c == selectedTile)
			{
				screenBuffer[x*6+5+(y*11+y2)*RXRES+TILESXPOS+TILESYPOS*RXRES] = 0x71;
				screenBuffer[x*6-1+(y*11+y2)*RXRES+TILESXPOS+TILESYPOS*RXRES] = 0x71;
			}
		}
	}
}

void drawChar()
{
	for (int y = 0; y < 8*CHARXSCALE; ++y)
	for (int x = 0; x < 4*CHARYSCALE; ++x)
	{
		int d = selectedChar;
		int e = (curState.levelFont[d*8+y/CHARYSCALE]>>(6-x/CHARXSCALE*2)) & 3;
		int f = 0;
		switch(e)
		{
			case 0: f = backgroundColor2(y,x,curState.levelFontCol1[d],curState.levelFontCol2[d]); break;
			case 1: f = curState.levelFontCol1[d]; break;
			case 2: f = curState.levelFontCol2[d]; break;
			case 3: f = foregroundColor; break;
		}
		screenBuffer[x+y*RXRES+CHARXPOS+CHARYPOS*RXRES] = f;
	}
}

void drawCharColors()
{
	for (int i = 0; i < 4; ++i)
	{
		int d = selectedChar;

		int f = 0;
		switch(i)
		{
		case 0: f = backgroundColor2(0,0,curState.levelFontCol1[d],curState.levelFontCol2[d]); break;
		case 1: f = curState.levelFontCol1[d]; break;
		case 2: f = curState.levelFontCol2[d]; break;
		case 3: f = foregroundColor; break;
		}

		for (int y = 0; y < CHARCOLORSYSCALE; ++y)
		for (int x = 0; x < CHARCOLORSXSCALE; ++x)
		{
			screenBuffer[x + i * (CHARCOLORSXSCALE + 1) + y*RXRES + CHARCOLORSXPOS + CHARCOLORSYPOS*RXRES] = f; 
		}
	}
}


void drawTile()
{
	for (int y = 0; y < 4 * 8 * TILEYSCALE; ++y)
	for (int x = 0; x < 4 * 4 * TILEXSCALE; ++x)
	{
		int px = x / TILEXSCALE;
		int py = y / TILEYSCALE;

		int tx = px / 4;
		int ty = py / 8;

		int d = curState.tileMap[tilexy(tx,ty)+selectedTile*16];

		int x2 = px & 3;
		int y2 = py & 7;

		int e = (curState.levelFont[d*8+y2]>>(6-x2*2)) & 3;

		int f = 0;
		switch(e)
		{
			case 0: f = backgroundColor2(y,x,curState.levelFontCol1[d],curState.levelFontCol2[d]); break;
			case 1: f = curState.levelFontCol1[d]; break;
			case 2: f = curState.levelFontCol2[d]; break;
			case 3: f = foregroundColor; break;
		}
		screenBuffer[x+y*RXRES+TILEXPOS+TILEYPOS*RXRES] = f;
	}
}

void drawPalette()
{
	for (int i = 0; i < 128; ++i)
	{
		int xp = i & 15;
		int yp = i / 16;
		
		xp *= PALETTEXSCALE;
		yp *= PALETTEYSCALE;
		
		for (int y = 0; y < PALETTEYSCALE; ++y)
		for (int x = 0; x < PALETTEXSCALE; ++x)
		{
			screenBuffer[(xp+x+PALETTEXPOS) + (yp+y+PALETTEYPOS)*RXRES] = i;
		}

		if ((i == paintColor))
		{
			for (int y = 0; y < PALETTEYSCALE; ++y)
			for (int x = 0; x < PALETTEXSCALE; ++x)
			{
				if ((x == 0))
					screenBuffer[(xp+x+PALETTEXPOS)+(yp+y+PALETTEYPOS)*RXRES] = 0x71;
			}
		}

		if ((i == foregroundColor) || (i == backgroundColor) || (i == vidMemColor1) || (i == vidMemColor2) || (i == paintColor) || (i == spriteColor1))
		{
			screenBuffer[(xp+PALETTEXPOS+PALETTEXSCALE/2)+(yp+PALETTEYPOS+PALETTEYSCALE/2)*RXRES] = 0x71;
			screenBuffer[(xp+PALETTEXPOS+PALETTEXSCALE/2)+(yp+PALETTEYPOS+PALETTEYSCALE/2+1)*RXRES] = 0x00;
		}
	}
}

#define GRADIENTXSCALE 8
#define GRADIENTYSCALE 8
#define GRADIENTXPOS 312
#define GRADIENTYPOS 0

void setPixel(int x, int y,int c)
{
	if ((x>=0)&&(x<RXRES)&&(y>=0)&&(y<RYRES))
		screenBuffer[x+y*RXRES] = c;
}

void drawGradient()
{
	for (int i = 0; i < 256; ++i)
	{
		int xp = 0;
		int yp = i * GRADIENTYSCALE;
		for (int y = 0; y < GRADIENTYSCALE; ++y)
		for (int x = 0; x < GRADIENTXSCALE; ++x)
		{
			setPixel((xp+x+GRADIENTXPOS),(yp+y+GRADIENTYPOS),gradient[i+levelScrollPosY/2]);
			if (i == levelScrollPosY/4)
			{
				setPixel(xp+GRADIENTXPOS-1,yp+y+GRADIENTYPOS,0x71);
			}
		}
	}
}

void drawMap()
{
	for (int y = 0; y < MAPYSCALE; ++y)
	for (int x = 0; x < MAPXSCALE; ++x)
	{
		int rx = x * LEVELSIZEX / MAPXSCALE;
		int ry = y * LEVELSIZEY / MAPYSCALE;
		int a = (curState.level4Map[mapxy(rx,ry)] & 63) + 0x03;
		if (activeOverlay > 0)
		{
			a = layers[LEVELSIZEX*LEVELSIZEY*(activeOverlay-1)+mapxy(rx,ry)];
			if (a != 0)
				a = (a & 63)+0x03;
		}

		screenBuffer[x+y*RXRES+MAPXPOS+MAPYPOS*RXRES] = a;
		if ( ((rx == levelScrollPosX/4)||(rx == (levelScrollPosX+40)/4)) && 
			 ((ry == levelScrollPosY/4)||(ry == (levelScrollPosY+25)/4))
			 )
		{
			screenBuffer[x+y*RXRES+MAPXPOS+MAPYPOS*RXRES] = 0x71;
		}
	}
}

void drawFlags()
{
	for (int i = 0; i < 8; ++i)
	{
		for (int y = 0; y < FLAGSYSCALE; ++y)
		for (int x = 0; x < FLAGSXSCALE; ++x)
		{
			int f = curState.levelFontFlags[selectedChar];
			int c = 0x00;
			if (f & (1<<i))
				c = 0x71;
			screenBuffer[x + i * (FLAGSXSCALE + 1) + y*RXRES + FLAGSXPOS + FLAGSYPOS*RXRES] = c; 
		}
	}
}

void drawLevelEnemyAtXY(int nr,int xp, int yp)
{
	int image = enemySpriteImage[nr];

	const VectorSprite &sprite = vsprites[image]; 

	yp -= sprite.pictureHeight - 8;

	for (int y = 0; y < sprite.pictureHeight; ++y)
	for (int x = 0; x < sprite.pictureWidth; ++x)
	{
		int c = sprite.picture[x + y * sprite.pictureWidth];
		int r = (c >> 0) & 255;
		int g = (c >> 8) & 255;
		int b = (c >> 16) & 255;

		if (!((r == 255) && (g == 0) && (b == 0)))
		{
			int nx = x + xp;
			int ny = y + yp;
			if ((nx >= 0) && (nx < 160) && (ny >= 0) && (ny < 25 * 8))
			{
				screenBuffer[nx+ny*RXRES] = getColor(c);
			}
		}
	}

}

unsigned char font[256*8];

void drawLevelEnemySpecialAtXY(int nr,int xp, int yp)
{
	int nullpos = 8*16;
	for (int y = 0; y < 8; ++y)
	{
		int c = font[nr*8 + y + nullpos];
		for (int x = 0; x < 8; ++x)
		{
			if ((c >> (7-x)) & 1)
			{
				int nx = x + xp;
				int ny = y + yp;
				if ((nx >= 0) && (nx < 160) && (ny >= 0) && (ny < 25 * 8))
				{
					screenBuffer[nx+ny*RXRES] = 0x01;
				}
			}
		}
	}
}

void drawEnemies()
{
	for (int y = 0; y < 25; ++y)
	for (int x = 0; x < 40; ++x)
	{
		int c = curState.enemyNr[enemyxy((((x+levelScrollPosX)) % (LEVELSIZEX*4)),(((y+levelScrollPosY)) % (LEVELSIZEY*4)))];
		int s = curState.enemySpecial[enemyxy((((x+levelScrollPosX)) % (LEVELSIZEX*4)),(((y+levelScrollPosY)) % (LEVELSIZEY*4)))];
		for (int y2 = 0; y2 < 8; ++y2)
		{
			for (int x2 = 0; x2 < 4; ++x2)
			{
				if (c != 0)
					screenBuffer[x*4+x2+(y*8+y2)*RXRES+LEVELXPOS+LEVELYPOS*RXRES] = 0x52;
			}
		}
		if (c > 0)
			drawLevelEnemyAtXY(c-1,x * 4, y * 8);
		if (s > 0)
		{
			//char *textRemap = " !\"#$\%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_äabcdefghijklmnopqrstuvwxyzö|üÖÄ";
			if (s >= 10)
				s += 7;
			drawLevelEnemySpecialAtXY(s,x * 4, y * 8);
		}
	}
}

//-------------------------------------------------------------------------------------------------------------------------------
void clipScrollPos()
{
	if (levelScrollPosX < 0) levelScrollPosX = 0;
	if (levelScrollPosY < 0) levelScrollPosY = 0;
	if (levelScrollPosX >= LEVELSIZEX*4-40) levelScrollPosX = LEVELSIZEX*4-40;
	if (levelScrollPosY >= LEVELSIZEY*4-25) levelScrollPosY = LEVELSIZEY*4-25;
}

void handlePalette()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= PALETTEXPOS; 
	posY -= PALETTEYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= PALETTEXSCALE;
	posY /= PALETTEYSCALE;

	if ((posX >= 0) && (posX < 16) && (posY >= 0) && (posY < 16))
	{
		int color = posX + posY * 16;

		if (mouseButtonL || mouseButtonR)
		{
			paintColor = color;
		}
	}
}

void handleGradient()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= GRADIENTXPOS; 
	posY -= GRADIENTYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= GRADIENTXSCALE;
	posY /= GRADIENTYSCALE;

	if ((posX >= 0) && (posX < 1) && (posY >= 0) && (posY < 256))
	{
		if (mouseButtonL)
		{
			gradient[posY+levelScrollPosY/2] = paintColor;
		}

		if (mouseButtonR)
			paintColor = gradient[posY+levelScrollPosY/2];
	}
}

void handleCharColors()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= CHARCOLORSXPOS; 
	posY -= CHARCOLORSYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= (CHARCOLORSXSCALE + 1);
	posY /= CHARCOLORSYSCALE;

	if ((posX >= 0) && (posX < 4) && (posY >= 0) && (posY < 1))
	{
		if (mouseButtonL)
		{
			switch(posX)
			{
				case 1: curState.levelFontCol1[selectedChar] = paintColor; break;			
				case 2: curState.levelFontCol2[selectedChar] = paintColor; break;			
			}
		}
		if (mouseButtonR)
		{
			switch(posX)
			{
				case 0: paintColor = backgroundColor; break; 
				case 1: paintColor = curState.levelFontCol1[selectedChar]; break;			
				case 2: paintColor = curState.levelFontCol2[selectedChar]; break;			
				case 3: paintColor = foregroundColor; break; 
			}
		}
	}
}

void handleChar()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= CHARXPOS; 
	posY -= CHARYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= CHARXSCALE;
	posY /= CHARYSCALE;

	if ((posX >= 0) && (posX < 4) && (posY >= 0) && (posY < 8))
	{
		if (mouseButtonL)
		{
			unsigned char cols[4] = {backgroundColor,curState.levelFontCol1[selectedChar],curState.levelFontCol2[selectedChar],foregroundColor};
			int bt = nearestColor(paintColor,cols);
			curState.levelFont[selectedChar * 8 + posY] &= ~(3<<(6-posX*2));
			curState.levelFont[selectedChar * 8 + posY] |= bt<<(6-posX*2);
		}
		if (mouseButtonR)
		{
			int bt = (curState.levelFont[selectedChar * 8 + posY] >> (6-posX*2)) & 3;
			unsigned char cols[4] = {backgroundColor,curState.levelFontCol1[selectedChar],curState.levelFontCol2[selectedChar],foregroundColor};
			paintColor = cols[bt];
		}
	}
}

void handleFont()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= FONTXPOS; 
	posY -= FONTYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= 5;
	posY /= 9;

	if ((posX >= 0) && (posX < 16) && (posY >= 0) && (posY < 16))
	{
		if (mouseButtonL || mouseButtonR)
		{
			selectedChar = posX + posY * 16;
		}

		if (GetAsyncKeyState('C')&0x8000)
		{
			charToCopy = selectedChar;
			while (GetAsyncKeyState('C')&0x8000);
		}

		if (GetAsyncKeyState('V')&0x8000)
		{
			copyChar(charToCopy,selectedChar);
			while (GetAsyncKeyState('V')&0x8000);
		}

		if (GetAsyncKeyState('N')&0x8000)
		{
			charToCopy = selectedChar;
			while (GetAsyncKeyState('N')&0x8000);
		}

		if (GetAsyncKeyState('M')&0x8000)
		{
			swapChar(charToCopy,selectedChar);
			while (GetAsyncKeyState('M')&0x8000);
		}

		if (GetAsyncKeyState('X')&0x8000)
		{
			flipCharX(selectedChar);
			while(GetAsyncKeyState('X')&0x8000);
		}


		if (GetAsyncKeyState('Y')&0x8000)
		{
			flipCharY(selectedChar);
			while(GetAsyncKeyState('Y')&0x8000);
		}


	}
}

void handleTile()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= TILEXPOS; 
	posY -= TILEYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= TILEXSCALE * 4;
	posY /= TILEYSCALE * 8;

	if ((posX >= 0) && (posX < 4) && (posY >= 0) && (posY < 4))
	{
		if (mouseButtonR)
		{
			selectedChar = curState.tileMap[selectedTile * 16 + tilexy(posX,posY)];
		}
		if (mouseButtonL)
		{
			curState.tileMap[selectedTile * 16 + tilexy(posX,posY)] = selectedChar;
		}
	}
}

void handleTiles()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= TILESXPOS; 
	posY -= TILESYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= 6;
	posY /= 11;

	if ((posX >= 0) && (posX < 16) && (posY >= 0) && (posY < 10))
	{
		int tile = posX + posY * 16;
		
		if (mouseButtonL || mouseButtonR)
		{
			selectedTile = tile;
		}

		if (GetAsyncKeyState('C')&0x8000)
		{
			tileToCopy = selectedTile;
			while (GetAsyncKeyState('C')&0x8000);
		}

		if (GetAsyncKeyState('V')&0x8000)
		{
			copyTile(tileToCopy,selectedTile);
			while (GetAsyncKeyState('V')&0x8000);
		}

		if (GetAsyncKeyState('N')&0x8000)
		{
			tileToCopy = selectedTile;
			while (GetAsyncKeyState('N')&0x8000);
		}

		if (GetAsyncKeyState('M')&0x8000)
		{
			swapTile(tileToCopy,selectedTile);
			while (GetAsyncKeyState('M')&0x8000);
		}
	}
}

void handleLevel()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= LEVELXPOS; 
	posY -= LEVELYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= 4;
	posY /= 8;

	if ((posX >= 0) && (posX < 40) && (posY >= 0) && (posY < 25))
	{
		int adrX = posX + levelScrollPosX;
		int adrY = posY + levelScrollPosY;
		int tx = adrX & 3;
		int ty = adrY & 3;
		adrX /= 4;
		adrY /= 4;

		if (mouseButtonL)
		{
			if (activeOverlay == 0)
			{
				int tile;
				for (int i = 0; i < 8; ++i)
				{
					tile = selectedTile + ((randTab[(randTab[adrX & 255]+randTab[adrY & 255]*2) & 255]+i) % (tileRandom+1));
					if (
						(curState.level4Map[mapxy(adrX+1,adrY)] != tile) && 
						(curState.level4Map[mapxy(adrX-1,adrY)] != tile) && 
						(curState.level4Map[mapxy(adrX,adrY+1)] != tile) && 
						(curState.level4Map[mapxy(adrX,adrY-1)] != tile))
						break;
				}
				curState.level4Map[mapxy(adrX,adrY)] = tile;
			}
			else
			{
				layers[LEVELSIZEX*LEVELSIZEY*(activeOverlay-1)+mapxy(adrX,adrY)] = selectedTile;
			}
		}

		if (mouseButtonR)
		{
			if (activeOverlay == 0)
				selectedTile = curState.level4Map[mapxy(adrX,adrY)];
			else
				selectedTile = layers[LEVELSIZEX*LEVELSIZEY*(activeOverlay-1)+mapxy(adrX,adrY)];

			selectedChar = curState.tileMap[selectedTile * 16 + tilexy(tx,ty)];
		}
	}
}

void handleEnemyNr(int nr)
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= LEVELXPOS; 
	posY -= LEVELYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= 4;
	posY /= 8;
	if ((posX >= 0) && (posX < 40) && (posY >= 0) && (posY < 25))
	{
		int adrX = posX + levelScrollPosX;
		int adrY = posY + levelScrollPosY;
		curState.enemyNr[enemyxy(adrX,adrY)] = nr;
		curState.enemySpecial[enemyxy(adrX,adrY)] = 0;
	}
}

void handleEnemyPlusMinus(int plusMinus)
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= LEVELXPOS; 
	posY -= LEVELYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= 4;
	posY /= 8;
	if ((posX >= 0) && (posX < 40) && (posY >= 0) && (posY < 25))
	{
		int adrX = posX + levelScrollPosX;
		int adrY = posY + levelScrollPosY;

		if (curState.enemyNr[enemyxy(adrX,adrY)] != 0)
		{
			int a = curState.enemySpecial[enemyxy(adrX,adrY)];
			a += plusMinus;
			if (a < 0)
				a = 0;
			curState.enemySpecial[enemyxy(adrX,adrY)]= a;
		}
	}
}

void handleMap()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= MAPXPOS; 
	posY -= MAPYPOS;
	if (posX < 0 || posY < 0)
		return;

	if ((posX >= 0) && (posX < MAPXSCALE) && (posY >= 0) && (posY < MAPYSCALE))
	{
		if (mouseButtonL)
		{
			int lx = posX * LEVELSIZEX * 4 / MAPXSCALE;
			int ly = posY * LEVELSIZEY * 4 / MAPYSCALE;
			levelScrollPosX = lx;
			levelScrollPosY = ly;
			clipScrollPos();
		}
	}
}

void handleFlags()
{
	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	posX -= FLAGSXPOS; 
	posY -= FLAGSYPOS;
	if (posX < 0 || posY < 0)
		return;
	posX /= (FLAGSXSCALE + 1);
	posY /= FLAGSYSCALE;

	if ((posX >= 0) && (posX < 8) && (posY >= 0) && (posY < 1))
	{
		if (mouseButtonL)
		{
			curState.levelFontFlags[selectedChar] |= 1 << posX;
		}
		if (mouseButtonR)
		{
			curState.levelFontFlags[selectedChar] &= ~(1 << posX);
		}
	}
}

void writeByteArray(FILE *out, const char *name, unsigned char *bytes, int count)
{
	fprintf(out,"%s\n",name);
	if (count > 0)
	{
		for (int i = 0; i < count; ++i)
		{
			if ((i & 15)==0)
				fprintf(out,"\n\tdc.b %d",bytes[i]);
			else
				fprintf(out,",%d",bytes[i]);
		}
		fprintf(out,"\n");
	}
}

void loadGradient()
{
	FILE *in;
	in = fopen((tilesOutputDirPrefix+"gradient.bin").c_str(),"rb");
	fread(gradient,1,0xa8,in);
	fclose(in);
}

void saveGradient()
{
	if (gWorld == 5)
	{
		for (int i = 0; i < 0xa8; ++i)
		{
			gradient[i] = gradient[i & 31];
		}
	}

	FILE *out;
	out = fopen((tilesOutputDirPrefix+"gradient.bin").c_str(),"wb");
	fwrite(gradient,1,0xa8,out);
	fclose(out);
}

void saveSpriteTables()
{
	FILE *out;
	for (int i = 0; i < 3; ++i)
	{
		char buffer[1000];
		sprintf(buffer,(spritesOutputDirPrefix + "rortable1_%i.bin").c_str(),i);
		out = fopen(buffer,"wb");
		for (int j = 0; j < 256; ++j)
		{
			unsigned char c = j << ((i+1) * 2);
			fwrite(&c,1,1,out);
		}
		fclose(out);

		sprintf(buffer,(spritesOutputDirPrefix + "rortable2_%i.bin").c_str(),i);
		out = fopen(buffer,"wb");
		for (int j = 0; j < 256; ++j)
		{
			unsigned char c = j >> ((3-(i)) * 2);
			fwrite(&c,1,1,out);
		}
		fclose(out);
	}

	out = fopen((spritesOutputDirPrefix + "automasking.bin").c_str(),"wb");
	for(int i = 0; i < 256; ++i)
	{
		unsigned char mask = 0;
		for (int j = 0; j < 4; ++j)
		{
			int k = (i >> (j * 2)) & 3;
			if (k == 0)
				mask |= 3 << (j * 2);
			else
				mask |= k << (j * 2);
		}
		fwrite(&mask,1,1,out);
	}
	fclose(out);

	out = fopen((spritesOutputDirPrefix + "specialwhite.bin").c_str(),"wb");
	for(int i = 0; i < 256; ++i)
	{
		unsigned char mask = 0;
		for (int j = 0; j < 4; ++j)
		{
			int k = (i >> (j * 2)) & 3;
			if (k != 0)
				mask |= 3 << (j * 2);
		}
		fwrite(&mask,1,1,out);
	}
	fclose(out);

	out = fopen((spritesOutputDirPrefix + "specialxflip.bin").c_str(),"wb");
	for(int i = 0; i < 256; ++i)
	{
		unsigned char mask = 0;
		for (int j = 0; j < 4; ++j)
		{
			int k = (i >> ((3-j) * 2)) & 3;
			mask |= k << (j * 2);
		}
		fwrite(&mask,1,1,out);
	}
	fclose(out);

	out = fopen((spritesOutputDirPrefix + "specialxflipwhite.bin").c_str(),"wb");
	for(int i = 0; i < 256; ++i)
	{
		unsigned char mask = 0;
		for (int j = 0; j < 4; ++j)
		{
			int k = (i >> ((3-j) * 2)) & 3;
			if (k != 0)
				mask |= 3 << (j * 2);
		}
		fwrite(&mask,1,1,out);
	}
	fclose(out);
}

void exportLayers()
{
	FILE *out;
	out = fopen((levelOutputDirPrefix+"layers.inc").c_str(),"w");
	fprintf(out,"LAYERCOUNT = %d\n",LAYERCOUNT);
	for (int i = 0; i < LAYERCOUNT; ++i)
	{
		fprintf(out,"LAYER%d\n",i);
		fprintf(out,"\tdc.b %d; is layer currently on?\n",layerOn[i]);
		int itemPosX = 0xff;
		int itemPosY = 0xff;
		for(int y = 0; y < LEVELSIZEY; ++y)
		{
			for(int x = 0; x < LEVELSIZEX; ++x)
			{
				int element = layers[i*LEVELSIZEX*LEVELSIZEY+mapxy(x,y)];
				if (element > 0)
				{
					fprintf(out,"\tdc.b %d,%d ; X AND Y\n",x,y);
					fprintf(out,"\tdc.b %d,%d ; BEFORE AND LAYER\n",curState.level4Map[mapxy(x,y)],element);
				}
				// item
				if (element < 158 && element > (158-4)) // four items reserved
				{
					itemPosX = x;
					itemPosY = y;
				}
			}
		}
		fprintf(out,"\tdc.b $ff ; endLayer\n");
		if ((itemPosX != 0xff) && (itemPosY != 0xff))
		{
			fprintf(out,"\tdc.b $fe ; itemattached\n"); // attention this could lead to trouble
			fprintf(out,"\tdc.b %d,%d ; itemPosX, itemPosY\n",itemPosX*4+1,itemPosY*4+1);
		}
	}
}

int globalEnemyCount = 0; 
int globalEnemyXSpanCount = 0;

void saveLevel()
{
	FILE *out;
	
	out = fopen((tilesWorkingDirPrefix + "levelFont.bin").c_str(),"wb");
	fwrite(curState.levelFont,1,0x800,out);
	fclose(out);
	out = fopen((tilesOutputDirPrefix + "levelFont.bin").c_str(),"wb");
	fwrite(curState.levelFont,1,0x800,out);
	fclose(out);

	out = fopen((tilesWorkingDirPrefix + "levelFontColor1.bin").c_str(),"wb");
	fwrite(curState.levelFontCol1,1,0x100,out);
	fclose(out);

	out = fopen((tilesWorkingDirPrefix + "levelFontColor2.bin").c_str(),"wb");
	fwrite(curState.levelFontCol2,1,0x100,out);
	fclose(out);

	unsigned char colorRam[256];
	unsigned char lumaRam[256];

	for (int i = 0; i < 256; ++i)
	{
		int a = curState.levelFontCol1[i];
		int b = curState.levelFontCol2[i];
		int lum = ((a & 0xf0)>>4) | ((b & 0xf0));
		int col = ((a & 0x0f)<<4) | ((b & 0x0f));
		colorRam[i] = col;
		bool fullytransparent = i == 0;
		lumaRam[i] = lum | (fullytransparent ? 0x80 : 0);
	}

	out = fopen((tilesWorkingDirPrefix + "levelFontColor.bin").c_str(),"wb");
	fwrite(colorRam,1,0x100,out);
	fclose(out);
	out = fopen((tilesOutputDirPrefix + "levelFontColor.bin").c_str(),"wb");
	fwrite(colorRam,1,0x100,out);
	fclose(out);

	out = fopen((tilesWorkingDirPrefix + "levelFontLuma.bin").c_str(),"wb");
	fwrite(lumaRam,1,0x100,out);
	fclose(out);
	out = fopen((tilesOutputDirPrefix + "levelFontLuma.bin").c_str(),"wb");
	fwrite(lumaRam,1,0x100,out);
	fclose(out);

	out = fopen((tilesWorkingDirPrefix + "levelFontFlags.bin").c_str(),"wb");
	fwrite(curState.levelFontFlags,1,0x100,out);
	fclose(out);
	out = fopen((tilesOutputDirPrefix + "levelFontFlags.bin").c_str(),"wb");
	fwrite(curState.levelFontFlags,1,0x100,out);
	fclose(out);

	out = fopen((levelWorkingDirPrefix + "level4Map.bin").c_str(),"wb");
	fwrite(curState.level4Map,1,LEVELSIZEX*LEVELSIZEY,out);
	fclose(out);
	out = fopen((levelOutputDirPrefix + "level4Map.bin").c_str(),"wb");
	fwrite(curState.level4Map,1,LEVELSIZEX*LEVELSIZEY,out);
	fclose(out);

	out = fopen((tilesWorkingDirPrefix + "tileMap.bin").c_str(),"wb");
	fwrite(curState.tileMap,1,16*10*16,out);
	fclose(out);
	out = fopen((tilesOutputDirPrefix + "tileMap.bin").c_str(),"wb");
	fwrite(curState.tileMap,1,16*10*16,out);
	fclose(out);

	out = fopen((levelWorkingDirPrefix+"enemies.bin").c_str(),"wb");
	fwrite(curState.enemyNr,1,LEVELSIZEX*4*LEVELSIZEY*4,out);
	fclose(out);

	out = fopen((levelWorkingDirPrefix+"enemySpecial.bin").c_str(),"wb");
	fwrite(curState.enemySpecial,1,LEVELSIZEX*4*LEVELSIZEY*4,out);
	fclose(out);

	out = fopen((levelWorkingDirPrefix+"layers.bin").c_str(),"wb");
	fwrite(layers,1,LAYERCOUNT*LEVELSIZEX*LEVELSIZEY,out);
	fclose(out);

	//unsigned char xpositions[256];
	unsigned char xcounts[256];
	unsigned char xlookupstart[256];
	unsigned char elookupstart[256];
	unsigned char yenemynr[256];
	unsigned char ypos[256];
	unsigned char flags[256];

	//memset(xpositions,0,sizeof(xpositions));
	memset(xcounts,0,sizeof(xcounts));
	memset(xlookupstart,0,sizeof(xlookupstart));
	memset(elookupstart,0,sizeof(elookupstart));

	int curxcount = 0;
	int lookupstart = 0;
	for (int x = 0; x < LEVELSIZEX*4; ++x)
	{
		int countHere = 0;
		std::vector<std::pair<int,int>> collected;
		for (int y = 0; y < LEVELSIZEY*4; ++y)
		{
			int enemyType = curState.enemyNr[enemyxy(x,y)];
			int enemySpecial = curState.enemySpecial[enemyxy(x,y)];
			if (enemyType > 0 && enemyType != 0xff)
			{
				countHere++;
				collected.push_back(std::pair<int,int>(enemyTypeForKey[enemyType-1]+enemySpecial,y));
			}
		}
		if (countHere != 0)
		{
			//xpositions[curxcount]=x;
			xlookupstart[x]=curxcount + 1;
			xcounts[curxcount]=countHere;
			elookupstart[curxcount]=lookupstart;
			for (int i = 0; i < collected.size(); ++i)
			{
				yenemynr[lookupstart]=collected[i].first;
				ypos[lookupstart]=collected[i].second;
				flags[lookupstart]=0;
				lookupstart++;
				if (lookupstart>255) // too many enemies
					lookupstart=255;
			}
			curxcount++;
		}
	}
	out = fopen((levelOutputDirPrefix + "enemies.inc").c_str(),"w");
	globalEnemyCount = lookupstart;
	globalEnemyXSpanCount = curxcount;
	//fprintf(out,"ENEMYCOUNT = %d\n",lookupstart);
	//fprintf(out,"ENEMYXSPANCOUNT = %d\n",curxcount);
	writeByteArray(out,"ENEMYX_XARRAYINDEX",xlookupstart,256);
	writeByteArray(out,"ENEMYX_EARRAYINDEX",elookupstart,curxcount);
	writeByteArray(out,"ENEMYX_COUNT",xcounts,curxcount);
	writeByteArray(out,"ENEMYY_ENEMYTYPE",yenemynr,lookupstart);
	writeByteArray(out,"ENEMYY_YPOSITION",ypos,lookupstart);
	fclose(out);

	out = fopen((levelOutputDirPrefix+"constants.inc").c_str(),"wb");
	fprintf(out,"LEVELSIZEX = %d\n",LEVELSIZEX);
	fprintf(out,"LEVELSIZEY = %d\n",LEVELSIZEY);
	//fprintf(out,"FOREGROUNDCOLOR = %d\n",foregroundColor);
	//fprintf(out,"BACKGROUNDCOLOR = %d\n",backgroundColor);
	fclose(out);

	saveGradient();
	saveSpriteTables();
}

void loadLevel()
{
	FILE *in;

	in = fopen((tilesWorkingDirPrefix + "levelFont.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.levelFont,1,0x800,in);
		fclose(in);
	}

	in = fopen((tilesWorkingDirPrefix+"levelFontColor1.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.levelFontCol1,1,0x100,in);
		fclose(in);
	}

	in = fopen((tilesWorkingDirPrefix+"levelFontColor2.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.levelFontCol2,1,0x100,in);
		fclose(in);
	}

	in = fopen((tilesWorkingDirPrefix+"levelFontFlags.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.levelFontFlags,1,0x100,in);
		fclose(in);
	}

	in = fopen((levelWorkingDirPrefix+"level4Map.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.level4Map,1,LEVELSIZEX*LEVELSIZEY,in);
		fclose(in);
	}
	else
		memset(curState.level4Map,0,LEVELSIZEX*LEVELSIZEY);


	in = fopen((tilesWorkingDirPrefix+"tileMap.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.tileMap,1,16*10*16,in);
		fclose(in);
	}
	else
		memset(curState.tileMap,0,16*10*16);

	in = fopen((levelWorkingDirPrefix+"enemies.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.enemyNr,1,LEVELSIZEX*4*LEVELSIZEY*4,in);
		fclose(in);
	}
	else
		memset(curState.enemyNr,0,LEVELSIZEX*4*LEVELSIZEY*4);

	in = fopen((levelWorkingDirPrefix+"enemySpecial.bin").c_str(),"rb");
	if (in)
	{
		fread(curState.enemySpecial,1,LEVELSIZEX*4*LEVELSIZEY*4,in);
		fclose(in);
	}
	else
		memset(curState.enemySpecial,0,LEVELSIZEX*4*LEVELSIZEY*4);

	in = fopen((levelWorkingDirPrefix+"layers.bin").c_str(),"rb");
	if (in)
	{
		fread(layers,1,LAYERCOUNT*LEVELSIZEX*LEVELSIZEY,in);
		fclose(in);
	}
	else
		memset(layers,0,LAYERCOUNT*LEVELSIZEX*LEVELSIZEY);

	loadGradient();
}

//rotate/flip a quadrant appropriately
void rot(int n, int *x, int *y, int rx, int ry) {
    if (ry == 0) {
        if (rx == 1) {
            *x = n-1 - *x;
            *y = n-1 - *y;
        }
 
        //Swap x and y
        int t  = *x;
        *x = *y;
        *y = t;
    }
}

//convert (x,y) to d
int xy2d (int n, int x, int y) {
    int rx, ry, s, d=0;
    for (s=n/2; s>0; s/=2) {
        rx = (x & s) > 0;
        ry = (y & s) > 0;
        d += s * s * ((3 * rx) ^ ry);
        rot(s, &x, &y, rx, ry);
    }
    return d;
}
 
//convert d to (x,y)
void d2xy(int n, int d, int *x, int *y) {
    int rx, ry, s, t=d;
    *x = *y = 0;
    for (s=1; s<n; s*=2) {
        rx = 1 & (t/2);
        ry = 1 & (t ^ rx);
        rot(s, x, y, rx, ry);
        *x += s * rx;
        *y += s * ry;
        t /= 4;
    }
}

void exportTables()
{
	FILE *out;
	char sinPlus[32];
	for (int i = 0; i < 32; ++i)
	{
		float riHere = (float)i / 32;
		float riLast = (float)(i-1) / 32;
		float sinHere = sin(riHere * 2.f * 3.14159f)*16.f;
		float sinLast = sin(riLast * 2.f * 3.14159f)*16.f;
		float delta = sinHere - sinLast;
		sinPlus[i] = (int)delta;
	}
	out = fopen((globalOutputDirPrefix+"sinplus.bin").c_str(),"wb");
	fwrite(sinPlus,1,32,out);
	fclose(out);

	for (int i = 0; i < 32; ++i)
	{
		float riHere = (float)i / 32;
		float riLast = (float)(i-1) / 32;
		float sinHere = sin(fmod(riHere*1.f,1.f) * 3.14159f)*16.f;
		float sinLast = sin(fmod(riLast*1.f,1.f) * 3.14159f)*16.f;
		float delta = sinHere - sinLast;
		sinPlus[i] = (int)delta;
	}
	out = fopen((globalOutputDirPrefix+"sinplus2.bin").c_str(),"wb");
	fwrite(sinPlus,1,32,out);
	fclose(out);

	unsigned char fadextable[256];
	unsigned char fadeytable[256];
	int fadeTablePos = 0;
	int fadeTableX = 0;
	int fadeTableY = 0;

#define	TABSIZE 120

	int k = 0;
	for (int i = 0; i < 256; ++i)
	{
		int x = 0;
		int y = 0;
		d2xy(16, i, &x, &y);
		x = x * 10 / 16;
		y = y * 12 / 16;
		bool found = false;
		for (int j = 0; j < i; ++j)
		{
			if ((fadextable[j] == x) && (fadeytable[j]==y))
				found = true;
		}
		if (!found)
		{
			fadextable[k]=x;
			fadeytable[k]=y;
			k++;
		}
	}


/*
	int startx = 0;
	int endx = 10;
	int starty = 0;
	int endy = 13;

	for (int j = 0; j < 6; ++j)
	{
		for (int i = starty; i < endy; ++i)
		{
			fadextable[fadeTablePos] = fadeTableX;
			fadeytable[fadeTablePos] = fadeTableY;
			fadeTablePos++;
			fadeTableY++;
		}
		for (int i = startx; i < endx; ++i)
		{
			fadextable[fadeTablePos] = fadeTableX;
			fadeytable[fadeTablePos] = fadeTableY;
			fadeTablePos++;
			fadeTableX++;
		}
		for (int i = starty; i < endy; ++i)
		{
			fadextable[fadeTablePos] = fadeTableX;
			fadeytable[fadeTablePos] = fadeTableY;
			fadeTablePos++;
			fadeTableY--;
		}
		for (int i = startx; i < endx; ++i)
		{
			fadextable[fadeTablePos] = fadeTableX;
			fadeytable[fadeTablePos] = fadeTableY;
			fadeTablePos++;
			fadeTableX--;
		}
		endx--;
		endy--;
		startx++;
		starty++;
		fadeTableX++;
		fadeTableY++;
	}
*/
/*
#define	TABSIZE 156
	for (int i = 0; i < 256; ++i)
	{
		int a = rand() % TABSIZE;
		if (a < TABSIZE - 20)
		{
		int b = (a + rand() % 256) % TABSIZE;
		int c = fadextable[a];
		fadextable[a]=fadextable[b];
		fadextable[b] = c;
		int d = fadeytable[a];
		fadeytable[a]=fadeytable[b];
		fadeytable[b] = d;
		}
	}
*/

	out = fopen((globalOutputDirPrefix+"fadextable.bin").c_str(),"wb");
	fwrite(fadextable,TABSIZE,1,out);
	fclose(out);
	out = fopen((globalOutputDirPrefix+"fadeytable.bin").c_str(),"wb");
	fwrite(fadeytable,TABSIZE,1,out);
	fclose(out);

	const int DOTCOUNT = 0x10;
	unsigned char rand160table[DOTCOUNT];
	unsigned char rand200table[DOTCOUNT];

	for (int i = 0; i < DOTCOUNT; ++i)
	{
		rand160table[i] = (rand() % (160-16))+8;
		rand200table[i] = (rand() % (200-32))+16;
	}

	unsigned char rand160table2[DOTCOUNT];
	unsigned char rand200table2[DOTCOUNT];

	for (int i = 0; i < DOTCOUNT/2; ++i)
	{
		rand160table2[i] = (rand() % (160-16))+8;
		rand160table2[i+DOTCOUNT/2] = rand160table2[i]+1;
		rand200table2[i] = (rand() % (200-32))+16;
		rand200table2[i+DOTCOUNT/2] = rand200table2[i];
	}

	out = fopen((globalOutputDirPrefix+"rand160table.bin").c_str(),"wb");
	fwrite(rand160table,DOTCOUNT,1,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix+"rand160table2.bin").c_str(),"wb");
	fwrite(rand160table2,DOTCOUNT,1,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix+"rand160table3.bin").c_str(),"wb");
	fwrite(rand160table2,4,1,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix+"rand200table.bin").c_str(),"wb");
	fwrite(rand200table,DOTCOUNT,1,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix+"rand200table2.bin").c_str(),"wb");
	fwrite(rand200table2,DOTCOUNT,1,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix+"rand200table3.bin").c_str(),"wb");
	fwrite(rand200table2,4,1,out);
	fclose(out);

	srand(1337+12);
	for (int i = 0; i < DOTCOUNT; ++i)
	{
		rand160table[i] = (rand() % (160-16))+8;
		rand200table[i] = (rand() % (200-32))+16;
	}
	out = fopen((globalOutputDirPrefix+"rand160tablelinear.bin").c_str(),"wb");
	fwrite(rand160table,DOTCOUNT,1,out);
	fclose(out);
	out = fopen((globalOutputDirPrefix+"rand200tablelinear.bin").c_str(),"wb");
	fwrite(rand200table,DOTCOUNT,1,out);
	fclose(out);
}

void exportTextScreensForLevel();

void save()
{
	saveLevel();
	exportTables();

	convertVectorSprites();
	exportVectorSprites();
	exportNormalSprites();
	reprocessVectorSpriteImages();
	saveVectorSprites();

	playerStartX = 0;
	playerStartY = 0;

	for (int y = 0; y < LEVELSIZEY * 4; ++y)
	for (int x = 0; x < LEVELSIZEX * 4; ++x)
	{
		if (curState.enemyNr[enemyxy(x,y)] == 1) // kate
		{
			playerStartX = x;
			playerStartY = y;
		}
	}

	FILE *out = fopen((tilesOutputDirPrefix + "worldsetup.inc").c_str(),"w");
	fprintf(out,	"SPRITES			dc.w SPRITES_ADR\n");
	fprintf(out,	"FOREGROUNDCOLOR	dc.b %d\n",foregroundColor);
	fprintf(out,	"BACKGROUNDCOLOR	dc.b %d\n",backgroundColor);
	fprintf(out,	"PLAYERSTARTPOSX	dc.w %d\n",playerStartX*4);
	int ylon = playerStartY*8-(getEnemy("KATE").yend-8);
	fprintf(out,	"PLAYERSTARTPOSY	dc.w %d\n",ylon);
	fprintf(out,	"ENEMYCOUNT			dc.b %d\n",globalEnemyCount);
	fprintf(out,	"ENEMYXSPANCOUNT	dc.b %d\n",globalEnemyXSpanCount);

	fprintf(out,	"ENEMYX_XARRAYINDEX_ADR	dc.w ENEMYX_XARRAYINDEX\n");
	fprintf(out,	"ENEMYX_EARRAYINDEX_ADR	dc.w ENEMYX_EARRAYINDEX\n");
	fprintf(out,	"ENEMYX_COUNT_ADR		dc.w ENEMYX_COUNT\n");
	fprintf(out,	"ENEMYY_ENEMYTYPE_ADR	dc.w ENEMYY_ENEMYTYPE\n");
	fprintf(out,	"ENEMYY_YPOSITION_ADR	dc.w ENEMYY_YPOSITION\n");
	
	fclose(out);
	
	exportTextScreensForLevel();
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
  return ri;
}

unsigned char charsetX[256*8];
unsigned char screenX[40*26];
unsigned char colX[40*26];
int charCountX = 0;

void convertScreenMask(int charAdd)
{
	LoadPNG((globalWorkingDirPrefix+"rahmen.png").c_str());

#define LOGOX 40
#define LOGOY 25
	unsigned char LOGO_COLOR1 = 0x02;
	unsigned char LOGO_COLOR2 = 0x58;
	unsigned char backgroundColor = 0;
	
	FILE *out = fopen((globalOutputDirPrefix + "screensSetup.inc").c_str(),"w");
	fprintf(out, "SCREENS_BACKGROUNDCOLOR = %d\n",backgroundColor);
	fprintf(out, "SCREENS_COLOR1 = %d\n",LOGO_COLOR1);
	fprintf(out, "SCREENS_COLOR2 = %d\n",LOGO_COLOR2);
	fprintf(out, "SCREENS_COLOR3 = %d\n",0x71 + 0x08);
	fclose(out);

	int current = 0;
	int CONVPICXSIZE = LOGOX;
	int CONVPICYSIZE = LOGOY;

	for (int i = 8; i < 256 * 8; ++i) charsetX[i] = 0;
	for (int i = 0; i < CONVPICXSIZE*CONVPICYSIZE; ++i) screenX[i] = current;

	int comp[8];

	for (int y = 0; y < CONVPICYSIZE; ++y)
	for (int x = 0; x < CONVPICXSIZE; ++x)
	{
		unsigned int colCounts[256];
		for (int i = 0; i < 256; ++i)
			colCounts[i] = 0;

		for (int ky = 0; ky < 8; ky++)
		for (int kx = 0; kx < 8; kx++)
		{
			int rgb = pictureS[(x*8+kx)+(y*8+ky)*pictureWidth];
			colCounts[getColor(rgb)]++;
		}

		int differentColors = 0;
		for (int i = 0; i < 256; ++i)
		{
			if ((colCounts[i] != 0) && (i != backgroundColor))
				differentColors++;
		}

		bool hires = true;
		if (differentColors > 1)
			hires = false;

		int mostColor = -1;
		for (int i = 0; i < 256; ++i)
		{
			if (hires)
			{
				if ((i != backgroundColor) && (mostColor == -1 || (colCounts[i] >= colCounts[mostColor])))
					mostColor = i;
			}
			else
			{
				if ((i != backgroundColor) && (i != LOGO_COLOR1) && (i != LOGO_COLOR2) && (mostColor == -1 || (colCounts[i] >= colCounts[mostColor])))
					mostColor = i;
			}
		}

		// mostcolor
		if (differentColors == 0)
			mostColor = 0x71;

		int plus4cols[4] = {backgroundColor,LOGO_COLOR1,LOGO_COLOR2,mostColor};

		for (int i = 0; i < 8; ++i)
		{
			comp[i] = 0;
			int xadd = 2;
			if (hires) xadd = 1;
			for (int x2 = 0; x2 < 8; x2+=xadd)
			{
				int pixel = 0;
				int ypos = y*8+i;
				if ((ypos >= 0) && (ypos < pictureHeight))
				{
					int rgb = pictureS[(x*8+x2)+ypos*pictureWidth];
					int r = (rgb >> 0) & 255;
					int g = (rgb >> 8) & 255;
					int b = (rgb >> 16) & 255;
					if (getColor(rgb) != backgroundColor)
					{
						if (hires)
							pixel = 1;
						else
							pixel = nearestColor(getColor(rgb),plus4cols);
					}
				}
				pixel &= 3;
				if (hires)
					comp[i] |= pixel << (7-x2);
				else
					comp[i] |= pixel << (6-x2);
			}
		}

		int screenPos = x + y * CONVPICXSIZE;

		colX[screenPos] = mostColor;
		if (!hires)
			colX[screenPos] |= 0x08;


		int found = -1;
		for (int k = 0; k < current; ++k)
		{
			int c = k;
			
			bool mfound = true;
			for (int i = 0; i < 8; ++i)
			{
				int cst = charsetX[c*8+i];
				int st = comp[i];
				if (cst != st)
					mfound = false;
			}
			
			if (mfound && (found == -1))
			{
				found = c;
				break;
			}
		}

		if (found != -1)
			screenX[screenPos] = (found + charAdd) & 255;
		else
		{
			if (current >= 256-charAdd)
				current = 255-charAdd;
			for (int i = 0; i < 8; ++i)
			{
				charsetX[current*8+i] = comp[i];
			}
			screenX[screenPos] = current + charAdd;	
			current++;
		}
	}
	charCountX = current;
	out = fopen((globalOutputDirPrefix + "screenmask.bin").c_str(),"wb");
	fwrite(colX,1,LOGOX*LOGOY,out);
	unsigned char pad[0x400-LOGOX*LOGOY];
	memset(pad,0,0x400-LOGOX*LOGOY);
	fwrite(pad,1,0x400-LOGOX*LOGOY,out);
	fwrite(screenX,1,LOGOX*LOGOY,out);
	fclose(out);
}

int fontCharCount = 32 * 3;

void convertFont()
{
	convertScreenMask(fontCharCount);

	int yc = 0;

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
			font[yc++] = c;
			fwrite(&c,1,1,out);
		}
	}
	fwrite(charsetX,charCountX*8,1,out);
	fclose(out);

	LoadPNG((globalWorkingDirPrefix+"zordan2.png").c_str());
	out = fopen((globalOutputDirPrefix + "zordan.bin").c_str(),"wb");
	for (int y2 = 0; y2 < 4; ++y2)
	{
		for (int x2 = 0; x2 < 4; ++x2)
		{
			for (int y = 0; y < 8; ++y)
			{
				unsigned char c = 0;
				for (int x = 0; x < 4; ++x)
				{
					int pixel = 0;
					int color = pictureS[(x+x2*4)+(y+y2*8)*pictureWidth];
		
					bool mask = getMaskBool(color);
					bool white = getWhiteBool(color);
					bool grey = getGreyBool(color);
					if (!mask)
						pixel = 0;
					else
					if (white)
						pixel = 3;
					else
					if (grey)
						pixel = 2;
					else
						pixel = 1;

					c |= (pixel & 3)<<(6-x*2);
				}
				fwrite(&c,1,1,out);
			}
		}
	}
	fclose(out);
}

#define LIFELOST\
	"Oh no! One life lost!         ",\
	"You have § lives remaining.   ",\
	"Prepare yourself, take a deep ",\
	"breath and try again!         "

#define	GAMEOVER\
	"Katy, you didn't succeed in    ",\
	"completing the mission.        ",\
	"Try again, and good luck!      "

#define HEALING\
	"Let me heal you, Katy! And now ",\
	"continue with your mission.    "

#define THREEBULLETS\
	"Here are 3 magic bullets for   ",\
	"you. Use them with care, Katy! "

#define TASKSOLVED\
	"Yes Katy, you already solved  ",\
	"the task. Yet, there is more  ",\
	"to do.                        "

#define ZORDAN 0x40

char *textScreensWorld1[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"Kate was in her old abode       ",
	"reminiscing about all the days  ",
	"in Zador. She looked around     ",
	"and prepared herself for a      ",
	"long and mysterious journey.    ",
	"                                ",
	"*** The adventure begins.       ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Well done, Katy! Let's see     ",
	"if you can solve the ancient   ",
	"mysteries of the next quest    ",
	"in the hidden castle!          ",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // STONE 1 STARTING
	(char *)0x01, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x88, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Look Katy, there's a diamond  ",
	"missing that I need for       ",
	"building a path to the old    ",
	"caves!                        ",
	NULL,
	// screen 08 // STONE 1 FINISHED
	(char *)0x81, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x02+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Yes, that's it! Let me see... ",
	"That should be the way.       ",
	"Well done. You can continue   ",
	"your quest in the caves below.",
	NULL,
	// screen 09 // STONE 3
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x09, // nextscreen (on Goal or 0x80)
	(char *)0x04+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"If you think it can't be done,",
	"there are always ways to make ",
	"it work. Let's move the stone!",
	NULL,
	// screen 10 // STONE 4
	(char *)0x06, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x8b, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Katy, I am looking for the    ",
	"old crystal, which opens the  ",
	"gate to the underworld here.  ",
	"Please bring it to me, so I   ",
	"can help you move further!    ", 
	NULL,
	// screen 11 // STONE 4
	(char *)0x86, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x05+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Yes, this is the crystal!     ",
	"Now the path is free. See you ",
	"later in this quest.          ",
	NULL,
	// screen 12 // TELLING ABOUT BUTTONS
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x0c, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Hey Katy, did you know that   ",
	"there is a button somewhere   ",
	"near you? Try it out.         ",
	NULL,
	// screen 13 // TELLING ABOUT BUTTONS
	(char *)0x87, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Easy! Well done. You know     ",
	"how to use buttons properly.  ",
	"Go ahead to the Hidden Castle!",
	NULL,
	NULL
};

char *textScreensWorld2[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"Kate looks around! Yes, this  ",
	"is already the castle she     ",
	"heard about. No one has       ",
	"visited it for centuries. Katy", 
	"feels the wind and takes a    ",
	"deep breath. She prepares for ",
	"                              ",
	"*** The Hidden Castle ***     ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Well done, Katy! There is a   ",
	"miraculous skyland hidden     ",
	"in Zador's clouds. Prepare    ",
	"to arrive at the top!         ",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // STONE 1 STARTING
	(char *)0x82, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x88, // nextscreen (on Goal or 0x80)
	(char *)0x02+ZORDAN, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"I will teleport you to the    ",
	"chamber of the ancient kings. ",
	"Please bring me the           ",
	"Cloud Queen's old stone to    ",
	"continue your quest.          ",
	NULL,
	// screen 08 // STONE 1 FINISHED
	(char *)0x81, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x02+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Thanks! Yes, that is the      ",
	"stone. Look, the hidden       ",
	"purpose of the stone is to    ",
	"restore the passage to the    ",
	"upper area. Let's start the   ",
	"process!                      ",
	NULL,
	// screen 09 // STONE 2
	(char *)0x0d, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x09, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Katy, my dear! Do you mind    ",
	"taking these 3 extra lives?   ",
	"Let me give you this present  ",
	"to continue your quest!       ",
	NULL,
	NULL
};

char *textScreensWorld3[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"Welcome to the skies of Zador.",
	"Enjoy your stay and take      ",
	"a deep breath.                ",
	"                              ",
	"*** Zador's Skylands ***      ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Well done, Katy! Now we'll    ",
	"take the transportation beam  ",
	"to the next millenium. Have   ",
	"you ever visited the future?  ",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // stone for the blocking tree
	(char *)0x81, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"The tree of knowledge has now ",
	"been transformed, and a       ",
	"stepping stone has appeared in",
	"the upper area.               ",
	NULL,
	// screen 08 // house
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x08, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"Hello, Katy!                  ",
	"Long time no see! Here, take  ",
	"this cake. And greet          ",
	"Zordan if you see him again.  ",
	NULL,
	NULL,
};

char *textScreensWorld4[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"The transportation beam slowed",
	"down and Katy arrived at the  ",
	"center of a futuristic space  ",
	"station. Prepare for the next ",
	"quest in                      ",
	"                              ",
	"*** The Future ***            ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Way to go, Katy! The future is",
	"yours! Let's get on to the    ",
	"elevating starships.          ",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // STONE 1 STARTING // transport stone (first stone)
	(char *)0x01, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x07, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"The upper city transport      ",
	"station! You have found it.   ",
	"So, let's see if we can       ",
	"activate the beam.            ",
	NULL,
	// screen 08 // Unblock Level at uppercities
	(char *)0x84, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x08, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"The upper cathedral is now    ",
	"open! Keep on, Katy!          ",
	NULL,
	// screen 09 // STONE 3
	(char *)0x05, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x8a, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"This is a magic place. To move",
	"further I need the crystal at ",
	"the towers below! Bring me the",
	"crystal of the ancient        ",
	"time travellers!              ",
	NULL,
	// screen 10 // Level Exit
	(char *)0x85, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x06+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"This opens the first gate     ",
	"to the elevator!              ",
	NULL,
	// screen 11 // Level Exit
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x0b, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"There is a switch for this    ",
	"device! You need to find it!  ",
	NULL,
	// screen 12 // Shield! :)
	(char *)0x8d, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x0c, // nextscreen (on Goal or 0x80)
	(char *)0x0d, // switchlayer (0 = nothing, sbc 1)
	"Look, this shield will protect",
	"you. You are energized now!   ",
	NULL,
	NULL
};

char *textScreensWorld5[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"This is the elevator for the  ",
	"starships. Katy, just press   ",
	"each button once!             ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"OK. Easy move. You have       ",
	"completed the elevator. Let's ",
	"see if you can handle the     ",
	"                              ",
	"*** Space Laboratory ***      ",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	NULL
};

char *textScreensWorld6[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"For the first time in ages,   ",
	"someone is visiting this place",
	"in the asteroid belt of Zador!",
	"Prepare to continue in        ",
	"                              ",
	"*** The Space Laboratory ***  ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Let's move on to the seas!    ",
	"There is something hidden in  ",
	"the depths of Zador.          ",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // STONE 1 STARTING // transport stone (first stone)
	(char *)0x01, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x88, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"Did you see? The laboratory is",
	"locked. Just bring me the     ",
	"missing part of this machine, ",
	"and I will unlock the         ",
	"laboratory.                   ",
	NULL,
	// screen 08 // STONE 1 SOLVED
	(char *)0x81, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x02+ZORDAN, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"Yes, that is the missing part!",
	"Move on to the laboratory.    ",
	NULL,
	// screen 09 // STONE 2 
	(char *)0x83, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"Stratasphere Keychain         ",
	"                              ",
	"Your credentials              ",
	"User: Katy                    ",
	"Password: KXCVBN32A           ",
	"                              ",
	"Door unlocked                 ",
	NULL,
	// screen 10 // STONE 3 
	(char *)0x84, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"User: Katy                    ",
	"Password: KXCVBN32A           ",
	"                              ",
	"unlock confirmed!             ",
	NULL,
	// screen 11 // STONE 4 
	(char *)0x85, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1 on Goal or 0x80) (switch of again)
	"Stones removed!               ",
	NULL,
	NULL
};

char *textScreensWorld7[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"Let's swim! Did you know that ",
	"this place has never been     ",
	"visited by the people of      ",
	"Zador? So take a deep breath  ",
	"and let's start diving into   ",
	"                              ",
	"*** The Seas of Fortune ***   ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Level completed!",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // stone1 way blocker
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x07, // nextscreen (on Goal or 0x80)
	(char *)0x01, // switchlayer (0 = nothing, sbc 1)
	"You are worthy, Katy!         ",
	"This is the ancient temple. No",
	"one ever reached it - except  ",
	"you!                          ",
	NULL,
	// screen 08 // stone2 search for transformation stone
	(char *)0x02, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x89, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Do you know that there is a   ",
	"hidden stone at the temple?   ",
	"Just bring it to me!          ",
	NULL,
	// screen 09 // stone2 found transformation stone unblock level at lava
	(char *)0x03, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"The sea barrier has been      ",
	"removed. Move on, Katy!       ",
	NULL,
	// screen 10 // stone3 unlock way
	(char *)0x84, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Wow, these rocks look heavy.  ",
	"Yes easy, I just removed them!",
	NULL,
	NULL
};

char *textScreensWorld8[] = {
	// screen 00
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x00, // nextscreen on goal
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"Almost done with your quest.  ",
	"Just this one left.           ",
	"Prepare to visit the lunar    ",
	"                              ",
	"*** Trithium Mines ***        ",
	NULL,
	// screen 01 // LEVEL DONE
	(char *)0x8e, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x01, // nextscreen (on goal or 0x80)
	(char *)0x0e, // switchlayer (0 = nothing, sbc 1)
	"So, what's next?",
	NULL,
	// screen 02 // LOST A LIVE
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x02, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	LIFELOST,
	NULL,
	// screen 03 // GAME OVER
	(char *)0xff, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x03, // nextscreen (on goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	GAMEOVER,
	NULL,
	// screen 04 // NEW ENERGY
	(char *)0x90, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x04, // nextscreen (on goal or 0x80)
	(char *)0x10+ZORDAN, // switchlayer on goal (0 = nothing, sbc 1)
	"",//HEALING,
	NULL,
	// screen 05 // THREE SHOTS
	(char *)0x8f, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x05, // nextscreen (on Goal or 0x80)
	(char *)0x0f+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	THREEBULLETS,
	NULL,
	// screen 06 // STONE SOLVED
	(char *)0xff, // activate layer + 1
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	TASKSOLVED,
	NULL,
	// screen 07 // stone1 spacestation blocked
	(char *)0x83, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00, // switchlayer (0 = nothing, sbc 1)
	"That must be the button for   ",
	"the door of the spacestation. ",
	"I read in the book of Andorow ",
	"about it! Yes, it is unlocked!",
	"Well done!                    ",
	NULL,
	// screen 08 // stone2 stone blockade at comets
	(char *)0x86, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x06, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Did you see the comets?       ",
	"Let's remove the stones that  ",
	"are blocking the path there!  ",
	NULL,
	// screen 09
	(char *)0x08, // activate layer (255 is none) or 0x80 means deactivate layer // not null (sbc 1)
	(char *)0x09, // nextscreen (on Goal or 0x80)
	(char *)0x00+ZORDAN, // switchlayer (0 = nothing, sbc 1)
	"Is this the end of your       ",
	"quest? Move through the portal",
	"and we will see!              ",
	NULL,
	NULL
};

#define STONECOUNT 10
void exportTextScreens(char *textScreens[],unsigned char textScreenForStone[]);

void exportTextScreensForLevel()
{
	unsigned char textScreenForStone[STONECOUNT];

	for (int i = 0; i < STONECOUNT; ++i)
		textScreenForStone[i] = 0;

	for (int i = 0; i < LAYERCOUNT; ++i)
		layerOn[i] = 1;
	layerOn[0x0d] = 0; // level done
	layerOn[0x0e] = 0; // three shots
	layerOn[0x0f] = 0; // full energy

	int level = gWorld;
	if (level == 1)
	{
		layerOn[0] = 0; // for stone 1
		layerOn[1] = 1; // levelstop for quest 1
		layerOn[2] = 0; // schalter 1 (layer 3-1)
		layerOn[3] = 1; // bridge 1
		layerOn[4] = 1; // levelstop for quest 2
		layerOn[5] = 0; // quest 2 
		layerOn[6] = 1; // levelstop for schalter
		layerOn[7] = 1; // schalter


		textScreenForStone[1] = 7; // the first stone has text 7
		textScreenForStone[2] = 5; 
		textScreenForStone[3] = 9; 
		textScreenForStone[4] = 10; 
		textScreenForStone[5] = 4; 
		textScreenForStone[6] = 12; 
		textScreenForStone[7] = 13; 
		textScreenForStone[8] = 1; 

		exportTextScreens(textScreensWorld1,textScreenForStone);
	}

	if (level == 2)
	{
		layerOn[0] = 1; // levelstop at stone1
		layerOn[1] = 0; // levelstop for quest 1 (enables teleport)
		layerOn[2] = 1; // levelstop above castle
		layerOn[3] = 1; // saulen cave levelstop
		layerOn[4] = 1; // graveyard levelstop
		layerOn[5] = 0; // way some extra lives above the castle
		layerOn[6] = 0; // levelstop upper pathway1
		layerOn[7] = 0; // levelstop upper pathway2

		layerOn[12] = 0; // three extra lives for caty

		textScreenForStone[1] = 7; // the first stone has text 7
		textScreenForStone[2] = 5; 
		textScreenForStone[3] = 4; 
		textScreenForStone[4] = 9; // the cross
		textScreenForStone[5] = 1; // level exit

		exportTextScreens(textScreensWorld2,textScreenForStone);
	}

	if (level == 3)
	{
		for (int i = 0; i < LAYERCOUNT; ++i)
			layerOn[i] = 0;

		layerOn[0] = 1; // the blocking tree

		textScreenForStone[1] = 1; // level exit
		textScreenForStone[2] = 7; // transforming tree of knowledge
		textScreenForStone[3] = 8; // telling 

		exportTextScreens(textScreensWorld3,textScreenForStone);
	}

	if (level == 4)
	{
		layerOn[0] = 0; // transportation stone
		layerOn[1] = 0; // schalter at level bottom
		layerOn[2] = 1; // way blocker at upper cities
		layerOn[3] = 1; // way blocker to the upper cathedral
		layerOn[4] = 0; // light artifact cathedral quest
		layerOn[5] = 1; // blocker cathedral quest
		layerOn[6] = 1; // exit blocker 1
		layerOn[7] = 1; // exit blocker 2

		layerOn[12] = 0; // shield

		textScreenForStone[1] = 7; // the first stone has text 7
		textScreenForStone[2] = 8; // unblock the way to the upper cathedral
		textScreenForStone[3] = 5; // three magic stones 
		textScreenForStone[4] = 9; // quest bring the light artifact
		textScreenForStone[5] = 11; // info for the two exit blockers
		textScreenForStone[6] = 1; // level exit
		textScreenForStone[7] = 12; // you found a shield
		exportTextScreens(textScreensWorld4,textScreenForStone);
	}

	if (level == 5)
	{
		for (int i = 0; i < LAYERCOUNT; ++i)
			layerOn[i] = 0;

		layerOn[0] = 1; // the first schalter for the elevator
		layerOn[1] = 0; // steps up from the hangar
		layerOn[2] = 1; // level block from the hangar
		layerOn[3] = 1; // level block from the above hangar
		layerOn[4] = 1; // level block on the tower

		textScreenForStone[1] = 1; // level exit
		textScreenForStone[2] = 5; // three bullets

		exportTextScreens(textScreensWorld5,textScreenForStone);
	}

	if (level == 6)
	{
		for (int i = 0; i < LAYERCOUNT; ++i)
			layerOn[i] = 0;

		layerOn[0] = 0; // quest1
		layerOn[1] = 1; // block space station
		layerOn[2] = 1; // block upper space station
		layerOn[3] = 1; // block entrance to spacestation (password)
		layerOn[4] = 1; // stones blocking the way
		layerOn[5] = 1; // blocking exit

		textScreenForStone[1] = 7; // the first stone has text 7 quest1 
		textScreenForStone[2] = 9; // quest2 get password
		textScreenForStone[3] = 10; // quest2 use password
		textScreenForStone[4] = 11; // open barrier
		textScreenForStone[5] = 1; // level exit
		textScreenForStone[6] = 5; // three magic bullets

		exportTextScreens(textScreensWorld6,textScreenForStone);
	}

	if (level == 7)
	{
		for (int i = 0; i < LAYERCOUNT; ++i)
			layerOn[i] = 0;

		layerOn[0] = 1; // spiritual block
		layerOn[1] = 0; // transformation stone
		layerOn[2] = 0; // way block transfomation quest
		layerOn[3] = 1; // way block 
		layerOn[4] = 0; // rocket entrance 

		textScreenForStone[1] = 7; // the first stone has text 7 quest1 
		textScreenForStone[2] = 8; // find the transformation stone 
		textScreenForStone[3] = 10; // unlock the rest of the level 
		textScreenForStone[4] = 1; // level done 

		exportTextScreens(textScreensWorld7,textScreenForStone);
	}

	if (level == 8)
	{
		for (int i = 0; i < LAYERCOUNT; ++i)
			layerOn[i] = 0;

		layerOn[0] = 1; // wayblocker1-1
		layerOn[1] = 1; // wayblocker1-2
		layerOn[2] = 1; // spacestation blocker
		layerOn[3] = 0; // missing stone
		layerOn[4] = 1; // shipstructure block
		layerOn[5] = 1; // comet block
		layerOn[6] = 1; // last blocker
		layerOn[7] = 0; // the activation of the portal

		textScreenForStone[1] = 7; // the first stone has text 7 wayunblock station 
		textScreenForStone[2] = 8; // comet block 
		textScreenForStone[3] = 9; // activate forcefield 
		textScreenForStone[4] = 1; // level done 

		exportTextScreens(textScreensWorld8,textScreenForStone);
	}

	exportLayers();
}

void exportTextScreens(char *textScreens[],unsigned char textScreenForStone[])
{
	char *textRemap = " !\"#$\%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_äabcdefghijklmnopqrstuvwxyzö|üÖÄ";

	int baseChar = 0;

	char *currentLineText = NULL;
	int currentLine = 0;
	int currentText = 0;

	FILE *out = fopen((tilesOutputDirPrefix + "textscreens.inc").c_str(),"w");
	std::vector<int> nextScreens;
	do
	{
		fprintf(out,"TEXTSCREENNR%d\n",currentText);

		unsigned char layer = (unsigned char)textScreens[currentLine];
		fprintf(out,"\tdc.b %d ; Layer (0x80 = disable)\n",layer);
		currentLine++;

		unsigned char nextScreen = (unsigned char)textScreens[currentLine];
		nextScreens.push_back(nextScreen);
		fprintf(out,"\tdc.b %d ; nextScreen\n",nextScreen);
		currentLine++;


		unsigned char switchLayerOnGoal = (unsigned char)textScreens[currentLine];
		fprintf(out,"\tdc.b %d ; switchLayerOnGoal\n",switchLayerOnGoal);
		currentLine++;

		int lineCount = currentLine;
		do
		{
			lineCount++;
		} while (textScreens[lineCount] != NULL);
		lineCount-=currentLine;
		fprintf(out,"\tdc.b %d ; LineCount\n",lineCount);

		do
		{
			currentLineText = textScreens[currentLine];
			char writeOut[30];
			for (int i = 0; i < 30; ++i)
				writeOut[i] = baseChar; // space

			int j = 0;
			while(currentLineText[j] != NULL && j < 30)
			{
				char toLookFor = currentLineText[j];
				
				if (toLookFor == '§')
				{
					writeOut[j] = 0x80;
				}
				else
				{
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
				}
				j++;
			};

			fprintf(out,"\tdc.b %d",writeOut[0]);
			for (int i = 1; i < 30; ++i)
				fprintf(out,",%d",writeOut[i]);
			fprintf(out,"; One Line\n");

			currentLine++;
		} while (textScreens[currentLine] != NULL);

		currentText++;
		currentLine++;

	} while(textScreens[currentLine] != NULL);
	fclose(out);

	out = fopen((tilesOutputDirPrefix + "textscreensheader.inc").c_str(),"w");
	fprintf(out,"\nTEXTSCREENPOINTERS\n");
	for (int i = 0; i < nextScreens.size();++i)
		fprintf(out,"\tdc.w TEXTSCREENNR%d\n",i);
	fclose(out);

#define MAXSCREENS 32

	out = fopen((tilesOutputDirPrefix + "textscreenspersistent.inc").c_str(),"w");
	fprintf(out,"\nCURRENTSCREENS\n");
	for (int i = 0; i < MAXSCREENS;++i)
		if (i < nextScreens.size())
			fprintf(out,"\tdc.b %d\n",i);
		else
			fprintf(out,"\tdc.b $00 ; empty\n");
	fclose(out);

	out = fopen((tilesOutputDirPrefix +"textscreensforstones.inc").c_str(),"w");
	fprintf(out,"TEXTSCREENSFORSTONES\n");
	for (int i = 0; i < STONECOUNT; ++i)
	{
		fprintf(out,"\tdc.b %d\n", textScreenForStone[i]);
	}
	fclose(out);
}

std::vector<SpriteDesc> vectorSprites;

void addFrames(std::vector<SpriteDesc> &vectorSprites,int count,const char *fileName,int xsize,int ysize, const char *name)
{
	FRAME frame;
	frame.firstSpriteFrame = vectorSprites.size();
	frame.spriteFrameCount = count;
	frame.name = name;
	frame.xsize = xsize;
	frame.ysize = ysize;
	frames.push_back(frame);

	for (int i = 0; i < count; ++i)
	{
		char buffer[256];
		sprintf(buffer, fileName,i+1);
		vectorSprites.push_back(SpriteDesc(spritesWorkingDirPrefix + buffer,0,0,xsize,ysize));
	}
}

void addEnemy(const char *name, const char *spriteFrameName,const char *initFunction, const char *handleFunction,int hitPoints, int specialEnemyType = -1)
{
	ENEMY enemy;
	int i;
	for (i = 0; i < frames.size(); ++i)
	{
		std::string name = frames[i].name;
		if (name == spriteFrameName)
			break;
	}
	if (i != frames.size())
	{
		FRAME frame = frames[i];
		enemy.name = name;
		enemy.firstSpriteFrame = frame.firstSpriteFrame;
		enemy.xstart = 0;
		enemy.ystart = 0;
		enemy.xend = frame.xsize;
		enemy.yend = frame.ysize;
		enemy.initFunction = initFunction;
		enemy.handleFunction = handleFunction;
		enemy.hitPoints = hitPoints;
		enemy.specialEnemyType = specialEnemyType;
	}
	enemies.push_back(enemy);
}

void exportEnemyData()
{
#define MAXENEMYCOUNT 20
	FILE *out;
	out = fopen((spritesOutputDirPrefix + "enemyData.inc").c_str(),"w");
	fprintf(out,"SPRITEFRAMECOUNT = %d\n\n",vectorSprites.size());
	for (int i = 0; i < frames.size(); ++i)
	{
		fprintf(out,"SPRITE%s = %d\n",frames[i].name.c_str(),frames[i].firstSpriteFrame);
	}
	fprintf(out,"\n");
	for (int i = 0; i < frames.size(); ++i)
	{
		fprintf(out,"SPRITE%sCOUNT = %d\n",frames[i].name.c_str(),frames[i].spriteFrameCount);
	}
	fprintf(out,"\n");
	for (int j = 0,i = 0; i < enemies.size(); ++i)
	{
		if (enemies[i].specialEnemyType != 0xff)
		{
			fprintf(out,"ENEMY_TYPE_%s = %d\n",enemies[i].name.c_str(),j);
			j++;
		}
	}
	fprintf(out,"\nenemyInitFuncs\n");
	int i = 0,j=0;
	while (j != MAXENEMYCOUNT)
	{
			if (i < enemies.size())
			{
				if (enemies[i].specialEnemyType != 0xff)
				{
					fprintf(out,"\tdc.w %s ; %s\n",enemies[i].initFunction.c_str(),enemies[i].name.c_str());
					++j;
				}
			}
			else
			{
				fprintf(out,"\tdc.w $0000 ; clean\n");
				++j;
			}
			i++;
	}

	fprintf(out,"\nenemyHandleFuncs\n");
	i = 0;j=0;
	while (j != MAXENEMYCOUNT)
	{
			if (i < enemies.size())
			{
				if (enemies[i].specialEnemyType != 0xff)
				{
					fprintf(out,"\tdc.w %s ; %s\n",enemies[i].handleFunction.c_str(),enemies[i].name.c_str());
					++j;
				}
			}
			else
			{
				fprintf(out,"\tdc.w $0000 ; clean\n");
				++j;
			}
			i++;
	}

	fprintf(out,"\nenemyXStart\n");
	i = 0;j=0;
	while (j != MAXENEMYCOUNT)
	{
			if (i < enemies.size())
			{
				if (enemies[i].specialEnemyType != 0xff)
				{
					int add = vsprites[enemies[i].firstSpriteFrame].pixxadd;
					fprintf(out,"\tdc.b %d ; %s\n",add,enemies[i].name.c_str());
					++j;
				}
			}
			else
			{
				fprintf(out,"\tdc.b $00 ; clean\n");
				++j;
			}
		i++;
	}

	fprintf(out,"\nenemyYStart\n");
	i = 0;j=0;
	while (j != MAXENEMYCOUNT)
	{
			if (i < enemies.size())
			{
				if (enemies[i].specialEnemyType != 0xff)
				{
					int add = vsprites[enemies[i].firstSpriteFrame].pixyadd;
					fprintf(out,"\tdc.b %d ; %s\n",add,enemies[i].name.c_str());
					++j;
				}
			}
			else
			{
				fprintf(out,"\tdc.b $00 ; clean\n");
				++j;
			}
		i++;
	}

	fprintf(out,"\nenemyXEnd\n");
	i = 0;j=0;
	while (j != MAXENEMYCOUNT)
	{
			if (i < enemies.size())
			{
				if (enemies[i].specialEnemyType != 0xff)
				{
					int add = vsprites[enemies[i].firstSpriteFrame].pixxadd;
					int siz = vsprites[enemies[i].firstSpriteFrame].xsize;
					fprintf(out,"\tdc.b %d ; %s\n",siz+add,enemies[i].name.c_str());
					++j;
				}
			}
			else
			{
				fprintf(out,"\tdc.b $00 ; clean\n");
				++j;
			}
		i++;
	}

	fprintf(out,"\nenemyYEnd\n");
	i = 0;j=0;
	while (j != MAXENEMYCOUNT)
	{
			if (i < enemies.size())
			{
				if (enemies[i].specialEnemyType != 0xff)
				{
					fprintf(out,"\tdc.b %d ; %s\n",enemies[i].yend,enemies[i].name.c_str());
					++j;
				}
			}
			else
			{
				fprintf(out,"\tdc.b $00 ; clean\n");
				++j;
			}
		i++;
	}

	fprintf(out,"\nenemyHitPoints\n");
	i = 0;j=0;
	while (j != MAXENEMYCOUNT)
	{
		if (i < enemies.size())
		{
			if (enemies[i].specialEnemyType != 0xff)
			{
				fprintf(out,"\tdc.b %d ; %s\n",enemies[i].hitPoints,enemies[i].name.c_str());
				++j;
			}
		}
		else
		{
			fprintf(out,"\tdc.b $00 ; clean\n");
			++j;
		}
		i++;
	}

	fclose(out);
}

void intro_init( void )
{
	setupWithCommandLine();

	FILE *in = fopen((dataDirPrefix+"PLU4COLORS.bin").c_str(),"rb");
	fread(palette,1,1024,in);
	fclose(in);
	for (int i = 0; i < 256; ++i)
	palette[i] = ((palette[i] >> 16) & 255) + ((palette[i] & 0xff)<<16) + (palette[i] & 0xff00)+0xff000000;
	frameCounter = 0;
	loadLevel();
	newUndoPoint();
	convertFont();

	for (int i = 0; i < 256; ++i)
		randTab[i] = i;

	for (int j = 0; j < 256; ++j)
	{
		int a = rand() & 255;
		int b = (a + (rand() & 3)) & 255;
		int t = randTab[a];
		randTab[a] = randTab[b];
		randTab[b] = t;
	}

	// -----------------------------------------------------------------------------------
	//				SPRITEFRAMES
	// -----------------------------------------------------------------------------------

	int xs = 14;
	for (int i = 0; i < 12; ++i)
	{
		vectorSprites.push_back(SpriteDesc(spritesWorkingDirPrefix + "kate.png",xs*i,0,xs,32));
	}
	FRAME frame;
	frame.firstSpriteFrame = 0;
	frame.spriteFrameCount = 12;
	frame.name = "FRAMES_KATE";
	frame.xsize = xs;
	frame.ysize = 32;
	frames.push_back(frame);

	if (gWorld == 0)
		addFrames(vectorSprites,1,"zordan2.png",16,32,"FRAMES_ZORDAN");

	addFrames(vectorSprites,2,"playerShot%d.png",4,8,"FRAMES_PLAYERSHOT");
	addFrames(vectorSprites,4,"explosion1_%d.png",12,24,"FRAMES_EXPLOSION");
	addFrames(vectorSprites,5,"status%d.png",10,5,"FRAMES_STATUS");
	addFrames(vectorSprites,2,"dust%d.png",4,4,"FRAMES_DUST");
	addFrames(vectorSprites,1,"hit.png",7,5,"FRAMES_HIT50");
	addFrames(vectorSprites,3,"sparkles%d.png",9,16,"FRAMES_SPARKLES");
	addFrames(vectorSprites,3,"diamond%d.png",5,10,"FRAMES_DIAMOND");
	addFrames(vectorSprites,3,"heart%d.png",9,16,"FRAMES_HEART");
	if (gWorld == 8)
		addFrames(vectorSprites,3,"backgroundanim%d.png",9,6,"FRAMES_BACKGROUND");
	else
		addFrames(vectorSprites,3,"backgroundanim%d.png",9,8,"FRAMES_BACKGROUND");

	addFrames(vectorSprites,2,"schalter%d.png",6,8,"FRAMES_SCHALTER");
	addFrames(vectorSprites,3,"item%d.png",9,16,"FRAMES_ITEM");
	
	// ab hier folgen die dynamischen enemy sprites
	addFrames(vectorSprites,3,"smallEnemy1_%d.png",10,18,"FRAMES_ENEMY1");
	if (gWorld == 5 || gWorld == 6)
		addFrames(vectorSprites,4,"smallBird1_%d.png",12,30,"FRAMES_ENEMY2");
	else	
		addFrames(vectorSprites,3,"smallBird1_%d.png",12,30,"FRAMES_ENEMY2");
	addFrames(vectorSprites,2,"walkingEnemy1_%d.png",12,32,"FRAMES_ENEMY3");
	addFrames(vectorSprites,2,"walkingEnemy2_%d.png",16,32,"FRAMES_ENEMY4");
	addFrames(vectorSprites,2,"walkingEnemy3_%d.png",10,24,"FRAMES_ENEMY5");

	if (gWorld == 8)
		addFrames(vectorSprites,2,"portal%d.png",8,32,"FRAMES_ENEMY6");
	else
	if (gWorld == 3)
		addFrames(vectorSprites,2,"animalEnemy1_%d.png",1,1,"FRAMES_ENEMY6");
	else
		addFrames(vectorSprites,2,"animalEnemy1_%d.png",16,20,"FRAMES_ENEMY6");

	addFrames(vectorSprites,1,"enemyShot1.png",6,12,"FRAMES_ENEMYSHOT1");
	addFrames(vectorSprites,1,"enemyShot2.png",6,12,"FRAMES_ENEMYSHOT2");
	if (gWorld == 4)
		addFrames(vectorSprites,2,"special%d.png",8,16,"FRAMES_SPECIAL");
	else
	if (gWorld == 5)
		addFrames(vectorSprites,2,"special%d.png",8,16,"FRAMES_SPECIAL");
	else
	if (gWorld == 6)
		addFrames(vectorSprites,2,"special%d.png",8,16,"FRAMES_SPECIAL");
	else
	if (gWorld == 7)
	{}
	else
		addFrames(vectorSprites,2,"special%d.png",4,8,"FRAMES_SPECIAL");

	registerVectorSprites(vectorSprites);

	// to get the height
	convertVectorSprites();

	// -----------------------------------------------------------------------------------
	//				ENEMIES
	// -----------------------------------------------------------------------------------

	// all enemies global
	addEnemy("PLAYERSHOT","FRAMES_PLAYERSHOT","InitPlayerShot","HandlePlayerShot",0);
	addEnemy("EXPLOSION","FRAMES_EXPLOSION","InitExplosion","HandleExplosion",0);
	addEnemy("SPARKLES","FRAMES_SPARKLES","InitSparkles","HandleSparkles",0);

	int enemiesForKeysStart = enemies.size();;
	addEnemy("KATE","FRAMES_KATE","InitBackground","HandleBackground",0,0xff);

	addEnemy("HEART","FRAMES_HEART","InitCollectable","HandleCollectable",0,32);
	addEnemy("DIAMOND","FRAMES_DIAMOND","InitCollectable","HandleCollectable",0,33);
	addEnemy("BACKGROUND","FRAMES_BACKGROUND","InitBackground","HandleBackground",0,34);
	addEnemy("STONE","FRAMES_SPARKLES","InitBackground","HandleBackground",0,40); // use +,- to skipp between (ten stones)
	addEnemy("SCHALTER","FRAMES_SCHALTER","InitSchalter","HandleSchalter",0,50); // use +,- to skipp between
	addEnemy("ITEM","FRAMES_ITEM","InitCollectable","HandleCollectable",0,35);

	// the real enemies
	addEnemy("ENEMY1","FRAMES_ENEMY1","InitFrog","HandleStandardEnemy",3);
	addEnemy("ENEMY2","FRAMES_ENEMY2","InitBird","HandleStandardEnemy",3);
	addEnemy("ENEMY3","FRAMES_ENEMY3","InitBomby","HandleStandardEnemy",3);
	addEnemy("ENEMY4","FRAMES_ENEMY4","InitFat","HandleStandardEnemy",3);
	addEnemy("ENEMY5","FRAMES_ENEMY5","InitThrower","HandleStandardEnemy",3);
	if (gWorld == 8)
		addEnemy("ENEMY6","FRAMES_ENEMY6","InitDog","HandlePortalEnemy",3);
	else
		addEnemy("ENEMY6","FRAMES_ENEMY6","InitDog","HandleStandardEnemy",3);

	addEnemy("ENEMYSHOT1","FRAMES_ENEMYSHOT1","InitEnemyShot1","HandleStandardEnemy",0);
	addEnemy("ENEMYSHOT2","FRAMES_ENEMYSHOT2","InitEnemyShot2","HandleStandardEnemy",0);
	if (gWorld == 7)
	{
		addEnemy("SPECIALENEMY","FRAMES_ENEMY4","InitSpecialEnemy","HandleSpecialEnemy",6);
	}
	else
		addEnemy("SPECIALENEMY","FRAMES_SPECIAL","InitSpecialEnemy","HandleSpecialEnemy",6);

	int j = 0;
	for (int i = 0; i < 20; ++i)
	{
		if (i < (enemies.size() - enemiesForKeysStart))
		{
			enemySpriteImage[i] = enemies[i+enemiesForKeysStart].firstSpriteFrame;
			int specialType = enemies[i+enemiesForKeysStart].specialEnemyType;
			if (specialType == -1)
				enemyTypeForKey[i] = j + enemiesForKeysStart;
			else
			{
				enemyTypeForKey[i] = specialType;
				if (specialType == 0xff)
					j--;
			}
			j++;		
		}
		else
		{
			enemySpriteImage[i] = 0;
			enemyTypeForKey[i] = 0;
		}
	}

	exportEnemyData();
}

int spriteBlockW = 8;
int spriteBlockH = 8;
int greyColor = 0x51;
void drawBigSprite(int nr)
{
	VectorSprite sprite = vsprites[nr];
	int w = sprite.pictureWidth;
	int h = sprite.pictureHeight;
	for (int y = 0; y < h; ++y)
	for (int x = 0; x < w; ++x)
	{
		for (int y2 = 0; y2 < spriteBlockH; ++y2)
		for (int x2 = 0; x2 < spriteBlockW; ++x2)
		{
			int c = 0x63; 
			int vc = sprite.picture[x+y*sprite.pictureWidth];
			if (getMaskBool(vc) == true)
				c = backgroundColor;
			if (getWhiteBool(vc) == true)
				c = foregroundColor;
			if (getGreyBool(vc) == true)
				c = greyColor;

			setPixel(x+spriteBlockW*w+10,y,c);

			setPixel(x*spriteBlockW+x2,y*spriteBlockH+y2,c);
		}
	}
}

int threeCols[4] = {0xff0000ff,backgroundColor,0xff808080,0xffffffff};

void paintInSprite(int nr,int color)
{
	VectorSprite &sprite = vsprites[nr];

	int posX = (int)mousePosX;
	int posY = (int)mousePosY;
	posX = posX*RXRES/XRES;
	posY = posY*RYRES/YRES;
	if ((posX < 0) || (posY < 0))
		return;
	posX /= spriteBlockW;
	posY /= spriteBlockH;
	if (((unsigned int)posX < sprite.pictureWidth) && ((unsigned int)posY < sprite.pictureHeight))
	{
		sprite.picture[posX + posY * sprite.pictureWidth] = threeCols[color];
	}
}

VectorSprite copySprite;

int currentSprite = 0;
int paintColorS = 1;
void spriteControls()
{
	if (GetAsyncKeyState(VK_ADD)&0x8000) 
	{
		currentSprite++;
		if ( currentSprite > vsprites.size()-1 )
			currentSprite = vsprites.size()-1;
		while(GetAsyncKeyState(VK_ADD)&0x8000);
	}

	if (GetAsyncKeyState(VK_SUBTRACT)&0x8000) 
	{
		currentSprite--;
		if (currentSprite<0)
			currentSprite=0;
		while(GetAsyncKeyState(VK_SUBTRACT)&0x8000);
	}

	if (GetAsyncKeyState('1')&0x8000) 
	{
		paintColorS = 1;
	}
	if (GetAsyncKeyState('2')&0x8000) 
	{
		paintColorS = 2;
	}
	if (GetAsyncKeyState('3')&0x8000) 
	{
		paintColorS = 3;
	}

	if (GetAsyncKeyState('C')&0x8000) 
	{
		copySprite = vsprites[currentSprite];
	}
	if (GetAsyncKeyState('V')&0x8000) 
	{
		vsprites[currentSprite].xsize = copySprite.xsize;
		vsprites[currentSprite].ysize = copySprite.ysize;
		vsprites[currentSprite].imageData = copySprite.imageData;
		vsprites[currentSprite].picture = new unsigned int[copySprite.pictureWidth * copySprite.pictureHeight];
		vsprites[currentSprite].pictureWidth	= copySprite.pictureWidth;
		vsprites[currentSprite].pictureHeight	= copySprite.pictureHeight;
		vsprites[currentSprite].pixxadd = copySprite.pixxadd;
		vsprites[currentSprite].pixyadd = copySprite.pixyadd;
		vsprites[currentSprite].onlyWhite = copySprite.onlyWhite;
		vsprites[currentSprite].realxsize = copySprite.realxsize;
		vsprites[currentSprite].doubleSize = copySprite.doubleSize;
		vsprites[currentSprite].sourceX = copySprite.sourceX;
		vsprites[currentSprite].sourceY = copySprite.sourceY;

		memcpy(vsprites[currentSprite].picture,copySprite.picture,copySprite.pictureWidth*copySprite.pictureHeight*sizeof(unsigned int));
	}


	if (mouseButtonL)
	{
		paintInSprite(currentSprite,paintColorS);
	}

	if (mouseButtonR)
	{
		paintInSprite(currentSprite,0);
	}

	drawBigSprite(currentSprite);
}


bool levelMode = true;
void intro_do( unsigned int *buffer, long itime )
{ 
	float secs = (float)itime / 1000.f;
	float frame = secs * 60.f / 1.f;
	int iFrame = (int)frame;
	static int lFrame = iFrame;

	for( int i=0; i<RXRES*RYRES; i++ )
		screenBuffer[i] = 0x01;

	if (GetAsyncKeyState('S')&0x8000)
	{
		levelMode = false;
	}

	if (GetAsyncKeyState('L')&0x8000)
	{
		levelMode = true;
	}


	if (levelMode)
	{
		saveState();

		drawLevel();
		drawFont();
		drawTiles();
		drawChar();
		drawCharColors();
		drawTile();
		drawPalette();
		drawMap();
		drawFlags();
		drawEnemies();
		drawGradient();

		handlePalette();
		handleCharColors();
		handleChar();
		handleFont();
		handleTile();
		handleTiles();
		handleLevel();
		handleMap();
		handleFlags();
		handleGradient();
	
		checkStateUpdateAndMakeUndoPointIfRequired();

		if (GetAsyncKeyState(VK_RIGHT)&0x8000)
		{
			levelScrollPosX++;
			clipScrollPos();
		}
		if (GetAsyncKeyState(VK_LEFT)&0x8000)
		{
			levelScrollPosX--;
			clipScrollPos();
		}
		if (GetAsyncKeyState(VK_UP)&0x8000)
		{
			levelScrollPosY--;
			clipScrollPos();
		}
		if (GetAsyncKeyState(VK_DOWN)&0x8000)
		{
			levelScrollPosY++;
			clipScrollPos();
		}
		if (GetAsyncKeyState('Z')&0x8000)
		{
			if (!(GetAsyncKeyState(VK_SHIFT)&0x8000))
				undo();
			else
				redo();
			while(GetAsyncKeyState('Z')&0x8000);
		}

		int numberPressed = -1;
		for (int i = 0; i < 10; ++i)
		{
			if (GetAsyncKeyState('0'+i)&0x8000)
				numberPressed = i;
		}
		for (int i = 0; i < 10; ++i)
		{
			if (GetAsyncKeyState('A'+i)&0x8000)
				numberPressed = i+10;
		}

		if (numberPressed != -1)
		{
			if (GetAsyncKeyState(VK_CONTROL)&0x8000)
			{
				activeOverlay = numberPressed;
			}
			else
			if (GetAsyncKeyState(VK_SHIFT)&0x8000)
			{
				tileRandom = numberPressed-1;
			}
			else
			{
				handleEnemyNr(numberPressed);
			}
		}
		if (GetAsyncKeyState(VK_ADD)&0x8000)
		{
			handleEnemyPlusMinus(1);
			while(GetAsyncKeyState(VK_ADD)&0x8000);
		}
		if (GetAsyncKeyState(VK_SUBTRACT)&0x8000)
		{
			handleEnemyPlusMinus(-1);
			while(GetAsyncKeyState(VK_SUBTRACT)&0x8000);
		}

	}
	else
	{
		spriteControls();
	}

	int i = 0;
	for (int y2 = 0; y2 < YRES; ++y2)
	for (int x2 = 0; x2 < XRES; ++x2)
	{
		int x = x2*RXRES/XRES;
		int y = y2*RYRES/YRES;
		buffer[i++] = palette[screenBuffer[x+y*RXRES]];
	}

	int fairies = 0;
	for (int i = 0; i < LEVELSIZEX*4*LEVELSIZEY*4; ++i)
	{
		if (curState.enemyNr[i] == 11)
			fairies++;
	}
	int debug = 1;

	frameCounter++;
	lFrame = iFrame;
}
