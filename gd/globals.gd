extends Node

var level = 0
var lives = 3

func _ready():
	pass

func set_pause_node(node : Node, pause : bool) -> void:
    node.set_process(!pause)
    node.set_process_input(!pause)
    node.set_process_internal(!pause)
    node.set_process_unhandled_input(!pause)
    node.set_process_unhandled_key_input(!pause)
