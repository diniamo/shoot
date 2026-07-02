package pile_xml

import "base:runtime"

Element :: struct {
	name:        string,
	attributes: map[string]string,

	content:    string,
	children:   [dynamic]Element,

	// NOTE: internal
	content_position: int
}

parse :: proc(input: string, allocator: runtime.Allocator) -> Element {
	document := Element {
		content  = input,
		children = make([dynamic]Element, allocator)
	}
	tokenizer := Tokenizer{data = input}

	stack := make([dynamic]^Element, context.temp_allocator)
	append(&stack, &document)

	for token in scan(&tokenizer) {
		if token.kind == .Less_Than {
			next_token, _ := scan(&tokenizer)
			#partial switch next_token.kind {
			case .Identifier:
				element := Element {
					name       = input[next_token.start:next_token.end],
					attributes = make(map[string]string, allocator),
					children   = make([dynamic]Element, allocator)
				}

				closed: bool = ---
				loop: for {
					identifier, _ := scan(&tokenizer)
					#partial switch identifier.kind {
					case .Greater_Than:
						closed = false
						break loop
					case .Slash:
						closed = true
						scan(&tokenizer)
						break loop
					}

					equal, _ := scan(&tokenizer)
					open, _  := scan(&tokenizer)
					close, _ := scan_to(&tokenizer, open.kind)

					key   := input[identifier.start:identifier.end]
					value := input[open.end:close.start]
					element.attributes[key] = value
				}

				parent := stack[len(stack) - 1]
				append(&parent.children, element)

				if closed {
					element.content = ""
				} else {
					element.content_position = tokenizer.position
					append(&stack, &parent.children[len(parent.children) - 1])
				}
			case .Slash:
				top := stack[len(stack) - 1]
				top.content = input[top.content_position:token.start]

				pop(&stack)

				scan_to(&tokenizer, .Greater_Than)
			case:
				scan_to(&tokenizer, .Greater_Than)
			}
		}
	}

	return document
}
