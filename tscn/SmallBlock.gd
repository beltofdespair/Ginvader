extends Node2D

onready var sprite1 = get_node("Sprite")
onready var sprite2 = get_node("Sprite2")


func _ready():
	pass
#	modulate = Color(0,1,0)

func _on_SmallBlock_area_entered(area):
	#print("hit by ", area)
	if "EShot" in area.name or area.name == "PShot":
		if sprite2.is_visible_in_tree() == true:
#			print("sprite2.is_visible_in_tree() = ", sprite2.is_visible_in_tree())
			queue_free()
		else:
			sprite1.hide()
			sprite2.show()
	elif "Enemy" in area.name:
		queue_free()

