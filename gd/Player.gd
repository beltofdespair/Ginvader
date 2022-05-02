extends Area2D

#onready var main = get_node("/root/Main")
onready var main = get_parent()
#onready var screensize = main.screensize
onready var timer = get_node("Timer")
onready var shot = preload("res://tscn/PShot.tscn")
onready var sprite = get_node("Sprite2")
onready var anim = get_node("AnimationPlayer")
onready var death_timer = get_node("DeathTimer")

const SHOTSPEED := 10
const SPEED := 1
var move := 0
var vel := 0
var can_shoot = true
#var lives = 3
var frames 
var moving = 0
var screensize

func _ready():
	screensize = get_viewport_rect().size
	#print(screensize)
	sprite.region_rect = Rect2(115,63,11,8)
#	print(sprite.region_rect)
#	print("screensize = ", screensize)
	pass

func _process(_delta):
#	print("time left = ", timer.time_left)
	move = int(Input.get_action_strength("right")) - int(Input.get_action_strength("left"))
	vel = move * SPEED
#	print("vel = ", vel)
	if moving:
		position.x += vel

		position.x = clamp(position.x, screensize.x-screensize.x+30, screensize.x-30)

		if Input.is_action_just_pressed("shoot"):
			if get_parent().get_node_or_null("PShot"):
#			if get_parent().get_node("PShot"):
				can_shoot = false
			else:
				main.shots += 1
#				can_shoot = true
				var shotinstance = shot.instance()
				get_parent().add_child(shotinstance)
				shotinstance.global_position.y += position.y - 10
				shotinstance.global_position.x += position.x
	
func die():
	get_node("CollisionPolygon2D").set_deferred("disabled", true)
	moving = 0
	sprite.region_rect = Rect2(147,63,15,8)
#	frames = 0
#	frames += 1
#	var loops = 0
	anim.play("die")
	var animqueue = 0
	while animqueue < 11:
		anim.queue("die")
		animqueue += 1
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
#	anim.queue("die")
	death_timer.start(2)
#	anim.stop()
#	while loops < 11:
#		anim.play("die")
#		loops += 1
#	print("loops = ", loops)
#	if loops > 10:
#		anim.stop()
	
#	while loops < 11:
#		frames = 0
#		while frames < 10:
#			if frames == 4:
#				sprite.region_rect = Rect2(132,63,13,8)
#			if frames == 9:
#				sprite.region_rect = Rect2(147,63,15,8)
#			frames += 1
#			print("frames = ", frames)
#			print("sprite.region_rect = ", sprite.region_rect)
#		loops += 1
#		print("loops = ", loops)
	
#	if anim.is_playing() == true:
#		print("anim play")
#	if anim.is_playing() == false:
#		print("anim stop")


func _on_Timer_timeout():
	can_shoot = true

func _on_DeathTimer_timeout():
	var i = Globals.lives
	Globals.lives -= 1
	if Globals.lives == 0:
		var _k = get_tree().change_scene("res://tscn/Start.tscn")
	main.get_node(str("PlayerSprite", i)).queue_free()
	get_node("CollisionPolygon2D").set_deferred("disabled", false)
	sprite.region_rect = Rect2(115,63,11,8)
	main.player_set()
#	queue_free()
