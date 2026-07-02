// Copyright 2012 Google Inc. All Rights Reserved.
//
// Use of this source code is governed by a BSD-style license
// that can be found in the COPYING file in the root of the source
// tree. An additional intellectual property rights grant can be found
// in the file PATENTS. All contributing project authors may
// be found in the AUTHORS file in the root of the source tree.
// -----------------------------------------------------------------------------
//
// Data-types common to the mux and demux libraries.
//
// Author: Urvang (urvang@google.com)
package webp

import "core:c"

foreign import lib "system:webp"
_ :: lib

// VP8X Feature Flags.
FeatureFlags :: enum u32 {
	ANIMATION_FLAG  = 2,
	XMP_FLAG        = 4,
	EXIF_FLAG       = 8,
	ALPHA_FLAG      = 16,
	ICCP_FLAG       = 32,
	ALL_VALID_FLAGS = 62,
}

// Dispose method (animation only). Indicates how the area used by the current
// frame is to be treated before rendering the next frame on the canvas.
MuxAnimDispose :: enum u32 {
	NONE       = 0, // Do not dispose.
	BACKGROUND = 1, // Dispose to background color.
}

// Blend operation (animation only). Indicates how transparent pixels of the
// current frame are blended with those of the previous canvas.
MuxAnimBlend :: enum u32 {
	BLEND    = 0, // Blend.
	NO_BLEND = 1, // Do not blend.
}

// Data type used to describe 'raw' data, e.g., chunk data
// (ICC profile, metadata) and WebP compressed image data.
// 'bytes' memory must be allocated using WebPMalloc() and such.
Data :: struct {
	bytes: ^u8,
	size:  c.size_t,
}

