class_name Pellet
extends AnimatableBody2D

@export var animator: AnimationPlayer
@export var animacja: String = "ruch"
@export var predkosc: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if animator && animacja:
		animator.play(animacja)

func _physics_process(_delta):
	position += predkosc
	
