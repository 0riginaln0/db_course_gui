extends Control
class_name Journal

enum JOURNAL_STATE {
	GOODS,
	WAREHOUSE1,
	WAREHOUSE2,
	SALES,
}

var state: JOURNAL_STATE

var good_factory = preload("res://grid_entities/Good.tscn")
var sale_factory = preload("res://grid_entities/Sale.tscn")
var wh_factory = preload("res://grid_entities/Warehouse.tscn")

#var response: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# add row func

func _on_request_performer_response_ready() -> void:
	var response: Array = $RequestPerformer.response
	match state:
		JOURNAL_STATE.GOODS:
			set_goods(response)
		JOURNAL_STATE.SALES:
			set_sales(response)
		JOURNAL_STATE.WAREHOUSE1:
			set_warehouse1(response)
		JOURNAL_STATE.WAREHOUSE2:
			set_warehouse2(response)

func set_goods(response: Array):
	for ch in $DbGrid/ScrollContainer/VBoxContainer.get_children():
		ch.free()
	for good in response:
		var new_good: Good = good_factory.instantiate()
		new_good.set_good_id(str(good.get("goodId")))
		new_good.set_good_name(str(good.get("name")))
		new_good.set_priority(str(good.get("priority")))
		$DbGrid/ScrollContainer/VBoxContainer.add_child(new_good)


func _on_goods_button_down() -> void:
	state = JOURNAL_STATE.GOODS
	var str: String = "good/all"
	$RequestPerformer.get_request(ApplicationProperties.url + str)

func set_sales(response: Array):
	for ch in $DbGrid/ScrollContainer/VBoxContainer.get_children():
		ch.free()
	for sale in response:
		var new_sale: Sale = sale_factory.instantiate()
		new_sale.set_sale_id(str(sale.get("saleId")))
		new_sale.set_good_count(str(sale.get("goodCount")))
		new_sale.set_create_date(str(sale.get("createDate")))
		new_sale.set_good_id_name_priority(str(sale.get("good").get("name"), "\n",
												sale.get("good").get("goodId")))
		$DbGrid/ScrollContainer/VBoxContainer.add_child(new_sale)

func _on_sales_button_down() -> void:
	state = JOURNAL_STATE.SALES
	var str: String = "sale/all"
	$RequestPerformer.get_request(ApplicationProperties.url + str)

func set_warehouse2(response: Array):
	for ch in $DbGrid/ScrollContainer/VBoxContainer.get_children():
		ch.free()
	for wh in response:
		var new_wh: Warehosue = wh_factory.instantiate()
		new_wh.set_warehouse_id(str(wh.get("warehouse2Id")))
		new_wh.set_good_count(str(wh.get("goodCount")))
		new_wh.set_good_id_name_priority(str(wh.get("good").get("name"),
											 "\n", wh.get("good").get("goodId")))
		$DbGrid/ScrollContainer/VBoxContainer.add_child(new_wh)

func _on_warehouse_2_button_down() -> void:
	state = JOURNAL_STATE.WAREHOUSE2
	var str: String = "warehouse2/all"
	$RequestPerformer.get_request(ApplicationProperties.url + str)

func set_warehouse1(response: Array):
	for ch in $DbGrid/ScrollContainer/VBoxContainer.get_children():
		ch.free()
	for wh in response:
		var new_wh: Warehosue = wh_factory.instantiate()
		new_wh.set_warehouse_id(str(wh.get("warehouse1Id")))
		new_wh.set_good_count(str(wh.get("goodCount")))
		new_wh.set_good_id_name_priority(str(wh.get("good").get("name"),
											 "\n", wh.get("good").get("goodId")))
		$DbGrid/ScrollContainer/VBoxContainer.add_child(new_wh)

func _on_warehouse_1_button_down() -> void:
	state = JOURNAL_STATE.WAREHOUSE1
	var str: String = "warehouse1/all"
	$RequestPerformer.get_request(ApplicationProperties.url + str)
