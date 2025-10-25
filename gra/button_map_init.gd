extends Button

func _pressed() -> void:
	mapswitcher.goto_scene(self.get_meta("target"), "init", false)
