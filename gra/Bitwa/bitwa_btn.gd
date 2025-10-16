class_name BitwaBtn
extends Area2D

enum Typy {BTN_WALKA, BTN_UCIECZKA}

const NAPISY = {
	Typy.BTN_WALKA: "WALKA",
	Typy.BTN_UCIECZKA: "UCIEKAJ"
}

@export var typ: Typy

var tekst: Label

var jestgracz: bool = false
var kolor_pierwotny: Color

func _ready():
	tekst = get_node("Tekst")
	
	self.body_entered.connect(gracz_wszedl)
	self.body_exited.connect(gracz_wyszedl)
	
	tekst.label_settings = tekst.label_settings.duplicate_deep(Resource.DEEP_DUPLICATE_ALL)
	kolor_pierwotny = tekst.label_settings.font_color
	
	tekst.text = NAPISY[typ]

func gracz_wszedl(body):
	if not body is Dusza: return
	jestgracz = true
	var kolor = Color(1.0, 1.0, 0.0, 1.0)
	tekst.label_settings.font_color = kolor

func gracz_wyszedl(body):
	if not body is Dusza: return
	jestgracz = false
	tekst.label_settings.font_color = kolor_pierwotny

func _input(_event):
	if Input.is_action_just_pressed("player_action"):
		if jestgracz: print(typ)
