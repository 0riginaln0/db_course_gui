extends Control

enum REPORT_STATE {
	TOP5,
	DEMAND,
}

var current_state: REPORT_STATE

var good_factory = preload("res://grid_entities/TopGood.tscn")
var chart_factory = preload("res://windows/chart_folder/line_chart/Control.tscn")

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


func _on_demand_graph_button_up() -> void:
	if ($RequestButtons/TBeginBox/LineEdit.text == "" or
		$RequestButtons/TEndBox/LineEdit.text == "" or 
		$RequestButtons/GoodId/LineEdit.text == ""):
		$RequestButtons/RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var t_begin = $RequestButtons/TBeginBox/LineEdit.text + "+00:00"
	var t_end = $RequestButtons/TEndBox/LineEdit.text + "+00:00"
	var good_id = $RequestButtons/GoodId/LineEdit.text
	var str = "good/demand-change/" + t_begin + "/" + t_end + "/" + good_id;
	current_state = REPORT_STATE.DEMAND
	$RequestPerformer.get_request(ApplicationProperties.url + str)


func _on_request_performer_response_ready() -> void:
	if $RequestPerformer.response is String:
		$RequestButtons/RequestResponse.text = $RequestPerformer.response
		return
	var response: Array = $RequestPerformer.response
	match current_state:
		REPORT_STATE.TOP5:
			hanlde_top5_response(response)
		REPORT_STATE.DEMAND:
			handle_demand_response(response)

func handle_demand_response(response: Array):
	var dates_array = []
	var x_dates = []
	var demands_array = []
	if response.is_empty():
		$RequestButtons/RequestResponse.text = "Нету данных по выбранным параметрам"
		return
	
	var good_name = str(response[0].get("name"))
	
	var counter = 1
	for record in response:
		demands_array.append(int(record.get("demand")))
		dates_array.append(str(record.get("date")))
		x_dates.append(counter)
		counter += 1
	var new_chart = chart_factory.instantiate()
	new_chart._x_values = x_dates
	new_chart._y_values = demands_array
	new_chart._x_values_labels = dates_array
	new_chart._y_scale = demands_array.max() - demands_array.min()
	$FuckingChart.add_child(new_chart)
	
