class_name Gracz
extends CharacterBody2D

var speed_mul: float = 1
var constVel = Vector2(0,0)

var po_wejsciu = 0

const SPEED = 150.0

func _ready() -> void:
	var transition = ResourceLoader.load("res://Wazne/transition.tscn")
	self.add_child(transition.instantiate())
	var instancedTransition = self.get_node("Transition")
	instancedTransition.name = "initTransition"
	instancedTransition.color = Color(0, 0, 0, 255)
	instancedTransition.get_node("fadein").play("fadein")
	
	set_meta("movable", false)
	await get_tree().create_timer(0.3).timeout
	set_meta("movable", true)
	await get_tree().create_timer(0.45).timeout
	if instancedTransition:
		instancedTransition.queue_free()

func _physics_process(_delta):
	if self.get_meta("movable"):
		var dir_x = Input.get_axis("player_left", "player_right")
		var dir_y = Input.get_axis("player_up", "player_down")
		
		speed_mul = 0.5 if Input.is_action_pressed("player_action") else 1.0
		
		velocity.x = dir_x * speed_mul * SPEED
		velocity.y = dir_y * speed_mul * SPEED
	else:
		pass
	move_and_slide()
	velocity = constVel

var mode = 0 #0 - red, 1 - yellow
