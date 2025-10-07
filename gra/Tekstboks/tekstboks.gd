extends Control

signal tekstboks_koniec
signal tekstboks_schowany

var tlo 
var animator: AnimationPlayer
var tekstboks: RichTextLabel

var pos
var maxpos

# Called when the node enters the scene tree for the first time.
func _ready():
	tlo = get_node("tlo")
	animator = get_node("AnimationPlayer")
	tekstboks = get_node("tlo/Tekst")
	
	pos = 0
	maxpos = 0
	
	self.visible = false

func odlaczOdAnimatora():
	for c in animator.animation_finished.get_connections():
		animator.animation_finished.disconnect(c.callable)

func pokazTekst(tekst: String = 'Tekstbox', przedrostek: String = "", opoznienie: float = 0.05):
	var callback = func(__): napiszTekst(tekst, przedrostek, opoznienie)
	
	tekstboks.text = przedrostek
	
	animator.stop(true)
	animator.play("tekstboks_pokaz")
	odlaczOdAnimatora()
	animator.animation_finished.connect(callback.call)

func dokonczTekst():
	pos = maxpos

func schowajTekst():
	var callback = func(__): self.emit_signal("tekstboks_schowany")
	
	dokonczTekst()
	
	animator.stop(true)
	animator.play("tekstboks_schowaj")
	odlaczOdAnimatora()
	animator.animation_finished.connect(callback.call)

func napiszTekst(tekst: String, przedrostek: String = "", opoznienie: float = 0.05):
	pos = 0
	maxpos = tekst.length()
	tekstboks.text = przedrostek
	
	var timer = Timer.new()
	self.add_child(timer)
	
	var callback = func():	
		pos += 1
		
		tekstboks.text = przedrostek + tekst.substr(0, pos)
		
		if pos < maxpos:
			timer.start()
		else:
			timer.queue_free()
			self.emit_signal("tekstboks_koniec")
	
	timer.wait_time = opoznienie
	timer.one_shot = true
	timer.timeout.connect(callback.call)
	
	callback.call()
