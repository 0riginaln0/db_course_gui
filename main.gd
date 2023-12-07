extends Control

var arr: Array = [6]
var dic: Dictionary = {"Name": "Dmitriy"}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(ApplicationProperties.url)
	print(arr)
	print(dic)
	pass # Replace with function body.

func _on_request_performer_response_ready() -> void:
	
	var response: Array = $RequestPerformer.response
	#var response = format_json($RequestPerformer.response)
	var dict: Dictionary = response[0]
	print(dict)

func _on_button_button_up() -> void:
	var str: String = "good/demand-comparison/4/9"
	$RequestPerformer.get_request(ApplicationProperties.url + str)

func format_json(json_string: String) -> String:
	var formatted_string: String = ""
	var indent_level: int = 0
	var in_quotes: bool = false

	for i in range(json_string.length()):
		var ch: String = json_string.substr(i, 1)
		if ch == '"' and json_string.substr(i - 1, 1) != "\\":
			in_quotes = not in_quotes
		if not in_quotes:
			if ch == "{" or ch == "[":
				formatted_string += ch + "\n" + "\t".repeat(indent_level + 1)
				indent_level += 1
			elif ch == "}" or ch == "]":
				indent_level -= 1
				formatted_string += "\n" + "\t".repeat(indent_level) + ch
			elif ch == ",":
				formatted_string += "," + "\n" + "\t".repeat(indent_level)
			else:
				formatted_string += ch
		else:
			formatted_string += ch
	return formatted_string
