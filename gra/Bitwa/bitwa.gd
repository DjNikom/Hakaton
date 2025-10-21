extends Node2D

var tekstboks: Tekstboks
var dusza
var wrog: Sprite2D
var clickhandler
var graczhp: Label
var przyciski: Node2D

var efekty: Array[Sprite2D] = []

var wrogowie: Dane_Wrogowie

var gracz_data = {
	"hp": 20,
	"maxhp": 20
}

var wrog_typ: String = "smoke"
var wrog_data: Dictionary = {}

func _ready():
	randomize()
	
	tekstboks = get_node("Tekstboks")
	dusza = get_node("Dusza")
	wrog = get_node("Wrog")
	graczhp = get_node("GraczHp")
	przyciski = get_node("Przyciski")
	
	efekty.push_back(get_node("Efekt0"))
	efekty.push_back(get_node("Efekt1"))
	efekty.push_back(get_node("Efekt2"))
	efekty.push_back(get_node("Efekt3"))
	
	wrogowie = load("res://Bitwa/Wrogowie/dane.gd").new()
	wrog_data = wrogowie.dane[wrog_typ]
	
	wrog.get_node("AnimationPlayer").play("wrog_" + wrog_data["skin"])
	dusza.visible = false
	hud_aktualizacja()
	
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
	
	tekstboks.pokazTekst(wrog_data["appeartexts"].pick_random())
	tekstboks.tekstboks_koniec.connect(th.call)
	
	clickhandler = ch

func bitwa_start():
	dusza.visible = true
	
	for c: BitwaBtn in przyciski.get_children():
		c.bitwabtn_wcisniety.connect(bitwa_btn)
	
	print("Wojna!!!")

func bitwa_btn(typ: BitwaBtn.Typy):
	if not przyciski.visible: return
	match typ:
		BitwaBtn.Typy.BTN_WALKA: bitwa_btnwalka()

var atak = []
var atak_stan = 0
var atak_opoznienie = 0

func bitwa_btnwalka():
	print("Peace was never an option")
	przyciski.visible = false
	
	atak = wrog_data["ataki"].pick_random()
	atak_stan = 0
	atak_opoznienie = 0
	print(atak)
	
	var timer = Timer.new()
	self.add_child(timer)
	
	var tykacz = func():
		if atak_stan >= len(atak) and atak_opoznienie <= 0:
			timer.queue_free()
			bitwa_koniecataku()
			return
		while atak_opoznienie <= 0:
			var stan = atak[atak_stan]
			var f = stan["funkcja"]
			atak_opoznienie = stan["opoznienie"]
			atak_stan += 1
			if f: f.callv(stan["parametry"])
		atak_opoznienie -= 1
	
	timer.wait_time = 0.1
	timer.one_shot = false
	timer.timeout.connect(tykacz.call)
	
	timer.start()

func bitwa_koniecataku():
	print("Koniec ataku")
	przyciski.visible = true

func hud_aktualizacja():
	graczhp.text = "HP: %d/%d" % [gracz_data["hp"], gracz_data["maxhp"]]

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
