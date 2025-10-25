class_name Pellet
extends AnimatableBody2D

@export var animator: AnimationPlayer
@export var animacja: String = "ruch"
@export var obrazenia: int = 1
@export var predkosc: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	if animator && animacja:
		animator.play(animacja)

func _physics_process(_delta):
	position += predkosc
	var kolizja = move_and_collide(Vector2(0, 0), true)
	if !kolizja: return
	var dusza = kolizja.get_collider()
	if not dusza is Dusza: return
	dusza.damage(obrazenia)
