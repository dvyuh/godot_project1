extends Area2D

func _physics_process(delta):
	look_at(get_global_mouse_position())


func shoot():
	const bullet = preload("res://scenes/bullet.tscn")
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = %shooting_point.global_position
	new_bullet.global_rotation = %shooting_point.global_rotation
	%shooting_point.add_child(new_bullet)
'
func alt_shoot():
	if not alt_can_shoot:
		return
	const bullet = preload("res://bullet.tscn")
	var spread_angles = [-0.15, 0, 0.15]   
	for angle in spread_angles:
		var new_bullet = bullet.instantiate()
		new_bullet.global_position = %shooting_point.global_position
		new_bullet.global_rotation = %shooting_point.global_rotation + angle
		%shooting_point.add_child(new_bullet)
	await get_tree().create_timer(alt_cooldown).timeout
	alt_can_shoot = true
'


# shoot bullet on press mouse button
func _input(event):
	if event.is_action_pressed("shoot"):
		shoot()
'	elif event.is_action_just_pressed("alt_shoot"):
		alt_shoot()
'
