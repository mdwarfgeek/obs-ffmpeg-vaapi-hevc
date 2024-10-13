# Makefile for obs plugin

# apt install libavcodec-dev libavdevice-dev libavfilter-dev libavformat-dev libavutil-dev libobs-dev libpci-dev libva-dev

### Constants: edit to suit your system ###

# libav include and library paths
PKGS=libavcodec libavfilter libavformat libavutil libobs libpci libva libva-drm
ALL_INC?=`pkg-config $(PKGS) --cflags`
ALL_LIBS?=`pkg-config $(PKGS) --libs`

# C compiler
#CC=gcc

# Include paths
INC=-I../lib $(ALL_INC)

# Optimization flags

# DEBUG:
#OPT=-g

# OPT:
OPT=-O -fPIC

# Compiler flags
CFLAGS=-pthread -std=gnu99 $(OPT) -Wall $(INC) -DBUILDDIR=\"`pwd`\"

# Linker flags
LIBS=$(ALL_LIBS)

# Installer
INSTALL?=install

INSTPATH?=$(HOME)/.config/obs-studio/plugins/ffmpeg-vaapi-hevc/bin/64bit

### End constants section ###

SRCS=obs-ffmpeg-vaapi.c vaapi-utils.c
OBJS=${SRCS:%.c=%.o}

DEPEND_SRCS=$(SRCS)

# Rules for building

.SUFFIXES: .c .o

.c.o:
	$(CC) $(CFLAGS) -o $@ -c $<

all: ffmpeg-vaapi-hevc.so

install: ffmpeg-vaapi-hevc.so
	$(INSTALL) -d $(INSTPATH)
	$(INSTALL) -m 0755 ffmpeg-vaapi-hevc.so $(INSTPATH)

depend:
	$(CC) $(CFLAGS) -E -MM $(DEPEND_SRCS) > .depend

ffmpeg-vaapi-hevc.so: $(OBJS) $(LIB_OBJS)
	$(CC) -shared -o ffmpeg-vaapi-hevc.so $(OBJS) $(LIB_OBJS) $(LIBS)

clean:
	rm -f $(OBJS) ffmpeg-vaapi-hevc.so
	rm -f .depend
