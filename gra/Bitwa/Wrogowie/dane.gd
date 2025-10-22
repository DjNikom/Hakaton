class_name Dane_Wrogowie

var dane = {
	"smoke": {
		"skin": "smoke",
		"hp": 100,
		
		"ataki": [
			[
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": []},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [1.0]},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [-1.0]},
				{"opoznienie": 25, "funkcja": null}
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
		"hp": 100,
		
		"ataki": [
			[
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": []},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [1.0]},
				{"opoznienie": 0, "funkcja": atak_normalny, "parametry": [-1.0]},
				{"opoznienie": 25, "funkcja": null}
			]
		],
		
		"appeartexts": [
			"* You feel like you picked the wrong house.",
			"* You suddenly want to have two number nines.",
			"* You feel like you can't breathe with all the smoke in here."
		]
	}
}



func atak_normalny(kat_presuniecie: float = 0.0):
	print(kat_presuniecie)
