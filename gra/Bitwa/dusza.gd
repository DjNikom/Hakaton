extends CharacterBody2D

const SPEED = 300.0

func _physics_process(_delta):
	var dir_x = Input.get_axis("player_left", "player_right")
	var dir_y = Input.get_axis("player_up", "player_down")
	
	velocity.x = dir_x * SPEED
	velocity.y = dir_y * SPEED

	move_and_slide()
