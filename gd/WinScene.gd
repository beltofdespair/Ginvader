extends Node2D

onready var start_scene = preload("res://tscn/Start.tscn")
onready var exit_timer = get_node("ExitTimer")

var scene

func _ready():
	exit_timer.start(2)

func _process(_delta):
	print("time left = ", exit_timer.time_left)

func _on_ExitTimer_timeout():
	scene = get_tree().change_scene_to(start_scene)
