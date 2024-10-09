extends Node2D

@export var textSize : int  = 20

var parsedText = ""

@onready var _rtl = $ResultsSheet/VBContainer/RichTextLabel
@onready var _cont = $ResultsSheet
@onready var _ech = $ResultsSheet/stamps/echec
@onready var _suc = $ResultsSheet/stamps/success
var isFinished = false

signal quitResults

# Called when the node enters the scene tree for the first time.
func _ready():
	isFinished = false
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	_suc.modulate = Color.TRANSPARENT
	_ech.modulate = Color.TRANSPARENT
	_cont.modulate = Color.TRANSPARENT
	_rtl.clear()
	
func reset():
	isFinished = false
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	_suc.modulate = Color.TRANSPARENT
	_ech.modulate = Color.TRANSPARENT
	_cont.modulate = Color.TRANSPARENT
	_rtl.clear()
	
func showPanel(text, hum):
	
	_rtl.clear()
	_rtl.push_font_size(textSize)
	_rtl.append_text(text)
	_rtl.pop()
	parsedText = _rtl.get_parsed_text()
	_rtl.visible_characters = 0
	_rtl.visible_characters_behavior = 2
	var duration = 0.015*parsedText.length()
	
	var tween = get_tree().create_tween()
	_cont.modulate = Color.TRANSPARENT
	tween.tween_property(_cont, "modulate", Color.WHITE, 0.75)
	tween.tween_property(_rtl, "visible_characters", parsedText.length(), duration)
	
	# Make stamp and Pasqua appear
	match hum:
		-1:
			$charles_bien.modulate = Color.TRANSPARENT
			$charles_bof.modulate = Color.TRANSPARENT
			tween.tween_property(_ech, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_bof, "modulate", Color.WHITE, 1.5)
		1:
			$charles_bien.modulate = Color.TRANSPARENT
			$charles_bof.modulate = Color.TRANSPARENT
			tween.tween_property(_suc, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_bien, "modulate", Color.WHITE, 1.5)
	
	
	return tween.finished

func _input(event):
	if isFinished and event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				quitResults.emit(self)
