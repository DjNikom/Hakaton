extends Node2D

var animator: AnimationPlayer

var btnquit: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	animator = get_node("AnimationPlayer")
	btnquit = get_node("ButtonQuit")
	
	btnquit.button_down.connect(get_tree().quit)
	
	self.modulate = Color(0, 0, 0)
	animator.play("gameover")
