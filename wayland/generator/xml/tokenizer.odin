package pile_xml

Token_Kind :: enum {
	Invalid,

	Identifier,

	Less_Than,
	Greater_Than,
	Exclamation,
	Question,
	Equal,
	Hash,
	Slash,
	Dash,
	Colon,
	Opening_Square_Bracket,
	Closing_Square_Bracket,
	Double_Quote,
	Single_Quote
}

Token :: struct {
	kind: Token_Kind,
	start, end: int
}

Tokenizer :: struct {
	data: string,
	position: int
}

scan :: proc(tokenizer: ^Tokenizer) -> (Token, bool) {
	skip_whitespace(tokenizer)

	token := Token {
		kind = .Invalid,
		start = tokenizer.position
	}

	c := peek_char(tokenizer)
	switch {
	case c == 0:
		return {}, false
	case is_identifier_character(c):
		tokenizer.position += 1
		scan_identifier(tokenizer)
		token.end = tokenizer.position
		token.kind = .Identifier
	case:
		switch c {
		case '<':  token.kind = .Less_Than
		case '>':  token.kind = .Greater_Than
		case '!':  token.kind = .Exclamation
		case '?':  token.kind = .Question
		case '=':  token.kind = .Equal
		case '#':  token.kind = .Hash
		case '/':  token.kind = .Slash
		case '-':  token.kind = .Dash
		case ':':  token.kind = .Colon
		case '[':  token.kind = .Opening_Square_Bracket
		case ']':  token.kind = .Closing_Square_Bracket
		case '"':  token.kind = .Double_Quote
		case '\'': token.kind = .Single_Quote
		case:      token.kind = .Invalid
		}

		token.end = token.start + 1
		tokenizer.position = token.end
	}


	return token, true
}

skip_whitespace :: proc(tokenizer: ^Tokenizer) {
	for {
		switch peek_char(tokenizer) {
		case ' ', '\t', '\r', '\n':
			tokenizer.position += 1
		case:
			return
		}
	}
}

scan_identifier :: proc(tokenizer: ^Tokenizer) {
	for ; is_identifier_character(peek_char(tokenizer)); tokenizer.position += 1 {}
}

is_identifier_character :: proc(c: u8) -> bool {
	switch c {
	case 'a'..='z', 'A'..='Z': return true
	case '0'..='9':            return true
	case '-', '_', ':':        return true
	}

	return false
}

peek_char :: proc(tokenizer: ^Tokenizer) -> u8 {
	return tokenizer.position < len(tokenizer.data) ? tokenizer.data[tokenizer.position] : 0
}

scan_to :: proc(tokenizer: ^Tokenizer, kind: Token_Kind) -> (Token, bool) {
	for token in scan(tokenizer) {
		if token.kind == kind {
			return token, true
		}
	}

	return {}, false
}
