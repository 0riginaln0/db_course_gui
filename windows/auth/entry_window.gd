extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_button_up() -> void:
	get_tree().quit()


func _on_log_in_button_up() -> void:
	get_tree().change_scene_to_file("res://windows/auth/AuthenticationWindow.tscn")
	pass # Replace with function body.


func _on_continue_as_guest_button_up() -> void:
	Jwt.set_token("")
	get_tree().change_scene_to_file("res://MainScene.tscn")
	pass # Replace with function body.
