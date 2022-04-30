extends Node2D

export var paused = 0
onready var count_label = get_node("enemy_count")
onready var shotcount = get_node("shotcount")
onready var playertimer = get_node("PlayerTimer")
onready var player = preload("res://tscn/Player.tscn")
onready var right_disable_timer = get_node("RightDisableTimer")
onready var left_disable_timer = get_node("LeftDisableTimer")
onready var speed = 2
onready var velocity
onready var wall = 0
onready var dir = 1
onready var vert = 0

var shots = 0
var playernode
var vader
var vader_node
var lastvader = ""
var lastvader_node

var sprite1
var sprite2
var enemycount = 60
var hits = 0

var time := 0.0
var counter = 0
var frame = 0

func _ready():
	playertimer.start()
	VisualServer.set_default_clear_color(Color8(5,5,5,255))
	pass

func _process(delta):

#	print("frame = ", frame)

	if enemycount == 0:
#		get_next_vader().
		print("win")
		get_tree().paused = true
#	print(counter)
	
#	print("frame = ", frame, " enemycount = ", enemycount)
	velocity = speed * dir

	if enemycount == 0:
#		print("win")
		var _k = get_tree().paused
	count_label.text = str("ginvaders=",+ enemycount)
	if shots > 0:
		shotcount.text = str(hits,"/",shots,"=", stepify(100*(float(hits)/float(shots)), 1), "%")
	time += delta

	if time > 1:

		if frame >= enemycount:
			frame = 0
		frame += 1

		if counter == int(lastvader.substr(13,15)):
			counter = 0
		counter += 1
		get_next_vader()
		lastvader_node = get_last_vader()
		if vert == 0:
			vader_node.position.x += velocity
		elif vert == 1:
			vader_node.position.x += velocity
			vader_node.position.y += 8
			if counter == int(lastvader.substr(13,15)):
				vert = 0

		if counter == int(lastvader.substr(13,15)):
			if wall == 1:
				vert = 1
				dir = -1
				wall = 0
			if wall == -1:
				vert = 1
				dir = 1
				wall = 0

		if sprite1.is_visible():
			sprite1.hide()
			sprite2.show()
		else:
			sprite2.hide()
			sprite1.show()
		
func _on_Timer_timeout():
	playernode = player.instance()
	add_child(playernode)
	playernode.position = Vector2(30,220)

func get_next_vader():

	vader = "Enemies/Enemy" + str(counter)
	vader_node = get_node_or_null(vader)

	sprite1 = get_node_or_null(vader + "/Sprite")
	sprite2 = get_node_or_null(vader + "/Sprite2")

	if vader_node == null:
		
		if counter == int(lastvader.substr(13,15)):
			counter = 0
		counter += 1
		get_next_vader()
	else: 
		return vader_node

func get_last_vader():
	var wr = weakref(lastvader_node);
	var count = 60
	if lastvader_node == null:
		while lastvader_node == null:
			lastvader = "Enemies/Enemy" + str(count)
			lastvader_node = get_node_or_null(lastvader)
			count -= 1
		return lastvader_node

	if (!wr.get_ref()):
		lastvader = "Enemies/Enemy" + str(count)
		lastvader_node = get_node_or_null(lastvader)

	return lastvader_node

func _on_RightWall_area_entered(area):
	if "Enemy" in area.name:
		wall = 1
		print("wall = ", wall)
		get_node("RightWall/CollisionShape2D").set_deferred("disabled", true)
		right_disable_timer.start()

func _on_LeftWall_area_entered(area):
	if "Enemy" in area.name:
		wall = -1
		print("wall = ", wall)
		get_node("LeftWall/CollisionShape2D").set_deferred("disabled", true)
		left_disable_timer.start()

func _on_RightDisableTimer_timeout():
	get_node("RightWall/CollisionShape2D").disabled = false

func _on_LeftDisableTimer_timeout():
	get_node("LeftWall/CollisionShape2D").disabled = false
