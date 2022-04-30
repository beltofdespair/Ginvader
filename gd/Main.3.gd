extends Node2D

onready var playertimer = get_node("PlayerTimer")

var player = preload("res://tscn/Player.tscn")
var playernode


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	playertimer.start()
	VisualServer.set_default_clear_color(Color8(5,5,5,255))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayerTimer_timeout():
	print("playertimer timeout")
	playernode = player.instance()
	add_child(playernode)
	playernode.position = Vector2(30,220)
	pass # Replace with function body.
