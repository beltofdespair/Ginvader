extends Area2D


func _ready():
	pass

func _on_TopLeft_area_entered(area):
	if area.name == "EShot":
		print("shield hit")
		queue_free()
		get_parent().get_node("TopLeft2").show()
		
