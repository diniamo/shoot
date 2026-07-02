// Copyright 2012 Google Inc. All Rights Reserved.
//
// Use of this source code is governed by a BSD-style license
// that can be found in the COPYING file in the root of the source
// tree. An additional intellectual property rights grant can be found
// in the file PATENTS. All contributing project authors may
// be found in the AUTHORS file in the root of the source tree.
// -----------------------------------------------------------------------------
//
// Demux API.
// Enables extraction of image and extended format data from WebP files.

// Code Example: Demuxing WebP data to extract all the frames, ICC profile
// and EXIF/XMP metadata.
/*
  WebPDemuxer* demux = WebPDemux(&webp_data);

  uint32_t width = WebPDemuxGetI(demux, WEBP_FF_CANVAS_WIDTH);
  uint32_t height = WebPDemuxGetI(demux, WEBP_FF_CANVAS_HEIGHT);
  // ... (Get information about the features present in the WebP file).
  uint32_t flags = WebPDemuxGetI(demux, WEBP_FF_FORMAT_FLAGS);

  // ... (Iterate over all frames).
  WebPIterator iter;
  if (WebPDemuxGetFrame(demux, 1, &iter)) {
    do {
      // ... (Consume 'iter'; e.g. Decode 'iter.fragment' with WebPDecode(),
      // ... and get other frame properties like width, height, offsets etc.
      // ... see 'struct WebPIterator' below for more info).
    } while (WebPDemuxNextFrame(&iter));
    WebPDemuxReleaseIterator(&iter);
  }

  // ... (Extract metadata).
  WebPChunkIterator chunk_iter;
  if (flags & ICCP_FLAG) WebPDemuxGetChunk(demux, "ICCP", 1, &chunk_iter);
  // ... (Consume the ICC profile in 'chunk_iter.chunk').
  WebPDemuxReleaseChunkIterator(&chunk_iter);
  if (flags & EXIF_FLAG) WebPDemuxGetChunk(demux, "EXIF", 1, &chunk_iter);
  // ... (Consume the EXIF metadata in 'chunk_iter.chunk').
  WebPDemuxReleaseChunkIterator(&chunk_iter);
  if (flags & XMP_FLAG) WebPDemuxGetChunk(demux, "XMP ", 1, &chunk_iter);
  // ... (Consume the XMP metadata in 'chunk_iter.chunk').
  WebPDemuxReleaseChunkIterator(&chunk_iter);
  WebPDemuxDelete(demux);
*/
package webp

foreign import lib "system:webp"
_ :: lib

DEMUX_ABI_VERSION :: 0x0107    // MAJOR(8b) + MINOR(8b)

Demuxer :: struct {}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Returns the version number of the demux library, packed in hexadecimal using
	// 8bits for each of major/minor/revision. E.g: v2.5.7 is 0x020507.
	GetDemuxVersion :: proc() -> i32 ---
}

//------------------------------------------------------------------------------
// Life of a Demux object
DemuxState :: enum i32 {
	PARSE_ERROR    = -1, // An error occurred while parsing.
	PARSING_HEADER = 0,  // Not enough data to parse full header.
	PARSED_HEADER  = 1,  // Header parsing complete,

	// data may be available.
	DONE           = 2,  // Entire file has been parsed.
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Internal, version-checked, entry point
	DemuxInternal :: proc(^Data, i32, ^DemuxState, i32) -> ^Demuxer ---

	// Frees memory associated with 'dmux'.
	DemuxDelete :: proc(dmux: ^Demuxer) ---
}

//------------------------------------------------------------------------------
// Data/information extraction.
FormatFeature :: enum u32 {
	FORMAT_FLAGS     = 0, // bit-wise combination of WebPFeatureFlags

	// corresponding to the 'VP8X' chunk (if present).
	CANVAS_WIDTH     = 1,
	CANVAS_HEIGHT    = 2,
	LOOP_COUNT       = 3, // only relevant for animated file
	BACKGROUND_COLOR = 4, // idem.
	FRAME_COUNT      = 5, // Number of frames present in the demux object.
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Get the 'feature' value from the 'dmux'.
	// NOTE: values are only valid if WebPDemux() was used or WebPDemuxPartial()
	// returned a state > WEBP_DEMUX_PARSING_HEADER.
	// If 'feature' is WEBP_FF_FORMAT_FLAGS, the returned value is a bit-wise
	// combination of WebPFeatureFlags values.
	// If 'feature' is WEBP_FF_LOOP_COUNT, WEBP_FF_BACKGROUND_COLOR, the returned
	// value is only meaningful if the bitstream is animated.
	DemuxGetI :: proc(dmux: ^Demuxer, feature: FormatFeature) -> u32 ---
}

//------------------------------------------------------------------------------
// Frame iteration.
Iterator :: struct {
	frame_num:          i32,
	num_frames:         i32,            // equivalent to WEBP_FF_FRAME_COUNT.
	x_offset, y_offset: i32,            // offset relative to the canvas.
	width, height:      i32,            // dimensions of this frame.
	duration:           i32,            // display duration in milliseconds.
	dispose_method:     MuxAnimDispose, // dispose method for the frame.
	complete:           i32,            // true if 'fragment' contains a full frame. partial images

	// may still be decoded with the WebP incremental decoder.
	fragment: Data, // The frame given by 'frame_num'. Note for historical

	// reasons this is called a fragment.
	has_alpha:    i32,          // True if the frame contains transparency.
	blend_method: MuxAnimBlend, // Blend operation for the frame.
	pad:          [2]u32,       // padding for later use.
	private_:     rawptr,       // for internal use only.
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Retrieves frame 'frame_number' from 'dmux'.
	// 'iter->fragment' points to the frame on return from this function.
	// Setting 'frame_number' equal to 0 will return the last frame of the image.
	// Returns false if 'dmux' is NULL or frame 'frame_number' is not present.
	// Call WebPDemuxReleaseIterator() when use of the iterator is complete.
	// NOTE: 'dmux' must persist for the lifetime of 'iter'.
	DemuxGetFrame :: proc(dmux: ^Demuxer, frame_number: i32, iter: ^Iterator) -> i32 ---

	// Sets 'iter->fragment' to point to the next ('iter->frame_num' + 1) or
	// previous ('iter->frame_num' - 1) frame. These functions do not loop.
	// Returns true on success, false otherwise.
	DemuxNextFrame :: proc(iter: ^Iterator) -> i32 ---
	DemuxPrevFrame :: proc(iter: ^Iterator) -> i32 ---

	// Releases any memory associated with 'iter'.
	// Must be called before any subsequent calls to WebPDemuxGetChunk() on the same
	// iter. Also, must be called before destroying the associated WebPDemuxer with
	// WebPDemuxDelete().
	DemuxReleaseIterator :: proc(iter: ^Iterator) ---
}

//------------------------------------------------------------------------------
// Chunk iteration.
ChunkIterator :: struct {
	// The current and total number of chunks with the fourcc given to
	// WebPDemuxGetChunk().
	chunk_num:  i32,
	num_chunks: i32,
	chunk:      Data,   // The payload of the chunk.
	pad:        [6]u32, // padding for later use
	private_:   rawptr,
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Retrieves the 'chunk_number' instance of the chunk with id 'fourcc' from
	// 'dmux'.
	// 'fourcc' is a character array containing the fourcc of the chunk to return,
	// e.g., "ICCP", "XMP ", "EXIF", etc.
	// Setting 'chunk_number' equal to 0 will return the last chunk in a set.
	// Returns true if the chunk is found, false otherwise. Image related chunk
	// payloads are accessed through WebPDemuxGetFrame() and related functions.
	// Call WebPDemuxReleaseChunkIterator() when use of the iterator is complete.
	// NOTE: 'dmux' must persist for the lifetime of the iterator.
	DemuxGetChunk :: proc(dmux: ^Demuxer, fourcc: ^[4]i8, chunk_number: i32, iter: ^ChunkIterator) -> i32 ---

	// Sets 'iter->chunk' to point to the next ('iter->chunk_num' + 1) or previous
	// ('iter->chunk_num' - 1) chunk. These functions do not loop.
	// Returns true on success, false otherwise.
	DemuxNextChunk :: proc(iter: ^ChunkIterator) -> i32 ---
	DemuxPrevChunk :: proc(iter: ^ChunkIterator) -> i32 ---

	// Releases any memory associated with 'iter'.
	// Must be called before destroying the associated WebPDemuxer with
	// WebPDemuxDelete().
	DemuxReleaseChunkIterator :: proc(iter: ^ChunkIterator) ---
}

AnimDecoder :: struct {} // Main opaque object.

// Global options.
AnimDecoderOptions :: struct {
	// Output colorspace. Only the following modes are supported:
	// MODE_RGBA, MODE_BGRA, MODE_rgbA and MODE_bgrA.
	color_mode:  WEBP_CSP_MODE,
	use_threads: i32,    // If true, use multi-threaded decoding.
	padding:     [7]u32, // Padding for later use.
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Internal, version-checked, entry point.
	AnimDecoderOptionsInitInternal :: proc(^AnimDecoderOptions, i32) -> i32 ---

	// Internal, version-checked, entry point.
	AnimDecoderNewInternal :: proc(^Data, ^AnimDecoderOptions, i32) -> ^AnimDecoder ---
}

// Global information about the animation..
AnimInfo :: struct {
	canvas_width:  u32,
	canvas_height: u32,
	loop_count:    u32,
	bgcolor:       u32,
	frame_count:   u32,
	pad:           [4]u32, // padding for later use
}

@(default_calling_convention="c", link_prefix="WebP")
foreign lib {
	// Get global information about the animation.
	// Parameters:
	//   dec - (in) decoder instance to get information from.
	//   info - (out) global information fetched from the animation.
	// Returns:
	//   True on success.
	AnimDecoderGetInfo :: proc(dec: ^AnimDecoder, info: ^AnimInfo) -> i32 ---

	// Fetch the next frame from 'dec' based on options supplied to
	// WebPAnimDecoderNew(). This will be a fully reconstructed canvas of size
	// 'canvas_width * 4 * canvas_height', and not just the frame sub-rectangle. The
	// returned buffer 'buf' is valid only until the next call to
	// WebPAnimDecoderGetNext(), WebPAnimDecoderReset() or WebPAnimDecoderDelete().
	// Parameters:
	//   dec - (in/out) decoder instance from which the next frame is to be fetched.
	//   buf - (out) decoded frame.
	//   timestamp - (out) timestamp of the frame in milliseconds.
	// Returns:
	//   False if any of the arguments are NULL, or if there is a parsing or
	//   decoding error, or if there are no more frames. Otherwise, returns true.
	AnimDecoderGetNext :: proc(dec: ^AnimDecoder, buf: ^^u8, timestamp: ^i32) -> i32 ---

	// Check if there are more frames left to decode.
	// Parameters:
	//   dec - (in) decoder instance to be checked.
	// Returns:
	//   True if 'dec' is not NULL and some frames are yet to be decoded.
	//   Otherwise, returns false.
	AnimDecoderHasMoreFrames :: proc(dec: ^AnimDecoder) -> i32 ---

	// Resets the WebPAnimDecoder object, so that next call to
	// WebPAnimDecoderGetNext() will restart decoding from 1st frame. This would be
	// helpful when all frames need to be decoded multiple times (e.g.
	// info.loop_count times) without destroying and recreating the 'dec' object.
	// Parameters:
	//   dec - (in/out) decoder instance to be reset
	AnimDecoderReset :: proc(dec: ^AnimDecoder) ---

	// Grab the internal demuxer object.
	// Getting the demuxer object can be useful if one wants to use operations only
	// available through demuxer; e.g. to get XMP/EXIF/ICC metadata. The returned
	// demuxer object is owned by 'dec' and is valid only until the next call to
	// WebPAnimDecoderDelete().
	//
	// Parameters:
	//   dec - (in) decoder instance from which the demuxer object is to be fetched.
	AnimDecoderGetDemuxer :: proc(dec: ^AnimDecoder) -> ^Demuxer ---

	// Deletes the WebPAnimDecoder object.
	// Parameters:
	//   dec - (in/out) decoder instance to be deleted
	AnimDecoderDelete :: proc(dec: ^AnimDecoder) ---
}

