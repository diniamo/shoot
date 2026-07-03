/* png.h - header file for PNG reference library
 *
 * libpng version 1.6.58
 *
 * Copyright (c) 2018-2026 Cosmin Truta
 * Copyright (c) 1998-2002,2004,2006-2018 Glenn Randers-Pehrson
 * Copyright (c) 1996-1997 Andreas Dilger
 * Copyright (c) 1995-1996 Guy Eric Schalnat, Group 42, Inc.
 *
 * This code is released under the libpng license. (See LICENSE, below.)
 *
 * Authors and maintainers:
 *   libpng versions 0.71, May 1995, through 0.88, January 1996: Guy Schalnat
 *   libpng versions 0.89, June 1996, through 0.96, May 1997: Andreas Dilger
 *   libpng versions 0.97, January 1998, through 1.6.35, July 2018:
 *     Glenn Randers-Pehrson
 *   libpng versions 1.6.36, December 2018, through 1.6.58, April 2026:
 *     Cosmin Truta
 *   See also "Contributing Authors", below.
 */

/*
 * COPYRIGHT NOTICE, DISCLAIMER, and LICENSE
 * =========================================
 *
 * PNG Reference Library License version 2
 * ---------------------------------------
 *
 *  * Copyright (c) 1995-2026 The PNG Reference Library Authors.
 *  * Copyright (c) 2018-2026 Cosmin Truta.
 *  * Copyright (c) 2000-2002, 2004, 2006-2018 Glenn Randers-Pehrson.
 *  * Copyright (c) 1996-1997 Andreas Dilger.
 *  * Copyright (c) 1995-1996 Guy Eric Schalnat, Group 42, Inc.
 *
 * The software is supplied "as is", without warranty of any kind,
 * express or implied, including, without limitation, the warranties
 * of merchantability, fitness for a particular purpose, title, and
 * non-infringement.  In no event shall the Copyright owners, or
 * anyone distributing the software, be liable for any damages or
 * other liability, whether in contract, tort or otherwise, arising
 * from, out of, or in connection with the software, or the use or
 * other dealings in the software, even if advised of the possibility
 * of such damage.
 *
 * Permission is hereby granted to use, copy, modify, and distribute
 * this software, or portions hereof, for any purpose, without fee,
 * subject to the following restrictions:
 *
 *  1. The origin of this software must not be misrepresented; you
 *     must not claim that you wrote the original software.  If you
 *     use this software in a product, an acknowledgment in the product
 *     documentation would be appreciated, but is not required.
 *
 *  2. Altered source versions must be plainly marked as such, and must
 *     not be misrepresented as being the original software.
 *
 *  3. This Copyright notice may not be removed or altered from any
 *     source or altered source distribution.
 *
 *
 * PNG Reference Library License version 1 (for libpng 0.5 through 1.6.35)
 * -----------------------------------------------------------------------
 *
 * libpng versions 1.0.7, July 1, 2000, through 1.6.35, July 15, 2018 are
 * Copyright (c) 2000-2002, 2004, 2006-2018 Glenn Randers-Pehrson, are
 * derived from libpng-1.0.6, and are distributed according to the same
 * disclaimer and license as libpng-1.0.6 with the following individuals
 * added to the list of Contributing Authors:
 *
 *     Simon-Pierre Cadieux
 *     Eric S. Raymond
 *     Mans Rullgard
 *     Cosmin Truta
 *     Gilles Vollant
 *     James Yu
 *     Mandar Sahastrabuddhe
 *     Google Inc.
 *     Vadim Barkov
 *
 * and with the following additions to the disclaimer:
 *
 *     There is no warranty against interference with your enjoyment of
 *     the library or against infringement.  There is no warranty that our
 *     efforts or the library will fulfill any of your particular purposes
 *     or needs.  This library is provided with all faults, and the entire
 *     risk of satisfactory quality, performance, accuracy, and effort is
 *     with the user.
 *
 * Some files in the "contrib" directory and some configure-generated
 * files that are distributed with libpng have other copyright owners, and
 * are released under other open source licenses.
 *
 * libpng versions 0.97, January 1998, through 1.0.6, March 20, 2000, are
 * Copyright (c) 1998-2000 Glenn Randers-Pehrson, are derived from
 * libpng-0.96, and are distributed according to the same disclaimer and
 * license as libpng-0.96, with the following individuals added to the
 * list of Contributing Authors:
 *
 *     Tom Lane
 *     Glenn Randers-Pehrson
 *     Willem van Schaik
 *
 * libpng versions 0.89, June 1996, through 0.96, May 1997, are
 * Copyright (c) 1996-1997 Andreas Dilger, are derived from libpng-0.88,
 * and are distributed according to the same disclaimer and license as
 * libpng-0.88, with the following individuals added to the list of
 * Contributing Authors:
 *
 *     John Bowler
 *     Kevin Bracey
 *     Sam Bushell
 *     Magnus Holmgren
 *     Greg Roelofs
 *     Tom Tanner
 *
 * Some files in the "scripts" directory have other copyright owners,
 * but are released under this license.
 *
 * libpng versions 0.5, May 1995, through 0.88, January 1996, are
 * Copyright (c) 1995-1996 Guy Eric Schalnat, Group 42, Inc.
 *
 * For the purposes of this copyright and license, "Contributing Authors"
 * is defined as the following set of individuals:
 *
 *     Andreas Dilger
 *     Dave Martindale
 *     Guy Eric Schalnat
 *     Paul Schmidt
 *     Tim Wegner
 *
 * The PNG Reference Library is supplied "AS IS".  The Contributing
 * Authors and Group 42, Inc. disclaim all warranties, expressed or
 * implied, including, without limitation, the warranties of
 * merchantability and of fitness for any purpose.  The Contributing
 * Authors and Group 42, Inc. assume no liability for direct, indirect,
 * incidental, special, exemplary, or consequential damages, which may
 * result from the use of the PNG Reference Library, even if advised of
 * the possibility of such damage.
 *
 * Permission is hereby granted to use, copy, modify, and distribute this
 * source code, or portions hereof, for any purpose, without fee, subject
 * to the following restrictions:
 *
 *  1. The origin of this source code must not be misrepresented.
 *
 *  2. Altered versions must be plainly marked as such and must not
 *     be misrepresented as being the original source.
 *
 *  3. This Copyright notice may not be removed or altered from any
 *     source or altered source distribution.
 *
 * The Contributing Authors and Group 42, Inc. specifically permit,
 * without fee, and encourage the use of this source code as a component
 * to supporting the PNG file format in commercial products.  If you use
 * this source code in a product, acknowledgment is not required but would
 * be appreciated.
 *
 * END OF COPYRIGHT NOTICE, DISCLAIMER, and LICENSE.
 *
 * TRADEMARK
 * =========
 *
 * The name "libpng" has not been registered by the Copyright owners
 * as a trademark in any jurisdiction.  However, because libpng has
 * been distributed and maintained world-wide, continually since 1995,
 * the Copyright owners claim "common-law trademark protection" in any
 * jurisdiction where common-law trademark is recognized.
 */

/*
 * A "png_get_copyright" function is available, for convenient use in "about"
 * boxes and the like:
 *
 *    printf("%s", png_get_copyright(NULL));
 *
 * Also, the PNG logo (in PNG format, of course) is supplied in the
 * files "pngbar.png" and "pngbar.jpg (88x31) and "pngnow.png" (98x31).
 */

/*
 * The contributing authors would like to thank all those who helped
 * with testing, bug fixes, and patience.  This wouldn't have been
 * possible without all of you.
 *
 * Thanks to Frank J. T. Wojcik for helping with the documentation.
 */

/* Note about libpng version numbers:
 *
 *    Due to various miscommunications, unforeseen code incompatibilities
 *    and occasional factors outside the authors' control, version numbering
 *    on the library has not always been consistent and straightforward.
 *    The following table summarizes matters since version 0.89c, which was
 *    the first widely used release:
 *
 *    source                 png.h  png.h  shared-lib
 *    version                string   int  version
 *    -------                ------ -----  ----------
 *    0.89c "1.0 beta 3"     0.89      89  1.0.89
 *    0.90  "1.0 beta 4"     0.90      90  0.90  [should have been 2.0.90]
 *    0.95  "1.0 beta 5"     0.95      95  0.95  [should have been 2.0.95]
 *    0.96  "1.0 beta 6"     0.96      96  0.96  [should have been 2.0.96]
 *    0.97b "1.00.97 beta 7" 1.00.97   97  1.0.1 [should have been 2.0.97]
 *    0.97c                  0.97      97  2.0.97
 *    0.98                   0.98      98  2.0.98
 *    0.99                   0.99      98  2.0.99
 *    0.99a-m                0.99      99  2.0.99
 *    1.00                   1.00     100  2.1.0 [100 should be 10000]
 *    1.0.0      (from here on, the   100  2.1.0 [100 should be 10000]
 *    1.0.1       png.h string is   10001  2.1.0
 *    1.0.1a-e    identical to the  10002  from here on, the shared library
 *    1.0.2       source version)   10002  is 2.V where V is the source code
 *    1.0.2a-b                      10003  version, except as noted.
 *    1.0.3                         10003
 *    1.0.3a-d                      10004
 *    1.0.4                         10004
 *    1.0.4a-f                      10005
 *    1.0.5 (+ 2 patches)           10005
 *    1.0.5a-d                      10006
 *    1.0.5e-r                      10100 (not source compatible)
 *    1.0.5s-v                      10006 (not binary compatible)
 *    1.0.6 (+ 3 patches)           10006 (still binary incompatible)
 *    1.0.6d-f                      10007 (still binary incompatible)
 *    1.0.6g                        10007
 *    1.0.6h                        10007  10.6h (testing xy.z so-numbering)
 *    1.0.6i                        10007  10.6i
 *    1.0.6j                        10007  2.1.0.6j (incompatible with 1.0.0)
 *    1.0.7beta11-14        DLLNUM  10007  2.1.0.7beta11-14 (binary compatible)
 *    1.0.7beta15-18           1    10007  2.1.0.7beta15-18 (binary compatible)
 *    1.0.7rc1-2               1    10007  2.1.0.7rc1-2 (binary compatible)
 *    1.0.7                    1    10007  (still compatible)
 *    ...
 *    1.0.69                  10    10069  10.so.0.69[.0]
 *    ...
 *    1.2.59                  13    10259  12.so.0.59[.0]
 *    ...
 *    1.4.20                  14    10420  14.so.0.20[.0]
 *    ...
 *    1.5.30                  15    10530  15.so.15.30[.0]
 *    ...
 *    1.6.58                  16    10658  16.so.16.58[.0]
 *
 *    Henceforth the source version will match the shared-library major and
 *    minor numbers; the shared-library major version number will be used for
 *    changes in backward compatibility, as it is intended.
 *    The PNG_LIBPNG_VER macro, which is not used within libpng but is
 *    available for applications, is an unsigned integer of the form XYYZZ
 *    corresponding to the source version X.Y.Z (leading zeros in Y and Z).
 *    Beta versions were given the previous public release number plus a
 *    letter, until version 1.0.6j; from then on they were given the upcoming
 *    public release number plus "betaNN" or "rcNN".
 *
 *    Binary incompatibility exists only when applications make direct access
 *    to the info_ptr or png_ptr members through png.h, and the compiled
 *    application is loaded with a different version of the library.
 *
 * See libpng.txt or libpng.3 for more information.  The PNG specification
 * is available as a W3C Recommendation and as an ISO/IEC Standard; see
 * <https://www.w3.org/TR/2003/REC-PNG-20031110/>
 */
package png

import "core:c/libc"
import "core:c"

foreign import lib "system:png"
_ :: lib

/* This is not the place to learn how to use libpng. The file libpng-manual.txt
* describes how to use libpng, and the file example.c summarizes it
* with some code on which to build.  This file is useful for looking
* at the actual function definitions and structure components.  If that
* file has been stripped from your copy of libpng, you can find it at
* <http://www.libpng.org/pub/png/libpng-manual.txt>
*
* If you just need to read a PNG file and don't want to read the documentation
* skip to the end of this file and read the section entitled 'simplified API'.
*/

/* Version information for png.h - this should match the version in png.c */
LIBPNG_VER_STRING     :: "1.6.58"
HEADER_VERSION_STRING :: " libpng version " + LIBPNG_VER_STRING + "\n"

/* The versions of shared library builds should stay in sync, going forward */
LIBPNG_VER_SHAREDLIB :: 16
LIBPNG_VER_SONUM     :: LIBPNG_VER_SHAREDLIB /* [Deprecated] */
LIBPNG_VER_DLLNUM    :: LIBPNG_VER_SHAREDLIB /* [Deprecated] */

/* These should match the first 3 components of PNG_LIBPNG_VER_STRING: */
LIBPNG_VER_MAJOR   :: 1
LIBPNG_VER_MINOR   :: 6
LIBPNG_VER_RELEASE :: 58

/* This should be zero for a public release, or non-zero for a
* development version.
*/
LIBPNG_VER_BUILD :: 0

/* Release Status */
LIBPNG_BUILD_ALPHA               :: 1
LIBPNG_BUILD_BETA                :: 2
LIBPNG_BUILD_RC                  :: 3
LIBPNG_BUILD_STABLE              :: 4
LIBPNG_BUILD_RELEASE_STATUS_MASK :: 7

/* Release-Specific Flags */
LIBPNG_BUILD_PATCH     :: 8  /* Can be OR'ed with
                                       PNG_LIBPNG_BUILD_STABLE only */
LIBPNG_BUILD_PRIVATE   :: 16 /* Cannot be OR'ed with
                                       PNG_LIBPNG_BUILD_SPECIAL */
LIBPNG_BUILD_SPECIAL   :: 32 /* Cannot be OR'ed with
                                       PNG_LIBPNG_BUILD_PRIVATE */
LIBPNG_BUILD_BASE_TYPE :: LIBPNG_BUILD_STABLE

/* Careful here.  At one time, Guy wanted to use 082, but that
* would be octal.  We must not include leading zeros.
* Versions 0.7 through 1.0.0 were in the range 0 to 100 here
* (only version 1.0.0 was mis-numbered 100 instead of 10000).
* From version 1.0.1 it is:
* XXYYZZ, where XX=major, YY=minor, ZZ=release
*/
LIBPNG_VER        :: 10658 /* 1.6.58 */
LIBPNG_BUILD_TYPE :: (LIBPNG_BUILD_BASE_TYPE)

/* This triggers a compiler error in png.c, if png.c and png.h
* do not agree upon the version number.
*/
Libpng_Version_1_6_58 :: cstring

/* Basic control structions.  Read libpng-manual.txt or libpng.3 for more info.
*
* png_struct is the cache of information used while reading or writing a single
* PNG file.  One of these is always required, although the simplified API
* (below) hides the creation and destruction of it.
*/
Struct        :: Struct_Def
Struct_Def    :: struct {}
Const_Structp :: ^Struct
Structp       :: ^Struct
Structpp      :: ^^Struct
Info_Def      :: struct {}

/* png_info contains information read from or to be written to a PNG file.  One
* or more of these must exist while reading or creating a PNG file.  The
* information is not used by libpng during read but is used to control what
* gets written when a PNG file is created.  "png_get_" function calls read
* information during read and "png_set_" functions calls write information
* when creating a PNG.
* been moved into a separate header file that is not accessible to
* applications.  Read libpng-manual.txt or libpng.3 for more info.
*/
Info        :: Info_Def
Infop       :: ^Info
Const_Infop :: ^Info
Infopp      :: ^^Info

/* Types with names ending 'p' are pointer types.  The corresponding types with
* names ending 'rp' are identical pointer types except that the pointer is
* marked 'restrict', which means that it is the only pointer to the object
* passed to the function.  Applications should not use the 'restrict' types;
* it is always valid to pass 'p' to a pointer with a function argument of the
* corresponding 'rp' type.  Different compilers have different rules with
* regard to type matching in the presence of 'restrict'.  For backward
* compatibility libpng callbacks never have 'restrict' in their parameters and,
* consequentially, writing portable application code is extremely difficult if
* an attempt is made to use 'restrict'.
*/
Structrp       :: ^Struct
Const_Structrp :: ^Struct
Inforp         :: ^Info
Const_Inforp   :: ^Info

/* Three color definitions.  The order of the red, green, and blue, (and the
* exact size) is not important, although the size of the fields need to
* be png_byte or png_uint_16 (as defined below).
*/
Color_Struct :: struct {
	red:   Byte,
	green: Byte,
	blue:  Byte,
}

/* Three color definitions.  The order of the red, green, and blue, (and the
* exact size) is not important, although the size of the fields need to
* be png_byte or png_uint_16 (as defined below).
*/
Color        :: Color_Struct
Colorp       :: ^Color
Const_Colorp :: ^Color
Colorpp      :: ^^Color

Color_16_Struct :: struct {
	index: Byte,    /* used for palette files */
	red:   Uint_16, /* for use in red green blue files */
	green: Uint_16,
	blue:  Uint_16,
	gray:  Uint_16, /* for use in grayscale files */
}

Color_16        :: Color_16_Struct
Color_16p       :: ^Color_16
Const_Color_16p :: ^Color_16
Color_16pp      :: ^^Color_16

Color_8_Struct :: struct {
	red:   Byte, /* for use in red green blue files */
	green: Byte,
	blue:  Byte,
	gray:  Byte, /* for use in grayscale files */
	alpha: Byte, /* for alpha channel files */
}

Color_8        :: Color_8_Struct
Color_8p       :: ^Color_8
Const_Color_8p :: ^Color_8
Color_8pp      :: ^^Color_8

/*
* The following two structures are used for the in-core representation
* of sPLT chunks.
*/
S_Plt_Entry_Struct :: struct {
	red:       Uint_16,
	green:     Uint_16,
	blue:      Uint_16,
	alpha:     Uint_16,
	frequency: Uint_16,
}

/*
* The following two structures are used for the in-core representation
* of sPLT chunks.
*/
S_Plt_Entry        :: S_Plt_Entry_Struct
S_Plt_Entryp       :: ^S_Plt_Entry
Const_S_Plt_Entryp :: ^S_Plt_Entry
S_Plt_Entrypp      :: ^^S_Plt_Entry

/*  When the depth of the sPLT palette is 8 bits, the color and alpha samples
*  occupy the LSB of their respective members, and the MSB of each member
*  is zero-filled.  The frequency member always occupies the full 16 bits.
*/
S_Plt_Struct :: struct {
	name:     Charp,        /* palette name */
	depth:    Byte,         /* depth of palette samples */
	entries:  S_Plt_Entryp, /* palette entries */
	nentries: Int_32,       /* number of palette entries */
}

/*  When the depth of the sPLT palette is 8 bits, the color and alpha samples
*  occupy the LSB of their respective members, and the MSB of each member
*  is zero-filled.  The frequency member always occupies the full 16 bits.
*/
S_Plt_T        :: S_Plt_Struct
S_Plt_Tp       :: ^S_Plt_T
Const_S_Plt_Tp :: ^S_Plt_T
S_Plt_Tpp      :: ^^S_Plt_T

/* png_text holds the contents of a text/ztxt/itxt chunk in a PNG file,
* and whether that contents is compressed or not.  The "key" field
* points to a regular zero-terminated C string.  The "text" fields can be a
* regular C string, an empty string, or a NULL pointer.
* However, the structure returned by png_get_text() will always contain
* the "text" field as a regular zero-terminated C string (possibly
* empty), never a NULL pointer, so it can be safely used in printf() and
* other string-handling functions.  Note that the "itxt_length", "lang", and
* "lang_key" members of the structure only exist when the library is built
* with iTXt chunk support.  Prior to libpng-1.4.0 the library was built by
* default without iTXt support. Also note that when iTXt *is* supported,
* the "lang" and "lang_key" fields contain NULL pointers when the
* "compression" field contains * PNG_TEXT_COMPRESSION_NONE or
* PNG_TEXT_COMPRESSION_zTXt. Note that the "compression value" is not the
* same as what appears in the PNG tEXt/zTXt/iTXt chunk's "compression flag"
* which is always 0 or 1, or its "compression method" which is always 0.
*/
Text_Struct :: struct {
	compression: i32,      /* compression value:
                             -1: tEXt, none
                              0: zTXt, deflate
                              1: iTXt, none
                              2: iTXt, deflate  */
	key:         Charp,    /* keyword, 1-79 character description of "text" */
	text:        Charp,    /* comment, may be an empty string (ie "")
                              or a NULL pointer */
	text_length: c.size_t, /* length of the text string */
	itxt_length: c.size_t, /* length of the itxt string */
	lang:        Charp,    /* language code, 0-79 characters
                              or a NULL pointer */
	lang_key:    Charp,    /* keyword translated UTF-8 string, 0 or more
                              chars or a NULL pointer */
}

/* png_text holds the contents of a text/ztxt/itxt chunk in a PNG file,
* and whether that contents is compressed or not.  The "key" field
* points to a regular zero-terminated C string.  The "text" fields can be a
* regular C string, an empty string, or a NULL pointer.
* However, the structure returned by png_get_text() will always contain
* the "text" field as a regular zero-terminated C string (possibly
* empty), never a NULL pointer, so it can be safely used in printf() and
* other string-handling functions.  Note that the "itxt_length", "lang", and
* "lang_key" members of the structure only exist when the library is built
* with iTXt chunk support.  Prior to libpng-1.4.0 the library was built by
* default without iTXt support. Also note that when iTXt *is* supported,
* the "lang" and "lang_key" fields contain NULL pointers when the
* "compression" field contains * PNG_TEXT_COMPRESSION_NONE or
* PNG_TEXT_COMPRESSION_zTXt. Note that the "compression value" is not the
* same as what appears in the PNG tEXt/zTXt/iTXt chunk's "compression flag"
* which is always 0 or 1, or its "compression method" which is always 0.
*/
Text        :: Text_Struct
Textp       :: ^Text
Const_Textp :: ^Text
Textpp      :: ^^Text

/* Supported compression types for text in PNG files (tEXt, and zTXt).
* The values of the PNG_TEXT_COMPRESSION_ defines should NOT be changed. */
TEXT_COMPRESSION_NONE_WR :: -3
TEXT_COMPRESSION_zTXt_WR :: -2
TEXT_COMPRESSION_NONE    :: -1
TEXT_COMPRESSION_zTXt     :: 0
ITXT_COMPRESSION_NONE     :: 1
ITXT_COMPRESSION_zTXt     :: 2
TEXT_COMPRESSION_LAST     :: 3  /* Not a valid value */

/* png_time is a way to hold the time in an machine independent way.
* Two conversions are provided, both from time_t and struct tm.  There
* is no portable way to convert to either of these structures, as far
* as I know.  If you know of a portable way, send it to me.  As a side
* note - PNG has always been Year 2000 compliant!
*/
Time_Struct :: struct {
	year:   Uint_16, /* full year, as in, 1995 */
	month:  Byte,    /* month of year, 1 - 12 */
	day:    Byte,    /* day of month, 1 - 31 */
	hour:   Byte,    /* hour of day, 0 - 23 */
	minute: Byte,    /* minute of hour, 0 - 59 */
	second: Byte,    /* second of minute, 0 - 60 (for leap seconds) */
}

/* png_time is a way to hold the time in an machine independent way.
* Two conversions are provided, both from time_t and struct tm.  There
* is no portable way to convert to either of these structures, as far
* as I know.  If you know of a portable way, send it to me.  As a side
* note - PNG has always been Year 2000 compliant!
*/
Time        :: Time_Struct
Timep       :: ^Time
Const_Timep :: ^Time
Timepp      :: ^^Time

/* png_unknown_chunk is a structure to hold queued chunks for which there is
* no specific support.  The idea is that we can use this to queue
* up private chunks for output even though the library doesn't actually
* know about their semantics.
*
* The data in the structure is set by libpng on read and used on write.
*/
Unknown_Chunk_T :: struct {
	name: [5]Byte, /* Textual chunk name with '\0' terminator */
	data: ^Byte,   /* Data, should not be modified on read! */
	size: c.size_t,

	/* On write 'location' must be set using the flag values listed below.
	* Notice that on read it is set by libpng however the values stored have
	* more bits set than are listed below.  Always treat the value as a
	* bitmask.  On write set only one bit - setting multiple bits may cause the
	* chunk to be written in multiple places.
	*/
	location: Byte, /* mode of operation at read time */
}

/* png_unknown_chunk is a structure to hold queued chunks for which there is
* no specific support.  The idea is that we can use this to queue
* up private chunks for output even though the library doesn't actually
* know about their semantics.
*
* The data in the structure is set by libpng on read and used on write.
*/
Unknown_Chunk        :: Unknown_Chunk_T
Unknown_Chunkp       :: ^Unknown_Chunk
Const_Unknown_Chunkp :: ^Unknown_Chunk
Unknown_Chunkpp      :: ^^Unknown_Chunk

/* Flag values for the unknown chunk location byte. */
HAVE_IHDR  :: 0x01
HAVE_PLTE  :: 0x02
AFTER_IDAT :: 0x08
SIZE_MAX :: max(c.size_t)

/* These are constants for fixed point values encoded in the
* PNG specification manner (x100000)
*/
FP_1    :: 100000
FP_HALF  :: 50000

/* These describe the color_type field in png_info. */
/* color type masks */
COLOR_MASK_PALETTE    :: 1
COLOR_MASK_COLOR      :: 2
COLOR_MASK_ALPHA      :: 4

/* color types.  Note that not all combinations are legal */
COLOR_TYPE_GRAY       :: 0
COLOR_TYPE_PALETTE    :: (COLOR_MASK_COLOR|COLOR_MASK_PALETTE)
COLOR_TYPE_RGB        :: (COLOR_MASK_COLOR)
COLOR_TYPE_RGB_ALPHA  :: (COLOR_MASK_COLOR|COLOR_MASK_ALPHA)
COLOR_TYPE_GRAY_ALPHA :: (COLOR_MASK_ALPHA)

/* aliases */
COLOR_TYPE_RGBA  :: COLOR_TYPE_RGB_ALPHA
COLOR_TYPE_GA   :: COLOR_TYPE_GRAY_ALPHA

/* This is for compression type. PNG 1.0-1.2 only define the single type. */
COMPRESSION_TYPE_BASE    :: 0 /* Deflate method 8, 32K window */
COMPRESSION_TYPE_DEFAULT :: COMPRESSION_TYPE_BASE

/* This is for filter type. PNG 1.0-1.2 only define the single type. */
FILTER_TYPE_BASE        :: 0  /* Single row per-byte filtering */
INTRAPIXEL_DIFFERENCING :: 64 /* Used only in MNG datastreams */
FILTER_TYPE_DEFAULT     :: FILTER_TYPE_BASE

/* These are for the interlacing type.  These values should NOT be changed. */
INTERLACE_NONE        :: 0 /* Non-interlaced image */
INTERLACE_ADAM7       :: 1 /* Adam7 interlacing */
INTERLACE_LAST        :: 2 /* Not a valid value */

/* These are for the oFFs chunk.  These values should NOT be changed. */
OFFSET_PIXEL          :: 0 /* Offset in pixels */
OFFSET_MICROMETER     :: 1 /* Offset in micrometers (1/10^6 meter) */
OFFSET_LAST           :: 2 /* Not a valid value */

/* These are for the pCAL chunk.  These values should NOT be changed. */
EQUATION_LINEAR       :: 0 /* Linear transformation */
EQUATION_BASE_E       :: 1 /* Exponential base e transform */
EQUATION_ARBITRARY    :: 2 /* Arbitrary base exponential transform */
EQUATION_HYPERBOLIC   :: 3 /* Hyperbolic sine transformation */
EQUATION_LAST         :: 4 /* Not a valid value */

/* These are for the sCAL chunk.  These values should NOT be changed. */
SCALE_UNKNOWN         :: 0 /* unknown unit (image scale) */
SCALE_METER           :: 1 /* meters per pixel */
SCALE_RADIAN          :: 2 /* radians per pixel */
SCALE_LAST            :: 3 /* Not a valid value */

/* These are for the pHYs chunk.  These values should NOT be changed. */
RESOLUTION_UNKNOWN    :: 0 /* pixels/unknown unit (aspect ratio) */
RESOLUTION_METER      :: 1 /* pixels/meter */
RESOLUTION_LAST       :: 2 /* Not a valid value */

/* These are for the sRGB chunk.  These values should NOT be changed. */
sRGB_INTENT_PERCEPTUAL :: 0
sRGB_INTENT_RELATIVE   :: 1
sRGB_INTENT_SATURATION :: 2
sRGB_INTENT_ABSOLUTE   :: 3
sRGB_INTENT_LAST       :: 4 /* Not a valid value */

/* This is for text chunks */
KEYWORD_MAX_LENGTH     :: 79

/* Maximum number of entries in PLTE/sPLT/tRNS arrays */
MAX_PALETTE_LENGTH    :: 256

/* These determine if an ancillary chunk's data has been successfully read
* from the PNG header, or if the application has filled in the corresponding
* data in the info_struct to be written into the output file.  The values
* of the PNG_INFO_<chunk> defines should NOT be changed.
*/
INFO_gAMA :: 0x0001
INFO_sBIT :: 0x0002
INFO_cHRM :: 0x0004
INFO_PLTE :: 0x0008
INFO_tRNS :: 0x0010
INFO_bKGD :: 0x0020
INFO_hIST :: 0x0040
INFO_pHYs :: 0x0080
INFO_oFFs :: 0x0100
INFO_tIME :: 0x0200
INFO_pCAL :: 0x0400
INFO_sRGB :: 0x0800  /* GR-P, 0.96a */
INFO_iCCP :: 0x1000  /* ESR, 1.0.6 */
INFO_sPLT :: 0x2000  /* ESR, 1.0.6 */
INFO_sCAL :: 0x4000  /* ESR, 1.0.6 */
INFO_IDAT :: 0x8000  /* ESR, 1.0.6 */
INFO_eXIf :: 0x10000 /* GR-P, 1.6.31 */
INFO_cICP :: 0x20000 /* PNGv3: 1.6.45 */
INFO_cLLI :: 0x40000 /* PNGv3: 1.6.45 */
INFO_mDCV :: 0x80000 /* PNGv3: 1.6.45 */

/* APNG: these chunks are stored as unknown, these flags are never set
* however they are provided as a convenience for implementors of APNG and
* avoids any merge conflicts.
*
* Private chunks: these chunk names violate the chunk name recommendations
* because the chunk definitions have no signature and because the private
* chunks with these names have been reserved.  Private definitions should
* avoid them.
*/
INFO_acTL :: 0x100000 /* PNGv3: 1.6.45: unknown */
INFO_fcTL :: 0x200000 /* PNGv3: 1.6.45: unknown */
INFO_fdAT :: 0x400000 /* PNGv3: 1.6.45: unknown */

/* This is used for the transformation routines, as some of them
* change these values for the row.  It also should enable using
* the routines for other purposes.
*/
Row_Info_Struct :: struct {
	width:       Uint_32,  /* width of row */
	rowbytes:    c.size_t, /* number of bytes in row */
	color_type:  Byte,     /* color type of row */
	bit_depth:   Byte,     /* bit depth of row */
	channels:    Byte,     /* number of channels (1, 2, 3, or 4) */
	pixel_depth: Byte,     /* bits per pixel (depth * channels) */
}

/* This is used for the transformation routines, as some of them
* change these values for the row.  It also should enable using
* the routines for other purposes.
*/
Row_Info   :: Row_Info_Struct
Row_Infop  :: ^Row_Info
Row_Infopp :: ^^Row_Info

/* These are the function types for the I/O functions and for the functions
* that allow the user to override the default I/O functions with his or her
* own.  The png_error_ptr type should match that of user-supplied warning
* and error functions, while the png_rw_ptr type should match that of the
* user read/write data functions.  Note that the 'write' function must not
* modify the buffer it is passed. The 'read' function, on the other hand, is
* expected to return the read data in the buffer.
*/
Error_Ptr            :: proc "c" (Structp, Const_Charp)
Rw_Ptr               :: proc "c" (Structp, Bytep, c.size_t)
Flush_Ptr            :: proc "c" (Structp)
Read_Status_Ptr      :: proc "c" (Structp, Uint_32, i32)
Write_Status_Ptr     :: proc "c" (Structp, Uint_32, i32)
Progressive_Info_Ptr :: proc "c" (Structp, Infop)
Progressive_End_Ptr  :: proc "c" (Structp, Infop)

/* The following callback receives png_uint_32 row_number, int pass for the
* png_bytep data of the row.  When transforming an interlaced image the
* row number is the row number within the sub-image of the interlace pass, so
* the value will increase to the height of the sub-image (not the full image)
* then reset to 0 for the next pass.
*
* Use PNG_ROW_FROM_PASS_ROW(row, pass) and PNG_COL_FROM_PASS_COL(col, pass) to
* find the output pixel (x,y) given an interlaced sub-image pixel
* (row,col,pass).  (See below for these macros.)
*/
Progressive_Row_Ptr :: proc "c" (Structp, Bytep, Uint_32, i32)
User_Transform_Ptr  :: proc "c" (Structp, Row_Infop, Bytep)
User_Chunk_Ptr      :: proc "c" (Structp, Unknown_Chunkp) -> i32

/* This must match the function definition in <setjmp.h>, and the application
* must include this before png.h to obtain the definition of jmp_buf.  The
* function is required to be PNG_NORETURN, but this is not checked.  If the
* function does return the application will crash via an abort() or similar
* system level call.
*
* If you get a warning here while building the library you may need to make
* changes to ensure that pnglibconf.h records the calling convention used by
* your compiler.  This may be very difficult - try using a different compiler
* to build the library!
*/
Longjmp_Ptr :: proc "c" (^Jmp_Buf, i32)

/* Transform masks for the high-level interface */
TRANSFORM_IDENTITY       :: 0x0000    /* read and write */
TRANSFORM_STRIP_16       :: 0x0001    /* read only */
TRANSFORM_STRIP_ALPHA    :: 0x0002    /* read only */
TRANSFORM_PACKING        :: 0x0004    /* read and write */
TRANSFORM_PACKSWAP       :: 0x0008    /* read and write */
TRANSFORM_EXPAND         :: 0x0010    /* read only */
TRANSFORM_INVERT_MONO    :: 0x0020    /* read and write */
TRANSFORM_SHIFT          :: 0x0040    /* read and write */
TRANSFORM_BGR            :: 0x0080    /* read and write */
TRANSFORM_SWAP_ALPHA     :: 0x0100    /* read and write */
TRANSFORM_SWAP_ENDIAN    :: 0x0200    /* read and write */
TRANSFORM_INVERT_ALPHA   :: 0x0400    /* read and write */
TRANSFORM_STRIP_FILLER   :: 0x0800    /* write only */

/* Added to libpng-1.2.34 */
TRANSFORM_STRIP_FILLER_BEFORE :: TRANSFORM_STRIP_FILLER
TRANSFORM_STRIP_FILLER_AFTER  :: 0x1000 /* write only */

/* Added to libpng-1.4.0 */
TRANSFORM_GRAY_TO_RGB   :: 0x2000      /* read only */

/* Added to libpng-1.5.4 */
TRANSFORM_EXPAND_16     :: 0x4000      /* read only */
TRANSFORM_SCALE_16      :: 0x8000      /* read only */

/* Flags for MNG supported features */
FLAG_MNG_EMPTY_PLTE     :: 0x01
FLAG_MNG_FILTER_64      :: 0x04
ALL_MNG_FEATURES        :: 0x05

/* NOTE: prior to 1.5 these functions had no 'API' style declaration,
* this allowed the zlib default functions to be used on Windows
* platforms.  In 1.5 the zlib default malloc (which just calls malloc and
* ignores the first argument) should be completely compatible with the
* following.
*/
Malloc_Ptr :: proc "c" (Structp, Alloc_Size_T) -> Voidp
Free_Ptr   :: proc "c" (Structp, Voidp)

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	/* Returns the version number of the library */
	access_version_number :: proc() -> Uint_32 ---

	/* Tell lib we have already handled the first <num_bytes> magic bytes.
	* Handling more than 8 bytes from the beginning of the file is an error.
	*/
	set_sig_bytes :: proc(png_ptr: Structrp, num_bytes: i32) ---

	/* Check sig[start] through sig[start + num_to_check - 1] to see if it's a
	* PNG file.  Returns zero if the supplied bytes match the 8-byte PNG
	* signature, and non-zero otherwise.  Having num_to_check == 0 or
	* start > 7 will always fail (i.e. return non-zero).
	*/
	sig_cmp :: proc(sig: Const_Bytep, start: c.size_t, num_to_check: c.size_t) -> i32 ---

	/* Allocate and initialize png_ptr struct for reading, and any other memory. */
	create_read_struct :: proc(user_png_ver: Const_Charp, error_ptr: Voidp, error_fn: Error_Ptr, warn_fn: Error_Ptr) -> Structp ---

	/* Allocate and initialize png_ptr struct for writing, and any other memory */
	create_write_struct         :: proc(user_png_ver: Const_Charp, error_ptr: Voidp, error_fn: Error_Ptr, warn_fn: Error_Ptr) -> Structp ---
	get_compression_buffer_size :: proc(png_ptr: Const_Structrp) -> c.size_t ---
	set_compression_buffer_size :: proc(png_ptr: Structrp, size: c.size_t) ---

	/* This function returns the jmp_buf built in to *png_ptr.  It must be
	* supplied with an appropriate 'longjmp' function to use on that jmp_buf
	* unless the default error function is overridden in which case NULL is
	* acceptable.  The size of the jmp_buf is checked against the actual size
	* allocated by the library - the call will return NULL on a mismatch
	* indicating an ABI mismatch.
	*/
	set_longjmp_fn :: proc(png_ptr: Structrp, longjmp_fn: Longjmp_Ptr, jmp_buf_size: c.size_t) -> ^Jmp_Buf ---

	/* This function should be used by libpng applications in place of
	* longjmp(png_ptr->jmpbuf, val).  If longjmp_fn() has been set, it
	* will use it; otherwise it will call PNG_ABORT().  This function was
	* added in libpng-1.5.0.
	*/
	longjmp :: proc(png_ptr: Const_Structrp, val: i32) ---

	/* Reset the compression stream */
	reset_zstream         :: proc(png_ptr: Structrp) -> i32 ---
	create_read_struct_2  :: proc(user_png_ver: Const_Charp, error_ptr: Voidp, error_fn: Error_Ptr, warn_fn: Error_Ptr, mem_ptr: Voidp, malloc_fn: Malloc_Ptr, free_fn: Free_Ptr) -> Structp ---
	create_write_struct_2 :: proc(user_png_ver: Const_Charp, error_ptr: Voidp, error_fn: Error_Ptr, warn_fn: Error_Ptr, mem_ptr: Voidp, malloc_fn: Malloc_Ptr, free_fn: Free_Ptr) -> Structp ---

	/* Write the PNG file signature. */
	write_sig :: proc(png_ptr: Structrp) ---

	/* Write a PNG chunk - size, type, (optional) data, CRC. */
	write_chunk :: proc(png_ptr: Structrp, chunk_name: Const_Bytep, data: Const_Bytep, length: c.size_t) ---

	/* Write the start of a PNG chunk - length and chunk name. */
	write_chunk_start :: proc(png_ptr: Structrp, chunk_name: Const_Bytep, length: Uint_32) ---

	/* Write the data of a PNG chunk started with png_write_chunk_start(). */
	write_chunk_data :: proc(png_ptr: Structrp, data: Const_Bytep, length: c.size_t) ---

	/* Finish a chunk started with png_write_chunk_start() (includes CRC). */
	write_chunk_end :: proc(png_ptr: Structrp) ---

	/* Allocate and initialize the info structure */
	create_info_struct :: proc(png_ptr: Const_Structrp) -> Infop ---

	/* DEPRECATED: this function allowed init structures to be created using the
	* default allocation method (typically malloc).  Use is deprecated in 1.6.0 and
	* the API will be removed in the future.
	*/
	info_init_3 :: proc(info_ptr: Infopp, png_info_struct_size: c.size_t) ---

	/* Writes all the PNG information before the image. */
	write_info_before_PLTE :: proc(png_ptr: Structrp, info_ptr: Const_Inforp) ---
	write_info             :: proc(png_ptr: Structrp, info_ptr: Const_Inforp) ---

	/* Read the information before the actual image data. */
	read_info :: proc(png_ptr: Structrp, info_ptr: Inforp) ---

	/* To do: remove this from libpng17 (and from libpng17/png.c and pngstruct.h) */
	convert_to_rfc1123        :: proc(png_ptr: Structrp, ptime: Const_Timep) -> Const_Charp ---
	convert_to_rfc1123_buffer :: proc(out: ^[29]i8, ptime: Const_Timep) -> i32 ---

	/* Convert from a struct tm to png_time */
	convert_from_struct_tm :: proc(ptime: Timep, ttime: ^Tm) ---

	/* Convert from time_t to png_time.  Uses gmtime() */
	convert_from_time_t :: proc(ptime: Timep, ttime: libc.time_t) ---

	/* Expand data to 24-bit RGB, or 8-bit grayscale, with alpha if available. */
	set_expand                 :: proc(png_ptr: Structrp) ---
	set_expand_gray_1_2_4_to_8 :: proc(png_ptr: Structrp) ---
	set_palette_to_rgb         :: proc(png_ptr: Structrp) ---
	set_tRNS_to_alpha          :: proc(png_ptr: Structrp) ---

	/* Expand to 16-bit channels, forces conversion of palette to RGB and expansion
	* of a tRNS chunk if present.
	*/
	set_expand_16 :: proc(png_ptr: Structrp) ---

	/* Use blue, green, red order for pixels. */
	set_bgr :: proc(png_ptr: Structrp) ---

	/* Expand the grayscale to 24-bit RGB if necessary. */
	set_gray_to_rgb :: proc(png_ptr: Structrp) ---
}

/* Reduce RGB to grayscale. */
ERROR_ACTION_NONE   :: 1
ERROR_ACTION_WARN   :: 2
ERROR_ACTION_ERROR  :: 3
RGB_TO_GRAY_DEFAULT :: (-1) /*for red/green coefficients*/

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_rgb_to_gray         :: proc(png_ptr: Structrp, error_action: i32, red: f64, green: f64) ---
	set_rgb_to_gray_fixed   :: proc(png_ptr: Structrp, error_action: i32, red: Fixed_Point, green: Fixed_Point) ---
	get_rgb_to_gray_status  :: proc(png_ptr: Const_Structrp) -> Byte ---
	build_grayscale_palette :: proc(bit_depth: i32, palette: Colorp) ---
}

/* How the alpha channel is interpreted - this affects how the color channels
* of a PNG file are returned to the calling application when an alpha channel,
* or a tRNS chunk in a palette file, is present.
*
* This has no effect on the way pixels are written into a PNG output
* datastream. The color samples in a PNG datastream are never premultiplied
* with the alpha samples.
*
* The default is to return data according to the PNG specification: the alpha
* channel is a linear measure of the contribution of the pixel to the
* corresponding composited pixel, and the color channels are unassociated
* (not premultiplied).  The gamma encoded color channels must be scaled
* according to the contribution and to do this it is necessary to undo
* the encoding, scale the color values, perform the composition and re-encode
* the values.  This is the 'PNG' mode.
*
* The alternative is to 'associate' the alpha with the color information by
* storing color channel values that have been scaled by the alpha.
* image.  These are the 'STANDARD', 'ASSOCIATED' or 'PREMULTIPLIED' modes
* (the latter being the two common names for associated alpha color channels).
*
* For the 'OPTIMIZED' mode, a pixel is treated as opaque only if the alpha
* value is equal to the maximum value.
*
* The final choice is to gamma encode the alpha channel as well.  This is
* broken because, in practice, no implementation that uses this choice
* correctly undoes the encoding before handling alpha composition.  Use this
* choice only if other serious errors in the software or hardware you use
* mandate it; the typical serious error is for dark halos to appear around
* opaque areas of the composited PNG image because of arithmetic overflow.
*
* The API function png_set_alpha_mode specifies which of these choices to use
* with an enumerated 'mode' value and the gamma of the required output:
*/
ALPHA_PNG           :: 0 /* according to the PNG standard */
ALPHA_STANDARD      :: 1 /* according to Porter/Duff */
ALPHA_ASSOCIATED    :: 1 /* as above; this is the normal practice */
ALPHA_PREMULTIPLIED :: 1 /* as above */
ALPHA_OPTIMIZED     :: 2 /* 'PNG' for opaque pixels, else 'STANDARD' */
ALPHA_BROKEN        :: 3 /* the alpha channel is gamma encoded */

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_alpha_mode       :: proc(png_ptr: Structrp, mode: i32, output_gamma: f64) ---
	set_alpha_mode_fixed :: proc(png_ptr: Structrp, mode: i32, output_gamma: Fixed_Point) ---
}

/* The output_gamma value is a screen gamma in libpng terminology: it expresses
* how to decode the output values, not how they are encoded.
*/
DEFAULT_sRGB :: -1       /* sRGB gamma and color space */
GAMMA_MAC_18 :: -2       /* Old Mac '1.8' gamma and color space */
GAMMA_sRGB   :: 220000   /* Television standards--matches sRGB gamma */
GAMMA_LINEAR :: FP_1   /* Linear */

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_strip_alpha  :: proc(png_ptr: Structrp) ---
	set_swap_alpha   :: proc(png_ptr: Structrp) ---
	set_invert_alpha :: proc(png_ptr: Structrp) ---

	/* Add a filler byte to 8-bit or 16-bit Gray or 24-bit or 48-bit RGB images. */
	set_filler :: proc(png_ptr: Structrp, filler: Uint_32, flags: i32) ---
}

/* The values of the PNG_FILLER_ defines should NOT be changed */
FILLER_BEFORE :: 0
FILLER_AFTER  :: 1

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	/* Add an alpha byte to 8-bit or 16-bit Gray or 24-bit or 48-bit RGB images. */
	set_add_alpha :: proc(png_ptr: Structrp, filler: Uint_32, flags: i32) ---

	/* Swap bytes in 16-bit depth files. */
	set_swap :: proc(png_ptr: Structrp) ---

	/* Use 1 byte per pixel in 1, 2, or 4-bit depth files. */
	set_packing :: proc(png_ptr: Structrp) ---

	/* Swap packing order of pixels in bytes. */
	set_packswap :: proc(png_ptr: Structrp) ---

	/* Converts files to legal bit depths. */
	set_shift :: proc(png_ptr: Structrp, true_bits: Const_Color_8p) ---

	/* Have the code handle the interlacing.  Returns the number of passes.
	* MUST be called before png_read_update_info or png_start_read_image,
	* otherwise it will not have the desired effect.  Note that it is still
	* necessary to call png_read_row or png_read_rows png_get_image_height
	* times for each pass.
	*/
	set_interlace_handling :: proc(png_ptr: Structrp) -> i32 ---

	/* Invert monochrome files */
	set_invert_mono :: proc(png_ptr: Structrp) ---

	/* Handle alpha and tRNS by replacing with a background color.  Prior to
	* libpng-1.5.4 this API must not be called before the PNG file header has been
	* read.  Doing so will result in unexpected behavior and possible warnings or
	* errors if the PNG file contains a bKGD chunk.
	*/
	set_background :: proc(png_ptr: Structrp, background_color: Const_Color_16p, background_gamma_code: i32, need_expand: i32, background_gamma: f64) ---

	/* Handle alpha and tRNS by replacing with a background color.  Prior to
	* libpng-1.5.4 this API must not be called before the PNG file header has been
	* read.  Doing so will result in unexpected behavior and possible warnings or
	* errors if the PNG file contains a bKGD chunk.
	*/
	set_background_fixed :: proc(png_ptr: Structrp, background_color: Const_Color_16p, background_gamma_code: i32, need_expand: i32, background_gamma: Fixed_Point) ---
}

BACKGROUND_GAMMA_UNKNOWN :: 0
BACKGROUND_GAMMA_SCREEN  :: 1
BACKGROUND_GAMMA_FILE    :: 2
BACKGROUND_GAMMA_UNIQUE  :: 3

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	/* Scale a 16-bit depth file down to 8-bit, accurately. */
	set_scale_16 :: proc(png_ptr: Structrp) ---

	/* Strip the second byte of information from a 16-bit depth file. */
	set_strip_16 :: proc(png_ptr: Structrp) ---

	/* Turn on quantizing, and reduce the palette to the number of colors
	* available.
	*/
	set_quantize :: proc(png_ptr: Structrp, palette: Colorp, num_palette: i32, maximum_colors: i32, histogram: Const_Uint_16p, full_quantize: i32) ---

	/* Handle gamma correction. Screen_gamma=(display_exponent).
	* NOTE: this API simply sets the screen and file gamma values. It will
	* therefore override the value for gamma in a PNG file if it is called after
	* the file header has been read - use with care  - call before reading the PNG
	* file for best results!
	*
	* These routines accept the same gamma values as png_set_alpha_mode (described
	* above).  The PNG_GAMMA_ defines and PNG_DEFAULT_sRGB can be passed to either
	* API (floating point or fixed.)  Notice, however, that the 'file_gamma' value
	* is the inverse of a 'screen gamma' value.
	*/
	set_gamma :: proc(png_ptr: Structrp, screen_gamma: f64, override_file_gamma: f64) ---

	/* Handle gamma correction. Screen_gamma=(display_exponent).
	* NOTE: this API simply sets the screen and file gamma values. It will
	* therefore override the value for gamma in a PNG file if it is called after
	* the file header has been read - use with care  - call before reading the PNG
	* file for best results!
	*
	* These routines accept the same gamma values as png_set_alpha_mode (described
	* above).  The PNG_GAMMA_ defines and PNG_DEFAULT_sRGB can be passed to either
	* API (floating point or fixed.)  Notice, however, that the 'file_gamma' value
	* is the inverse of a 'screen gamma' value.
	*/
	set_gamma_fixed :: proc(png_ptr: Structrp, screen_gamma: Fixed_Point, override_file_gamma: Fixed_Point) ---

	/* Set how many lines between output flushes - 0 for no flushing */
	set_flush :: proc(png_ptr: Structrp, nrows: i32) ---

	/* Flush the current PNG output buffer */
	write_flush :: proc(png_ptr: Structrp) ---

	/* Optional update palette with requested transformations */
	start_read_image :: proc(png_ptr: Structrp) ---

	/* Optional call to update the users info structure */
	read_update_info :: proc(png_ptr: Structrp, info_ptr: Inforp) ---

	/* Read one or more rows of image data. */
	read_rows :: proc(png_ptr: Structrp, row: Bytepp, display_row: Bytepp, num_rows: Uint_32) ---

	/* Read a row of data. */
	read_row :: proc(png_ptr: Structrp, row: Bytep, display_row: Bytep) ---

	/* Read the whole image into memory at once. */
	read_image :: proc(png_ptr: Structrp, image: Bytepp) ---

	/* Write a row of image data */
	write_row :: proc(png_ptr: Structrp, row: Const_Bytep) ---

	/* Write a few rows of image data: (*row) is not written; however, the type
	* is declared as writeable to maintain compatibility with previous versions
	* of libpng and to allow the 'display_row' array from read_rows to be passed
	* unchanged to write_rows.
	*/
	write_rows :: proc(png_ptr: Structrp, row: Bytepp, num_rows: Uint_32) ---

	/* Write the image data */
	write_image :: proc(png_ptr: Structrp, image: Bytepp) ---

	/* Write the end of the PNG file. */
	write_end :: proc(png_ptr: Structrp, info_ptr: Inforp) ---

	/* Read the end of the PNG file. */
	read_end :: proc(png_ptr: Structrp, info_ptr: Inforp) ---

	/* Free any memory associated with the png_info_struct */
	destroy_info_struct :: proc(png_ptr: Const_Structrp, info_ptr_ptr: Infopp) ---

	/* Free any memory associated with the png_struct and the png_info_structs */
	destroy_read_struct :: proc(png_ptr_ptr: Structpp, info_ptr_ptr: Infopp, end_info_ptr_ptr: Infopp) ---

	/* Free any memory associated with the png_struct and the png_info_structs */
	destroy_write_struct :: proc(png_ptr_ptr: Structpp, info_ptr_ptr: Infopp) ---

	/* Set the libpng method of handling chunk CRC errors */
	set_crc_action :: proc(png_ptr: Structrp, crit_action: i32, ancil_action: i32) ---
}

/* Values for png_set_crc_action() say how to handle CRC errors in
* ancillary and critical chunks, and whether to use the data contained
* therein.  Note that it is impossible to "discard" data in a critical
* chunk.  For versions prior to 0.90, the action was always error/quit,
* whereas in version 0.90 and later, the action for CRC errors in ancillary
* chunks is warn/discard.  These values should NOT be changed.
*
*      value                       action:critical     action:ancillary
*/
CRC_DEFAULT       :: 0  /* error/quit          warn/discard data */
CRC_ERROR_QUIT    :: 1  /* error/quit          error/quit        */
CRC_WARN_DISCARD  :: 2  /* (INVALID)           warn/discard data */
CRC_WARN_USE      :: 3  /* warn/use data       warn/use data     */
CRC_QUIET_USE     :: 4  /* quiet/use data      quiet/use data    */
CRC_NO_CHANGE     :: 5  /* use current value   use current value */

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	/* Set the filtering method(s) used by libpng.  Currently, the only valid
	* value for "method" is 0.
	*/
	set_filter :: proc(png_ptr: Structrp, method: i32, filters: i32) ---
}

/* Flags for png_set_filter() to say which filters to use.  The flags
* are chosen so that they don't conflict with real filter types
* below, in case they are supplied instead of the #defined constants.
* These values should NOT be changed.
*/
NO_FILTERS     :: 0x00
FILTER_NONE    :: 0x08
FILTER_SUB     :: 0x10
FILTER_UP      :: 0x20
FILTER_AVG     :: 0x40
FILTER_PAETH   :: 0x80
FAST_FILTERS :: (FILTER_NONE|FILTER_SUB|FILTER_UP)
ALL_FILTERS  :: (FAST_FILTERS|FILTER_AVG|FILTER_PAETH)

/* Filter values (not flags) - used in pngwrite.c, pngwutil.c for now.
* These defines should NOT be changed.
*/
FILTER_VALUE_NONE  :: 0
FILTER_VALUE_SUB   :: 1
FILTER_VALUE_UP    :: 2
FILTER_VALUE_AVG   :: 3
FILTER_VALUE_PAETH :: 4
FILTER_VALUE_LAST  :: 5

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_filter_heuristics       :: proc(png_ptr: Structrp, heuristic_method: i32, num_weights: i32, filter_weights: Const_Doublep, filter_costs: Const_Doublep) ---
	set_filter_heuristics_fixed :: proc(png_ptr: Structrp, heuristic_method: i32, num_weights: i32, filter_weights: Const_Fixed_Point_P, filter_costs: Const_Fixed_Point_P) ---
}

/* The following are no longer used and will be removed from libpng-1.7: */
FILTER_HEURISTIC_DEFAULT    :: 0  /* Currently "UNWEIGHTED" */
FILTER_HEURISTIC_UNWEIGHTED :: 1  /* Used by libpng < 0.95 */
FILTER_HEURISTIC_WEIGHTED   :: 2  /* Experimental feature */
FILTER_HEURISTIC_LAST       :: 3  /* Not a valid value */

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_compression_level     :: proc(png_ptr: Structrp, level: i32) ---
	set_compression_mem_level :: proc(png_ptr: Structrp, mem_level: i32) ---
	set_compression_strategy  :: proc(png_ptr: Structrp, strategy: i32) ---

	/* If PNG_WRITE_OPTIMIZE_CMF_SUPPORTED is defined, libpng will use a
	* smaller value of window_bits if it can do so safely.
	*/
	set_compression_window_bits :: proc(png_ptr: Structrp, window_bits: i32) ---
	set_compression_method      :: proc(png_ptr: Structrp, method: i32) ---

	/* Also set zlib parameters for compressing non-IDAT chunks */
	set_text_compression_level     :: proc(png_ptr: Structrp, level: i32) ---
	set_text_compression_mem_level :: proc(png_ptr: Structrp, mem_level: i32) ---
	set_text_compression_strategy  :: proc(png_ptr: Structrp, strategy: i32) ---

	/* If PNG_WRITE_OPTIMIZE_CMF_SUPPORTED is defined, libpng will use a
	* smaller value of window_bits if it can do so safely.
	*/
	set_text_compression_window_bits :: proc(png_ptr: Structrp, window_bits: i32) ---
	set_text_compression_method      :: proc(png_ptr: Structrp, method: i32) ---

	/* Initialize the input/output for the PNG file to the default functions. */
	init_io :: proc(png_ptr: Structrp, fp: ^File) ---

	/* Replace the (error and abort), and warning functions with user
	* supplied functions.  If no messages are to be printed you must still
	* write and use replacement functions. The replacement error_fn should
	* still do a longjmp to the last setjmp location if you are using this
	* method of error handling.  If error_fn or warning_fn is NULL, the
	* default function will be used.
	*/
	set_error_fn :: proc(png_ptr: Structrp, error_ptr: Voidp, error_fn: Error_Ptr, warning_fn: Error_Ptr) ---

	/* Return the user pointer associated with the error functions */
	get_error_ptr :: proc(png_ptr: Const_Structrp) -> Voidp ---

	/* Replace the default data output functions with a user supplied one(s).
	* If buffered output is not used, then output_flush_fn can be set to NULL.
	* If PNG_WRITE_FLUSH_SUPPORTED is not defined at libpng compile time
	* output_flush_fn will be ignored (and thus can be NULL).
	* It is probably a mistake to use NULL for output_flush_fn if
	* write_data_fn is not also NULL unless you have built libpng with
	* PNG_WRITE_FLUSH_SUPPORTED undefined, because in this case libpng's
	* default flush function, which uses the standard *FILE structure, will
	* be used.
	*/
	set_write_fn :: proc(png_ptr: Structrp, io_ptr: Voidp, write_data_fn: Rw_Ptr, output_flush_fn: Flush_Ptr) ---

	/* Replace the default data input function with a user supplied one. */
	set_read_fn :: proc(png_ptr: Structrp, io_ptr: Voidp, read_data_fn: Rw_Ptr) ---

	/* Return the user pointer associated with the I/O functions */
	get_io_ptr          :: proc(png_ptr: Const_Structrp) -> Voidp ---
	set_read_status_fn  :: proc(png_ptr: Structrp, read_row_fn: Read_Status_Ptr) ---
	set_write_status_fn :: proc(png_ptr: Structrp, write_row_fn: Write_Status_Ptr) ---

	/* Replace the default memory allocation functions with user supplied one(s). */
	set_mem_fn :: proc(png_ptr: Structrp, mem_ptr: Voidp, malloc_fn: Malloc_Ptr, free_fn: Free_Ptr) ---

	/* Return the user pointer associated with the memory functions */
	get_mem_ptr                 :: proc(png_ptr: Const_Structrp) -> Voidp ---
	set_read_user_transform_fn  :: proc(png_ptr: Structrp, read_user_transform_fn: User_Transform_Ptr) ---
	set_write_user_transform_fn :: proc(png_ptr: Structrp, write_user_transform_fn: User_Transform_Ptr) ---
	set_user_transform_info     :: proc(png_ptr: Structrp, user_transform_ptr: Voidp, user_transform_depth: i32, user_transform_channels: i32) ---

	/* Return the user pointer associated with the user transform functions */
	get_user_transform_ptr :: proc(png_ptr: Const_Structrp) -> Voidp ---

	/* Return information about the row currently being processed.  Note that these
	* APIs do not fail but will return unexpected results if called outside a user
	* transform callback.  Also note that when transforming an interlaced image the
	* row number is the row number within the sub-image of the interlace pass, so
	* the value will increase to the height of the sub-image (not the full image)
	* then reset to 0 for the next pass.
	*
	* Use PNG_ROW_FROM_PASS_ROW(row, pass) and PNG_COL_FROM_PASS_COL(col, pass) to
	* find the output pixel (x,y) given an interlaced sub-image pixel
	* (row,col,pass).  (See below for these macros.)
	*/
	get_current_row_number  :: proc(Const_Structrp) -> Uint_32 ---
	get_current_pass_number :: proc(Const_Structrp) -> Byte ---

	/* This callback is called only for *unknown* chunks.  If
	* PNG_HANDLE_AS_UNKNOWN_SUPPORTED is set then it is possible to set known
	* chunks to be treated as unknown, however in this case the callback must do
	* any processing required by the chunk (e.g. by calling the appropriate
	* png_set_ APIs.)
	*
	* There is no write support - on write, by default, all the chunks in the
	* 'unknown' list are written in the specified position.
	*
	* The integer return from the callback function is interpreted thus:
	*
	* negative: An error occurred; png_chunk_error will be called.
	*     zero: The chunk was not handled, the chunk will be saved. A critical
	*           chunk will cause an error at this point unless it is to be saved.
	* positive: The chunk was handled, libpng will ignore/discard it.
	*
	* See "INTERACTION WITH USER CHUNK CALLBACKS" below for important notes about
	* how this behavior will change in libpng 1.7
	*/
	set_read_user_chunk_fn :: proc(png_ptr: Structrp, user_chunk_ptr: Voidp, read_user_chunk_fn: User_Chunk_Ptr) ---
	get_user_chunk_ptr     :: proc(png_ptr: Const_Structrp) -> Voidp ---

	/* Sets the function callbacks for the push reader, and a pointer to a
	* user-defined structure available to the callback functions.
	*/
	set_progressive_read_fn :: proc(png_ptr: Structrp, progressive_ptr: Voidp, info_fn: Progressive_Info_Ptr, row_fn: Progressive_Row_Ptr, end_fn: Progressive_End_Ptr) ---

	/* Returns the user pointer associated with the push read functions */
	get_progressive_ptr :: proc(png_ptr: Const_Structrp) -> Voidp ---

	/* Function to be called when data becomes available */
	process_data :: proc(png_ptr: Structrp, info_ptr: Inforp, buffer: Bytep, buffer_size: c.size_t) ---

	/* A function which may be called *only* within png_process_data to stop the
	* processing of any more data.  The function returns the number of bytes
	* remaining, excluding any that libpng has cached internally.  A subsequent
	* call to png_process_data must supply these bytes again.  If the argument
	* 'save' is set to true the routine will first save all the pending data and
	* will always return 0.
	*/
	process_data_pause :: proc(_: Structrp, save: i32) -> c.size_t ---

	/* A function which may be called *only* outside (after) a call to
	* png_process_data.  It returns the number of bytes of data to skip in the
	* input.  Normally it will return 0, but if it returns a non-zero value the
	* application must skip than number of bytes of input data and pass the
	* following data to the next call to png_process_data.
	*/
	process_data_skip :: proc(Structrp) -> Uint_32 ---

	/* Function that combines rows.  'new_row' is a flag that should come from
	* the callback and be non-NULL if anything needs to be done; the library
	* stores its own version of the new data internally and ignores the passed
	* in value.
	*/
	progressive_combine_row :: proc(png_ptr: Const_Structrp, old_row: Bytep, new_row: Const_Bytep) ---
	malloc                  :: proc(png_ptr: Const_Structrp, size: Alloc_Size_T) -> Voidp ---

	/* Added at libpng version 1.4.0 */
	calloc :: proc(png_ptr: Const_Structrp, size: Alloc_Size_T) -> Voidp ---

	/* Added at libpng version 1.2.4 */
	malloc_warn :: proc(png_ptr: Const_Structrp, size: Alloc_Size_T) -> Voidp ---

	/* Frees a pointer allocated by png_malloc() */
	free :: proc(png_ptr: Const_Structrp, ptr: Voidp) ---

	/* Free data that was allocated internally */
	free_data :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, free_me: Uint_32, num: i32) ---

	/* Reassign the responsibility for freeing existing data, whether allocated
	* by libpng or by the application; this works on the png_info structure passed
	* in, without changing the state for other png_info structures.
	*/
	data_freer :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, freer: i32, mask: Uint_32) ---
}

/* Assignments for png_data_freer */
DESTROY_WILL_FREE_DATA :: 1
SET_WILL_FREE_DATA     :: 1
USER_WILL_FREE_DATA    :: 2

/* Flags for png_ptr->free_me and info_ptr->free_me */
FREE_HIST :: 0x0008
FREE_ICCP :: 0x0010
FREE_SPLT :: 0x0020
FREE_ROWS :: 0x0040
FREE_PCAL :: 0x0080
FREE_SCAL :: 0x0100
FREE_UNKN :: 0x0200

/*      PNG_FREE_LIST 0x0400U   removed in 1.6.0 because it is ignored */
FREE_PLTE :: 0x1000
FREE_TRNS :: 0x2000
FREE_TEXT :: 0x4000
FREE_EXIF :: 0x8000 /* Added at libpng-1.6.31 */
FREE_ALL  :: 0xffff
FREE_MUL  :: 0x4220 /* PNG_FREE_SPLT|PNG_FREE_TEXT|PNG_FREE_UNKN */

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	malloc_default :: proc(png_ptr: Const_Structrp, size: Alloc_Size_T) -> Voidp ---
	free_default   :: proc(png_ptr: Const_Structrp, ptr: Voidp) ---

	/* Fatal error in PNG image of libpng - can't continue */
	error :: proc(png_ptr: Const_Structrp, error_message: Const_Charp) ---

	/* The same, but the chunk name is prepended to the error string. */
	chunk_error :: proc(png_ptr: Const_Structrp, error_message: Const_Charp) ---

	/* Non-fatal error in libpng.  Can continue, but may have a problem. */
	warning :: proc(png_ptr: Const_Structrp, warning_message: Const_Charp) ---

	/* Non-fatal error in libpng, chunk name is prepended to message. */
	chunk_warning :: proc(png_ptr: Const_Structrp, warning_message: Const_Charp) ---

	/* Benign error in libpng.  Can continue, but may have a problem.
	* User can choose whether to handle as a fatal error or as a warning. */
	benign_error :: proc(png_ptr: Const_Structrp, warning_message: Const_Charp) ---

	/* Same, chunk name is prepended to message (only during read) */
	chunk_benign_error :: proc(png_ptr: Const_Structrp, warning_message: Const_Charp) ---
	set_benign_errors  :: proc(png_ptr: Structrp, allowed: i32) ---

	/* The png_set_<chunk> functions are for storing values in the png_info_struct.
	* Similarly, the png_get_<chunk> calls are used to read values from the
	* png_info_struct, either storing the parameters in the passed variables, or
	* setting pointers into the png_info_struct where the data is stored.  The
	* png_get_<chunk> functions return a non-zero value if the data was available
	* in info_ptr, or return zero and do not change any of the parameters if the
	* data was not available.
	*
	* These functions should be used instead of directly accessing png_info
	* to avoid problems with future changes in the size and internal layout of
	* png_info_struct.
	*/
	/* Returns "flag" if chunk data is valid in info_ptr. */
	get_valid :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, flag: Uint_32) -> Uint_32 ---

	/* Returns number of bytes needed to hold a transformed row. */
	get_rowbytes :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> c.size_t ---

	/* Returns row_pointers, which is an array of pointers to scanlines that was
	* returned from png_read_png().
	*/
	get_rows :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Bytepp ---

	/* Set row_pointers, which is an array of pointers to scanlines for use
	* by png_write_png().
	*/
	set_rows :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, row_pointers: Bytepp) ---

	/* Returns number of color channels in image. */
	get_channels :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Byte ---

	/* Returns image width in pixels. */
	get_image_width :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---

	/* Returns image height in pixels. */
	get_image_height :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---

	/* Returns image bit_depth. */
	get_bit_depth :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Byte ---

	/* Returns image color_type. */
	get_color_type :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Byte ---

	/* Returns image filter_type. */
	get_filter_type :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Byte ---

	/* Returns image interlace_type. */
	get_interlace_type :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Byte ---

	/* Returns image compression_type. */
	get_compression_type :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Byte ---

	/* Returns image resolution in pixels per meter, from pHYs chunk data. */
	get_pixels_per_meter   :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---
	get_x_pixels_per_meter :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---
	get_y_pixels_per_meter :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---

	/* Returns pixel aspect ratio, computed from pHYs chunk data.  */
	get_pixel_aspect_ratio :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> f32 ---

	/* Returns pixel aspect ratio, computed from pHYs chunk data.  */
	get_pixel_aspect_ratio_fixed :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Fixed_Point ---

	/* Returns image x, y offset in pixels or microns, from oFFs chunk data. */
	get_x_offset_pixels  :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Int_32 ---
	get_y_offset_pixels  :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Int_32 ---
	get_x_offset_microns :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Int_32 ---
	get_y_offset_microns :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Int_32 ---

	/* Returns pointer to signature string read from PNG header */
	get_signature      :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Const_Bytep ---
	get_bKGD           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, background: ^Color_16p) -> Uint_32 ---
	set_bKGD           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, background: Const_Color_16p) ---
	get_cHRM           :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, white_x: ^f64, white_y: ^f64, red_x: ^f64, red_y: ^f64, green_x: ^f64, green_y: ^f64, blue_x: ^f64, blue_y: ^f64) -> Uint_32 ---
	get_cHRM_XYZ       :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, red_X: ^f64, red_Y: ^f64, red_Z: ^f64, green_X: ^f64, green_Y: ^f64, green_Z: ^f64, blue_X: ^f64, blue_Y: ^f64, blue_Z: ^f64) -> Uint_32 ---
	get_cHRM_fixed     :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, int_white_x: ^Fixed_Point, int_white_y: ^Fixed_Point, int_red_x: ^Fixed_Point, int_red_y: ^Fixed_Point, int_green_x: ^Fixed_Point, int_green_y: ^Fixed_Point, int_blue_x: ^Fixed_Point, int_blue_y: ^Fixed_Point) -> Uint_32 ---
	get_cHRM_XYZ_fixed :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, int_red_X: ^Fixed_Point, int_red_Y: ^Fixed_Point, int_red_Z: ^Fixed_Point, int_green_X: ^Fixed_Point, int_green_Y: ^Fixed_Point, int_green_Z: ^Fixed_Point, int_blue_X: ^Fixed_Point, int_blue_Y: ^Fixed_Point, int_blue_Z: ^Fixed_Point) -> Uint_32 ---
	set_cHRM           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, white_x: f64, white_y: f64, red_x: f64, red_y: f64, green_x: f64, green_y: f64, blue_x: f64, blue_y: f64) ---
	set_cHRM_XYZ       :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, red_X: f64, red_Y: f64, red_Z: f64, green_X: f64, green_Y: f64, green_Z: f64, blue_X: f64, blue_Y: f64, blue_Z: f64) ---
	set_cHRM_fixed     :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, int_white_x: Fixed_Point, int_white_y: Fixed_Point, int_red_x: Fixed_Point, int_red_y: Fixed_Point, int_green_x: Fixed_Point, int_green_y: Fixed_Point, int_blue_x: Fixed_Point, int_blue_y: Fixed_Point) ---
	set_cHRM_XYZ_fixed :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, int_red_X: Fixed_Point, int_red_Y: Fixed_Point, int_red_Z: Fixed_Point, int_green_X: Fixed_Point, int_green_Y: Fixed_Point, int_green_Z: Fixed_Point, int_blue_X: Fixed_Point, int_blue_Y: Fixed_Point, int_blue_Z: Fixed_Point) ---
	get_cICP           :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, colour_primaries: Bytep, transfer_function: Bytep, matrix_coefficients: Bytep, video_full_range_flag: Bytep) -> Uint_32 ---
	set_cICP           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, colour_primaries: Byte, transfer_function: Byte, matrix_coefficients: Byte, video_full_range_flag: Byte) ---
	get_cLLI           :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, maximum_content_light_level: ^f64, maximum_frame_average_light_level: ^f64) -> Uint_32 ---
	get_cLLI_fixed     :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, maximum_content_light_level_scaled_by_10000: Uint_32p, maximum_frame_average_light_level_scaled_by_10000: Uint_32p) -> Uint_32 ---
	set_cLLI           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, maximum_content_light_level: f64, maximum_frame_average_light_level: f64) ---
	set_cLLI_fixed     :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, maximum_content_light_level_scaled_by_10000: Uint_32, maximum_frame_average_light_level_scaled_by_10000: Uint_32) ---
	get_eXIf           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, exif: ^Bytep) -> Uint_32 ---
	set_eXIf           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, exif: Bytep) ---
	get_eXIf_1         :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, num_exif: ^Uint_32, exif: ^Bytep) -> Uint_32 ---
	set_eXIf_1         :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, num_exif: Uint_32, exif: Bytep) ---
	get_gAMA           :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, file_gamma: ^f64) -> Uint_32 ---
	get_gAMA_fixed     :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, int_file_gamma: ^Fixed_Point) -> Uint_32 ---
	set_gAMA           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, file_gamma: f64) ---
	set_gAMA_fixed     :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, int_file_gamma: Fixed_Point) ---
	get_hIST           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, hist: ^Uint_16p) -> Uint_32 ---
	set_hIST           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, hist: Const_Uint_16p) ---
	get_IHDR           :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, width: ^Uint_32, height: ^Uint_32, bit_depth: ^i32, color_type: ^i32, interlace_method: ^i32, compression_method: ^i32, filter_method: ^i32) -> Uint_32 ---
	set_IHDR           :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, width: Uint_32, height: Uint_32, bit_depth: i32, color_type: i32, interlace_method: i32, compression_method: i32, filter_method: i32) ---
	get_mDCV           :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, white_x: ^f64, white_y: ^f64, red_x: ^f64, red_y: ^f64, green_x: ^f64, green_y: ^f64, blue_x: ^f64, blue_y: ^f64, mastering_display_maximum_luminance: ^f64, mastering_display_minimum_luminance: ^f64) -> Uint_32 ---

	/* Mastering display luminance in cd/m2 (nits). */
	get_mDCV_fixed :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, int_white_x: ^Fixed_Point, int_white_y: ^Fixed_Point, int_red_x: ^Fixed_Point, int_red_y: ^Fixed_Point, int_green_x: ^Fixed_Point, int_green_y: ^Fixed_Point, int_blue_x: ^Fixed_Point, int_blue_y: ^Fixed_Point, mastering_display_maximum_luminance_scaled_by_10000: Uint_32p, mastering_display_minimum_luminance_scaled_by_10000: Uint_32p) -> Uint_32 ---
	set_mDCV       :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, white_x: f64, white_y: f64, red_x: f64, red_y: f64, green_x: f64, green_y: f64, blue_x: f64, blue_y: f64, mastering_display_maximum_luminance: f64, mastering_display_minimum_luminance: f64) ---

	/* Mastering display luminance in cd/m2 (nits). */
	set_mDCV_fixed         :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, int_white_x: Fixed_Point, int_white_y: Fixed_Point, int_red_x: Fixed_Point, int_red_y: Fixed_Point, int_green_x: Fixed_Point, int_green_y: Fixed_Point, int_blue_x: Fixed_Point, int_blue_y: Fixed_Point, mastering_display_maximum_luminance_scaled_by_10000: Uint_32, mastering_display_minimum_luminance_scaled_by_10000: Uint_32) ---
	get_oFFs               :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, offset_x: ^Int_32, offset_y: ^Int_32, unit_type: ^i32) -> Uint_32 ---
	set_oFFs               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, offset_x: Int_32, offset_y: Int_32, unit_type: i32) ---
	get_pCAL               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, purpose: ^Charp, X0: ^Int_32, X1: ^Int_32, type: ^i32, nparams: ^i32, units: ^Charp, params: ^Charpp) -> Uint_32 ---
	set_pCAL               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, purpose: Const_Charp, X0: Int_32, X1: Int_32, type: i32, nparams: i32, units: Const_Charp, params: Charpp) ---
	get_pHYs               :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, res_x: ^Uint_32, res_y: ^Uint_32, unit_type: ^i32) -> Uint_32 ---
	set_pHYs               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, res_x: Uint_32, res_y: Uint_32, unit_type: i32) ---
	get_PLTE               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, palette: ^Colorp, num_palette: ^i32) -> Uint_32 ---
	set_PLTE               :: proc(png_ptr: Structrp, info_ptr: Inforp, palette: Const_Colorp, num_palette: i32) ---
	get_sBIT               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, sig_bit: ^Color_8p) -> Uint_32 ---
	set_sBIT               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, sig_bit: Const_Color_8p) ---
	get_sRGB               :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, file_srgb_intent: ^i32) -> Uint_32 ---
	set_sRGB               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, srgb_intent: i32) ---
	set_sRGB_gAMA_and_cHRM :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, srgb_intent: i32) ---
	get_iCCP               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, name: Charpp, compression_type: ^i32, profile: Bytepp, proflen: ^Uint_32) -> Uint_32 ---
	set_iCCP               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, name: Const_Charp, compression_type: i32, profile: Const_Bytep, proflen: Uint_32) ---
	get_sPLT               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, entries: S_Plt_Tpp) -> i32 ---
	set_sPLT               :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, entries: Const_S_Plt_Tp, nentries: i32) ---

	/* png_get_text also returns the number of text chunks in *num_text */
	get_text :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, text_ptr: ^Textp, num_text: ^i32) -> i32 ---
	set_text :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, text_ptr: Const_Textp, num_text: i32) ---
	get_tIME :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, mod_time: ^Timep) -> Uint_32 ---
	set_tIME :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, mod_time: Const_Timep) ---
	get_tRNS :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, trans_alpha: ^Bytep, num_trans: ^i32, trans_color: ^Color_16p) -> Uint_32 ---
	set_tRNS :: proc(png_ptr: Structrp, info_ptr: Inforp, trans_alpha: Const_Bytep, num_trans: i32, trans_color: Const_Color_16p) ---
	get_sCAL :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, unit: ^i32, width: ^f64, height: ^f64) -> Uint_32 ---

	/* NOTE: this API is currently implemented using floating point arithmetic,
	* consequently it can only be used on systems with floating point support.
	* In any case the range of values supported by png_fixed_point is small and it
	* is highly recommended that png_get_sCAL_s be used instead.
	*/
	get_sCAL_fixed          :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, unit: ^i32, width: ^Fixed_Point, height: ^Fixed_Point) -> Uint_32 ---
	get_sCAL_s              :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, unit: ^i32, swidth: Charpp, sheight: Charpp) -> Uint_32 ---
	set_sCAL                :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, unit: i32, width: f64, height: f64) ---
	set_sCAL_fixed          :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, unit: i32, width: Fixed_Point, height: Fixed_Point) ---
	set_sCAL_s              :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, unit: i32, swidth: Const_Charp, sheight: Const_Charp) ---
	set_keep_unknown_chunks :: proc(png_ptr: Structrp, keep: i32, chunk_list: Const_Bytep, num_chunks: i32) ---

	/* The "keep" PNG_HANDLE_CHUNK_ parameter for the specified chunk is returned;
	* the result is therefore true (non-zero) if special handling is required,
	* false for the default handling.
	*/
	handle_as_unknown  :: proc(png_ptr: Const_Structrp, chunk_name: Const_Bytep) -> i32 ---
	set_unknown_chunks :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, unknowns: Const_Unknown_Chunkp, num_unknowns: i32) ---

	/* NOTE: prior to 1.6.0 this routine set the 'location' field of the added
	* unknowns to the location currently stored in the png_struct.  This is
	* invariably the wrong value on write.  To fix this call the following API
	* for each chunk in the list with the correct location.  If you know your
	* code won't be compiled on earlier versions you can rely on
	* png_set_unknown_chunks(write-ptr, png_get_unknown_chunks(read-ptr)) doing
	* the correct thing.
	*/
	set_unknown_chunk_location :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, chunk: i32, location: i32) ---
	get_unknown_chunks         :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, entries: Unknown_Chunkpp) -> i32 ---

	/* Png_free_data() will turn off the "valid" flag for anything it frees.
	* If you need to turn it off for a chunk that your application has freed,
	* you can use png_set_invalid(png_ptr, info_ptr, PNG_INFO_CHNK);
	*/
	set_invalid         :: proc(png_ptr: Const_Structrp, info_ptr: Inforp, mask: i32) ---
	read_png            :: proc(png_ptr: Structrp, info_ptr: Inforp, transforms: i32, params: Voidp) ---
	write_png           :: proc(png_ptr: Structrp, info_ptr: Inforp, transforms: i32, params: Voidp) ---
	get_copyright       :: proc(png_ptr: Const_Structrp) -> Const_Charp ---
	get_header_ver      :: proc(png_ptr: Const_Structrp) -> Const_Charp ---
	get_header_version  :: proc(png_ptr: Const_Structrp) -> Const_Charp ---
	get_libpng_ver      :: proc(png_ptr: Const_Structrp) -> Const_Charp ---
	permit_mng_features :: proc(png_ptr: Structrp, mng_features_permitted: Uint_32) -> Uint_32 ---
}

/* For use in png_set_keep_unknown, added to version 1.2.6 */
HANDLE_CHUNK_AS_DEFAULT   :: 0
HANDLE_CHUNK_NEVER        :: 1
HANDLE_CHUNK_IF_SAFE      :: 2
HANDLE_CHUNK_ALWAYS       :: 3
HANDLE_CHUNK_LAST         :: 4

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_user_limits     :: proc(png_ptr: Structrp, user_width_max: Uint_32, user_height_max: Uint_32) ---
	get_user_width_max  :: proc(png_ptr: Const_Structrp) -> Uint_32 ---
	get_user_height_max :: proc(png_ptr: Const_Structrp) -> Uint_32 ---

	/* Added in libpng-1.4.0 */
	set_chunk_cache_max :: proc(png_ptr: Structrp, user_chunk_cache_max: Uint_32) ---
	get_chunk_cache_max :: proc(png_ptr: Const_Structrp) -> Uint_32 ---

	/* Added in libpng-1.4.1 */
	set_chunk_malloc_max      :: proc(png_ptr: Structrp, user_chunk_cache_max: Alloc_Size_T) ---
	get_chunk_malloc_max      :: proc(png_ptr: Const_Structrp) -> Alloc_Size_T ---
	get_pixels_per_inch       :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---
	get_x_pixels_per_inch     :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---
	get_y_pixels_per_inch     :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Uint_32 ---
	get_x_offset_inches       :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> f32 ---
	get_x_offset_inches_fixed :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Fixed_Point ---
	get_y_offset_inches       :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> f32 ---
	get_y_offset_inches_fixed :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp) -> Fixed_Point ---
	get_pHYs_dpi              :: proc(png_ptr: Const_Structrp, info_ptr: Const_Inforp, res_x: ^Uint_32, res_y: ^Uint_32, unit_type: ^i32) -> Uint_32 ---
	get_io_state              :: proc(png_ptr: Const_Structrp) -> Uint_32 ---

	/* Removed from libpng 1.6; use png_get_io_chunk_type. */
	get_io_chunk_type :: proc(png_ptr: Const_Structrp) -> Uint_32 ---
}

/* The flags returned by png_get_io_state() are the following: */
IO_NONE        :: 0x0000   /* no I/O at this moment */
IO_READING     :: 0x0001   /* currently reading */
IO_WRITING     :: 0x0002   /* currently writing */
IO_SIGNATURE   :: 0x0010   /* currently at the file signature */
IO_CHUNK_HDR   :: 0x0020   /* currently at the chunk header */
IO_CHUNK_DATA  :: 0x0040   /* currently at the chunk data */
IO_CHUNK_CRC   :: 0x0080   /* currently at the chunk crc */
IO_MASK_OP     :: 0x000f   /* current operation: reading/writing */
IO_MASK_LOC    :: 0x00f0   /* current location: sig/hdr/data/crc */

/* Interlace support.  The following macros are always defined so that if
* libpng interlace handling is turned off the macros may be used to handle
* interlaced images within the application.
*/
INTERLACE_ADAM7_PASSES :: 7

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	get_uint_32                 :: proc(buf: Const_Bytep) -> Uint_32 ---
	get_uint_16                 :: proc(buf: Const_Bytep) -> Uint_16 ---
	get_int_32                  :: proc(buf: Const_Bytep) -> Int_32 ---
	get_uint_31                 :: proc(png_ptr: Const_Structrp, buf: Const_Bytep) -> Uint_32 ---
	save_uint_32                :: proc(buf: Bytep, i: Uint_32) ---
	save_int_32                 :: proc(buf: Bytep, i: Int_32) ---
	save_uint_16                :: proc(buf: Bytep, i: u32) ---
	set_check_for_invalid_index :: proc(png_ptr: Structrp, allowed: i32) ---
	get_palette_max             :: proc(png_ptr: Const_Structp, info_ptr: Const_Infop) -> i32 ---
}

IMAGE_VERSION :: 1

Controlp :: ^Control
Control  :: struct {}

Image :: struct {
	opaque:           Controlp, /* Initialize to NULL, free with png_image_free */
	version:          Uint_32,  /* Set to PNG_IMAGE_VERSION */
	width:            Uint_32,  /* Image width in pixels (columns) */
	height:           Uint_32,  /* Image height in pixels (rows) */
	format:           Uint_32,  /* Image format as defined below */
	flags:            Uint_32,  /* A bit mask containing informational flags */
	colormap_entries: Uint_32,
	warning_or_error: Uint_32,
	message:          [64]i8,
}

/* Number of entries in the color-map */

/* In the event of an error or warning the following field will be set to a
* non-zero value and the 'message' field will contain a '\0' terminated
* string with the libpng error or warning message.  If both warnings and
* an error were encountered, only the error is recorded.  If there
* are multiple warnings, only the first one is recorded.
*
* The upper 30 bits of this value are reserved, the low two bits contain
* a value as follows:
*/
IMAGE_WARNING :: 1
IMAGE_ERROR   :: 2

Imagep :: ^Image

/* The samples of the image have one to four channels whose components have
* original values in the range 0 to 1.0:
*
* 1: A single gray or luminance channel (G).
* 2: A gray/luminance channel and an alpha channel (GA).
* 3: Three red, green, blue color channels (RGB).
* 4: Three color channels and an alpha channel (RGBA).
*
* The components are encoded in one of two ways:
*
* a) As a small integer, value 0..255, contained in a single byte.  For the
* alpha channel the original value is simply value/255.  For the color or
* luminance channels the value is encoded according to the sRGB specification
* and matches the 8-bit format expected by typical display devices.
*
* The color/gray channels are not scaled (pre-multiplied) by the alpha
* channel and are suitable for passing to color management software.
*
* b) As a value in the range 0..65535, contained in a 2-byte integer.  All
* channels can be converted to the original value by dividing by 65535; all
* channels are linear.  Color channels use the RGB encoding (RGB end-points) of
* the sRGB specification.  This encoding is identified by the
* PNG_FORMAT_FLAG_LINEAR flag below.
*
* When the simplified API needs to convert between sRGB and linear colorspaces,
* the actual sRGB transfer curve defined in the sRGB specification (see the
* article at <https://en.wikipedia.org/wiki/SRGB>) is used, not the gamma=1/2.2
* approximation used elsewhere in libpng.
*
* When an alpha channel is present it is expected to denote pixel coverage
* of the color or luminance channels and is returned as an associated alpha
* channel: the color/gray channels are scaled (pre-multiplied) by the alpha
* value.
*
* The samples are either contained directly in the image data, between 1 and 8
* bytes per pixel according to the encoding, or are held in a color-map indexed
* by bytes in the image data.  In the case of a color-map the color-map entries
* are individual samples, encoded as above, and the image data has one byte per
* pixel to select the relevant sample from the color-map.
*/

/* PNG_FORMAT_*
*
* #defines to be used in png_image::format.  Each #define identifies a
* particular layout of sample data and, if present, alpha values.  There are
* separate defines for each of the two component encodings.
*
* A format is built up using single bit flag values.  All combinations are
* valid.  Formats can be built up from the flag values or you can use one of
* the predefined values below.  When testing formats always use the FORMAT_FLAG
* macros to test for individual features - future versions of the library may
* add new flags.
*
* When reading or writing color-mapped images the format should be set to the
* format of the entries in the color-map then png_image_{read,write}_colormap
* called to read or write the color-map and set the format correctly for the
* image data.  Do not set the PNG_FORMAT_FLAG_COLORMAP bit directly!
*
* NOTE: libpng can be built with particular features disabled. If you see
* compiler errors because the definition of one of the following flags has been
* compiled out it is because libpng does not have the required support.  It is
* possible, however, for the libpng configuration to enable the format on just
* read or just write; in that case you may see an error at run time.  You can
* guard against this by checking for the definition of the appropriate
* "_SUPPORTED" macro, one of:
*
*    PNG_SIMPLIFIED_{READ,WRITE}_{BGR,AFIRST}_SUPPORTED
*/
FORMAT_FLAG_ALPHA            :: 0x01 /* format with an alpha channel */
FORMAT_FLAG_COLOR            :: 0x02 /* color format: otherwise grayscale */
FORMAT_FLAG_LINEAR           :: 0x04 /* 2-byte channels else 1-byte */
FORMAT_FLAG_COLORMAP         :: 0x08 /* image data is color-mapped */
FORMAT_FLAG_BGR              :: 0x10 /* BGR colors, else order is RGB */
FORMAT_FLAG_AFIRST           :: 0x20 /* alpha channel comes first */
FORMAT_FLAG_ASSOCIATED_ALPHA :: 0x40 /* alpha channel is associated */

/* Commonly used formats have predefined macros.
*
* First the single byte (sRGB) formats:
*/
FORMAT_GRAY :: 0
FORMAT_GA   :: FORMAT_FLAG_ALPHA
FORMAT_AG   :: (FORMAT_GA|FORMAT_FLAG_AFIRST)
FORMAT_RGB  :: FORMAT_FLAG_COLOR
FORMAT_BGR  :: (FORMAT_FLAG_COLOR|FORMAT_FLAG_BGR)
FORMAT_RGBA :: (FORMAT_RGB|FORMAT_FLAG_ALPHA)
FORMAT_ARGB :: (FORMAT_RGBA|FORMAT_FLAG_AFIRST)
FORMAT_BGRA :: (FORMAT_BGR|FORMAT_FLAG_ALPHA)
FORMAT_ABGR :: (FORMAT_BGRA|FORMAT_FLAG_AFIRST)

/* Then the linear 2-byte formats.  When naming these "Y" is used to
* indicate a luminance (gray) channel.
*/
FORMAT_LINEAR_Y         :: FORMAT_FLAG_LINEAR
FORMAT_LINEAR_Y_ALPHA   :: (FORMAT_FLAG_LINEAR|FORMAT_FLAG_ALPHA)
FORMAT_LINEAR_RGB       :: (FORMAT_FLAG_LINEAR|FORMAT_FLAG_COLOR)
FORMAT_LINEAR_RGB_ALPHA :: (FORMAT_FLAG_LINEAR|FORMAT_FLAG_COLOR|FORMAT_FLAG_ALPHA)

/* With color-mapped formats the image data is one byte for each pixel, the byte
* is an index into the color-map which is formatted as above.  To obtain a
* color-mapped format it is sufficient just to add the PNG_FOMAT_FLAG_COLORMAP
* to one of the above definitions, or you can use one of the definitions below.
*/
FORMAT_RGB_COLORMAP  :: (FORMAT_RGB|FORMAT_FLAG_COLORMAP)
FORMAT_BGR_COLORMAP  :: (FORMAT_BGR|FORMAT_FLAG_COLORMAP)
FORMAT_RGBA_COLORMAP :: (FORMAT_RGBA|FORMAT_FLAG_COLORMAP)
FORMAT_ARGB_COLORMAP :: (FORMAT_ARGB|FORMAT_FLAG_COLORMAP)
FORMAT_BGRA_COLORMAP :: (FORMAT_BGRA|FORMAT_FLAG_COLORMAP)
FORMAT_ABGR_COLORMAP :: (FORMAT_ABGR|FORMAT_FLAG_COLORMAP)

/* Return the size, in bytes, of the color-map of this image.  If the image
* format is not a color-map format this will return a size sufficient for
* 256 entries in the given format; check PNG_FORMAT_FLAG_COLORMAP if
* you don't want to allocate a color-map in this case.
*/

/* PNG_IMAGE_FLAG_*
*
* Flags containing additional information about the image are held in the
* 'flags' field of png_image.
*/
IMAGE_FLAG_COLORSPACE_NOT_sRGB :: 0x01

/* This indicates that the RGB values of the in-memory bitmap do not
* correspond to the red, green and blue end-points defined by sRGB.
*/
IMAGE_FLAG_FAST :: 0x02

/* On write emphasise speed over compression; the resultant PNG file will be
* larger but will be produced significantly faster, particular for large
* images.  Do not use this option for images which will be distributed, only
* used it when producing intermediate files that will be read back in
* repeatedly.  For a typical 24-bit image the option will double the read
* speed at the cost of increasing the image size by 25%, however for many
* more compressible images the PNG file can be 10 times larger with only a
* slight speed gain.
*/
IMAGE_FLAG_16BIT_sRGB :: 0x04

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	image_begin_read_from_file :: proc(image: Imagep, file_name: cstring) -> i32 ---

	/* The named file is opened for read and the image header is filled in
	* from the PNG header in the file.
	*/
	image_begin_read_from_stdio  :: proc(image: Imagep, file: ^File) -> i32 ---
	image_begin_read_from_memory :: proc(image: Imagep, memory: Const_Voidp, size: c.size_t) -> i32 ---

	/* The PNG header is read from the given memory buffer. */
	image_finish_read :: proc(image: Imagep, background: Const_Colorp, buffer: rawptr, row_stride: Int_32, colormap: rawptr) -> i32 ---

	/* Finish reading the image into the supplied buffer and clean up the
	* png_image structure.
	*
	* row_stride is the step, in byte or 2-byte units as appropriate,
	* between adjacent rows.  A positive stride indicates that the top-most row
	* is first in the buffer - the normal top-down arrangement.  A negative
	* stride indicates that the bottom-most row is first in the buffer.
	*
	* background need only be supplied if an alpha channel must be removed from
	* a png_byte format and the removal is to be done by compositing on a solid
	* color; otherwise it may be NULL and any composition will be done directly
	* onto the buffer.  The value is an sRGB color to use for the background,
	* for grayscale output the green channel is used.
	*
	* background must be supplied when an alpha channel must be removed from a
	* single byte color-mapped output format, in other words if:
	*
	* 1) The original format from png_image_begin_read_from_* had
	*    PNG_FORMAT_FLAG_ALPHA set.
	* 2) The format set by the application does not.
	* 3) The format set by the application has PNG_FORMAT_FLAG_COLORMAP set and
	*    PNG_FORMAT_FLAG_LINEAR *not* set.
	*
	* For linear output removing the alpha channel is always done by compositing
	* on black and background is ignored.
	*
	* colormap must be supplied when PNG_FORMAT_FLAG_COLORMAP is set.  It must
	* be at least the size (in bytes) returned by PNG_IMAGE_COLORMAP_SIZE.
	* image->colormap_entries will be updated to the actual number of entries
	* written to the colormap; this may be less than the original value.
	*/
	image_free          :: proc(image: Imagep) ---
	image_write_to_file :: proc(image: Imagep, file: cstring, convert_to_8bit: i32, buffer: rawptr, row_stride: Int_32, colormap: rawptr) -> i32 ---

	/* Write the image to the named file. */
	image_write_to_stdio :: proc(image: Imagep, file: ^File, convert_to_8_bit: i32, buffer: rawptr, row_stride: Int_32, colormap: rawptr) -> i32 ---

	/* With all write APIs if image is in one of the linear formats with 16-bit
	* data then setting convert_to_8_bit will cause the output to be an 8-bit PNG
	* gamma encoded according to the sRGB specification, otherwise a 16-bit linear
	* encoded PNG file is written.
	*
	* With color-mapped data formats the colormap parameter point to a color-map
	* with at least image->colormap_entries encoded in the specified format.  If
	* the format is linear the written PNG color-map will be converted to sRGB
	* regardless of the convert_to_8_bit flag.
	*
	* With all APIs row_stride is handled as in the read APIs - it is the spacing
	* from one row to the next in component sized units (1 or 2 bytes) and if
	* negative indicates a bottom-up row layout in the buffer.  If row_stride is
	* zero, libpng will calculate it for you from the image width and number of
	* channels.
	*
	* Note that the write API does not support interlacing, sub-8-bit pixels or
	* most ancillary chunks.  If you need to write text chunks (e.g. for copyright
	* notices) you need to use one of the other APIs.
	*/
	image_write_to_memory :: proc(image: Imagep, memory: rawptr, memory_bytes: ^Alloc_Size_T, convert_to_8_bit: i32, buffer: rawptr, row_stride: Int_32, colormap: rawptr) -> i32 ---
}

/* SOFTWARE: Force maximum window */
MAXIMUM_INFLATE_WINDOW :: 2

/* SOFTWARE: Check ICC profile for sRGB */
SKIP_sRGB_CHECK_PROFILE :: 4

/* Next option - numbers must be even */
OPTION_NEXT :: 16

/* Return values: NOTE: there are four values and 'off' is *not* zero */
OPTION_UNSET   :: 0 /* Unset - defaults to off */
OPTION_INVALID :: 1 /* Option number out of range */
OPTION_OFF     :: 2
OPTION_ON      :: 3

@(default_calling_convention="c", link_prefix="png_")
foreign lib {
	set_option :: proc(png_ptr: Structrp, option: i32, onoff: i32) -> i32 ---
}

