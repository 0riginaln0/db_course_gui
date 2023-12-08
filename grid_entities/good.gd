class_name Good
extends Control

var good_id: String
var good_name: String
var priority: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Id.text = good_id
	$HBoxContainer/Name.text = good_name
	$HBoxContainer/Priority.text = priority

func _init(_good_id: String = "0", _good_name: String = "noname", 
	_priority: String = "null") -> void:
	good_id = _good_id
	good_name = _good_name
	priority = _priority
