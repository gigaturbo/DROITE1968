extends Node2D

@export var textSize : int  = 20

var parsedText = ""

@onready var _rtl = $ResultsSheet/VBContainer/RichTextLabel
@onready var _cont = $ResultsSheet
@onready var _ech = $ResultsSheet/stamps/echec
@onready var _suc = $ResultsSheet/stamps/success
@onready var _neu = $ResultsSheet/stamps/mouais
var isFinished = false
var tween
signal quitResults

# Called when the node enters the scene tree for the first time.
func _ready():
	reset()
	
func reset():
	isFinished = false
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	$charles_neutre.modulate = Color.TRANSPARENT
	$charles_joy.modulate = Color.TRANSPARENT
	$charles_fury.modulate = Color.TRANSPARENT
	_suc.modulate = Color.TRANSPARENT
	_ech.modulate = Color.TRANSPARENT
	_neu.modulate = Color.TRANSPARENT
	_cont.modulate = Color.TRANSPARENT
	_rtl.clear()
	
func showPanel(text, hum):
	
	reset()
	
	_rtl.push_font_size(textSize)
	_rtl.append_text(text)
	_rtl.pop()
	parsedText = _rtl.get_parsed_text()
	_rtl.visible_characters = 0
	_rtl.visible_characters_behavior = 2
	
	tween = create_tween()
	_cont.modulate = Color.TRANSPARENT
	tween.tween_property(_cont, "modulate", Color.WHITE, 0.75)
	
	
	# bruits de crayon au choix, une fois (j'ai pas réussi à faire un loop qui s'arrête avec la fin de tween)
	#var crayon1 = get_node("../Bruitages/Crayon1")
	#var crayon2 = get_node("../Bruitages/Crayon2")
	#var crayon3 = get_node("../Bruitages/Crayon3")
	#var crayon4 = get_node("../Bruitages/Crayon4")
	#var crayons = [crayon1, crayon2, crayon3, crayon4]
	#crayons[randi() % 4].play()
	
	await tween.tween_property(_rtl, "visible_characters", parsedText.length(), 0.015*parsedText.length()).finished
	
	#crayon1.stop()
	#crayon2.stop()
	#crayon3.stop()
	#crayon4.stop()
	
	if hum >= 1:
		get_tree().current_scene.get_node("Bruitages/MissionReussite").play()
	else:
		get_tree().current_scene.get_node("Bruitages/MissionEchec").play()
	tween = create_tween()
	
	# Make stamp and Pasqua appear
	match hum:
		-2:
			# TODO update sprite
			tween.tween_property(_ech, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_fury, "modulate", Color.WHITE, 1.5)
		-1:
			tween.tween_property(_ech, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_bof, "modulate", Color.WHITE, 1.5)
		0:
			tween.tween_property(_neu, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_neutre, "modulate", Color.WHITE, 1.5)
		1:
			tween.tween_property(_suc, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_bien, "modulate", Color.WHITE, 1.5)
		2:
			# TODO update sprite
			tween.tween_property(_suc, "modulate", Color.WHITE, 0.75)
			tween.parallel().tween_property($charles_joy, "modulate", Color.WHITE, 1.5)


func _input(event):
	if isFinished and event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				quitResults.emit(self)
	
