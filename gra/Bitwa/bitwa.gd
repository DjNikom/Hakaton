extends Node2D

var tekstboks: Tekstboks
var dusza
var wrog: Sprite2D
var clickhandler

var efekty: Array[Sprite2D] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	tekstboks = get_node("Tekstboks")
	dusza = get_node("Dusza")
	wrog = get_node("Wrog")
	
	efekty.push_back(get_node("Efekt0"))
	efekty.push_back(get_node("Efekt1"))
	efekty.push_back(get_node("Efekt2"))
	efekty.push_back(get_node("Efekt3"))
	
	wrog.get_node("AnimationPlayer").play("wrog_smoke")
	
	dusza.visible = false
	
	var ch = func():
		tekstboks.dokonczTekst()
		
	var th = func():
		var ch2 = func():
			clickhandler = null
			tekstboks.tekstboks_schowany.connect(bitwa_start)
			tekstboks.schowajTekst()
		clickhandler = null
		
		var timer = Timer.new()
		self.add_child(timer)
		
		var th2 = func():
			clickhandler = ch2
			timer.queue_free()
		
		timer.wait_time = 0.1
		timer.one_shot = true
		timer.timeout.connect(th2.call)
		
		timer.start()
	
	tekstboks.pokazTekst("* You feel like you picked the wrong house.")
	
	tekstboks.tekstboks_koniec.connect(th.call)
	
	clickhandler = ch

func bitwa_start():
	dusza.visible = true
	
	print("Wojna!!!")

var efekt_licznik: int = 0
const EFEKT_CZAS = 60 * 4

func efekt_pozycja(t: float) -> float:
	return sin(t * 2 * PI) * 32

func efekt_opoznienie(t: int, o: int) -> float:
	return float((t - o) % EFEKT_CZAS)

func _process(_delta):
	efekt_licznik += 1
	efekt_licznik %= EFEKT_CZAS
	
	efekty[0].position.x = efekt_pozycja(float(efekt_licznik) / (EFEKT_CZAS - 1))
	efekty[1].position.x = efekt_pozycja(efekt_opoznienie(efekt_licznik, 32) / (EFEKT_CZAS - 1))
	efekty[2].position.x = efekt_pozycja(efekt_opoznienie(efekt_licznik, 64) / (EFEKT_CZAS - 1))
	efekty[3].position.x = efekt_pozycja(efekt_opoznienie(efekt_licznik, 96) / (EFEKT_CZAS - 1))

func _input(event):
	if event is InputEventMouseButton or Input.is_action_just_pressed("player_action"):
		if clickhandler: clickhandler.call()
