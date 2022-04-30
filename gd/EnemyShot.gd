extends Area2D

onready var main = get_parent()
onready var player = main.get_node("Player")
onready var anim = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var shot_wait_timer = get_node("ShotWaitTimer")

var frames = 0
var allow_shot = 1
var wait_time = 0.2
var moving = 1

func _ready():
	sprite.region_rect = Rect2(121,18,3,7)

func _process(_delta):
	frames += 1
	if moving:
		if frames == 3:
			self.position.y += 4
			sprite.region_rect = Rect2(130,18,3,7)
		elif frames == 6:
			self.position.y += 4
			sprite.region_rect = Rect2(139,18,3,7)
		elif frames == 9:
			self.position.y += 4  
			sprite.region_rect = Rect2(112,18,3,7)
		elif frames == 12:
			self.position.y += 4  
			sprite.region_rect = Rect2(121,18,3,7)
			frames = 0

func _on_EShot_area_entered(area):
	if "Enemy" in area.name:
		pass
	elif "Greener" in area.name:
		pass
	elif "Whiter" in area.name:
		pass
	elif "EShot" in area.name:
		pass
#	elif "Shield" in area.get_parent().name:
#		get_node("CollisionShape2D").set_deferred("disabled", true)
#		#var area2 = str(area.name, "2")
#		#area.get_parent().get_node(area2).show()
#		#area.get_parent().get_node(area2).get_node("CollisionPolygon2D").call_deferred("set", "disabled", false)
#		print("collided with: ", area)
#		#print("show area: ", area.get_parent().get_node(area2))
#		#area.queue_free()
#		sprite.region_rect = Rect2(117,45,6,8)
#		shot_wait_timer.start(wait_time)
#		moving = 0
	elif area.name == "Player":
#		main.die()
		player.die()
		sprite.region_rect = Rect2(117,45,6,8)
		shot_wait_timer.start(wait_time)
		moving = 0
	else:
		#print("hit ", area)
		get_node("CollisionShape2D").call_deferred("set", "disabled", true)
		sprite.region_rect = Rect2(117,45,6,8)
		shot_wait_timer.start(wait_time)
		moving = 0
	
func _on_ShotWait_timeout():
	main.enemy_shot_gen()
	queue_free()
