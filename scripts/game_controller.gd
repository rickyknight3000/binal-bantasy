class_name GameController extends Node

@export var world : Node2D
@export var gui : Control

var current_world_scene
var current_gui_scene

func _ready() -> void:
	Global.game_controller = self
	current_world_scene = $World/WorldMap

func change_gui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_gui_scene != null:
		if delete:
			current_gui_scene.queue_free() #removes node
		elif keep_running:
			current_gui_scene.visible = false #keeps in memory and running
		else:
			gui.remove_child(current_gui_scene) #keeps in memory, doesn't run
	var new = load(new_scene).instantiate()
	gui.add_child(new)
	current_gui_scene = new

func change_world_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if delete:
		current_world_scene.queue_free() #removes node
	elif keep_running:
		current_world_scene.visible = false #keeps in memory and running
	else:
		gui.remove_child(current_world_scene) #keeps in memory, doesn't run
	var new = load(new_scene).instantiate()
	world.add_child(new)
	current_world_scene = new
