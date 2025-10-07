extends Sprite2D

func _process(delta: float) -> void:
	self.rotation += 5*delta


func _on_button_bitwa_test_pressed():
	get_tree().change_scene_to_file("res://Bitwa/Bitwa.tscn")
