extends CharacterBody2D

const SPEED = 200.0
var mode = 0 #0 - red, 1 - blue

func _physics_process(_delta):
	if mode == 0:
		self.modulate = Color(1, 0, 0)
		var dir_x = Input.get_axis("player_left", "player_right")
		var dir_y = Input.get_axis("player_up", "player_down")
		
		velocity.x = dir_x * SPEED
		velocity.y = dir_y * SPEED

		move_and_slide()
	if mode == 1:
		self.modulate = Color(0, 0, 1)
		var dir_x = Input.get_axis("player_left", "player_right")
		var dir_y = Input.get_axis("player_up", "player_down")
		
		velocity.x = dir_x * SPEED
		velocity.y = dir_y * SPEED

		move_and_slide()
