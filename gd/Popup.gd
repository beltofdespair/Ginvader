extends Popup


func _ready():
	pass

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == true:
			get_tree().paused = false
		else:
			get_tree().paused = true
