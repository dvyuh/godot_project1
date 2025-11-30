extends Node2D

var Score: int = 0
var mob_list = [
	preload("res://scenes/mob.tscn"),
	preload("res://scenes/mob_2.tscn") 
]

func _on_mob_killed() -> void:
	Score +=1
	%Label.text = "Score: %d" % Score	

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func spawn_mob():
	var enemy = randf_range(0,mob_list.size())
	var new_mob = mob_list[enemy].instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position =%PathFollow2D.global_position
	new_mob.mob_killed.connect(_on_mob_killed)
	add_child(new_mob)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		get_tree().reload_current_scene()
