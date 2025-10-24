extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(collision) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func collision(body):
	print(body)
	if body is Gracz:
		mapswitcher.goto_scene(self.get_meta("target"), self.get_meta("targetpos"))
