package webp

PictureInit :: proc "contextless" (picture: ^Picture) {
	PictureInitInternal(picture, ENCODER_ABI_VERSION)
}

ConfigInit :: proc(config: ^Config) -> i32 {
	return ConfigInitInternal(config, .DEFAULT, 75, ENCODER_ABI_VERSION)
}
