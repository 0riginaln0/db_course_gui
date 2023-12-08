class_name Sale
extends Control

var sale_id: String = "0"
var good_count: String = "noname"
var create_date: String = "null"
var good_id_name_priority: String = "null"

const center = "[center]"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Id.text = center + sale_id
	$HBoxContainer/GoodCount.text = center + good_count
	$HBoxContainer/CreateDate.text = center + create_date
	$HBoxContainer/GoodIdNamePriority.text = center + good_id_name_priority 

func set_sale_id(_sale_id):
	sale_id = "[u]id[/u]:\n" + _sale_id
	$HBoxContainer/Id.text = sale_id

func set_good_count(_good_count):
	good_count = "[u]good count[/u]:\n" + _good_count
	$HBoxContainer/GoodCount.text = good_count

func set_create_date(_create_date):
	create_date = "[u]create date[/u]:\n" + _create_date
	$HBoxContainer/CreateDate.text = create_date

func set_good_id_name_priority(_good_id_name_priority):
	good_id_name_priority = "[u]good[/u]:\n" + _good_id_name_priority
	$HBoxContainer/GoodIdNamePriority.text = good_id_name_priority
