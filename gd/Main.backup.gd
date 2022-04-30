extends Node2D

onready var timer = get_node("Timer")

var vader
var vader_node
var playernode

var enemycount := 60

var maxmoves := 4
var kills := 0
var playertime := 0.0

var moves := 0
var newmoves := 0

var time := 0.0
var frametime := 0.0

var reverse := -1
var velocity := 2

var frame_one := 1
var frame_two := 2

onready var player = preload("res://Player.tscn")

func _ready():
	timer.start()
#	VisualServer.set_default_clear_color(ColorN("black"))
	VisualServer.set_default_clear_color(Color8(5,5,5,255))

	pass

func _process(delta):
#	print("frame_two = ", frame_two)
	vader = "Enemy" + str(frame_one)
	vader_node = get_node_or_null(vader)
	var anim = get_node_or_null(vader + "/AnimationPlayer")

#	print("reverse = ", reverse)
#	print("time = ", time)
#	print("1+delta*60 = ", 1+delta*60)

	time += delta
	frametime = delta

	if time > 1:

		if time >= 1+delta*frame_one and time <= 1+delta*frame_two:
			get_next_vader()
			if anim != null:
				anim.play("move")
			else:
				pass
#			if moves > 0 and (moves == 8 or newmoves == 16):
#				if frame_two == enemycount+1:
#					reverse *= -1
#				if vader_node != null:
#					vader_node.position.y += 7
##					if frame_one == 1:
##						print("going down")
#				else:
#					frame_one += 1
#					frame_two += 1
#					vader = "Enemy" + str(frame_one)
#					vader_node = get_node_or_null(vader)
#					vader_node.position.y += 7
#			else:
#				if reverse == 1:
#					if vader_node != null:
#						vader_node.position.x -= velocity
#					else:
#						frame_one += 1
#						frame_two += 1
#						pass
#						vader = "Enemy" + str(frame_one)
#						vader_node = get_node_or_null(vader)
#						vader_node.position.x -= velocity
#				else:
#					get_next_vader()
#					if vader_node != null:
#						vader_node.position.x += velocity
#					else:
#						frame_one += 1
#						frame_two += 1
#						vader = "Enemy" + str(frame_one)
#						vader_node = get_node_or_null(vader)
#						vader_node.position.x += velocity
#			frame_one += 1
#			frame_two += 1
#			if frame_two > enemycount+1:
#				moves += 1
#				if moves > 9:
#					newmoves += 1
#				if newmoves > 16:
#					newmoves = 0
##				print("moves = ", moves)
##				print("newmoves = ", newmoves)
#				frame_one = 1
#				frame_two = 2

		if time > 1+delta*enemycount:
			moves += 1
			if moves > 9:
				newmoves += 1
			if newmoves > 16:
				newmoves = 0
#			print("moves = ", moves)
#			print("newmoves = ", newmoves)
			frame_one = 1
			frame_two = 2
#			print("1+delta*frame_one = ", 1+delta*frame_one)
#			print("1+delta*frame_two = ", 1+delta*frame_two)
			time = .999


func _on_Timer_timeout():
	print("add player")
	playernode = player.instance()
	add_child(playernode)
	playernode.position = Vector2(30,220)
	print("player position = ", playernode.position)

func get_next_vader():
	vader = "Enemy" + str(frame_one)
	vader_node = get_node_or_null(vader)
	frame_one += 1
	frame_two += 1
	if moves > 0 and (moves == 8 or newmoves == 16):
		if frame_two == enemycount+1:
			reverse *= -1
		if vader_node != null:
			vader_node.position.y += 7
#			frame_one += 1
#			frame_two += 1
		else:
#			frame_one += 1
#			frame_two += 1
			vader = get_next_vader()
	else:
		if vader_node != null:
			vader_node.position.x -= 1 * reverse
#			frame_one += 1
#			frame_two += 1
		else:
#			frame_one += 1
#			frame_two += 1
			vader = get_next_vader()
	
