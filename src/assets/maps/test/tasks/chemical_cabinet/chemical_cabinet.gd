extends Node2D

onready var door_timer = $DoorCloser
onready var closed_door_sprite = $DoorClosed
onready var opened_door_sprite = $DoorOpened

func closeDoor():
	opened_door_sprite.visible = false
	closed_door_sprite.visible = true

func openDoor():
	opened_door_sprite.visible = true
	closed_door_sprite.visible = false

func start_timer():
	door_timer.start()

func _on_DoorCloser_timeout():
	closeDoor()
