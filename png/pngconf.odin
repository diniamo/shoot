/* pngconf.h - machine-configurable file for libpng
 *
 * libpng version 1.6.58
 *
 * Copyright (c) 2018-2026 Cosmin Truta
 * Copyright (c) 1998-2002,2004,2006-2016,2018 Glenn Randers-Pehrson
 * Copyright (c) 1996-1997 Andreas Dilger
 * Copyright (c) 1995-1996 Guy Eric Schalnat, Group 42, Inc.
 *
 * This code is released under the libpng license.
 * For conditions of distribution and use, see the disclaimer
 * and license in png.h
 *
 * Any machine specific code is near the front of this file, so if you
 * are configuring libpng for a machine, you may want to read the section
 * starting here down to where it starts to typedef png_color, png_text,
 * and png_info.
 */
package png

import "core:c"

foreign import lib "system:png"
_ :: lib

Byte    :: u8
Int_16  :: i16
Uint_16 :: u16
Int_32  :: i32
Uint_32 :: u32

/* Prior to 1.6.0, it was possible to disable the use of size_t and ptrdiff_t.
* From 1.6.0 onwards, an ISO C90 compiler, as well as a standard-compliant
* behavior of sizeof and ptrdiff_t are required.
* The legacy typedefs are provided here for backwards compatibility.
*/
Size_T       :: c.size_t
Ptrdiff_T    :: c.ptrdiff_t
Alloc_Size_T :: c.size_t

/* Typedef for floating-point numbers that are converted to fixed-point with a
* multiple of 100,000, e.g., gamma
*/
Fixed_Point :: Int_32

/* Add typedefs for pointers */
Voidp               :: rawptr
Const_Voidp         :: rawptr
Bytep               :: ^Byte
Const_Bytep         :: ^Byte
Uint_32p            :: ^Uint_32
Const_Uint_32p      :: ^Uint_32
Int_32p             :: ^Int_32
Const_Int_32p       :: ^Int_32
Uint_16p            :: ^Uint_16
Const_Uint_16p      :: ^Uint_16
Int_16p             :: ^Int_16
Const_Int_16p       :: ^Int_16
Charp               :: cstring
Const_Charp         :: cstring
Fixed_Point_P       :: ^Fixed_Point
Const_Fixed_Point_P :: ^Fixed_Point
Size_Tp             :: ^c.size_t
Const_Size_Tp       :: ^c.size_t
Doublep             :: ^f64
Const_Doublep       :: ^f64

/* Pointers to pointers; i.e. arrays */
Bytepp         :: ^^Byte
Uint_32pp      :: ^^Uint_32
Int_32pp       :: ^^Int_32
Uint_16pp      :: ^^Uint_16
Int_16pp       :: ^^Int_16
Const_Charpp   :: ^cstring
Charpp         :: ^cstring
Fixed_Point_Pp :: ^^Fixed_Point
Doublepp       :: ^^f64

/* Pointers to pointers to pointers; i.e., pointer to array */
Charppp :: ^^cstring

