extends Node

var response

signal response_ready

func get_request(url: String):
	$HTTPRequest.request(url)

func post_request(url: String, json: String):
	var headers: PackedStringArray = [
		"Content-Type: application/json"
	]
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func put_request(url: String, json: String = "no json") -> void:
	if json != "no json":
		var headers: PackedStringArray = [
			 "Content-Type: application/json"
		]
		$HTTPRequest.request(url, headers, HTTPClient.METHOD_PUT, json)
	else:
		var headers: PackedStringArray = [
			"Content-Length: 0"
		]
		$HTTPRequest.request(url, headers, HTTPClient.METHOD_PUT, "")


func delete_request(url: String):
	var headers: PackedStringArray = []
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_DELETE)

func _on_http_request_request_completed(result: int, response_code: int, 
	headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200 and response_code != 201:
		# Error. Put it in response
		response = body.get_string_from_utf8()
		return
	# Get the body as json
	print(str("body", body))
	
	var json = body.get_string_from_utf8()
	print(json)
	# Parsing it into the dictionary
	var parsed_data = JSON.parse_string(json)
	# Because JSON.parse_string returns null when parsing fails.
	# Parsing fails when there is already a string in the body
	if parsed_data == null:
		#print(json)
		response = [json]
		emit_signal("response_ready")
	else:
		#print(parsed_data)
		response = parsed_data
		emit_signal("response_ready")
