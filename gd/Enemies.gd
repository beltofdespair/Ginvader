extends Node

export var paused = false
onready var main = get_parent()
onready var speed = 2
onready var velocity
onready var wall = 0
onready var dir = 1
onready var vert = 0

var vader
var vader_node
var lastvader = ""
var lastvader_node

var sprite1
var sprite2

var time := 0.0
var counter = 0
var frame = 0

func _ready():
	pass

func _process(delta):
	if paused == true:
		get_tree().paused = true
	velocity = speed * dir
	time += delta
#	print("time = ", time)
	if time > 1:
		if frame >= main.enemycount:
			frame = 0
		frame += 1
		if counter == int(lastvader.substr(5,7)):
			counter = 0
		counter += 1
		get_next_vader()
		lastvader_node = get_last_vader()
		if main.enemycount != 0:
			if vert == 0:
				vader_node.position.x += velocity
			elif vert == 1:
				vader_node.position.x += velocity
				vader_node.position.y += 8

		if counter == int(lastvader.substr(5,7)):
			
#			print("vert = ", vert, " | wall = ", wall)
			if wall == 1 or wall == -1:
				if vert == 1:
					vert = 0
					wall = 0
				else:
					vert = 1
				if wall == 1:
					dir = -1
				elif wall == -1:
					dir = 1

# switch enemy sprites each frame
		if main.enemycount != 0:
			if sprite1.is_visible():
				sprite1.hide()
				sprite2.show()
			else:
				sprite2.hide()
				sprite1.show()

func get_next_vader():
#	if main.enemycount < 1:
#		main.get_node("WinLabel").show()
#		get_tree().paused = true
	vader = "Enemy" + str(counter)
	vader_node = get_node_or_null(vader)

	sprite1 = get_node_or_null(vader + "/Sprite")
	sprite2 = get_node_or_null(vader + "/Sprite2")

	if vader_node == null:
		if counter == int(lastvader.substr(5,7)):
			counter = 0
		counter += 1
		if main.enemycount == 0:
			main.win()
		else:
			get_next_vader()
	else: 
		return vader_node
	if main.enemycount < 1:
		main.win()

func get_last_vader():
	var wr = weakref(lastvader_node);
	var count = 60
	if lastvader_node == null:
		while lastvader_node == null:
			lastvader = "Enemy" + str(count)
			lastvader_node = get_node_or_null(lastvader)
			count -= 1
		return lastvader_node

	if (!wr.get_ref()):
		lastvader = "Enemy" + str(count)
		lastvader_node = get_node_or_null(lastvader)

	return lastvader_node

func _on_RightWall_area_entered(area):
	if "Enemy" in area.name:
		wall = 1

func _on_LeftWall_area_entered(area):
	if "Enemy" in area.name:
		wall = -1
