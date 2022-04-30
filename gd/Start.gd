extends Node2D

onready var scene

func _ready():
	VisualServer.set_default_clear_color(Color( 0, 0, 0, 1 ))

func _process(_delta):
	if Input.is_action_just_released("ui_accept") or get_node("StartButton").is_pressed():
		scene = get_tree().change_scene("res://tscn/Main.tscn")
	if Input.is_action_just_released("ui_cancel") or get_node("ExitButton").is_pressed():
		get_tree().quit()
		
