// Copyright 2011 Google Inc. All Rights Reserved.
//
// Use of this source code is governed by a BSD-style license
// that can be found in the COPYING file in the root of the source
// tree. An additional intellectual property rights grant can be found
// in the file PATENTS. All contributing project authors may
// be found in the AUTHORS file in the root of the source tree.
// -----------------------------------------------------------------------------
//
//   WebP encoder: main interface
//
// Author: Skal (pascal.massimino@gmail.com)
package webp

import "core:c"

foreign import lib "system:webp"
_ :: lib

ENCODER_ABI_VERSION :: 0x0210  // MAJOR(8b) + MINOR(8b)

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Return the encoder's version number, packed in hexadecimal using 8bits for
	// each of major/minor/revision. E.g: v2.5.7 is 0x020507.
	GetEncoderVersion :: proc() -> i32 ---

	// Returns the size of the compressed data (pointed to by *output), or 0 if
	// an error occurred. The compressed data must be released by the caller
	// using the call 'WebPFree(*output)'.
	// These functions compress using the lossy format, and the quality_factor
	// can go from 0 (smaller output, lower quality) to 100 (best quality,
	// larger output).
	EncodeRGB  :: proc(rgb: ^u8, width: i32, height: i32, stride: i32, quality_factor: f32, output: ^^u8) -> c.size_t ---
	EncodeBGR  :: proc(bgr: ^u8, width: i32, height: i32, stride: i32, quality_factor: f32, output: ^^u8) -> c.size_t ---
	EncodeRGBA :: proc(rgba: ^u8, width: i32, height: i32, stride: i32, quality_factor: f32, output: ^^u8) -> c.size_t ---
	EncodeBGRA :: proc(bgra: ^u8, width: i32, height: i32, stride: i32, quality_factor: f32, output: ^^u8) -> c.size_t ---

	// These functions are the equivalent of the above, but compressing in a
	// lossless manner. Files are usually larger than lossy format, but will
	// not suffer any compression loss.
	// Note these functions, like the lossy versions, use the library's default
	// settings. For lossless this means 'exact' is disabled. RGB values in
	// transparent areas will be modified to improve compression. To avoid this,
	// use WebPEncode() and set WebPConfig::exact to 1.
	EncodeLosslessRGB  :: proc(rgb: ^u8, width: i32, height: i32, stride: i32, output: ^^u8) -> c.size_t ---
	EncodeLosslessBGR  :: proc(bgr: ^u8, width: i32, height: i32, stride: i32, output: ^^u8) -> c.size_t ---
	EncodeLosslessRGBA :: proc(rgba: ^u8, width: i32, height: i32, stride: i32, output: ^^u8) -> c.size_t ---
	EncodeLosslessBGRA :: proc(bgra: ^u8, width: i32, height: i32, stride: i32, output: ^^u8) -> c.size_t ---
}

// Image characteristics hint for the underlying encoder.
ImageHint :: enum u32 {
	DEFAULT = 0, // default preset.
	PICTURE = 1, // digital picture, like portrait, inner shot
	PHOTO   = 2, // outdoor photograph, with natural lighting
	GRAPH   = 3, // Discrete tone image (graph, map-tile etc).
	LAST    = 4,
}

// Compression parameters.
Config :: struct {
	lossless: i32, // Lossless encoding (0=lossy(default), 1=lossless).
	quality:  f32, // between 0 and 100. For lossy, 0 gives the smallest

	// size and 100 the largest. For lossless, this
	// parameter is the amount of effort put into the
	// compression: 0 is the fastest but gives larger
	// files compared to the slowest, but best, 100.
	method:      i32,       // quality/speed trade-off (0=fast, 6=slower-better)
	image_hint:  ImageHint, // Hint for image type (lossless only for now).
	target_size: i32,       // if non-zero, set the desired target size in bytes.

	// Takes precedence over the 'compression' parameter.
	target_PSNR: f32, // if non-zero, specifies the minimal distortion to

	// try to achieve. Takes precedence over target_size.
	segments:         i32, // maximum number of segments to use, in [1..4]
	sns_strength:     i32, // Spatial Noise Shaping. 0=off, 100=maximum.
	filter_strength:  i32, // range: [0 = off .. 100 = strongest]
	filter_sharpness: i32, // range: [0 = off .. 7 = least sharp]
	filter_type:      i32, // filtering type: 0 = simple, 1 = strong (only used

	// if filter_strength > 0 or autofilter > 0)
	autofilter:        i32, // Auto adjust filter's strength [0 = off, 1 = on]
	alpha_compression: i32, // Algorithm for encoding the alpha plane (0 = none,

	// 1 = compressed with WebP lossless). Default is 1.
	alpha_filtering: i32, // Predictive filtering method for alpha plane.

	//  0: none, 1: fast, 2: best. Default if 1.
	alpha_quality: i32, // Between 0 (smallest size) and 100 (lossless).

	// Default is 100.
	pass:            i32, // number of entropy-analysis passes (in [1..10]).
	show_compressed: i32, // if true, export the compressed picture back.

	// In-loop filtering is not applied.
	preprocessing: i32, // preprocessing filter:

	// 0=none, 1=segment-smooth, 2=pseudo-random dithering
	partitions: i32, // log2(number of token partitions) in [0..3]. Default

	// is set to 0 for easier progressive decoding.
	partition_limit: i32, // quality degradation allowed to fit the 512k limit

	// on prediction modes coding (0: no degradation,
	// 100: maximum possible degradation).
	emulate_jpeg_size: i32, // If true, compression parameters will be remapped

	// to better match the expected output size from
	// JPEG compression. Generally, the output size will
	// be similar but the degradation will be lower.
	thread_level:  i32, // If non-zero, try and use multi-threaded encoding.
	low_memory:    i32, // If set, reduce memory usage (but increase CPU use).
	near_lossless: i32, // Near lossless encoding [0 = max loss .. 100 = off

	// (default)].
	exact: i32, // if non-zero, preserve the exact RGB values under

	// transparent area. Otherwise, discard this invisible
	// RGB information for better compression. The default
	// value is 0.
	use_delta_palette: i32, // reserved
	use_sharp_yuv:     i32, // if needed, use sharp (and slow) RGB->YUV conversion
	qmin:              i32, // minimum permissible quality factor
	qmax:              i32, // maximum permissible quality factor
}

// Enumerate some predefined settings for WebPConfig, depending on the type
// of source picture. These presets are used when calling WebPConfigPreset().
Preset :: enum u32 {
	DEFAULT = 0, // default preset.
	PICTURE = 1, // digital picture, like portrait, inner shot
	PHOTO   = 2, // outdoor photograph, with natural lighting
	DRAWING = 3, // hand or line drawing, with high-contrast details
	ICON    = 4, // small-sized colorful images
	TEXT    = 5, // text-like
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Internal, version-checked, entry point
	ConfigInitInternal :: proc(^Config, Preset, f32, i32) -> i32 ---

	// Activate the lossless compression mode with the desired efficiency level
	// between 0 (fastest, lowest compression) and 9 (slower, best compression).
	// A good default level is '6', providing a fair tradeoff between compression
	// speed and final compressed size.
	// This function will overwrite several fields from config: 'method', 'quality'
	// and 'lossless'. Returns false in case of parameter error.
	ConfigLosslessPreset :: proc(config: ^Config, level: i32) -> i32 ---

	// Returns true if 'config' is non-NULL and all configuration parameters are
	// within their valid ranges.
	ValidateConfig :: proc(config: ^Config) -> i32 ---
}

//------------------------------------------------------------------------------
// Input / Output
// Structure for storing auxiliary statistics.
AuxStats :: struct {
	coded_size:   i32,    // final size
	PSNR:         [5]f32, // peak-signal-to-noise ratio for Y/U/V/All/Alpha
	block_count:  [3]i32, // number of intra4/intra16/skipped macroblocks
	header_bytes: [2]i32, // approximate number of bytes spent for header

	// and mode-partition #0
	residual_bytes: [3][4]i32, // approximate number of bytes spent for

	// DC/AC/uv coefficients for each (0..3) segments.
	segment_size:    [4]i32, // number of macroblocks in each segments
	segment_quant:   [4]i32, // quantizer values for each segments
	segment_level:   [4]i32, // filtering strength for each segments [0..63]
	alpha_data_size: i32,    // size of the transparency data
	layer_data_size: i32,    // size of the enhancement layer data

	// lossless encoder statistics
	lossless_features: u32, // bit0:predictor bit1:cross-color transform

	// bit2:subtract-green bit3:color indexing
	histogram_bits:             i32,    // number of precision bits of histogram
	transform_bits:             i32,    // precision bits for predictor transform
	cache_bits:                 i32,    // number of bits for color cache lookup
	palette_size:               i32,    // number of color in palette, if used
	lossless_size:              i32,    // final lossless size
	lossless_hdr_size:          i32,    // lossless header (transform, huffman etc) size
	lossless_data_size:         i32,    // lossless image data size
	cross_color_transform_bits: i32,    // precision bits for cross-color transform
	pad:                        [1]u32, // padding for later use
}

// Signature for output function. Should return true if writing was successful.
// data/data_size is the segment of data to write, and 'picture' is for
// reference (and so one can make use of picture->custom_ptr).
WriterFunction :: proc "c" (data: ^u8, data_size: c.size_t, picture: ^Picture) -> i32

// WebPMemoryWrite: a special WebPWriterFunction that writes to memory using
// the following WebPMemoryWriter object (to be set as a custom_ptr).
MemoryWriter :: struct {
	mem:      ^u8,      // final buffer (of size 'max_size', larger than 'size').
	size:     c.size_t, // final size
	max_size: c.size_t, // total capacity
	pad:      [1]u32,   // padding for later use
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// The following must be called first before any use.
	MemoryWriterInit :: proc(writer: ^MemoryWriter) ---

	// The following must be called to deallocate writer->mem memory. The 'writer'
	// object itself is not deallocated.
	MemoryWriterClear :: proc(writer: ^MemoryWriter) ---

	// The custom writer to be used with WebPMemoryWriter as custom_ptr. Upon
	// completion, writer.mem and writer.size will hold the coded data.
	// writer.mem must be freed by calling WebPMemoryWriterClear.
	MemoryWrite :: proc(data: ^u8, data_size: c.size_t, picture: ^Picture) -> i32 ---
}

// Progress hook, called from time to time to report progress. It can return
// false to request an abort of the encoding process, or true otherwise if
// everything is OK.
ProgressHook :: proc "c" (percent: i32, picture: ^Picture) -> i32

// Color spaces.
EncCSP :: enum u32 {
	// chroma sampling
	YUV420        = 0, // 4:2:0
	YUV420A       = 4, // alpha channel variant
	CSP_UV_MASK   = 3, // bit-mask to get the UV sampling factors
	CSP_ALPHA_BIT = 4, // bit that is set if alpha is present
}

// Encoding error conditions.
EncodingError :: enum u32 {
	OK                            = 0,
	ERROR_OUT_OF_MEMORY           = 1,  // memory error allocating objects
	ERROR_BITSTREAM_OUT_OF_MEMORY = 2,  // memory error while flushing bits
	ERROR_NULL_PARAMETER          = 3,  // a pointer parameter is NULL
	ERROR_INVALID_CONFIGURATION   = 4,  // configuration is invalid
	ERROR_BAD_DIMENSION           = 5,  // picture has invalid width/height
	ERROR_PARTITION0_OVERFLOW     = 6,  // partition is bigger than 512k
	ERROR_PARTITION_OVERFLOW      = 7,  // partition is bigger than 16M
	ERROR_BAD_WRITE               = 8,  // error while flushing bytes
	ERROR_FILE_TOO_BIG            = 9,  // file is bigger than 4G
	ERROR_USER_ABORT              = 10, // abort request by user
	ERROR_LAST                    = 11, // list terminator. always last.
}

// maximum width/height allowed (inclusive), in pixels
MAX_DIMENSION :: 16383

// Main exchange structure (input samples, output bytes, statistics)
//
// Once WebPPictureInit() has been called, it's ok to make all the INPUT fields
// (use_argb, y/u/v, argb, ...) point to user-owned data, even if
// WebPPictureAlloc() has been called. Depending on the value use_argb,
// it's guaranteed that either *argb or *y/*u/*v content will be kept untouched.
Picture :: struct {
	//   INPUT
	//////////////
	// Main flag for encoder selecting between ARGB or YUV input.
	// It is recommended to use ARGB input (*argb, argb_stride) for lossless
	// compression, and YUV input (*y, *u, *v, etc.) for lossy compression
	// since these are the respective native colorspace for these formats.
	use_argb: b32,

	// YUV input (mostly used for input to lossy compression)
	colorspace:          EncCSP, // colorspace: should be YUV420 for now (=Y'CbCr).
	width, height:       i32,    // dimensions (less or equal to WEBP_MAX_DIMENSION)
	y, u, v:             ^u8,    // pointers to luma/chroma planes.
	y_stride, uv_stride: i32,    // luma/chroma strides.
	a:                   ^u8,    // pointer to the alpha plane
	a_stride:            i32,    // stride of the alpha plane
	pad1:                [2]u32, // padding for later use

	// ARGB input (mostly used for input to lossless compression)
	argb:        ^u32,   // Pointer to argb (32 bit) plane.
	argb_stride: i32,    // This is stride in pixels units, not bytes.
	pad2:        [3]u32, // padding for later use

	//   OUTPUT
	///////////////
	// Byte-emission hook, to store compressed bytes as they are ready.
	writer:     WriterFunction, // can be NULL
	custom_ptr: rawptr,         // can be used by the writer.

	// map for extra information (only for lossy compression mode)
	extra_info_type: i32, // 1: intra type, 2: segment, 3: quant

	// 4: intra-16 prediction mode,
	// 5: chroma prediction mode,
	// 6: bit cost, 7: distortion
	extra_info: ^u8, // if not NULL, points to an array of size

	// ((width + 15) / 16) * ((height + 15) / 16) that
	// will be filled with a macroblock map, depending
	// on extra_info_type.
	
	//   STATS AND REPORTS
	///////////////////////////
	// Pointer to side statistics (updated only if not NULL)
	stats: ^AuxStats,

	// Error code for the latest error encountered during encoding
	error_code: EncodingError,

	// If not NULL, report progress during encoding.
	progress_hook: ProgressHook,
	user_data:     rawptr, // this field is free to be set to any value and

	// used during callbacks (like progress-report e.g.).
	pad3: [3]u32, // padding for later use

	// Unused for now
	pad4, pad5: ^u8,
	pad6:       [8]u32, // padding for later use

	// PRIVATE FIELDS
	////////////////////
	memory_:      rawptr,    // row chunk of memory for yuva planes
	memory_argb_: rawptr,    // and for argb too.
	pad7:         [2]rawptr, // padding for later use
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Internal, version-checked, entry point
	PictureInitInternal :: proc(^Picture, i32) -> i32 ---

	// Convenience allocation / deallocation based on picture->width/height:
	// Allocate y/u/v buffers as per colorspace/width/height specification.
	// Note! This function will free the previous buffer if needed.
	// Returns false in case of memory error.
	PictureAlloc :: proc(picture: ^Picture) -> i32 ---

	// Release the memory allocated by WebPPictureAlloc() or WebPPictureImport*().
	// Note that this function does _not_ free the memory used by the 'picture'
	// object itself.
	// Besides memory (which is reclaimed) all other fields of 'picture' are
	// preserved.
	PictureFree :: proc(picture: ^Picture) ---

	// Copy the pixels of *src into *dst, using WebPPictureAlloc. Upon return, *dst
	// will fully own the copied pixels (this is not a view). The 'dst' picture need
	// not be initialized as its content is overwritten.
	// Returns false in case of memory allocation error.
	PictureCopy :: proc(src: ^Picture, dst: ^Picture) -> i32 ---

	// Compute the single distortion for packed planes of samples.
	// 'src' will be compared to 'ref', and the raw distortion stored into
	// '*distortion'. The refined metric (log(MSE), log(1 - ssim),...' will be
	// stored in '*result'.
	// 'x_step' is the horizontal stride (in bytes) between samples.
	// 'src/ref_stride' is the byte distance between rows.
	// Returns false in case of error (bad parameter, memory allocation error, ...).
	PlaneDistortion :: proc(src: ^u8, src_stride: c.size_t, ref: ^u8, ref_stride: c.size_t, width: i32, height: i32, x_step: c.size_t, type: i32, distortion: ^f32, result: ^f32) -> i32 ---

	// Compute PSNR, SSIM or LSIM distortion metric between two pictures. Results
	// are in dB, stored in result[] in the B/G/R/A/All order. The distortion is
	// always performed using ARGB samples. Hence if the input is YUV(A), the
	// picture will be internally converted to ARGB (just for the measurement).
	// Warning: this function is rather CPU-intensive.
	PictureDistortion :: proc(src: ^Picture, ref: ^Picture, metric_type: i32, result: ^[5]f32) -> i32 ---

	// self-crops a picture to the rectangle defined by top/left/width/height.
	// Returns false in case of memory allocation error, or if the rectangle is
	// outside of the source picture.
	// The rectangle for the view is defined by the top-left corner pixel
	// coordinates (left, top) as well as its width and height. This rectangle
	// must be fully be comprised inside the 'src' source picture. If the source
	// picture uses the YUV420 colorspace, the top and left coordinates will be
	// snapped to even values.
	PictureCrop :: proc(picture: ^Picture, left: i32, top: i32, width: i32, height: i32) -> i32 ---

	// Extracts a view from 'src' picture into 'dst'. The rectangle for the view
	// is defined by the top-left corner pixel coordinates (left, top) as well
	// as its width and height. This rectangle must be fully be comprised inside
	// the 'src' source picture. If the source picture uses the YUV420 colorspace,
	// the top and left coordinates will be snapped to even values.
	// Picture 'src' must out-live 'dst' picture. Self-extraction of view is allowed
	// ('src' equal to 'dst') as a mean of fast-cropping (but note that doing so,
	// the original dimension will be lost). Picture 'dst' need not be initialized
	// with WebPPictureInit() if it is different from 'src', since its content will
	// be overwritten.
	// Returns false in case of invalid parameters.
	PictureView :: proc(src: ^Picture, left: i32, top: i32, width: i32, height: i32, dst: ^Picture) -> i32 ---

	// Returns true if the 'picture' is actually a view and therefore does
	// not own the memory for pixels.
	PictureIsView :: proc(picture: ^Picture) -> i32 ---

	// Rescale a picture to new dimension width x height.
	// If either 'width' or 'height' (but not both) is 0 the corresponding
	// dimension will be calculated preserving the aspect ratio.
	// No gamma correction is applied.
	// Returns false in case of error (invalid parameter or insufficient memory).
	PictureRescale :: proc(picture: ^Picture, width: i32, height: i32) -> i32 ---

	// Colorspace conversion function to import RGB samples.
	// Previous buffer will be free'd, if any.
	// *rgb buffer should have a size of at least height * rgb_stride.
	// Returns false in case of memory error.
	PictureImportRGB :: proc(picture: ^Picture, rgb: ^u8, rgb_stride: i32) -> i32 ---

	// Same, but for RGBA buffer.
	PictureImportRGBA :: proc(picture: ^Picture, rgba: ^u8, rgba_stride: i32) -> i32 ---

	// Same, but for RGBA buffer. Imports the RGB direct from the 32-bit format
	// input buffer ignoring the alpha channel. Avoids needing to copy the data
	// to a temporary 24-bit RGB buffer to import the RGB only.
	PictureImportRGBX :: proc(picture: ^Picture, rgbx: ^u8, rgbx_stride: i32) -> i32 ---

	// Variants of the above, but taking BGR(A|X) input.
	PictureImportBGR  :: proc(picture: ^Picture, bgr: ^u8, bgr_stride: i32) -> i32 ---
	PictureImportBGRA :: proc(picture: ^Picture, bgra: ^u8, bgra_stride: i32) -> i32 ---
	PictureImportBGRX :: proc(picture: ^Picture, bgrx: ^u8, bgrx_stride: i32) -> i32 ---

	// Converts picture->argb data to the YUV420A format. The 'colorspace'
	// parameter is deprecated and should be equal to WEBP_YUV420.
	// Upon return, picture->use_argb is set to false. The presence of real
	// non-opaque transparent values is detected, and 'colorspace' will be
	// adjusted accordingly. Note that this method is lossy.
	// Returns false in case of error.
	PictureARGBToYUVA :: proc(picture: ^Picture, _: EncCSP) -> i32 ---

	// Same as WebPPictureARGBToYUVA(), but the conversion is done using
	// pseudo-random dithering with a strength 'dithering' between
	// 0.0 (no dithering) and 1.0 (maximum dithering). This is useful
	// for photographic picture.
	PictureARGBToYUVADithered :: proc(picture: ^Picture, colorspace: EncCSP, dithering: f32) -> i32 ---

	// Performs 'sharp' RGBA->YUVA420 downsampling and colorspace conversion
	// Downsampling is handled with extra care in case of color clipping. This
	// method is roughly 2x slower than WebPPictureARGBToYUVA() but produces better
	// and sharper YUV representation.
	// Returns false in case of error.
	PictureSharpARGBToYUVA :: proc(picture: ^Picture) -> i32 ---

	// kept for backward compatibility:
	PictureSmartARGBToYUVA :: proc(picture: ^Picture) -> i32 ---

	// Converts picture->yuv to picture->argb and sets picture->use_argb to true.
	// The input format must be YUV_420 or YUV_420A. The conversion from YUV420 to
	// ARGB incurs a small loss too.
	// Note that the use of this colorspace is discouraged if one has access to the
	// raw ARGB samples, since using YUV420 is comparatively lossy.
	// Returns false in case of error.
	PictureYUVAToARGB :: proc(picture: ^Picture) -> i32 ---

	// Helper function: given a width x height plane of RGBA or YUV(A) samples
	// clean-up or smoothen the YUV or RGB samples under fully transparent area,
	// to help compressibility (no guarantee, though).
	CleanupTransparentArea :: proc(picture: ^Picture) ---

	// Scan the picture 'picture' for the presence of non fully opaque alpha values.
	// Returns true in such case. Otherwise returns false (indicating that the
	// alpha plane can be ignored altogether e.g.).
	PictureHasTransparency :: proc(picture: ^Picture) -> i32 ---

	// Remove the transparency information (if present) by blending the color with
	// the background color 'background_rgb' (specified as 24bit RGB triplet).
	// After this call, all alpha values are reset to 0xff.
	BlendAlpha :: proc(picture: ^Picture, background_rgb: u32) ---

	// Main encoding call, after config and picture have been initialized.
	// 'picture' must be less than 16384x16384 in dimension (cf WEBP_MAX_DIMENSION),
	// and the 'config' object must be a valid one.
	// Returns false in case of error, true otherwise.
	// In case of error, picture->error_code is updated accordingly.
	// 'picture' can hold the source samples in both YUV(A) or ARGB input, depending
	// on the value of 'picture->use_argb'. It is highly recommended to use
	// the former for lossy encoding, and the latter for lossless encoding
	// (when config.lossless is true). Automatic conversion from one format to
	// another is provided but they both incur some loss.
	Encode :: proc(config: ^Config, picture: ^Picture) -> b32 ---
}

