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
				"delete":
					print("delete good")
					delete_good()
		"sale":
			match request_type:
				"post":
					print("post sale")
					post_sale()
				"put":
					print("put sale")
					put_sale()
				"delete":
					print("delete sale")
					delete_sale()

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

func delete_good():
	if ($VBoxContainer3/GoodDeleteParams/IdContainer/IdInput.text == ""):
		$RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var id: String = $VBoxContainer3/GoodDeleteParams/IdContainer/IdInput.text
	var json: Dictionary = {}
	json.goodId = id
	var str = entity + "/" + request_type
	$RequestPerformer.delete_request(ApplicationProperties.url + str, str(json))

func delete_sale():
	if ($VBoxContainer3/SaleDeleteParams/IdContainer/IdInput.text == ""):
		$RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var id: String = $VBoxContainer3/SaleDeleteParams/IdContainer/IdInput.text
	var json: Dictionary = {}
	json.saleId = id
	var str = entity + "/" + request_type
	$RequestPerformer.delete_request(ApplicationProperties.url + str, str(json))

func post_sale():
	if ($VBoxContainer3/SaleCreateParams/CountContainer/CountInput.text == "" or
		$VBoxContainer3/SaleCreateParams/GoodIdContainer/GoodIdInput.text == ""):
		$RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var json: Dictionary = {}
	json.goodCount = $VBoxContainer3/SaleCreateParams/CountContainer/CountInput.text
	var create_date: String = $VBoxContainer3/SaleCreateParams/DateContainer/DateInput.text
	if create_date.is_empty():
		create_date = Time.get_datetime_string_from_system() + "+00:00"
		print(create_date)
	else:
		create_date += "+00:00"
	print(create_date)
	json.createDate = create_date
	json.good = {
		"goodId": $VBoxContainer3/SaleCreateParams/GoodIdContainer/GoodIdInput.text
	}
	var str = entity + "/" + request_type
	$RequestPerformer.post_request(ApplicationProperties.url + str, str(json))

func put_sale():
	if ($VBoxContainer3/SaleUpdateParams/IdContainer/IdInput.text == ""):
		$RequestResponse.text = "Введите все обязательные параметры запроса"
		return
	var id: String = $VBoxContainer3/SaleUpdateParams/IdContainer/IdInput.text
	var goodCount: String = $VBoxContainer3/SaleUpdateParams/CountContainer/CountInput.text
	var createDate: String = $VBoxContainer3/SaleUpdateParams/DateContainer/DateInput.text
	var goodId: String = $VBoxContainer3/SaleUpdateParams/GoodIdContainer/GoodIdInput.text
		
	var json: Dictionary = {}
	json.saleId = id
	if !goodCount.is_empty():
		json.goodCount = goodCount
	if !createDate.is_empty():
		json.createDate = createDate + "+00:00"
	if !goodId.is_empty():
		json.good = {
			"goodId": goodId
		}
	var str = entity + "/" + request_type
	$RequestPerformer.put_request(ApplicationProperties.url + str, str(json))

func _on_request_performer_response_ready() -> void:
	var response = $RequestPerformer.response
	$RequestResponse.text = str(response)
