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
#include <string.h>
#include <vector>
#include <algorithm>
#include "png.h"
#include "clipper.hpp"
#include "setup.h"

float mousePosX;
float mousePosY;
bool mouseButtonL;
bool mouseButtonR;

using namespace std;

double FOV = 2.0;
#define SCREENSIZEX 127
#define SCREENSIZEY 191
int minPixelsVisible = 8;
int minPixelsForPolyToRemove = 8;
int pixelsForOneFrame = (160*200)/30;

int clipLeft = 0;
int clipRight = SCREENSIZEX;
int clipTop = 0;
int clipBottom = SCREENSIZEY;
double nearPlane = 0.1;
double farPlane = 16.0;

int sign(double v)
{
	if (v < 0)
		return -1;
	if (v > 0)
		return 1;
	return 0;
}

struct VECTOR
{
	VECTOR() {zero();specialClip = 0;}
	VECTOR(double x,double y,double z = 0.0) {set(x,y,z);}

	double x,y,z;
	float specialClip;

	void zero() {x=y=z=0.0;}
	void set(double x,double y,double z = 0.0) {this->x = x; this->y = y; this->z = z;}
	void add(const VECTOR &v) {x += v.x;y += v.y; z += v.z;}
	void add(double x, double y, double z = 0.0) {this->x += x;this->y += y;this->z += z;}
	void sub(const VECTOR &v) {x -= v.x;y -= v.y; z -= v.z;}
	void sub(double x, double y, double z = 0.0) {this->x -= x;this->y -= y;this->z -= z;}
	void scale(double s) {x*=s;y*=s;z*=s;}
	double length() {return sqrt(x*x+y*y+z*z);}
	void normalize() {double l = length(); if (l > 0.0) {x/=l;y/=l;z/=l;}}
};

double dot(const VECTOR &a,const VECTOR &b);

struct VECTOR2D
{
	VECTOR2D() {x=y=0.0;z=0.0;specialClip=0.0;}
	VECTOR2D(int x,int y) {this->x=x;this->y=y;z=0.0;specialClip=0.0;}
	float x,y;
	float z;
	float specialClip;
};

struct VECTOR2DI
{
	VECTOR2DI() {x=y=0;}
	int x,y;
};

struct EDGE2D
{
	EDGE2D() {;}
	EDGE2D(VECTOR2D a, VECTOR2D b) {this->a = a; this->b = b;}

	VECTOR2D a;
	VECTOR2D b;

	float dist(const VECTOR2D &v) {
		VECTOR n;
		// coordinate vertauschung for normal
		n.x = b.y - a.y;
		n.y = -(b.x - a.x);
		n.normalize(); // 2d
		VECTOR p;
		p.x = v.x - a.x;
		p.y = v.y - a.y;
		return dot(p,n);
	}

	VECTOR2D intersect(const VECTOR2D &a,const VECTOR2D &b)
	{
		double dist1 = dist(a);
		double dist2 = dist(b);
		double ratio = dist1/(dist2-dist1);
		VECTOR2D ret;
		ret.x = a.x + ratio * (b.x - a.x);
		ret.y = a.y + ratio * (b.y - a.y);
		return ret;
	}

	bool inside(const VECTOR2D &v) 
	{
		return dist(v) < 0.f;
	}
};

struct MATRIX
{
	MATRIX() {identity();}
	VECTOR t;
	double m[3][3];

	void zero() {memset(m,0,sizeof(m));t.zero();}
	void identity() {zero();m[0][0] = 1.0;m[1][1] = 1.0;m[2][2] = 1.0;}
	void buildRotateX(double angle)
	{
		zero();
		m[0][0] = 1.f;
		m[1][1] = cos(angle);
		m[1][2] = -sin(angle);
		m[2][1] = sin(angle);
		m[2][2] = cos(angle);
	}
	void buildRotateY(double angle)
	{
		zero();
		m[0][0] = cos(angle);
		m[0][2] = sin(angle);
		m[1][1] = 1.f;
		m[2][0] = -sin(angle);
		m[2][2] = cos(angle);
	}
	void buildRotateZ(double angle)
	{
		zero();
		m[0][0] = cos(angle);
		m[0][1] = -sin(angle);
		m[1][0] = sin(angle);
		m[1][1] = cos(angle);
		m[2][2] = 1.f;
	}
	void setTranslate(double x, double y, double z) {t.x = x;t.y = y; t.z = z;}
	void setTranslate(const VECTOR &v) {t = v;}
	void translate(const VECTOR &v) {t.add(v);}
	void translate(double x, double y, double z) {t.add(x,y,z);}
};

double dot(const VECTOR &a,const VECTOR &b) {return a.x*b.x+a.y*b.y+a.z*b.z;}
VECTOR cross(const VECTOR &a,const VECTOR &b) {
	VECTOR ret;	
	ret.x = a.y*b.z - a.z*b.y;
	ret.y = a.z*b.x - a.x*b.z;
	ret.z = a.x*b.y - a.y*b.x;
	return ret;
}
VECTOR transform(const VECTOR &p, const MATRIX &mat)
{
	VECTOR ret;
	ret.x = p.x * mat.m[0][0] + p.y * mat.m[1][0] + p.z * mat.m[2][0] + mat.t.x;
	ret.y = p.x * mat.m[0][1] + p.y * mat.m[1][1] + p.z * mat.m[2][1] + mat.t.y;
	ret.z = p.x * mat.m[0][2] + p.y * mat.m[1][2] + p.z * mat.m[2][2] + mat.t.z;
	return ret;
}
VECTOR2D project(const VECTOR &p)
{
	VECTOR2D ret;
	ret.x = (p.x * FOV / (p.z) + 1.0) * SCREENSIZEX / 2.0;
	ret.y = (p.y * FOV / (p.z) + 1.0) * SCREENSIZEY / 2.0;
	ret.z = p.z;
	return ret;
}
MATRIX mul33(const MATRIX &m2, const MATRIX &m1)
{
	MATRIX ret;
	for(int i=0; i<3; i++)
	for(int j=0; j<3; j++)
	{
		ret.m[i][j] = 0;
		for(int k=0; k<3; k++)
			ret.m[i][j] += m2.m[i][k] * m1.m[k][j];
	}
	return ret;
}

struct POLYGON3D
{
	POLYGON3D() {color = 0;}
	int color;
	vector<VECTOR> points;
	VECTOR generateNormal()
	{
		if (points.size()<3)
			return VECTOR();
		VECTOR p0 = points[0];
		VECTOR p1 = points[1];
		VECTOR p2 = points[(-1+points.size()) % points.size()];
		p1.sub(p0);
		p2.sub(p0);
		VECTOR n = cross(p1,p2);
		n.normalize();
		return n;
	}
	void flipPointOrder()
	{
		vector<VECTOR> points2;
		for (int i = points.size()-1; i >= 0; --i)
			points2.push_back(points[i]);
		points = points2;
	}
};

struct POLYGON2D
{
	POLYGON2D() {color = 0; depth = 0.0;}
	int color;
	vector<VECTOR2D> pointsTransformed;
	double depth;
	bool checkConvex()
	{
		double testz;
		for (int i = 0; i < pointsTransformed.size(); ++i)
		{
			int i1 = (i + 1) % pointsTransformed.size();
			int i2 = (i + 2) % pointsTransformed.size();

			double dx1 = pointsTransformed[i1].x-pointsTransformed[i].x;
			double dy1 = pointsTransformed[i1].y-pointsTransformed[i].y;
			double dx2 = pointsTransformed[i2].x-pointsTransformed[i1].x;
			double dy2 = pointsTransformed[i2].y-pointsTransformed[i1].y;
			double zcrossproduct = dx1*dy2 - dy1*dx2;
			if (i == 0)
				testz = zcrossproduct;
			else
			if (sign(testz) != sign(zcrossproduct))
				return false;
		}
		return true;
	}
};

struct OBJECT
{
	MATRIX mat;
	vector<POLYGON3D> polys;
};

struct CAMERA
{
	CAMERA() {fov = 2.f;}

	float fov;
	MATRIX mat;
};

struct SCENE
{
	CAMERA cam;
	vector<OBJECT> objects;
};

vector<POLYGON3D> transformedPolys;
vector<POLYGON2D> outputPolys;
vector<std::vector<POLYGON2D>> playFrames;
SCENE scene;

// ----------------------------------------------------
// the 8 points for the cube
// ----------------------------------------------------
VECTOR CubePoints[8] =
{
  VECTOR(-1,-1,-1),
  VECTOR(+1,-1,-1),
  VECTOR(-1,+1,-1),
  VECTOR(+1,+1,-1),
  VECTOR(-1,-1,+1),
  VECTOR(+1,-1,+1),
  VECTOR(-1,+1,+1),
  VECTOR(+1,+1,+1)
};

// ----------------------------------------------------
// the 6 faces with each 4 indices
// ----------------------------------------------------
int CubeFaces[6][4] =
{
  {0,1,3,2},
  {5,4,6,7},
  {1,5,7,3},
  {4,0,2,6},
  {4,5,1,0},
  {2,3,7,6}
};

#define PI 3.14159f
#define Log(fmt,...) {char buffer[1000];sprintf(buffer,fmt, ##__VA_ARGS__);OutputDebugStringA(buffer);OutputDebugStringA("\n");}

int frameCounter = 0;
int screenBuffer[160*200];

unsigned int palette[256];


//--------------------------------------------------------

unsigned char getColor(int color) 
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
			if (ri == 0x72)
			ri = 0x71;
		}
	}
	//if (ri == 0) ri = 0x2D;
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

unsigned char getColor2(int color) 
{
	int r = color & 255;
	int g = (color>>8) & 255;
	int b = (color>>16) & 255;
	int lastDelta = 10000*10000;
	int ri = 0;
	unsigned int colorEnabled[16] = {0,0,0,0,1,0,1,0, 0,0,0,0,0,0,0,0};

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
	return ri;
}

unsigned char getColorFloat2(float r,float g,float b)
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
	return getColor2(ri|(gi<<8)|(bi<<16));
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


void exportReziprokeTable()
{
	FILE *out = fopen((globalOutputDirPrefix + "reziproke16.inc").c_str(),"w");
	fprintf(out,"; LOW\n");
	for (int i = 0; i < 256; ++i)
	{
		int z = i;
		if (i == 0)
			z = 1;
		int h = 0x10000 / z;
		if (i < 2) h = 0xffff;
		fprintf(out,"\tdc.b %d\n",h & 255);
	}
	fprintf(out,"; HIGH\n");
	for (int i = 0; i < 256; ++i)
	{
		int z = i;
		if (i == 0)
			z = 1;
		int h = 0x10000 / z;
		if (i < 2) h = 0xffff;
		fprintf(out,"\tdc.b %d\n",h / 256);
	}
	fclose(out);
}

void exportSinTables()
{
	unsigned char sin1table[256];
	unsigned char sin2table[256];

	for (int i = 0; i < 256; ++i)
	{
		float fi = (float)i/256.f*2.f*3.14159f;
		sin1table[i] = (-cos(fi+cos(fi*2.0)))*32+90;
		float fi2 = (float)(i)/256.f*2.f*3.14159f;
		sin2table[i] = sin(fi2-cos(fi2*3.0))*16+32;
	}

	FILE *out;

	out = fopen((globalOutputDirPrefix + "sin1.bin").c_str(),"wb");
	fwrite(sin1table,1,256,out);
	fclose(out);

	out = fopen((globalOutputDirPrefix + "sin2.bin").c_str(),"wb");
	fwrite(sin2table,1,256,out);
	fclose(out);
}

const int CHECKX = 160;
const int CHECKY = 200;

int screenBufferCheck[CHECKX*CHECKY];

void clearCheckBuffer()
{
	memset(screenBufferCheck,0,CHECKX*CHECKY*sizeof(int));
}

void setCheckPixel(int x, int y, int c)
{
	if (((unsigned int)x < CHECKX) && ((unsigned int)y < CHECKY))
		screenBufferCheck[x+y*CHECKX] = c;
}

int pixelsDrawn = 0;
int pixelsDrawnReal = 0;

void drawPoly(vector<VECTOR2D> pointsf, int index)
{
	vector<VECTOR2DI> points;
	for (int i = 0; i < pointsf.size(); ++i)
	{
		VECTOR2DI pointi;
		pointi.x = pointsf[i].x;
		pointi.y = pointsf[i].y;
		points.push_back(pointi);
	}


	int t = 0;
	int xt = points[0].x;
	for (int i = 1; i < points.size(); ++i)
		if (points[i].x < xt) {xt = points[i].x;t = i;}

	int xt2 = points[0].x;
	for (int i = 1; i < points.size(); ++i)
		if (points[i].x > xt2) {xt2 = points[i].x;}

	if (xt2 <= xt)
		return;

	int lp1 = t;
	int lp2 = t;

	int np1 = t;
	int np2 = t;

	int xp = points[t].x;

	//--------
	int dx1,dya1,yp1;
	int dx2,dya2,yp2;

	//--------
	dx1 = 0;
	dx2 = 0;

	bool ready = false;

	while(!ready)
	{
		if (dx1 == 0)
		{
			do
			{
				lp1 = np1;
				np1 = (np1 + 1) % points.size();
				dx1 = points[np1].x - points[lp1].x;
			} while (dx1 == 0);
			if (dx1 < 0)
				return;
			dya1 = ((points[np1].y - points[lp1].y) *256) / dx1;
			yp1 = points[lp1].y * 256;
		}

		if (dx2 == 0)
		{
			do
			{
				lp2 = np2;
				np2 = (np2 - 1 + points.size())  % points.size();
				dx2 = points[np2].x - points[lp2].x;
			} while (dx2 == 0);
			if (dx2 < 0)
				return;
			dya2 = ((points[np2].y - points[lp2].y) *256) / dx2;
			yp2 = points[lp2].y * 256;
		}

		if (yp2 + dya2 < yp1 + dya1) // ccw
		{
			return;
		}

		bool blitfast = false;
		int yue = 0;
		int yde = 0;
		if ((dx1 > 4) && (dx2 > 4) && ((xp & 3) == 0))
		{
			blitfast = true;
			int yp14 = yp1 + dya1 * 4;
			int yp24 = yp2 + dya2 * 4;

			if (yp14 < yp1)
				yp14 = yp1;
			if (yp24 > yp2)
				yp24 = yp2;

			yue = yp14 / 256;
			yde = yp24 / 256;

			if (yde < yue)
				yde = yue;
					
			if (yp14 > yp2)
				blitfast = false;
			if (yp24 < yp1)
				blitfast = false;
		}

		if (blitfast)
		{
			for (int j = 0; j < 4; ++j)
			{
				int yus = yp1 / 256;

				for (int y = yus; y < yue; ++y)
				{
					setCheckPixel(xp,y,index);
					pixelsDrawn++;
					pixelsDrawnReal++;
				}

				int yds = yp2 / 256;
				for (int y = yde; y < yds; ++y)
				{
					setCheckPixel(xp,y,index);
					pixelsDrawn++;
					pixelsDrawnReal++;
				}

				yp1 += dya1;
				yp2 += dya2;
				xp++;
			}

			xp -= 4;
			int viererPixels = 0;
			for (int j = 0; j < 4; ++j)
			{
				for (int y = yue; y < yde; ++y)
				{
					setCheckPixel(xp,y,index);
					pixelsDrawnReal++;
					viererPixels++;
				}
				xp++;
			}
			pixelsDrawn += viererPixels / 9; // atleast 4

			dx1 -= 4;
			dx2 -= 4;
		}
		else
		{
			for (int y = yp1 / 256; y < yp2 / 256; ++y)
			{
				setCheckPixel(xp,y,index);
				pixelsDrawnReal++;
				pixelsDrawn++;
			}
			yp1 += dya1;
			yp2 += dya2;
			xp++;
			dx1--;
			dx2--;
		}

	}
}

OBJECT buildTorus(const MATRIX &mat, int segments, int sectors, float minRad,float maxRad)
{
	OBJECT object;

	for (int sector = 0; sector < sectors; ++sector)
	{

		for (int segment = 0; segment < segments; ++segment)
		{
			POLYGON3D poly;
			poly.color = (segment + sector) & 7;
			int xp[4] = {0,1,1,0};
			int yp[4] = {1,1,0,0};
			for (int pn = 0; pn < 4; ++pn)
			{
				float sr = sin((float)(sector+yp[pn])/sectors*2.f*3.14159f)*(maxRad-minRad)*0.5f+(minRad+maxRad)*0.5f;
				float ringx = sin((float)(segment+xp[pn])/segments*2.f*3.14159f)*sr;
				float ringz = cos((float)(segment+xp[pn])/segments*2.f*3.14159f)*sr;
				float ringy = cos((float)(sector+yp[pn])/sectors*2.f*3.14159f)*(maxRad-minRad)*0.5f;
				VECTOR p;
				p.x = ringx;
				p.y = ringz;
				p.z = ringy;
				p = transform(p,mat);
				poly.points.push_back(p);
			}
			object.polys.push_back(poly);
		}
	}
	return object;
}

OBJECT buildCube(const MATRIX &mat, float xRad, float yRad, float zRad, float transX = 0, float transY = 0, float transZ = 0)
{
	OBJECT object;

	for (int f = 0; f < 6; ++f)
	{
		POLYGON3D poly;
		poly.color = f;
		for (int pn = 0; pn < 4; ++pn)
		{
			VECTOR p = CubePoints[CubeFaces[f][pn]];
			p.x *= xRad;
			p.y *= yRad;
			p.z *= zRad;
			p.add(transX,transY,transZ);
			p = transform(p,mat);
			poly.points.push_back(p);
		}
		object.polys.push_back(poly);
	}
	return object;
}

void buildSortedPolyArray()
{
	outputPolys.clear();
	for (int p = 0; p < transformedPolys.size(); ++p)
	{
		POLYGON3D poly = transformedPolys[p];
		POLYGON2D oPoly;
		double depthCheck = 0.0;
		oPoly.color = poly.color;
		for (int p = 0; p < poly.points.size(); ++p)
		{
			VECTOR point = poly.points[p];
			VECTOR2D projected = project(point);
			oPoly.pointsTransformed.push_back(projected);
			depthCheck += projected.z / poly.points.size();
		}
		oPoly.depth = depthCheck;
		outputPolys.push_back(oPoly);
	}
	// sort it
	std::sort(outputPolys.begin(), outputPolys.end(), [](const POLYGON2D &a, const POLYGON2D &b)
	{
		return a.depth > b.depth;
	});
}

void buildTransformedPolysArray()
{
	FOV = scene.cam.fov;
	transformedPolys.clear();
	for (int o = 0; o < scene.objects.size(); ++o)
	{
		OBJECT obj = scene.objects[o];
		for (int f = 0; f < obj.polys.size(); ++f)
		{
			POLYGON3D poly = obj.polys[f];
			POLYGON3D oPoly = poly;
			double depthCheck = 0.0;
			oPoly.color = poly.color;
			for (int p = 0; p < poly.points.size(); ++p)
			{
				VECTOR point = poly.points[p];
				point = transform(point,obj.mat);
				point = transform(point,scene.cam.mat);
				oPoly.points[p] = point;
			}
			transformedPolys.push_back(oPoly);
		}
	}
}

int exportedByteCount;
void exportSortedPolyArray(FILE *out)
{
	playFrames.push_back(outputPolys);
	for (int i = 0; i < outputPolys.size(); ++i)
	{
		POLYGON2D poly2d = outputPolys[i];
		bool yDiv2Flag = false;
		for (int j = 0; j < poly2d.pointsTransformed.size(); ++j)
		{
			int delta = abs(poly2d.pointsTransformed[j].y-poly2d.pointsTransformed[(j+1) % poly2d.pointsTransformed.size()].y);
			if (delta > 126)
			{
				yDiv2Flag = true;
			}
		}

		int p_cnt = poly2d.pointsTransformed.size();
		if (p_cnt > 0)
		{
			fprintf(out,"\tdc.b %d", p_cnt + poly2d.color * 16 + (yDiv2Flag ? 0x80 : 0x00));
			exportedByteCount++;
			for (int j = 0; j < p_cnt; ++j)
			{
				int px = poly2d.pointsTransformed[j].x;
				int py = poly2d.pointsTransformed[j].y;
				const int GuardLeft = 0;
				const int GuardRight = 0;
				const int GuardTop = 0;
				const int GuardBottom = 0;

				if (px < clipLeft + GuardLeft) px = clipLeft + GuardLeft;
				if (px > clipRight - GuardRight) px = clipRight - GuardRight;
				if (py < clipTop) py = clipTop + GuardTop;
				if (py > clipBottom - GuardBottom) py = clipBottom - GuardBottom;

				//if (yDiv2Flag)
				//	py /= 2;

				fprintf(out," ,%d,%d",px, py);
				exportedByteCount+=2;
			}
			fprintf(out,"\t\t; p_cnt = %d,p_cr = %d,yd2 = %d\n", p_cnt,poly2d.color,yDiv2Flag ? 1 : 0);
		}
	}
}

void removeNotVisiblePolygonsFromSortedPolyArray()
{
	clearCheckBuffer();
	vector<int> usedIndices;
	for (int i = 0; i < outputPolys.size(); ++i)
	{
		POLYGON2D poly2d = outputPolys[i];
		drawPoly(poly2d.pointsTransformed,i+1);
		usedIndices.push_back(0);
	}

	for (int y = 0; y < CHECKY; ++y)
	for (int x = 0; x < CHECKX; ++x)
	{
		int a = screenBufferCheck[x+y*CHECKX];
		if (a != 0)
		{
			usedIndices[a-1]++;
		}
	}

	for (int i = outputPolys.size()-1; i >= 0; --i)
	{
		if (usedIndices[i] < minPixelsVisible)
		{
			outputPolys.erase(outputPolys.begin()+i);
		}
	}
}

bool clipPoly2DAndCheckForRemove(int i)
{
	bool found = false;
	for (int i = 0; i < outputPolys[i].pointsTransformed.size(); ++i)
	{ 
		// wenn ein punkt drin ist dann ist es nicht ganz draussen
		VECTOR2D point = outputPolys[i].pointsTransformed[i];
		if ((point.x > clipLeft) || (point.x < clipRight) || (point.y > clipTop) || (point.y < clipBottom))
		{
			found = true;
			break;
		}
	}
	if (!found)
		return true; // all out

	POLYGON2D poly = outputPolys[i];

	VECTOR planeDirs[4] = {
		VECTOR(1,0),
		VECTOR(-1,0),
		VECTOR(0,1),
		VECTOR(0,-1)
	};
	VECTOR planeOrigs[4] = {
		VECTOR(clipLeft,0),
		VECTOR(clipRight,0),
		VECTOR(0,clipTop),
		VECTOR(0,clipBottom)
	};

	POLYGON2D oldPoly = poly;
	POLYGON2D newPoly = poly;
	for (int pl = 0; pl < 4; ++pl)
	{
		VECTOR distancePlaneOrigin = planeOrigs[pl];
		VECTOR distancePlaneDir = planeDirs[pl];

		for (int i = 0; i < oldPoly.pointsTransformed.size(); ++i)
		{
			double distanceCheckX = oldPoly.pointsTransformed[i].x - distancePlaneOrigin.x;
			double distanceCheckY = oldPoly.pointsTransformed[i].y - distancePlaneOrigin.y;
			double distance = distancePlaneDir.x * distanceCheckX + distancePlaneDir.y * distanceCheckY;
			oldPoly.pointsTransformed[i].specialClip = distance;
		}

		newPoly.pointsTransformed.clear();
		// negative distance means its clipped
		for (int i = 0; i < oldPoly.pointsTransformed.size(); ++i)
		{
			int i2 = (i+1) % oldPoly.pointsTransformed.size();
			// it's inside
			if (oldPoly.pointsTransformed[i].specialClip >= 0 && oldPoly.pointsTransformed[i2].specialClip >= 0)
				newPoly.pointsTransformed.push_back(oldPoly.pointsTransformed[i]);
			else
			if ( 
				   (oldPoly.pointsTransformed[i].specialClip < 0 && oldPoly.pointsTransformed[i2].specialClip >= 0) 
				|| (oldPoly.pointsTransformed[i2].specialClip < 0 && oldPoly.pointsTransformed[i].specialClip >= 0) 
				)
			{
				VECTOR p1(oldPoly.pointsTransformed[i].x,oldPoly.pointsTransformed[i].y);
				VECTOR p2(oldPoly.pointsTransformed[i2].x,oldPoly.pointsTransformed[i2].y);
				double a1 = oldPoly.pointsTransformed[i].specialClip;
				double a2 = oldPoly.pointsTransformed[i2].specialClip;
				double l = a1/(a2-a1);
				VECTOR2D d2 = oldPoly.pointsTransformed[i];
				d2.specialClip = 0.f;
				if (oldPoly.pointsTransformed[i2].specialClip < 0 && oldPoly.pointsTransformed[i].specialClip >= 0)
				{

					d2.x = p1.x + l * (p1.x - p2.x);
					d2.y = p1.y + l * (p1.y - p2.y);
					newPoly.pointsTransformed.push_back(oldPoly.pointsTransformed[i]);
					newPoly.pointsTransformed.push_back(d2);
				}
				else
				{
					d2.x = p1.x + l * (p1.x - p2.x);
					d2.y = p1.y + l * (p1.y - p2.y);
					newPoly.pointsTransformed.push_back(d2);
				}
			}
		}
		oldPoly = newPoly;
	}

 	outputPolys[i] = newPoly;
	if (newPoly.pointsTransformed.size() == 0)
		return true;

	return false;
}

bool clipPoly3DAndCheckForRemove(int i)
{
	bool found = false;
	for (int j = 0; j < transformedPolys[i].points.size(); ++j)
	{ 
		// wenn ein punkt drin ist dann ist es nicht ganz draussen
		VECTOR point = transformedPolys[i].points[j];
		if (point.z > nearPlane && point.z < farPlane)
		{
			found = true;
			break;
		}
	}
	if (!found)
		return true; // all out

	POLYGON3D poly = transformedPolys[i];

	VECTOR planeDirs[2] = {
		VECTOR(0,0,1),
		VECTOR(0,0,-1),
	};
	VECTOR planeOrigs[2] = {
		VECTOR(0,0,nearPlane),
		VECTOR(0,0,farPlane),
	};

	POLYGON3D oldPoly = poly;
	POLYGON3D newPoly = poly;
	for (int pl = 0; pl < 2; ++pl)
	{
		VECTOR distancePlaneOrigin = planeOrigs[pl];
		VECTOR distancePlaneDir = planeDirs[pl];

		for (int i = 0; i < oldPoly.points.size(); ++i)
		{
			double distanceCheckX = oldPoly.points[i].x - distancePlaneOrigin.x;
			double distanceCheckY = oldPoly.points[i].y - distancePlaneOrigin.y;
			double distanceCheckZ = oldPoly.points[i].z - distancePlaneOrigin.z;
			double distance = distancePlaneDir.x * distanceCheckX + distancePlaneDir.y * distanceCheckY + distancePlaneDir.z * distanceCheckZ;
			oldPoly.points[i].specialClip = distance;
		}

		newPoly.points.clear();
		// negative distance means its clipped
		for (int i = 0; i < oldPoly.points.size(); ++i)
		{
			int i2 = (i+1) % oldPoly.points.size();
			// it's inside
			if (oldPoly.points[i].specialClip >= 0 && oldPoly.points[i2].specialClip >= 0)
				newPoly.points.push_back(oldPoly.points[i]);
			else
			if ( 
				   (oldPoly.points[i].specialClip < 0 && oldPoly.points[i2].specialClip >= 0) 
				|| (oldPoly.points[i2].specialClip < 0 && oldPoly.points[i].specialClip >= 0) 
				)
			{
				VECTOR p1 = oldPoly.points[i];
				VECTOR p2 = oldPoly.points[i2];
				double a1 = oldPoly.points[i].specialClip;
				double a2 = oldPoly.points[i2].specialClip;
				double l = a1/(a2-a1);
				VECTOR d2 = oldPoly.points[i];
				d2.specialClip = 0.f;
				d2.x = p1.x + l * (p1.x - p2.x);
				d2.y = p1.y + l * (p1.y - p2.y);
				d2.z = p1.z + l * (p1.z - p2.z);
				if (oldPoly.points[i2].specialClip < 0 && oldPoly.points[i].specialClip >= 0)
				{

					newPoly.points.push_back(oldPoly.points[i]);
					newPoly.points.push_back(d2);
				}
				else
				{
					newPoly.points.push_back(d2);
				}
			}
		}
		oldPoly = newPoly;
	}

 	transformedPolys[i] = newPoly;
	if (newPoly.points.size() == 0)
		return true;

	return false;
}

void convertToConvex(int position)
{
	POLYGON2D inputPoly = outputPolys[position];
	if (!inputPoly.checkConvex())
	{
		outputPolys.erase(outputPolys.begin()+position);

		int currentBase = 0;
		
		while(inputPoly.pointsTransformed.size() > 3)
		{
			int i0 = currentBase % inputPoly.pointsTransformed.size();
			int i1 = (currentBase - 1 + inputPoly.pointsTransformed.size()) % inputPoly.pointsTransformed.size();
			int i2 = (currentBase + 1) % inputPoly.pointsTransformed.size();
			VECTOR2D p[3];
			p[0] = inputPoly.pointsTransformed[i0];
			p[1] = inputPoly.pointsTransformed[i1];
			p[2] = inputPoly.pointsTransformed[i2];
			bool isPointInside = true;
			for (int i = 0; i < 3; ++i)
			{
				EDGE2D e;
				e.a = p[i];
				e.b = p[(i+1) % 3];

				for (int k = 0; k < inputPoly.pointsTransformed.size(); ++k)
				{
					if (k == i0 || k == i1 || k == i2)
						continue;
					VECTOR2D c = inputPoly.pointsTransformed[k];
					if (e.dist(c) > 0.0) // is it outside this line?
						isPointInside = false;
				}
			}
			if (!isPointInside)
			{
				POLYGON2D newPoly = inputPoly;
				newPoly.pointsTransformed.clear();
				newPoly.pointsTransformed.push_back(p[1]);
				newPoly.pointsTransformed.push_back(p[0]);
				newPoly.pointsTransformed.push_back(p[2]);
				outputPolys.insert(outputPolys.begin()+position,newPoly);
				inputPoly.pointsTransformed.erase(inputPoly.pointsTransformed.begin() + i0);
			}

			currentBase++;
		}
		outputPolys.insert(outputPolys.begin()+position,inputPoly);
	}
}

/*
  List outputList = subjectPolygon;
  for (Edge clipEdge in clipPolygon) do
     List inputList = outputList;
     outputList.clear();
     Point S = inputList.last;
     for (Point E in inputList) do
        if (E inside clipEdge) then
           if (S not inside clipEdge) then
              outputList.add(ComputeIntersection(S,E,clipEdge));
           end if
           outputList.add(E);
        else if (S inside clipEdge) then
           outputList.add(ComputeIntersection(S,E,clipEdge));
        end if
        S = E;
     done
  done
*/
// this is infact for the inside of a polygon so not usable here
bool clipOutputPolyWithPoly(int i1,int i2)
{
	POLYGON2D clipPolygon = outputPolys[i2];
	std::vector<VECTOR2D> outputList = outputPolys[i1].pointsTransformed;
	for (int i = 0; i < clipPolygon.pointsTransformed.size(); ++i) // all edges
	{
		if (outputList.size() == 0)
			return true;
		EDGE2D clipEdge(clipPolygon.pointsTransformed[i],clipPolygon.pointsTransformed[(i+1) % clipPolygon.pointsTransformed.size()]);
		std::vector<VECTOR2D> inputList = outputList;
		outputList.clear();
		VECTOR2D S = inputList.back();
		for (int j = 0; j < inputList.size(); ++j)
		{
			VECTOR2D E = inputList[j];
			if (clipEdge.inside(E))
			{
				if (!clipEdge.inside(S))
				{
					outputList.push_back(clipEdge.intersect(S,E));
				}
				outputList.push_back(E);
			}
			else
			{
				if (clipEdge.inside(S))
				{
					outputList.push_back(clipEdge.intersect(S,E));
				}
			}
		}
	}
	if (outputList.size() == 0)
		return true;

	outputPolys[i1].pointsTransformed = outputList;

	if (!outputPolys[i1].checkConvex())
		convertToConvex(i1);

	return false;
}

void do2DClippingOnSortedPolyArray()
{
	for (int i = outputPolys.size()-1; i >= 0; --i)
	{
		if (clipPoly2DAndCheckForRemove(i))
		{
			outputPolys.erase(outputPolys.begin()+i);
		}
	}
}

void do3DClippingOnTransformedPolyArray()
{
	for (int i = transformedPolys.size()-1; i >= 0; --i)
	{
		if (clipPoly3DAndCheckForRemove(i))
		{
			transformedPolys.erase(transformedPolys.begin()+i);
		}
	}
}

using namespace ClipperLib; 

void doRemovePolygonIntersections()
{
	for (int i = outputPolys.size()-1; i >= 0 ; i--)
	{
		Paths poly0(1); 
		Paths poly1(1); 

		poly0[0].clear();

		for (int k = 0; k < outputPolys[i].pointsTransformed.size(); ++k)
		{
			int px = outputPolys[i].pointsTransformed[k].x;
			int py = outputPolys[i].pointsTransformed[k].y;
			poly0[0].push_back(IntPoint(px,py));
		}
		for (int j = i-1; j >= 0; --j)
		{
			poly1[0].clear();
			for (int k = 0; k < outputPolys[j].pointsTransformed.size(); ++k)
			{
				int px = outputPolys[j].pointsTransformed[k].x;
				int py = outputPolys[j].pointsTransformed[k].y;
				poly1[0].push_back(IntPoint(px,py));
			}
			Clipper clpr; 
			clpr.AddPaths(poly0, ptClip, true); 
			clpr.AddPaths(poly1, ptSubject, true); 
			Paths solution; 
			clpr.Execute(ctXor, solution, pftEvenOdd, pftEvenOdd); 
			int num = solution.size();
			if (num == 0)
			{
				outputPolys.erase(outputPolys.begin()+j);
				if (outputPolys.size() - 1 < i )
					i = outputPolys.size() - 1;
			}
			else
			if (num == 2)
			{
				int debug = 1;
			}
			else
			if (num == 1)
			{
				int debug = 1;
				outputPolys[j].pointsTransformed.clear();
				for (int k = 0; k < solution[0].size(); ++k)
				{
					outputPolys[j].pointsTransformed.push_back(VECTOR2D(solution[0][k].X,solution[0][k].Y));
				}
				if (solution[0].size() == 0)
				{
					outputPolys.erase(outputPolys.begin()+j);
					if (outputPolys.size() - 1 < i )
						i = outputPolys.size() - 1;
				}
			}
		}
	}

	for (int i = outputPolys.size()-1; i >= 0 ; i--)
		convertToConvex(i);
}

void removeVerySmallPolygons()
{
	for (int i = outputPolys.size()-1; i >= 0 ; i--)
	{
		pixelsDrawnReal = 0;
		drawPoly(outputPolys[i].pointsTransformed,1);
		if (pixelsDrawnReal < minPixelsForPolyToRemove)
		{
			outputPolys.erase(outputPolys.begin()+i);
		}
	}
}

void removeDoubledVertices()
{
	for (int i = outputPolys.size()-1; i >= 0 ; i--)
	{
		for (int j = outputPolys[i].pointsTransformed.size() - 1; j >= 0; --j)
		{
			VECTOR2D p0 = outputPolys[i].pointsTransformed[j];
			VECTOR2D p1 = outputPolys[i].pointsTransformed[(j+1) % outputPolys[i].pointsTransformed.size()];
			if (p0.x == p1.x && p0.y == p1.y)
			{
				outputPolys[i].pointsTransformed.erase(outputPolys[i].pointsTransformed.begin() + j);
			}
		}
		if (outputPolys[i].pointsTransformed.size() < 3)
		{
			outputPolys.erase(outputPolys.begin() + i);
		}
	}
}

int countDrawnPixels()
{
	clearCheckBuffer();
	pixelsDrawn = 0;
	for (int i = outputPolys.size()-1; i >= 0; --i)
	{
		drawPoly(outputPolys[i].pointsTransformed,(rand() & 127) + 1);
	}
	return pixelsDrawn;
}

//doRemovePolygonIntersections(); // that is a very hard optimization which clips every polygon against every polygon

void buildSceneForTime(float t);

int overallFrameCount = 0;

void exportAnimation(FILE *out, int frames, float startTime, float endTime)
{
	Log("Starting export of animation.");
	int realFrameCount = 0;
	int nextFrame = 0;
	for (int i = 0; i < frames; ++i)
	{
		if ((i & 31) == 0)
			Log("Tick RealFrame:%d FrameInEngine:%d",i,realFrameCount);
		if (i >= nextFrame)
		{
			float t = (float)i/frames*(endTime-startTime)+startTime;
			buildSceneForTime(t);
			buildTransformedPolysArray();
			do3DClippingOnTransformedPolyArray();
			buildSortedPolyArray();
			removeNotVisiblePolygonsFromSortedPolyArray(); // screenspace stuff
			do2DClippingOnSortedPolyArray();
			removeDoubledVertices();
			removeVerySmallPolygons();

			exportSortedPolyArray(out);
			int pixelsDrawnHere = countDrawnPixels();
			fprintf(out,"\tdc.b $00 ; frame end\n");
			exportedByteCount++;
			nextFrame = i + pixelsDrawnHere / pixelsForOneFrame;
			realFrameCount++;
			overallFrameCount++;
		}
	}
	fprintf(out,"; frames for this portion %d\n",realFrameCount);
}

void lightScene(SCENE &scene)
{
	VECTOR lightpos(0.0,-5.0,-10.0);
	for (int o = 0; o < scene.objects.size(); ++o)
	{
		OBJECT &object = scene.objects[o];
		for (int f = 0; f < object.polys.size(); ++f)
		{
			POLYGON3D &poly = object.polys[f];
			if (poly.points.size()>=3)
			{
				// we can do lighting
				// first calculate normal
				VECTOR p0 = poly.points[0];
				VECTOR p1 = poly.points[poly.points.size()-1];
				VECTOR p2 = poly.points[1];
				p0 = transform(p0,object.mat);
				p1 = transform(p1,object.mat);
				p2 = transform(p2,object.mat);

				p1.sub(p0);
				p2.sub(p0);

				VECTOR normal = cross(p1,p2);
				normal.normalize();
				
				VECTOR lv = lightpos;
				lv.sub(p0);
				lv.normalize();

				double intens = dot(lv,normal);
				
				if (intens < 0) intens = 0;
				int col = intens * 8.f;
				if (col > 7)
					col = 7;
				poly.color = col;
			}
		}
	}
}

bool c(std::string a,std::string b)
{
	return a.compare(b) == 0;
}

std::string lowerCase(std::string a)
{
	for (int i = 0; i < a.length(); ++i)
	{
		if ((a[i]>='A') && (a[i]<='Z'))
			a[i] = a[i] - 'A' + 'a';
	}
	return a;
}

#define OBJECTENTRY 1
#define VERTEXENTRY 2
#define FACEENTRY   3
#define NORMALENTRY 4

int entryType;
std::vector<double> lwodv;
std::vector<int> lwodi1;
std::vector<int> lwodi2;
std::vector<int> lwodi3;
std::vector<VECTOR> lwovs;
std::vector<VECTOR> lwons;
std::vector<std::vector<int>> lwoff;
std::vector<std::vector<int>> lwofn;

void checkLWOWord(std::string w)
{
	if (c(lowerCase(w),"o"))
	{
		entryType = OBJECTENTRY;
		return;
	}
	else
	if (c(lowerCase(w),"v"))
	{
		entryType = VERTEXENTRY;
		return;
	}
	else
	if (c(lowerCase(w),"f"))
	{
		entryType = FACEENTRY;
		return;
	}
	else
	if (c(lowerCase(w),"vn"))
	{
		entryType = NORMALENTRY;
		return;
	}
	else
	if (entryType == OBJECTENTRY)
	{
		//Log("%s",w.c_str());
	}
	else
	if (entryType == VERTEXENTRY || entryType == NORMALENTRY)
	{
		double z = ::atof(w.c_str());
		lwodv.push_back(z);
	}
	else
	if (entryType == FACEENTRY)
	{
		int i = ::atoi(w.c_str());
		lwodi1.push_back(i);
		int sep = w.find("//");
		if (sep != w.npos)
		{
			w = w.substr(sep+2,-1);
			i = ::atoi(w.c_str());
			lwodi2.push_back(i);
			int sep = w.find("//");
			if (sep != w.npos)
			{
				w = w.substr(sep+2,-1);
				i = ::atoi(w.c_str());
				lwodi3.push_back(i);
			}
		}
	}
}

void completeEntry()
{
	if (entryType == VERTEXENTRY)
	{
		if (lwodv.size() == 3)
			lwovs.push_back(VECTOR(lwodv[0],lwodv[1],lwodv[2]));
	}
	if (entryType == NORMALENTRY)
	{
		if (lwodv.size() == 3)
			lwons.push_back(VECTOR(lwodv[0],lwodv[1],lwodv[2]));
	}
	if (entryType == FACEENTRY)
	{
		lwoff.push_back(lwodi1);
		lwofn.push_back(lwodi2);
	}
	lwodv.clear();
	lwodi1.clear();
	lwodi2.clear();
	lwodi3.clear();
	entryType = 0;
}

void addLightwaveObjectToScene(SCENE &dest, MATRIX mat, std::string fileName, float size = 1.f)
{
	FILE *in = fopen((globalWorkingDirPrefix + fileName).c_str(),"rb");
	fseek(in,0,SEEK_END);
	int fileSize = ftell(in);
	fseek(in,0,SEEK_SET);
	char *file = (char*)malloc(fileSize);
	fread(file,1,fileSize,in);
	fclose(in);

	int filePos = 0;
	bool newLine = true;
	bool comment = false;
	entryType = 0;
	lwodv.clear();
	lwodi1.clear();
	lwodi2.clear();
	lwodi3.clear();
	lwovs.clear();
	lwons.clear();
	lwoff.clear();
	lwofn.clear();

	std::string lastCombined;
	while (filePos < fileSize)
	{
		if (file[filePos] == 0x0d || file[filePos] == 0x0a)
		{
			checkLWOWord(lastCombined);
			completeEntry();
			newLine = true;
			comment = false;
			lastCombined = "";
		}
		else
		{
			unsigned char c = file[filePos];
			if (c == '#')
				comment = true;
			if (!comment)
			{
				if (c == '\t' || c == ' ')
				{
					checkLWOWord(lastCombined);
					lastCombined = "";
				}
				else
				{
					lastCombined += c;
				}
			}
			newLine = false;
		}

		filePos++;
	}
	completeEntry();

	// calculate midpoint
	VECTOR mp;
	for (int i = 0; i < lwovs.size(); ++i)
	{
		mp.add(lwovs[i]);
	}
	if (lwovs.size()>0)
		mp.scale(1.0/lwovs.size());
	// midpoint to zero
	for (int i = 0; i < lwovs.size(); ++i)
	{
		lwovs[i].sub(mp);
	}
	// calculate radius from midpoint
	VECTOR mi,ma;
	for (int i = 0; i < lwovs.size(); ++i)
	{
		VECTOR p = lwovs[i];
		if (p.x < mi.x || i == 0) mi.x = p.x;
		if (p.y < mi.y || i == 0) mi.y = p.y;
		if (p.z < mi.z || i == 0) mi.z = p.z;
		if (p.x > ma.x || i == 0) ma.x = p.x;
		if (p.y > ma.y || i == 0) ma.y = p.y;
		if (p.z > ma.z || i == 0) ma.z = p.z;
	}
	// max "rad"
	double mr = fabs(mi.x);
	if (fabs(mi.y)>mr) mr = fabs(mi.y);
	if (fabs(mi.z)>mr) mr = fabs(mi.z);
	if (fabs(ma.x)>mr) mr = fabs(ma.x);
	if (fabs(ma.y)>mr) mr = fabs(ma.y);
	if (fabs(ma.z)>mr) mr = fabs(ma.z);
	for (int i = 0; i < lwovs.size(); ++i)
	{
		lwovs[i].scale(size/mr);
		lwovs[i] = transform(lwovs[i],mat);
	}
	// build object
	OBJECT newObject;
	for (int i = 0; i < lwoff.size(); ++i)
	{
		std::vector<int> ff = lwoff[i];
		std::vector<int> fn = lwofn[i];
		POLYGON3D fd;
		fd.color = i & 7;
		VECTOR n1;
		for (int j = ff.size()-1; j >= 0; --j)
		{
			int pf = ff[j]-1;
			int pn = fn[j]-1;
			fd.points.push_back(lwovs[pf]);
			n1.add(lwons[pn]);
		}
		n1.normalize();
		VECTOR n2 = fd.generateNormal();
		double winkel = dot(n1,n2);
		//if (winkel < 0)
		//	fd.flipPointOrder();
		newObject.polys.push_back(fd);
	}
	dest.objects.push_back(newObject);
}

MATRIX getRotateXDeg(double angle0to360)
{
	MATRIX ret;
	ret.buildRotateX(angle0to360 / 360.0 * 2.0 * PI);
	return ret;
}

MATRIX getRotateYDeg(double angle0to360)
{
	MATRIX ret;
	ret.buildRotateY(angle0to360 / 360.0 * 2.0 * PI);
	return ret;
}

MATRIX getRotateZDeg(double angle0to360)
{
	MATRIX ret;
	ret.buildRotateZ(angle0to360 / 360.0 * 2.0 * PI);
	return ret;
}

MATRIX getTranslate(double x,double y,double z)
{
	MATRIX ret;
	ret.setTranslate(x,y,z);
	return ret;
}

/*
BACKGROUND
	incbin "background.bin"

BLITBACKGROUND1
Y SET 0
Y2 SET SCREENYSIZE - BACKGROUNDYSIZE
	REPEAT BACKGROUNDYSIZE/2
	lda (ZP_BACKGROUND_OFFSETS + Y * 2),y
	sta $2000+[[Y2] & 7]+[[Y2]/8*320]+SCREENXP4*8,x
Y SET Y + 2
Y2 SET Y2 + 2
	REPEND
	rts

BLITBACKGROUND2
Y SET 0
Y2 SET SCREENYSIZE - BACKGROUNDYSIZE
	REPEAT BACKGROUNDYSIZE/2
	lda (ZP_BACKGROUND_OFFSETS + Y * 2),y
	sta $4000+[[Y2] & 7]+[[Y2]/8*320]+SCREENXP4*8,x
Y SET Y + 2	
Y2 SET Y2 + 2
	REPEND
	rts
*/
/*
backgroundYPos dc.b SCREENYSIZE - BACKGROUNDYSIZE
backgroundstartyintern dc.b $00
backgroundendyintern dc.b $00

	lda largestYFrame,x
	sta backgroundendyintern
	cmp backgroundYPos
	bcc .onlyclear

	lda backgroundYPos
	sta backgroundstartyintern

	lda smallestYFrame,x
	cmp backgroundYPos
	bcc .notonlybackground
	sta backgroundstartyintern
	jsr drawBackground
	jmp .done
.notonlybackground
	jsr drawBackground
.onlyclear

	ldx doubleBuffer
*/
/*
backgroundstartyintern2 dc.b $00
backgroundendyintern2 dc.b $00
bgyjumpin dc.b $00
bgyend dc.b $00

drawBackground SUBROUTINE
	
	lda backgroundstartyintern
	sec
	sbc #SCREENYSIZE -BACKGROUNDYSIZE
	sta backgroundstartyintern2
	lda backgroundendyintern
	sec
	sbc #SCREENYSIZE -BACKGROUNDYSIZE
	sta backgroundendyintern2

	lda backgroundstartyintern2
	lsr
	asl
	asl
	clc
	adc backgroundstartyintern2 ; * 5
	sta bgyjumpin

	lda backgroundendyintern2
	lsr
	asl
	asl
	clc
	adc backgroundendyintern2 ; * 5
	sta bgyend

	lda doubleBuffer
	bne .zwo
	ldy bgyend
	lda #OPC_RTS
	sta BLITBACKGROUND2,y

	lda bgyjumpin
	clc
	adc #<BLITBACKGROUND2
	sta bgjumpin1 + 1
	sta bgjumpin2 + 1
	lda #>BLITBACKGROUND2
	adc #$00
	sta bgjumpin1 + 2
	sta bgjumpin2 + 2
	
	jsr blitbackgroundx

	ldy bgyend
	lda #OPC_LDA_I_ZY
	sta BLITBACKGROUND2,y
	rts
.zwo
	ldy bgyend
	lda #OPC_RTS
	sta BLITBACKGROUND1,y

	lda bgyjumpin
	clc
	adc #<BLITBACKGROUND1
	sta bgjumpin1 + 1
	sta bgjumpin2 + 1
	lda #>BLITBACKGROUND1
	adc #$00
	sta bgjumpin1 + 2
	sta bgjumpin2 + 2

	jsr blitbackgroundx

	ldy bgyend
	lda #OPC_LDA_I_ZY
	sta BLITBACKGROUND1,y
	rts

blitbackgroundx SUBROUTINE
	ldx #$00
	ldy #$00
bgjumpin1
	jsr $4444
	iny
	inx
bgjumpin2
	jsr $4444

	rts
*/
void exportBackground()
{
	const int backgroundXSize4 = 32;
	const int backgroundYSize = 64;

	FILE *out;

	out = fopen((globalOutputDirPrefix + "backgroundsetup.inc").c_str(),"w");
	fprintf(out,"BACKGROUNDXSIZE4 = %d\n",backgroundXSize4);
	fprintf(out,"BACKGROUNDYSIZE = %d\n",backgroundYSize);
	fprintf(out,"BGCOLORBYTE = %d\n",0);
	fclose(out);

	unsigned char background[backgroundXSize4*backgroundYSize];

	LoadPNG((globalWorkingDirPrefix + "background.png").c_str());

	for (int x = 0; x < backgroundXSize4; ++x)
	{
		for (int y = 0; y < backgroundYSize; ++y)
		{
			unsigned char c = 0;
			for (int x2 = 0; x2 < 4; ++x2)
			{
				int xp = x * 4 + x2;
				int yp = y;
				if (xp < pictureWidth && yp < pictureHeight)
				{
					unsigned char col = pictureS[xp + yp * pictureWidth];
					unsigned char p = (col & 255)*4 / 256;
					if (xp == 127) 
						p = 0;
					c |= p << (6-x2*2);
				}
			}
			background[x * backgroundYSize +y] = c; 
		}
	}


	out = fopen((globalOutputDirPrefix + "background.bin").c_str(),"wb");
	fwrite(background,1,backgroundXSize4*backgroundYSize,out);
	fclose(out);
}

void outputBitByte(FILE *out, unsigned char byte, int val)
{
	fprintf(out,"\tdc.b %%");
	for (int i = 7; i >= 0; --i)
	{
		fprintf(out,"%d",(byte>>i)&1);
	}
	fprintf(out,"; %d\n",val);
}

void exportColorBitmask()
{
	FILE *out = fopen((globalOutputDirPrefix + "colors.inc").c_str(),"wb");

#define COLORCOUNT 16
	unsigned char color1[COLORCOUNT];
	unsigned char color2[COLORCOUNT];

	for (int  i = 0; i < COLORCOUNT; ++i)
	{
		color1[i] = 0;
		color2[i] = 0;
		for (int x = 0; x < 4; ++x)
		{
			int p;
			p = (i*4+((x) & 1)*COLORCOUNT/2) / COLORCOUNT; 
			if (p > 3)
				p = 3;
			if (p < 0)
				p = 0;
			color1[i] |= p << (6-x*2);
			p = (i*4+4+((x+1) & 1)*COLORCOUNT/2) / COLORCOUNT; 
			if (p > 3)
				p = 3;
			if (p < 0)
				p = 0;
			color2[i] |= p << (6-x*2);
		}
	}
	fprintf(out,"COLORBITMASK\n");
	for (int k = 0; k < 1; ++k)
	{
		// we have just one dither :)
		fprintf(out,";----- DITHER%d\n",k);
		for (int  i = 0; i < COLORCOUNT; ++i)
		{
			fprintf(out,"; COL%d\n",i);
			int col1 = color1[i];
			int col2 = color2[i];
			for (int x = 0; x < 4; ++x)
			{
				int p =  col1 & (3<<(6-x*2));
				outputBitByte(out,p,i);
			}
			fprintf(out,"\n");
			for (int x = 0; x < 4; ++x)
			{
				int p = col2 & (3<<(6-x*2));
				outputBitByte(out,p,i);
			}
			fprintf(out,"\n");
		}
	}	

	fprintf(out,"\n");
	fprintf(out,"COLORBITMASKFULL1\n");
	for (int i = 0; i < COLORCOUNT; ++i)
	{
		outputBitByte(out,color1[i],i);
	}
	fprintf(out,"\n");
	fprintf(out,"COLORBITMASKFULL2\n");
	for (int i = 0; i < COLORCOUNT; ++i)
	{
		outputBitByte(out,color2[i],i);
	}
	fclose(out);
}

void convertTextFont()
{
	int fontCharCount = 32 * 3;
	LoadPNG((globalWorkingDirPrefix + "gamefont.png").c_str());
	FILE *out = fopen((globalOutputDirPrefix + "endfont.bin").c_str(),"wb");
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
				if (!((pix & 255) > 100)) // invert
					c |= 1 << (7-x);
			}
			fwrite(&c,1,1,out);
		}
	}
	fclose(out);
}

char *text2[] = {
	"                                        ",
	"    As Kate approached the portal a     ",
	"    frisky sound emerged from the       ",
	"    device.                             ",
	"                                        ",
	"    She went into the slipstream and    ",
	"    realized that Zordan was next       ",
	"    to her in the vortex.               ",
	"                                        ",
	"    A big blue gate opened before       ",
	"    her eyes. A big spaceship was       ",
	"    standing there.                     ",
	"                                        ",
	"    Zordan says that they both now will ",
	"    fly to the planet of the ancients   ",
	"    in order to save Zador.             ",
	"                                        ",
	"    Katy steps into one of the ships    ",
	"    and a deep rumble shaked her body.  ",
	"                                        ",
	"    The countdown goes                  ",
	"    10, 9, 8, 7, 6 ...                  ",
	"                                        ",
	"                                        ",
	NULL,
	NULL
};

char *text[] = {
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"       Is this really the end?          ",
	"   Did the gate lead to the starships?  ",
	"                                        ",
	"       You hear a countdown....         ",
	"                                        ",
	"            10,9,8,7,6,...              ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	"                                        ",
	NULL,
	NULL
};


void exportTextScreen(char *textScreen[],std::string fileName)
{
	char *textRemap = " !\"#$\%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_äabcdefghijklmnopqrstuvwxyzö|üÖÄ";

	int baseChar = 0;

	char *currentLineText = NULL;
	int currentLine = 0;
	int currentText = 0;

	FILE *out = fopen((globalOutputDirPrefix + fileName).c_str(),"w");
	std::vector<int> nextScreens;
	do
	{
		int lineCount = currentLine;
		do
		{
			lineCount++;
		} while (textScreen[lineCount] != NULL);
		lineCount-=currentLine;

		do
		{
			currentLineText = textScreen[currentLine];
			char writeOut[40];
			for (int i = 0; i < 40; ++i)
				writeOut[i] = baseChar; // space

			int j = 0;
			while(currentLineText[j] != NULL && j < 40)
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
			for (int i = 1; i < 40; ++i)
				fprintf(out,",%d",writeOut[i]);
			fprintf(out,"; One Line\n");

			currentLine++;
		} while (textScreen[currentLine] != NULL);

		currentText++;
		currentLine++;

	} while(textScreen[currentLine] != NULL);
	fclose(out);
}

unsigned char charsetX[2048];
#define CONVPICXSIZE (320/8)
#define CONVPICYSIZE (200/8)

int convertCharPics(std::vector<std::string> &fileNames)
{
	unsigned char *screenX = new unsigned char[CONVPICXSIZE*CONVPICYSIZE*fileNames.size()];

	int current = 0;

	for (int i = 8; i < 256 * 8; ++i) charsetX[i] = 0;
	for (int i = 0; i < CONVPICXSIZE*CONVPICYSIZE*fileNames.size(); ++i) screenX[i] = current;

	for (int q = 0; q < fileNames.size(); ++q)
	{
		LoadPNG(fileNames[q].c_str());
	
		int comp[8];

		for (int y = 0; y < CONVPICYSIZE; ++y)
		for (int x = 0; x < CONVPICXSIZE; ++x)
		{
			for (int y2 = 0; y2 < 8; ++y2)
			{
				comp[y2] = 0;		
				for (int x2 = 0; x2 < 8; x2++)
				{
					int pixel = 0;
					int ypos = y*8+y2;
					int xpos = x*8+x2;
					if ((ypos >= 0) && (ypos < pictureHeight) && (xpos >= 0) && (xpos < pictureWidth))
					{
						int rgb = pictureS[xpos+ypos*pictureWidth];
						int r = (rgb >> 0) & 255;
						int g = (rgb >> 8) & 255;
						int b = (rgb >> 16) & 255;
						int grey = (r + g + b) / 3;
						pixel = grey >= 100 ? 1 : 0;
					}
					comp[y2] |= pixel << (7-x2);
				}
			}
	
			int screenPos = x  + y * CONVPICXSIZE + q * CONVPICYSIZE * CONVPICXSIZE;

			int found = -1;
			for (int k = 0; k < screenPos; ++k)
			{
				int c = screenX[k] & 255;
			
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
				screenX[screenPos] = found & 255;
			else
			{
				if (current >= 256)
					current = 255;
				for (int i = 0; i < 8; ++i)
				{
					charsetX[current*8+i] = comp[i] ^ 0xff;
				}
				screenX[screenPos] = current;	
				current++;
			}
		}
		Log("charCountForPicture:%s->%d",fileNames[q].c_str(),current);
	}

	int charCount = current;

	for (int i = 0; i < fileNames.size(); ++i)
	{
		char fileNameScreen[1000];
		sprintf(fileNameScreen,"finScreen%04d.bin",i);
		FILE *out = fopen((globalOutputDirPrefix + fileNameScreen).c_str(),"wb");
		fwrite(&screenX[i * CONVPICYSIZE * CONVPICXSIZE],CONVPICYSIZE,CONVPICXSIZE,out);
		fclose(out);
	}

	FILE *out = fopen((globalOutputDirPrefix + "finCharset.bin").c_str(),"wb");
	fwrite(charsetX,current,8,out);
	fclose(out);

	return current;
}

void convert3DScene()
{
	FILE *out = fopen((globalOutputDirPrefix + "frames.inc").c_str(),"w");
	exportedByteCount = 0;
	overallFrameCount = 0;
	
	exportAnimation(out,335,0.f,3.f);
		
	fprintf(out,"\tdc.b $ff ; animation end ; frames %d\n",overallFrameCount);
	exportedByteCount++;
	fclose(out);
	Log("ByteCount: %d, BytesLeft: %d, Frames:%d\n",exportedByteCount, 0xfcf0 - 0xa000 - exportedByteCount,overallFrameCount);
}

int alreadyConverted = 0;
unsigned char *screenX;
void convertOneOutroShips(std::vector<std::string> fileNames)
{
	screenX = new unsigned char[CONVPICXSIZE*CONVPICYSIZE*fileNames.size()];

	int current = alreadyConverted;

	for (int i = 8; i < 256 * 8; ++i) charsetX[i] = 0;
	for (int i = 0; i < CONVPICXSIZE*CONVPICYSIZE*fileNames.size(); ++i) screenX[i] = current;

	for (int q = 0; q < fileNames.size(); ++q)
	{
		LoadPNG(fileNames[q].c_str());
	
		int comp[8];

		for (int y = 0; y < CONVPICYSIZE; ++y)
		for (int x = 0; x < CONVPICXSIZE; ++x)
		{
			for (int y2 = 0; y2 < 8; ++y2)
			{
				comp[y2] = 0;		
				for (int x2 = 0; x2 < 8; x2+=2)
				{
					int pixel = 0;
					int ypos = y*8+y2;
					int xpos = x*8+x2;
					if ((ypos >= 0) && (ypos < pictureHeight) && (xpos >= 0) && (xpos < pictureWidth))
					{
						int rgb = pictureS[xpos+ypos*pictureWidth];
						int r = (rgb >> 0) & 255;
						int g = (rgb >> 8) & 255;
						int b = (rgb >> 16) & 255;
						int grey = (r + g + b) / 3;
						pixel = grey * 6 / 255;
					}
					if (pixel > 3) pixel = 3;
					if (pixel < 0) pixel = 0;
					if (pixel == 3) 
						pixel = 0;
					else
					if (pixel == 0) 
						pixel = 3;

					comp[y2] |= pixel << (6-x2);
				}
			}
	
			int screenPos = x  + y * CONVPICXSIZE + q * CONVPICYSIZE * CONVPICXSIZE;

			int found = -1;
			for (int k = 0; k < screenPos; ++k)
			{
				int c = screenX[k] & 255;
			
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
				screenX[screenPos] = found & 255;
			else
			{
				if (current >= 256)
					current = 255;
				for (int i = 0; i < 8; ++i)
				{
					charsetX[current*8+i] = comp[i];
				}
				screenX[screenPos] = current;	
				current++;
			}
		}
		Log("charCountForPicture:%s->%d",fileNames[q].c_str(),current);
	}

	int charCount = current;

	alreadyConverted = current;
}

void outputByteArray(FILE *out,std::string name,unsigned char *arr, int len)
{
	fprintf(out,"\n%s\n",name.c_str());
	for (int i = 0; i < len; ++i)
	{
		if ((i & 15) == 0)
			fprintf(out,"\n\tdc.b %d",arr[i]);
		else
			fprintf(out,",%d",arr[i]);
	}

}

void convertOutroScene()
{
	std::vector<std::string> fileNames;
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/bigger/1bigger.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/bigger/2bigger.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/bigger/3bigger.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/bigger/4bigger.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/bigger/5bigger.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/bigger/6bigger.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/smaller/1smaller.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/smaller/2smaller.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/smaller/3smaller.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/smaller/4smaller.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/smaller/5smaller.png");
	fileNames.push_back(globalWorkingDirPrefix + "ending_ships/smaller/6smaller.png");
	convertOneOutroShips(fileNames);
	Log("%d charCount",alreadyConverted);
	FILE *out = fopen((globalOutputDirPrefix + "shipsCharset.bin").c_str(),"wb");
	fwrite(charsetX,alreadyConverted,8,out);
	fclose(out);
	
	for (int i = 0; i < 6; ++i)
	{
		char buffer[1000];
		sprintf(buffer,"%sbigship%d.scr",globalOutputDirPrefix.c_str(),i);
		int ysize = 4;
		int xsize = 9;
		out = fopen(buffer,"wb");
		for (int y = 0; y < ysize; ++y)
		{
			fwrite(&screenX[y*CONVPICXSIZE+i*CONVPICXSIZE*CONVPICYSIZE],1,xsize,out);
		}
		fclose(out);
	}

	for (int i = 0; i < 6; ++i)
	{
		char buffer[1000];
		sprintf(buffer,"%ssmallship%d.scr",globalOutputDirPrefix.c_str(),i);
		int ysize = 2;
		int xsize = 6;
		out = fopen(buffer,"wb");
		for (int y = 0; y < ysize; ++y)
		{
			fwrite(&screenX[y*CONVPICXSIZE+(i+6)*CONVPICXSIZE*CONVPICYSIZE],1,xsize,out);
		}
		fclose(out);
	}


	out = fopen((globalOutputDirPrefix + "starstuff.inc").c_str(),"w");
	const int starCount = 20;
	fprintf(out,"STARCOUNT = %d\n",starCount);
	unsigned char STARXLO[starCount];
	unsigned char STARXHI[starCount];
	unsigned char STARXLOSUB[starCount];
	unsigned char STARXHISUB[starCount];
	for (int i = 0; i < starCount; ++i)
	{
		int px = rand() % (256*39);
		int pxa = rand() % (256);
		STARXLO[i] = px & 255;
		STARXHI[i] = (px>>8) & 255;
		STARXLOSUB[i] = pxa & 255;
		STARXHISUB[i] = (pxa>>8) & 255;
	}
	outputByteArray(out,"STARXLO",STARXLO,starCount);
	outputByteArray(out,"STARXHI",STARXHI,starCount);
	outputByteArray(out,"STARXDISP",STARXHI,starCount);
	outputByteArray(out,"STARXLOSUB",STARXLOSUB,starCount);
	outputByteArray(out,"STARXHISUB",STARXHISUB,starCount);
	fclose(out);

	out = fopen((globalOutputDirPrefix + "starCharset.bin").c_str(),"wb");
	for (int y2 = 0; y2 < 8; ++y2)
	{
		for (int x = 0; x < 8; ++x)
		for (int y = 0; y < 8; ++y)
		{
			unsigned char c = 0x00;
			if (y == y2)
			{
				c |= (1 << (7-x));
			}
			c ^= 0xff;
			fwrite(&c,1,1,out);
		}
	}
	fclose(out);
}

void save()
{
}

void buildSceneForTime(float t)
{
	float treal = t;
	t *= 1.25f;
	t -= 0.25f;

	float tr = t;
	SCENE newScene;

	// translate the scene
	MATRIX rotateCam;
	rotateCam.setTranslate(0,0,1.5f);
	float fadeIn = 0.1;
	if (treal < fadeIn)
	{
		rotateCam.t.y = -10.f + treal / fadeIn * 10.f;
		rotateCam.t.z = -1.f + treal / fadeIn * 1.f;
	}

	float camAnimDistance = 0.985f;
	float t3 = 0.;
	if (treal > camAnimDistance)
	{
		float tc = treal-camAnimDistance;
		float tc2 = tc * tc;
		t -= sin(tc/2.25*PI) * 1.25f;
		t3 = tc2;
		rotateCam.t.z -= sin(tc/2.25*PI)*4.5;
		rotateCam.t.x -= sin(tc/2.25*PI*3.5f)*0.5;
		rotateCam.t.y -= cos(tc/2.25*PI*2.f)*3.5;
	}

	MATRIX rotateX;
	MATRIX rotateY;
	MATRIX rotateZ;
	MATRIX rotate;

	float t4 = t / (t3+1);
	rotate = mul33(mul33(getRotateXDeg(t4*40.f),mul33(mul33(mul33(mul33(mul33(getRotateYDeg(90.f),getRotateZDeg(180.f-90.f + t4 * 90.f)),getRotateYDeg(-45.f+t4*45)),getRotateXDeg(-60.f+t4*60)),getRotateXDeg(t*t*90.f*(1-t4))),
		getRotateXDeg(t4*t4*t4-40.f))),getRotateZDeg(180*(t4)*(1-t4)));


	double ts = 0.45f;
	double te = 1.f;

	double ti = 0.f;
	if (t > ts && t < te)
	{
		ti = (t-ts)/(te-ts);
		rotate = mul33(rotate,getRotateYDeg(ti*360.f*1.125f));
	}

	double ks = 1.f;
	double ke = 0.2f;
	if (t < ke)
	{
		ks = t / ke;
	}

	float ya = 0.0;
	float sy = 0.8;
	if (t > sy)
	{	
		float t3 = (t - sy) / (1.0 - sy);
		ya =  -t3 * t3 * 10.f;
	}

	rotate.setTranslate(0.125f+sin(t*t*2.f*PI*1.75f)*t*t,-cos(t*2.f*PI)*t*t*2.f-t*t*2.f+sin(t*t*2.f)*0.75f+1.f-ks+ya,(t * t * t * 30.f-0.5f + t*3.f+ti*2.f)*0.5f);

	addLightwaveObjectToScene(newScene,rotate,"spacecraft2.obj",1.f);
	
	float fix1 = 10;

	MATRIX torus = getRotateZDeg(t*360.f+fix1);
	torus.setTranslate(0,-1+t,5.f-t*30.f);

	newScene.objects.push_back(buildTorus(torus,7,4,1.55f,2.f));

	for (int  i = 0; i < 7; ++i)
	{
		float ai = (float)i/7*2.f*PI;
		newScene.objects.push_back(buildCube(torus,0.125f,0.125f,5.f,1.8f*sin(ai),1.8*cos(ai),+6.f));
	}

	torus = getRotateZDeg(t*360.f+20.f+fix1);
	torus.setTranslate(0,-1+t,25.f-t*30.f);

	newScene.objects.push_back(buildTorus(torus,7,4,1.55f,2.f));

	torus = getRotateZDeg(t*360.f*2.f+40.f+fix1);
	torus.setTranslate(0,-1+t,70.f-t*80.f);

	float s = 4.4f;
	//newScene.objects.push_back(buildTorus(torus,8,4,1.55f+s,2.f+s));

	rotate = mul33(getRotateZDeg(t*40.f*8.f),getRotateXDeg(t*100.f*8.f));
	rotate.setTranslate(-3.f,-1.f-rotateCam.t.y*0.85,10.f-t*10.f-rotateCam.t.z*0.85);
	double l = 1.5f;
	double w = 0.05f;
	newScene.objects.push_back(buildCube(rotate,l,w,w));
	newScene.objects.push_back(buildCube(rotate,w,l,w));
	newScene.objects.push_back(buildCube(rotate,w,w,l));

	double ts2 = 0.5f;
	if (t > ts2)
	{
		t = (t - ts2) / (1.f-ts2);
		rotate = mul33(mul33(getRotateXDeg(t*40.f),mul33(mul33(mul33(mul33(mul33(getRotateYDeg(90.f),getRotateZDeg(180.f-90.f + t * 90.f)),getRotateYDeg(-45.f+t*45)),getRotateXDeg(-60.f+t*60)),getRotateXDeg(t*t*90.f*(1-t))),
			getRotateXDeg(t*t*t-40.f))),getRotateZDeg(180*(t)*(1-t)));
		rotate.setTranslate(0.125f+cos(t*t*2.f*PI*1.75f)*t*t,-sin(t*2.f*PI)*t*t*2.f-t*t*2.f+cos(t*t*2.f)*0.75f+ya,(t * t * t * 30.f-0.5f + t*3.f+ti*2.f)*0.5f);

		addLightwaveObjectToScene(newScene,rotate,"spacecraft2.obj",1.f);
	}

	// light the scene
	lightScene(newScene);

	newScene.cam.mat = rotateCam;

	scene = newScene;
}

void intro_init( void )
{	
	setupWithCommandLine();

	FILE *in = fopen((dataDirPrefix + "PLU4COLORS.bin").c_str(),"rb");
	fread(palette,1,1024,in);
	fclose(in);
	for (int i = 0; i < 256; ++i)
	palette[i] = ((palette[i] >> 16) & 255) + ((palette[i] & 0xff)<<16) + (palette[i] & 0xff00);
	frameCounter = 0;

	exportReziprokeTable();
	exportSinTables();
	//convert3DScene();
	exportBackground();
	exportColorBitmask();
	convertTextFont();
	exportTextScreen(text,"endtext.inc");

	std::vector<std::string> picNames;
	picNames.push_back(globalWorkingDirPrefix + "theEnd.png");
	convertCharPics(picNames);
	convertOutroScene();
}

void intro_do( unsigned int *buffer, long itime )
{ 
	float secs = (float)itime / 1000.f;
	int fps = 1;
	float frame = secs * 60.f / fps;
	int iFrame = (int)frame;
	static int lFrame = iFrame;

	clearCheckBuffer();

	if (playFrames.size() > 0)
	{
		int frameNumber = (int)(iFrame) % playFrames.size();
		for (int i = 0; i < playFrames[frameNumber].size(); ++i)
		{
			POLYGON2D poly = playFrames[frameNumber][i];
			drawPoly(poly.pointsTransformed,((poly.color)<<4)+3);
		}
	}

	for( int i=0; i<XRES*YRES; i++ )
	{
		int x = ((i % XRES)*CHECKX/XRES);
		int y = ((i / XRES)*CHECKY/YRES);
		buffer[i] = palette[screenBufferCheck[x+y*CHECKX] & 127];
	}

	frameCounter++;
	lFrame = iFrame;
}
