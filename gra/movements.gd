class_name Frisk
extends CharacterBody2D

var speed_mul: float = 1

const SPEED = 300.0

func _physics_process(_delta):
	var dir_x = Input.get_axis("player_left", "player_right")
	var dir_y = Input.get_axis("player_up", "player_down")
	
	speed_mul = 0.5 if Input.is_action_pressed("player_action") else 1.0
	
	velocity.x = dir_x * speed_mul * SPEED
	velocity.y = dir_y * speed_mul * SPEED
	
	move_and_slide()

var mode = 0 #0 - red, 1 - yellow
