extends Node2D

onready var lives_label = get_node("LivesLabel")
onready var count_label = get_node("EnemyCount")
onready var shotcount = get_node("shotcount")
onready var enemyshot = preload("res://tscn/EShot.tscn")
onready var player = get_node("Player")
onready var enemies = get_node("Enemies")
onready var return_timer = get_node("ReturnTimer")

var scene
var lives = 3
var shoot = 1
var random_enemy
var hits = 0
var shots = 0
var playernode
var esi
var esi2
var enemycount = 60
var frames = 0
var stop_shot_gen = 0

func _ready():
	#if Globals.level == 2:
	var i = 1
	while i < 61:
		get_node(str("Enemies/Enemy", i)).position.y += 8*Globals.level
		i+=1
	
#	enemycount = 1
#	print(screensize.x)
#	lives = 3
	randomize()
	VisualServer.set_default_clear_color(Color8(0,0,0,255))

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
#	while enemycount < 60:
#		enemycount += 1
#	print("enemycount = ", enemycount)
	if enemycount < 1:
		win()
	frames += 1
	lives_label.text = str("lives = ", Globals.lives)
	count_label.text = str("gdinvaders = ", enemycount)
#	if shots > 0:
#		shotcount.text = str(hits,"/",shots,"=", stepify(100*(float(hits)/float(shots)), 1), "%")
	if enemycount < 45:
		stop_shot_gen = 1
	if frames == 140:
		player_set()

	if frames == 192:
		enemy_shot_gen()
	if frames == 768:
		enemy_shot_gen2()
	if Globals.level > 1:
		if frames == 384:
			enemy_shot_gen()
			

func _on_PlayerTimer_timeout():
#	print("playertimer timeout")

	pass # Replace with function body.
	
func get_random_enemy():
	#	get_random_enemy()
#	var i = randi() % 60 + 1
#	var bottom_id = i
#	print("random_enemy = ", random_enemy)
	var randen_id = randi() % 60 + 1
	random_enemy = get_node_or_null(str("Enemies/Enemy", randen_id))
	

	if random_enemy == null:
#		get_random_enemy()
#		print("null")
		while random_enemy == null:
			randen_id = randi() % 60 + 1
			
#			randen_id += 1
#			if randen_id > 60:
#				randen_id = 1
#				get_random_enemy()
			random_enemy = get_node_or_null(str("Enemies/Enemy", randen_id))
#		print("not null")
#	var i = 12
#	print("randen_id = ", randen_id)
	#print("random_enemy = ", random_enemy)
	var randen_mintwelve_id = randen_id
	while randen_mintwelve_id > 0:
		randen_mintwelve_id -= 12
	randen_mintwelve_id += 12
#	print("randen_mintwelve_id after min 12 = ", randen_mintwelve_id)
	var randen_mintwelve = get_node_or_null(str("Enemies/Enemy", randen_mintwelve_id))
	if randen_mintwelve == null:
		while randen_mintwelve == null:
			randen_mintwelve_id += 12
			if randen_mintwelve_id > 60:
				get_random_enemy()
			else:
				randen_mintwelve = get_node_or_null(str("Enemies/Enemy", randen_mintwelve_id))
			
#		print("randen_mintwelve = ", randen_mintwelve)
#		random_enemy = randen_plus
#		i += 12
#	print("randen_mintwelve = ", randen_mintwelve)
	return randen_mintwelve
#	random_enemy = 

func enemy_shot_gen():
	shoot = 0
	var randen = get_random_enemy()
	esi = enemyshot.instance()
	call_deferred("add_child", esi)
	esi.position.x = randen.position.x
	esi.position.y = randen.position.y+15

func enemy_shot_gen2():
	shoot = 0
	var randen = get_random_enemy()
	esi2 = enemyshot.instance()
	call_deferred("add_child", esi2)
	esi2.position.x = randen.position.x
	esi2.position.y = randen.position.y+15

func player_set():
#	playernode = player.instance()
#	call_deferred("add_child", playernode)
	player.moving = 1
	player.position = Vector2(32,225)
	player.get_node("Sprite2").region_rect = Rect2(115,63,11,8)
	player.show()
	player.get_node("Sprite2").region_rect = Rect2(115,63,11,8)

#func die():
#	lives -= 1
#	if lives == 0:
#		var _k = get_tree().change_scene("res://tscn/Start.tscn")
#	pass

func _on_Greener_area_entered(area):
	area.modulate = Color(0,1,0)	

func _on_Whiter_area_entered(area):
	area.modulate = Color(1,1,1)	


func _on_ReturnTimer_timeout():
	scene = get_tree().change_scene("res://tscn/Start.tscn")

func win():
	#scene = get_tree().change_scene("res://tscn/WinScene.tscn")
	Globals.level += 1
	scene = get_tree().change_scene("res://tscn/Main.tscn")
	#return_timer.start(2)

