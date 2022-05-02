extends Node2D

onready var sprite = preload("res://tscn/PlayerSprite.tscn")

var i = 0
var sprite_inst_id
var sprite_inst

func _ready():
	pass

func _process(_delta):
	pass
#	while i < Globals.lives:
##		print("lives = ", Globals.lives, " i = ", i)
#		sprite_inst = sprite.instance()
#		get_parent().add_child(sprite_inst)
#		sprite_inst.position = Vector2(20+i*15, 245)
#		print(sprite_inst)
#	
#		i += 1
		

func update_lives():
	if get_parent().get_node_or_null("PlayerSprite").:
		get_parent().get_node_or_null("PlayerSprite").queue_free()
	while i < Globals.lives:
#		print("lives = ", Globals.lives, " i = ", i)
		sprite_inst = sprite.instance()
		get_parent().add_child(sprite_inst)
		sprite_inst.position = Vector2(20+i*15, 245)
		print(sprite_inst)
	
		i += 1
	
