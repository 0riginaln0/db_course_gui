extends Control

func _ready() -> void:
	$RichTextLabel.text = Time.get_datetime_string_from_system()

func _on_timer_timeout() -> void:
	$RichTextLabel.text = Time.get_datetime_string_from_system()
