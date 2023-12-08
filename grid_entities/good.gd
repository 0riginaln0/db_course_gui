class_name Good
extends Control

var good_id: String = "0"
var good_name: String = "noname"
var priority: String = "null"

const center = "[center]"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Id.text = center + good_id
	$HBoxContainer/Name.text = center + good_name
	$HBoxContainer/Priority.text = center + priority

func set_good_id(_good_id):
	good_id = "[u]id[/u]:\n" + _good_id
	$HBoxContainer/Id.text = good_id

func set_good_name(_good_name):
	good_name = "[u]name[/u]:\n" + _good_name
	$HBoxContainer/Name.text = good_name

func set_priority(_priority):
	priority = "[u]priority[/u]:\n" + _priority
	$HBoxContainer/Priority.text =  priority
