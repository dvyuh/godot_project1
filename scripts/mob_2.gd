extends CharacterBody2D

var health = 1
signal mob_killed

@onready var Player = get_node("/root/Game/Player")

func _ready() -> void:
	%Slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(Player.global_position)
	velocity = direction * 600.0
	move_and_slide() 

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health == 0:
		emit_signal("mob_killed")
		queue_free()
		const smoke_screen = preload("res://assests/smoke_explosion/smoke_explosion.tscn")
		var smoke = smoke_screen.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		
