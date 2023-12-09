class_name RequestBuilder
extends Control

var entity: String = ""
var request_type: String = ""

func _on_db_picker_item_selected(index: int) -> void:
	match index:
		0:
			entity = "sale"
			print("Продажи")
		1:
			entity = "good"
			print("Товары")
	if not request_type.is_empty():
		view_params()

func _on_request_picker_item_selected(index: int) -> void:
	match index:
		0:
			request_type = "post"
			print("Создать")
		1:
			request_type = "put"
			print("Изменить")
		2:
			request_type = "delete"
			print("Удалить")
	if not entity.is_empty():
		view_params()


func view_params():
	get_tree().call_group("params", "hide")
	match entity:
		"good":
			match request_type:
				"post":
					$VBoxContainer3/GoodCreateParams.show()
				"put":
					$VBoxContainer3/GoodUpdateParams.show()
				"delete":
					$VBoxContainer3/GoodDeleteParams.show()
		"sale":
			match request_type:
				"post":
					$VBoxContainer3/SaleCreateParams.show()
				"put":
					$VBoxContainer3/SaleUpdateParams.show()
				"delete":
					$VBoxContainer3/SaleDeleteParams.show()


func _on_send_request_button_up() -> void:
	match entity:
		"good":
			match request_type:
				"post":
					print("post good")
					post_good()
				"put":
					print("put good")
					put_good()
					#$RequestPerformer.put_request(ApplicationProperties.url + str)
					pass
				"delete":
					#$RequestPerformer.delete_request(ApplicationProperties.url + str)
					pass
		"sale":
			match request_type:
				"post":
					#$RequestPerformer.post_request(ApplicationProperties.url + str)
					pass
				"put":
					#$RequestPerformer.put_request(ApplicationProperties.url + str)
					pass
				"delete":
					#$RequestPerformer.delete_request(ApplicationProperties.url + str)
					pass

func post_good():
	if ($VBoxContainer3/GoodCreateParams/NameContainer/NameInput.text == "" or
		$VBoxContainer3/GoodCreateParams/PriorityContainer/PriorityInput.text == ""):
		$RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var str = entity + "/" + request_type
	var json = {
			"name": $VBoxContainer3/GoodCreateParams/NameContainer/NameInput.text,
			"priority": $VBoxContainer3/GoodCreateParams/PriorityContainer/PriorityInput.text
		}
	$RequestPerformer.post_request(ApplicationProperties.url + str, str(json))

func put_good():
	if ($VBoxContainer3/GoodUpdateParams/IdContainer/IdInput.text == ""):
		$RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var id: String = $VBoxContainer3/GoodUpdateParams/IdContainer/IdInput.text
	var good_name: String = $VBoxContainer3/GoodUpdateParams/NameContainer/NameInput.text
	var priority: String = $VBoxContainer3/GoodUpdateParams/PriorityContainer/PriorityInput.text
	
	var json: Dictionary = {}
	json.goodId = id
	if !good_name.is_empty():
		json.name = good_name
	if !priority.is_empty():
		json.priority = priority
	
	var str = entity + "/" + request_type
	$RequestPerformer.put_request(ApplicationProperties.url + str, str(json))
	
func _on_request_performer_response_ready() -> void:
	var response = $RequestPerformer.response
	$RequestResponse.text = str(response)
