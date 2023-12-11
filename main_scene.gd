extends Control

func _ready() -> void:
	$CurrentTime.text = Time.get_datetime_string_from_system()
	$Timer.start()

func _on_timer_timeout() -> void:
	$CurrentTime.text = Time.get_datetime_string_from_system()


func _on_reports_button_up() -> void:
	$Journals.hide()
	$Reports.show()
	pass # eplace with function body.


func _on_journal_button_up() -> void:
	$Reports.hide()
	$Journals.show()
	pass # Replace with function body.


func _on_directory_button_up() -> void:
	$Journals.hide()
	$Reports.hide()
	pass # Replace with function body.
