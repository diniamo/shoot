// Copyright 2011 Google Inc. All Rights Reserved.
//
// Use of this source code is governed by a BSD-style license
// that can be found in the COPYING file in the root of the source
// tree. An additional intellectual property rights grant can be found
// in the file PATENTS. All contributing project authors may
// be found in the AUTHORS file in the root of the source tree.
// -----------------------------------------------------------------------------
//
//  RIFF container manipulation and encoding for WebP images.
//
// Authors: Urvang (urvang@google.com)
//          Vikas (vikasa@google.com)
package webp

foreign import lib "system:webp"
_ :: lib

MUX_ABI_VERSION :: 0x0109        // MAJOR(8b) + MINOR(8b)

Mux :: struct {} // main opaque object.

// Error codes
MuxError :: enum i32 {
	OK               = 1,
	NOT_FOUND        = 0,
	INVALID_ARGUMENT = -1,
	BAD_DATA         = -2,
	MEMORY_ERROR     = -3,
	NOT_ENOUGH_DATA  = -4,
}

// IDs for different types of chunks.
ChunkId :: enum u32 {
	VP8X       = 0, // VP8X
	ICCP       = 1, // ICCP
	ANIM       = 2, // ANIM
	ANMF       = 3, // ANMF
	DEPRECATED = 4, // (deprecated from FRGM)
	ALPHA      = 5, // ALPH
	IMAGE      = 6, // VP8/VP8L
	EXIF       = 7, // EXIF
	XMP        = 8, // XMP
	UNKNOWN    = 9, // Other chunks.
	NIL        = 10,
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Returns the version number of the mux library, packed in hexadecimal using
	// 8bits for each of major/minor/revision. E.g: v2.5.7 is 0x020507.
	GetMuxVersion :: proc() -> i32 ---

	// Internal, version-checked, entry point
	NewInternal :: proc(i32) -> ^Mux ---

	// Deletes the mux object.
	// Parameters:
	//   mux - (in/out) object to be deleted
	MuxDelete :: proc(mux: ^Mux) ---

	// Internal, version-checked, entry point
	MuxCreateInternal :: proc(^Data, i32, i32) -> ^Mux ---

	// Adds a chunk with id 'fourcc' and data 'chunk_data' in the mux object.
	// Any existing chunk(s) with the same id will be removed.
	// Parameters:
	//   mux - (in/out) object to which the chunk is to be added
	//   fourcc - (in) a character array containing the fourcc of the given chunk;
	//                 e.g., "ICCP", "XMP ", "EXIF" etc.
	//   chunk_data - (in) the chunk data to be added
	//   copy_data - (in) value 1 indicates given data WILL be copied to the mux
	//               object and value 0 indicates data will NOT be copied. If the
	//               data is not copied, it must exist until a call to
	//               WebPMuxAssemble() is made.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux, fourcc or chunk_data is NULL
	//                               or if fourcc corresponds to an image chunk.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	MuxSetChunk :: proc(mux: ^Mux, fourcc: ^[4]i8, chunk_data: ^Data, copy_data: i32) -> MuxError ---

	// Gets a reference to the data of the chunk with id 'fourcc' in the mux object.
	// The caller should NOT free the returned data.
	// Parameters:
	//   mux - (in) object from which the chunk data is to be fetched
	//   fourcc - (in) a character array containing the fourcc of the chunk;
	//                 e.g., "ICCP", "XMP ", "EXIF" etc.
	//   chunk_data - (out) returned chunk data
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux, fourcc or chunk_data is NULL
	//                               or if fourcc corresponds to an image chunk.
	//   WEBP_MUX_NOT_FOUND - If mux does not contain a chunk with the given id.
	//   WEBP_MUX_OK - on success.
	MuxGetChunk :: proc(mux: ^Mux, fourcc: ^[4]i8, chunk_data: ^Data) -> MuxError ---

	// Deletes the chunk with the given 'fourcc' from the mux object.
	// Parameters:
	//   mux - (in/out) object from which the chunk is to be deleted
	//   fourcc - (in) a character array containing the fourcc of the chunk;
	//                 e.g., "ICCP", "XMP ", "EXIF" etc.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or fourcc is NULL
	//                               or if fourcc corresponds to an image chunk.
	//   WEBP_MUX_NOT_FOUND - If mux does not contain a chunk with the given fourcc.
	//   WEBP_MUX_OK - on success.
	MuxDeleteChunk :: proc(mux: ^Mux, fourcc: ^[4]i8) -> MuxError ---
}

// Encapsulates data about a single frame.
MuxFrameInfo :: struct {
	bitstream: Data, // image data: can be a raw VP8/VP8L bitstream

	// or a single-image WebP file.
	x_offset: i32,     // x-offset of the frame.
	y_offset: i32,     // y-offset of the frame.
	duration: i32,     // duration of the frame (in milliseconds).
	id:       ChunkId, // frame type: should be one of WEBP_CHUNK_ANMF

	// or WEBP_CHUNK_IMAGE
	dispose_method: MuxAnimDispose, // Disposal method for the frame.
	blend_method:   MuxAnimBlend,   // Blend operation for the frame.
	pad:            [1]u32,         // padding for later use
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Sets the (non-animated) image in the mux object.
	// Note: Any existing images (including frames) will be removed.
	// Parameters:
	//   mux - (in/out) object in which the image is to be set
	//   bitstream - (in) can be a raw VP8/VP8L bitstream or a single-image
	//               WebP file (non-animated)
	//   copy_data - (in) value 1 indicates given data WILL be copied to the mux
	//               object and value 0 indicates data will NOT be copied. If the
	//               data is not copied, it must exist until a call to
	//               WebPMuxAssemble() is made.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux is NULL or bitstream is NULL.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	MuxSetImage :: proc(mux: ^Mux, bitstream: ^Data, copy_data: i32) -> MuxError ---

	// Adds a frame at the end of the mux object.
	// Notes: (1) frame.id should be WEBP_CHUNK_ANMF
	//        (2) For setting a non-animated image, use WebPMuxSetImage() instead.
	//        (3) Type of frame being pushed must be same as the frames in mux.
	//        (4) As WebP only supports even offsets, any odd offset will be snapped
	//            to an even location using: offset &= ~1
	// Parameters:
	//   mux - (in/out) object to which the frame is to be added
	//   frame - (in) frame data.
	//   copy_data - (in) value 1 indicates given data WILL be copied to the mux
	//               object and value 0 indicates data will NOT be copied. If the
	//               data is not copied, it must exist until a call to
	//               WebPMuxAssemble() is made.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or frame is NULL
	//                               or if content of 'frame' is invalid.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	MuxPushFrame :: proc(mux: ^Mux, frame: ^MuxFrameInfo, copy_data: i32) -> MuxError ---

	// Gets the nth frame from the mux object.
	// The content of 'frame->bitstream' is allocated using WebPMalloc(), and NOT
	// owned by the 'mux' object. It MUST be deallocated by the caller by calling
	// WebPDataClear().
	// nth=0 has a special meaning - last position.
	// Parameters:
	//   mux - (in) object from which the info is to be fetched
	//   nth - (in) index of the frame in the mux object
	//   frame - (out) data of the returned frame
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or frame is NULL.
	//   WEBP_MUX_NOT_FOUND - if there are less than nth frames in the mux object.
	//   WEBP_MUX_BAD_DATA - if nth frame chunk in mux is invalid.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	MuxGetFrame :: proc(mux: ^Mux, nth: u32, frame: ^MuxFrameInfo) -> MuxError ---

	// Deletes a frame from the mux object.
	// nth=0 has a special meaning - last position.
	// Parameters:
	//   mux - (in/out) object from which a frame is to be deleted
	//   nth - (in) The position from which the frame is to be deleted
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux is NULL.
	//   WEBP_MUX_NOT_FOUND - If there are less than nth frames in the mux object
	//                        before deletion.
	//   WEBP_MUX_OK - on success.
	MuxDeleteFrame :: proc(mux: ^Mux, nth: u32) -> MuxError ---
}

// Animation parameters.
MuxAnimParams :: struct {
	bgcolor: u32, // Background color of the canvas stored (in MSB order) as:

	// Bits 00 to 07: Alpha.
	// Bits 08 to 15: Red.
	// Bits 16 to 23: Green.
	// Bits 24 to 31: Blue.
	loop_count: i32, // Number of times to repeat the animation [0 = infinite].
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Sets the animation parameters in the mux object. Any existing ANIM chunks
	// will be removed.
	// Parameters:
	//   mux - (in/out) object in which ANIM chunk is to be set/added
	//   params - (in) animation parameters.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or params is NULL.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	MuxSetAnimationParams :: proc(mux: ^Mux, params: ^MuxAnimParams) -> MuxError ---

	// Gets the animation parameters from the mux object.
	// Parameters:
	//   mux - (in) object from which the animation parameters to be fetched
	//   params - (out) animation parameters extracted from the ANIM chunk
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or params is NULL.
	//   WEBP_MUX_NOT_FOUND - if ANIM chunk is not present in mux object.
	//   WEBP_MUX_OK - on success.
	MuxGetAnimationParams :: proc(mux: ^Mux, params: ^MuxAnimParams) -> MuxError ---

	// Sets the canvas size for the mux object. The width and height can be
	// specified explicitly or left as zero (0, 0).
	// * When width and height are specified explicitly, then this frame bound is
	//   enforced during subsequent calls to WebPMuxAssemble() and an error is
	//   reported if any animated frame does not completely fit within the canvas.
	// * When unspecified (0, 0), the constructed canvas will get the frame bounds
	//   from the bounding-box over all frames after calling WebPMuxAssemble().
	// Parameters:
	//   mux - (in) object to which the canvas size is to be set
	//   width - (in) canvas width
	//   height - (in) canvas height
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux is NULL; or
	//                               width or height are invalid or out of bounds
	//   WEBP_MUX_OK - on success.
	MuxSetCanvasSize :: proc(mux: ^Mux, width: i32, height: i32) -> MuxError ---

	// Gets the canvas size from the mux object.
	// Note: This method assumes that the VP8X chunk, if present, is up-to-date.
	// That is, the mux object hasn't been modified since the last call to
	// WebPMuxAssemble() or WebPMuxCreate().
	// Parameters:
	//   mux - (in) object from which the canvas size is to be fetched
	//   width - (out) canvas width
	//   height - (out) canvas height
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux, width or height is NULL.
	//   WEBP_MUX_BAD_DATA - if VP8X/VP8/VP8L chunk or canvas size is invalid.
	//   WEBP_MUX_OK - on success.
	MuxGetCanvasSize :: proc(mux: ^Mux, width: ^i32, height: ^i32) -> MuxError ---

	// Gets the feature flags from the mux object.
	// Note: This method assumes that the VP8X chunk, if present, is up-to-date.
	// That is, the mux object hasn't been modified since the last call to
	// WebPMuxAssemble() or WebPMuxCreate().
	// Parameters:
	//   mux - (in) object from which the features are to be fetched
	//   flags - (out) the flags specifying which features are present in the
	//           mux object. This will be an OR of various flag values.
	//           Enum 'WebPFeatureFlags' can be used to test individual flag values.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or flags is NULL.
	//   WEBP_MUX_BAD_DATA - if VP8X/VP8/VP8L chunk or canvas size is invalid.
	//   WEBP_MUX_OK - on success.
	MuxGetFeatures :: proc(mux: ^Mux, flags: ^u32) -> MuxError ---

	// Gets number of chunks with the given 'id' in the mux object.
	// Parameters:
	//   mux - (in) object from which the info is to be fetched
	//   id - (in) chunk id specifying the type of chunk
	//   num_elements - (out) number of chunks with the given chunk id
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if mux, or num_elements is NULL.
	//   WEBP_MUX_OK - on success.
	MuxNumChunks :: proc(mux: ^Mux, id: ChunkId, num_elements: ^i32) -> MuxError ---

	// Assembles all chunks in WebP RIFF format and returns in 'assembled_data'.
	// This function also validates the mux object.
	// Note: The content of 'assembled_data' will be ignored and overwritten.
	// Also, the content of 'assembled_data' is allocated using WebPMalloc(), and
	// NOT owned by the 'mux' object. It MUST be deallocated by the caller by
	// calling WebPDataClear(). It's always safe to call WebPDataClear() upon
	// return, even in case of error.
	// Parameters:
	//   mux - (in/out) object whose chunks are to be assembled
	//   assembled_data - (out) assembled WebP data
	// Returns:
	//   WEBP_MUX_BAD_DATA - if mux object is invalid.
	//   WEBP_MUX_INVALID_ARGUMENT - if mux or assembled_data is NULL.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	MuxAssemble :: proc(mux: ^Mux, assembled_data: ^Data) -> MuxError ---
}

AnimEncoder :: struct {} // Main opaque object.

// Global options.
AnimEncoderOptions :: struct {
	anim_params:   MuxAnimParams, // Animation parameters.
	minimize_size: i32,           // If true, minimize the output size (slow). Implicitly

	// disables key-frame insertion.
	kmin: i32,
	kmax: i32, // Minimum and maximum distance between consecutive key

	// frames in the output. The library may insert some key
	// frames as needed to satisfy this criteria.
	// Note that these conditions should hold: kmax > kmin
	// and kmin >= kmax / 2 + 1. Also, if kmax <= 0, then
	// key-frame insertion is disabled; and if kmax == 1,
	// then all frames will be key-frames (kmin value does
	// not matter for these special cases).
	allow_mixed: i32, // If true, use mixed compression mode; may choose

	// either lossy and lossless for each frame.
	verbose: i32,    // If true, print info and warning messages to stderr.
	padding: [4]u32, // Padding for later use.
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Internal, version-checked, entry point.
	AnimEncoderOptionsInitInternal :: proc(^AnimEncoderOptions, i32) -> i32 ---

	// Internal, version-checked, entry point.
	AnimEncoderNewInternal :: proc(i32, i32, ^AnimEncoderOptions, i32) -> ^AnimEncoder ---

	// Optimize the given frame for WebP, encode it and add it to the
	// WebPAnimEncoder object.
	// The last call to 'WebPAnimEncoderAdd' should be with frame = NULL, which
	// indicates that no more frames are to be added. This call is also used to
	// determine the duration of the last frame.
	// Parameters:
	//   enc - (in/out) object to which the frame is to be added.
	//   frame - (in/out) frame data in ARGB or YUV(A) format. If it is in YUV(A)
	//           format, it will be converted to ARGB, which incurs a small loss.
	//   timestamp_ms - (in) timestamp of this frame in milliseconds.
	//                       Duration of a frame would be calculated as
	//                       "timestamp of next frame - timestamp of this frame".
	//                       Hence, timestamps should be in non-decreasing order.
	//   config - (in) encoding options; can be passed NULL to pick
	//            reasonable defaults.
	// Returns:
	//   On error, returns false and frame->error_code is set appropriately.
	//   Otherwise, returns true.
	AnimEncoderAdd :: proc(enc: ^AnimEncoder, frame: ^Picture, timestamp_ms: i32, config: ^Config) -> i32 ---

	// Assemble all frames added so far into a WebP bitstream.
	// This call should be preceded by  a call to 'WebPAnimEncoderAdd' with
	// frame = NULL; if not, the duration of the last frame will be internally
	// estimated.
	// Parameters:
	//   enc - (in/out) object from which the frames are to be assembled.
	//   webp_data - (out) generated WebP bitstream.
	// Returns:
	//   True on success.
	AnimEncoderAssemble :: proc(enc: ^AnimEncoder, webp_data: ^Data) -> i32 ---

	// Get error string corresponding to the most recent call using 'enc'. The
	// returned string is owned by 'enc' and is valid only until the next call to
	// WebPAnimEncoderAdd() or WebPAnimEncoderAssemble() or WebPAnimEncoderDelete().
	// Parameters:
	//   enc - (in/out) object from which the error string is to be fetched.
	// Returns:
	//   NULL if 'enc' is NULL. Otherwise, returns the error string if the last call
	//   to 'enc' had an error, or an empty string if the last call was a success.
	AnimEncoderGetError :: proc(enc: ^AnimEncoder) -> cstring ---

	// Deletes the WebPAnimEncoder object.
	// Parameters:
	//   enc - (in/out) object to be deleted
	AnimEncoderDelete :: proc(enc: ^AnimEncoder) ---

	// Adds a chunk with id 'fourcc' and data 'chunk_data' in the enc object.
	// Any existing chunk(s) with the same id will be removed.
	// Parameters:
	//   enc - (in/out) object to which the chunk is to be added
	//   fourcc - (in) a character array containing the fourcc of the given chunk;
	//                 e.g., "ICCP", "XMP ", "EXIF", etc.
	//   chunk_data - (in) the chunk data to be added
	//   copy_data - (in) value 1 indicates given data WILL be copied to the enc
	//               object and value 0 indicates data will NOT be copied. If the
	//               data is not copied, it must exist until a call to
	//               WebPAnimEncoderAssemble() is made.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if enc, fourcc or chunk_data is NULL.
	//   WEBP_MUX_MEMORY_ERROR - on memory allocation error.
	//   WEBP_MUX_OK - on success.
	AnimEncoderSetChunk :: proc(enc: ^AnimEncoder, fourcc: ^[4]i8, chunk_data: ^Data, copy_data: i32) -> MuxError ---

	// Gets a reference to the data of the chunk with id 'fourcc' in the enc object.
	// The caller should NOT free the returned data.
	// Parameters:
	//   enc - (in) object from which the chunk data is to be fetched
	//   fourcc - (in) a character array containing the fourcc of the chunk;
	//                 e.g., "ICCP", "XMP ", "EXIF", etc.
	//   chunk_data - (out) returned chunk data
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if enc, fourcc or chunk_data is NULL.
	//   WEBP_MUX_NOT_FOUND - If enc does not contain a chunk with the given id.
	//   WEBP_MUX_OK - on success.
	AnimEncoderGetChunk :: proc(enc: ^AnimEncoder, fourcc: ^[4]i8, chunk_data: ^Data) -> MuxError ---

	// Deletes the chunk with the given 'fourcc' from the enc object.
	// Parameters:
	//   enc - (in/out) object from which the chunk is to be deleted
	//   fourcc - (in) a character array containing the fourcc of the chunk;
	//                 e.g., "ICCP", "XMP ", "EXIF", etc.
	// Returns:
	//   WEBP_MUX_INVALID_ARGUMENT - if enc or fourcc is NULL.
	//   WEBP_MUX_NOT_FOUND - If enc does not contain a chunk with the given fourcc.
	//   WEBP_MUX_OK - on success.
	AnimEncoderDeleteChunk :: proc(enc: ^AnimEncoder, fourcc: ^[4]i8) -> MuxError ---
}

