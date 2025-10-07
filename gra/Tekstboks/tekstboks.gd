extends Control

signal tekstboks_koniec

var tlo 
var animator: AnimationPlayer
var tekstboks: RichTextLabel

var pos

# Called when the node enters the scene tree for the first time.
func _ready():
	tlo = get_node("tlo")
	animator = get_node("AnimationPlayer")
	tekstboks = get_node("tlo/Tekst")
	
	pos = 0
	
	self.tekstboks_koniec.connect(_on_tekstboks_koniec)
	
	self.visible = false
	
	pokazTekst("Sans undertejl\ndedededet dundundududu.", "BIG SMOKE: ")

func pokazTekst(tekst: String = 'Tekstbox', przedrostek: String = "", opoznienie: float = 0.05):
	var callback = func(__): napiszTekst(tekst, przedrostek, opoznienie)
	
	tekstboks.text = przedrostek
	
	animator.stop(true)
	animator.play("tekstboks_pokaz")
	animator.animation_finished.connect(callback.call)

func napiszTekst(tekst: String, przedrostek: String = "", opoznienie: float = 0.05):
	pos = 0
	tekstboks.text = przedrostek
	
	var timer = Timer.new()
	self.add_child(timer)
	
	var callback = func():	
		pos += 1
		
		tekstboks.text = przedrostek + tekst.substr(0, pos)
		
		if pos < tekst.length():
			timer.start()
		else:
			timer.queue_free()
			self.emit_signal("tekstboks_koniec")
	
	timer.wait_time = opoznienie
	timer.one_shot = true
	timer.timeout.connect(callback.call)
	
	callback.call()

func _on_tekstboks_koniec():
	print("Koniec tekstu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
