extends WindowDialogTask

onready var leftHandle: Node = $DoorClosed/HandleLeft
onready var rightHandle: Node = $DoorClosed/HandleRight
onready var doorOpened: Node = $DoorOpened
onready var doorClosed: Node = $DoorClosed

func _ready():
	pass

func open():
	var res: Resource = get_res()
	if not res.is_connected("times_updated", self, "times_updated"):
# warning-ignore:return_value_discarded
		res.connect("times_updated", self, "times_updated")
	ui_data_updated()

func ui_data_updated():
	pass

func checkComplete():
	var completed: bool = is_task_completed()
	if completed:
		get_res().complete_task()
		
#func taskComplete():
#	.complete_task({"newText": str(getCurrentTime())})

func sync_task():
	get_res().sync_task()

func get_res() -> Resource:
	return TaskManager.get_task_resource(ui_data[TaskManager.TASK_ID_KEY])

func is_task_completed() -> bool:
	return get_res().can_complete_task()
