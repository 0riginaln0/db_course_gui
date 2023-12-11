extends Control

enum REPORT_STATE {
	TOP5,
	DEMAND,
}

var current_state: REPORT_STATE

var good_factory = preload("res://grid_entities/TopGood.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_top_5_goods_button_up() -> void:
	if ($RequestButtons/TBeginBox/LineEdit.text == "" or
		$RequestButtons/TEndBox/LineEdit.text == ""):
		$RequestButtons/RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var t_begin = $RequestButtons/TBeginBox/LineEdit.text + "+00:00"
	var t_end = $RequestButtons/TEndBox/LineEdit.text + "+00:00"
	var str = "good/top-5/" + t_begin + "/" + t_end;
	current_state = REPORT_STATE.TOP5
	$RequestPerformer.get_request(ApplicationProperties.url + str)

func hanlde_top5_response(response: Array):
	for ch in $Top5Container.get_children():
			ch.free()
	for good in response:
		var new_good: TopGood = good_factory.instantiate()
		new_good.set_good_id(str(good.get("popularity")))
		new_good.set_good_name(str(good.get("name")))
		new_good.set_priority(str(good.get("priority")))
		$Top5Container.add_child(new_good)

func _on_request_performer_response_ready() -> void:
	var response: Array = $RequestPerformer.response
	match current_state:
		REPORT_STATE.TOP5:
			hanlde_top5_response(response)
		REPORT_STATE.DEMAND:
			handle_demand_response(response)

func handle_demand_response(response: Array):
	pass
