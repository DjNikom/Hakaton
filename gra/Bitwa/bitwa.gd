extends Node2D

var tekstboks
var dusza
var clickhandler

# Called when the node enters the scene tree for the first time.
func _ready():
	tekstboks = get_node("Tekstboks")
	dusza = get_node("Dusza")
	
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

func _input(event):
	if event is InputEventMouseButton:
		if clickhandler: clickhandler.call()
