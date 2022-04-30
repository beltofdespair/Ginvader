extends Node2D

export var paused = 0
onready var count_label = get_node("enemy_count")
onready var shotcount = get_node("shotcount")
onready var timer = get_node("PlayerTimer")
onready var player = preload("res://tscn/Player.tscn")

var shots = 0
var playernode
var vader
var vader_node
var lastvader
var lastvader_node
onready var dir = 1
onready var speed = 2
onready var velocity
onready var wall = 0
onready var down = 0
var twice = 0
var counter = 1

var firstvader
var move_end
var move_start


var sprite1
var sprite2
var sprite = 1
var rightvaderid = 60
var rightvader
var rightvader_node

var enemycount := 60
var hits = 0

var time := 0.0



var frame_one = 0
var frame_two = 1


func _ready():
	timer.start()
#	VisualServer.set_default_clear_color(ColorN("black"))
	VisualServer.set_default_clear_color(Color8(5,5,5,255))

	pass

func _process(delta):
	if frame_one == 60:
		print("firstvader = ", firstvader)
	if frame_one > enemycount:
		frame_one = 1
		frame_two = 2
	frame_one += 1
#	print("frame_one = ", frame_one)
#	lastvader = "Enemies/Enemy" + str(enemycount)
#	lastvader_node = get_node_or_null(lastvader)
#	if Input.is_action_just_pressed("pause"):
##		print("pressed pause")
#		get_node("Popup").popup()
	if enemycount == 0:
#		print("win")
		var _k = get_tree().paused
#	if frame_one == 1:
#		print(paused)
	count_label.text = str("ginvaders=",+ enemycount)
	if shots > 0:
		shotcount.text = str(hits,"/",shots,"=", stepify(100*(float(hits)/float(shots)), 1), "%")
	


	time += delta
#	totaltime += delta
	
	if time > 1:
#		if enemycount == 0:
#			print("win")
#			get_tree().paused = true

		get_next_vader()

func _on_Timer_timeout():
	playernode = player.instance()
	add_child(playernode)
	playernode.position = Vector2(30,220)

func get_next_vader():
	var firstcounter = 1
	if firstcounter > 60:
		firstcounter = 1
	if counter > 60:
		counter = 1

		
	velocity = speed * dir
	vader = "Enemies/Enemy" + str(counter)
#	print("frame_two = ", frame_two)
	vader_node = get_node_or_null(vader)
	rightvader = "Enemies/Enemy" + str(rightvaderid)
	rightvader_node = get_node_or_null(rightvader)
	sprite1 = get_node_or_null(vader + "/Sprite")
	sprite2 = get_node_or_null(vader + "/Sprite2")
	
#	if frame_one == 60:
#		print("frame_one = ", frame_one)

#		down = 0
#	print("vader_node.position.x = ", vader_node.position.x)
	if vader_node != null:
		firstvader = "Enemies/Enemy" + str(firstcounter)
		var firstvader_node = get_node_or_null(firstvader)
		if firstvader_node == null:
			firstcounter += 1
	if vader_node == null:
		print("null counter = ", counter)
#		if frame_one == rightvaderid:
#			rightvaderid -= 12
##			print("rightvaderid = ", rightvaderid)
#			if rightvaderid == 0:
#				rightvaderid = 59
#		print("null")
#		frame_one += 1
#		frame_two += 1
		counter += 1
		firstcounter += 1
		get_next_vader()
	else:
#		if frame_one > 60:
#			frame_one = 1
#			frame_two = 2
#		if frame_one == 60:
#			print("frame_one = ", frame_one)
##			print("down = ", down)
#			print("frame_one = ", frame_one)
#			print("vader node = ", vader_node, vader_node.position.x)
#			print("wall = ", wall)
		vader_node.position.x += velocity
		counter += 1
#		get_next_vader()
#		if down == 1:
#			vader_node.position.y += 8
#			down = 0
#		if frame_one > enemycount:
#			if wall == 1:
#				print("wall and frame")
#				down = 1
##				move_down()
#				dir *= -1
#				print("dir = ", dir)
#				wall = 0
#				print("wall = ", wall)
#				print("wall = ", wall)
#		if frame_one == 61:
#			if twice == 1:
#				vader_node.position.x += -2*velocity
#				twice = 0
		
#		if frame_one == 60:
##			print("frame_one = ", frame_one)
#			print("velocity = ", velocity)
#			print("dir = ", dir)
##			print("rightvader = ", rightvader_node, rightvader_node.position.x)
##			print("vader node and position = ", vader_node.position.x)
##		print("frame_two = ", frame_two)
#		if frame_one == 60:
##		print("enemycount = ", enemycount)
##			frame_one = 1
##		print("frame_one = ", frame_one)
#			if dir == 1 and rightvader_node.position.x > 201:
##				print("vader node and position = ", vader_node, vader_node.position.x)
#
##				print("vader_node.position.x = ", vader_node, vader_node.position.x)
##				move_down()
#				pass
##				dir *= -1
##			vader_node.position.x += velocity
#
#				print("velocity = ", velocity)
##			print("velocity = ", velocity)
##				frame_one = 1
##				frame_two = 2
#
#			elif dir == 1 and rightvader_node.position.x < 175:
#				pass
##			vader_node.position.x += -2*velocity
##			print("vader_node.position.x = ", vader_node.position.x)
##				move_down()
##				dir *= -1
##				frame_one = 1
##				frame_two = 2
				




#		if frame_two == 61:
#			down = 0
		if sprite1.is_visible():
			sprite1.hide()
			sprite2.show()
		else:
			sprite2.hide()
			sprite1.show()
		

func move_down():
	print("reverse")
	frame_one = 1
	frame_two = 2
	while frame_two < 62:
#			while frame_one < 61:
		vader = "Enemies/Enemy" + str(frame_one)
		vader_node = get_node_or_null(vader)
#			frame_one +=1
#			frame_two +=1
#			if frame_two > 61:
#				frame_one = 1
#				frame_two = 2
		if vader_node == null:
#			get_next_vader()
			pass
		else:
#				if frame_two < 61:
			vader_node.position.y += 8
#			vader_node.position.x += velocity * reverse
			frame_one += 1
			frame_two += 1
#				get_next_vader()
#			frame_one += 1
#		reverse *= -1
#			frame_one = 1
pass


func _on_RightWall_area_entered(area):
	if "Enemy" in area.name:
#		print("right")
#		if frame_one == 60:
#			print("right 60")
		wall = 1
		twice = 1
		if frame_one == enemycount:
			turn_left()
#		print("wall = ", wall)
#		dir *= -1
	pass # Replace with function body.


func _on_LeftWall_area_entered(area):
	if "Enemy" in area.name:
		print("left")
		wall = 1
		twice = 1
		if frame_one == enemycount:
			turn_right()	
#		print("wall = ", wall)
		turn_right()
#		print("frame_one = ", frame_one)
	pass # Replace with function body.
	
func turn_left():
		dir = -1
		
func turn_right():
		dir = 1
