extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_log_in_button_up() -> void:
	var data_to_send = {
		"email": $VBoxContainer/email.text,
		"password": $VBoxContainer/password.text
	}
	# url to which the request will be executed
	var url := "http://localhost:8080/api/auth/authenticate"
	# Making json from a dictionary
	var json = JSON.stringify(data_to_send, "\t")
	# Preparing the header
	var headers = ["Content-Type: application/json"]
	# Sending a request
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)


func _on_http_request_request_completed(
		result: int, response_code: int, headers: PackedStringArray, 
		body: PackedByteArray
	) -> void:
	if response_code != 200:
		print("You entered something wrong, try again.")
		return
	# Get the body as json
	var json = body.get_string_from_utf8()
	# Parsing it into the dictionary
	var parsed_data = JSON.parse_string(json)
	# Put the received token into memory
	Jwt.set_token(str(parsed_data.token))
	print(str(parsed_data.token))
	get_tree().change_scene_to_file("res://MainScene.tscn")


func _on_back_button_up() -> void:
	Jwt.set_token("")
	get_tree().change_scene_to_file("res://windows/auth/entry_window.tscn")
