extends Area2D

onready var enemies = get_parent().get_node("Enemies")
onready var main = get_parent()
onready var player = main.get_node("Player")
onready var explode_timer = get_node("ExplodeTimer")
onready var collision = get_node("CollisionShape2D")
var moving = true
var explode_time = .3
var explode_switch = 0

func _ready():
	pass

func _process(_delta):
# if the shot should be moving (it hasn't hit anything yet), move it
	if moving:
		global_position.y -= 3.5
	
func _on_PlayerShot_area_entered(area):
# if it hits something, hide the sprite
# if it hits something, stop it
	if area.name == "Edge":
# don't have to wait for the explosion if it hits the edge of the screen
		player.can_shoot = true
# kill it if it hits the edge of the screen
		queue_free()
	elif area.name == "Player":
		pass
	elif area.name == "Greener":
		pass
	elif area.name == "Whiter":
		pass
	elif area.name == "EShot":
		moving = false
		get_node("Sprite").hide()
		collision.set_deferred("disabled", true)
		get_node("Explosion").show()
		area.queue_free()
		player.can_shoot = false
		explode_timer.start(explode_time)
		main.enemy_shot_gen()
	elif "Enemy" in area.name:
		Globals.set_pause_node(enemies,1)
		moving = false
		get_node("Sprite").hide()
#		if main.enemycount == 1:
#			print("last one")
#			main.get_node("WinLabel").show()
#			get_tree().paused = true
#		call_deferred("get_tree().paused","true", enemies)
# show the explosion sprite
		collision.set_deferred("disabled", true)
#		collision.disabled = true
		get_node("Explosion").show()
# explosion timer
		area.queue_free()
		main.enemycount -= 1
		#print("enemycount = ", main.enemycount)
		player.can_shoot = false
		explode_timer.start(explode_time)
# main.get_node("Enemies").paused = true
#		if explode_switch == 0:
#			main.enemycount -= 1
#			main.hits += 1
#			main.enemycount -= 1
# increase hit counter
#			main.hits +=1 
# player has to wait for explosion to end to shoot again
#		explode_switch = 1

	else:
		moving = false
		collision.set_deferred("disabled", true)
		player.can_shoot = false
		get_node("Explosion").show()
		explode_timer.start(explode_time)

func _on_ExplodeTimer_timeout():
#	explode_switch = 0
	player.can_shoot = true
#	main.enemycount -= 1
	Globals.set_pause_node(enemies,0)
	queue_free()
