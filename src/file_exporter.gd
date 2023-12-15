extends Node

var export_folder_path = OS.get_executable_path().get_base_dir().path_join("export")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var path = OS.get_executable_path().get_base_dir()
	print(path)
	var dir = DirAccess.open(path)
	var dirs = dir.get_directories()
	print(dirs)
	if dirs.has("export"):
		print("found")
	else:
		dir.make_dir("export")

func export(data: Array[PackedStringArray], name: String):
	var current_time = Time.get_datetime_string_from_system()
	var file_name = str(name, "_", current_time, ".csv")
	file_name = file_name.replace(":", "-")
	print(file_name)
	var file = FileAccess.open(
		export_folder_path.path_join(file_name), FileAccess.WRITE
	)
	for new_line in data:
		file.store_csv_line(new_line)
