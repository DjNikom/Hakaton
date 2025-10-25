class_name Dusza
extends CharacterBody2D

var speed_mul: float = 1

const SPEED = 300.0

func damage(obrazenia: int):
	var bitwa: Bitwa = get_parent()
	
	niewrazliwosc = 120
	hp -= obrazenia
	bitwa.hud_aktualizacja()
	bitwa.dzwieki["damage"].play()
	self.collision_layer &= ~2

func ruch_normalny(_delta, sprint = true):
	var dir_x = Input.get_axis("player_left", "player_right")
	var dir_y = Input.get_axis("player_up", "player_down")
	
	speed_mul = 1.0
	if sprint:
		speed_mul = 0.5 if Input.is_action_pressed("player_action") else 1.0
	
	velocity.x = dir_x * speed_mul * SPEED
	velocity.y = dir_y * speed_mul * SPEED
	
	move_and_slide()

var hp = -1
var maxhp = -1
var mode = 0 #0 - red, 1 - yellow
var niewrazliwosc = 0

func _physics_process(_delta):
	if niewrazliwosc > 0:
		niewrazliwosc -= 1
		if niewrazliwosc == 0:
			self.collision_layer |= 2
		self.visible = ~(niewrazliwosc >> 3) & 1
	
	match mode:
		0:
			self.modulate = Color(1, 0, 0)
			
			ruch_normalny(_delta)
		1:
			self.modulate = Color(1, 1, 0)
			self.rotation = PI
			
			if Input.is_action_just_pressed("player_action"):
				print("FEUER FREI")
			
			ruch_normalny(_delta, false)
