class_name Dane_Wrogowie

const ATAK_PELLET = "res://Bitwa/Ataki/pellet.tscn"

var dane = {
	"smoke": {
		"skin": "smoke",
		"hp": 100,
		
		"minobrazenia": 3,
		"maxobrazenia": 7,
		
		"ataki": [
			[
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 3.0]},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 3.0, 0.1]},
				{"opoznienie": 25, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 3.0, -0.1]},
				
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 4.0]},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 4.0, 0.2]},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 4.0, -0.2]},
				
				{"opoznienie": 50, "funkcja": null}
			]
		],
		
		"appeartexts": [
			"* You feel like you picked the wrong house.",
			"* You suddenly want to have two number nines.",
			"* You feel like you can't breathe with all the smoke in here."
		]
	}
	,
	
	"frog": {
		"skin": "frog",
		"hp": 10,
		
		"minobrazenia": 1,
		"maxobrazenia": 1,
		
		"ataki": [
			[
				{"opoznienie": 1, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 2.0]},
				{"opoznienie": 1, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 2.0]},
				{"opoznienie": 1, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 2.0]},
				{"opoznienie": 1, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 2.0]},
				{"opoznienie": 1, "funkcja": atak_normalny, "parametry": [ATAK_PELLET, 2.0]},
				{"opoznienie": 25, "funkcja": null}
			]
		],
		
		"appeartexts": [
			"* You are overwhelmed with the cuteness of this tiny creature.",
			"* You suddenly feel an urge to pet the frog.",
			"* FROG, THE RULER OF THE POND, ENTERS THE ARENA",
			"* meow"
		]
	}
}

class WrogInfo:
	var dane: Dictionary
	var obraz: Sprite2D
	var animator: AnimationPlayer
	var dusza: Dusza
	var pozycja: Vector2
	
	func _init(p_dane: Dictionary, p_obraz: Sprite2D, p_animator: AnimationPlayer, p_dusza):
		self.dane = p_dane
		self.obraz = p_obraz
		self.animator = p_animator
		self.dusza = p_dusza
		self.pozycja = p_obraz.position + p_obraz.offset

func atak_normalny(wrog: WrogInfo, objekt: StringName, szybkosc: float = 1.0, kat_presuniecie: float = 0.0):
	var atak = load(objekt).instantiate()
	wrog.dusza.get_tree().current_scene.add_child(atak)
	
	var kierunek = (wrog.dusza.position - wrog.pozycja).normalized() * szybkosc
	
	var minobrazenia = wrog.dane["minobrazenia"]
	var maxobrazenia = wrog.dane["maxobrazenia"]
	
	atak.predkosc = kierunek.rotated(kat_presuniecie)
	atak.position = wrog.pozycja
	atak.obrazenia = randi_range(minobrazenia, maxobrazenia)
