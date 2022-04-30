extends Area2D


func _ready():
	pass

func _process(_delta):
	pass
#	if position.y < 220:
#		modulate = Color8(255,255,255,255)
#	else:
#		modulate = Color8(255,128,255,255)
		#modulate = ColorN("white")
		
func _on_Enemy_area_entered(area):
	if area.name == "Player":
		area.die()	
