class_name Warehosue
extends Control

var warehouse_id: String = "0"
var good_id_name_priority: String = "null"
var good_count: String = "noname"

const center = "[center]"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Id.text = center + warehouse_id
	$HBoxContainer/GoodCount.text = center + good_count
	$HBoxContainer/GoodIdNamePriority.text = center + good_id_name_priority 

func set_warehouse_id(_warehouse_id):
	warehouse_id = "[u]id[/u]:\n" + _warehouse_id
	$HBoxContainer/Id.text = warehouse_id

func set_good_count(_good_count):
	good_count = "[u]good count[/u]:\n" + _good_count
	$HBoxContainer/GoodCount.text = good_count

func set_good_id_name_priority(_good_id_name_priority):
	good_id_name_priority = "[u]good[/u]:\n" + _good_id_name_priority
	$HBoxContainer/GoodIdNamePriority.text = good_id_name_priority
