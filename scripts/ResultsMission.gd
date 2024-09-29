extends Node2D

var parsedText = ""

@onready var rtl = $MarginContainer/MarginContainer/RichTextLabel

var isFinished = false

signal quitResults

# Called when the node enters the scene tree for the first time.
func _ready():
	isFinished = false
	$charles_bien.show()
	$charles_bof.show()
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	
	
func reset():
	isFinished = false
	$charles_bien.show()
	$charles_bof.show()
	$charles_bien.modulate = Color.TRANSPARENT
	$charles_bof.modulate = Color.TRANSPARENT
	$MarginContainer.modulate = Color.TRANSPARENT
	$MarginContainer/MarginContainer/RichTextLabel.parse_bbcode("")
	
func showPanel(text, hum):
	await get_tree().create_timer(0.25).timeout
	var tween = get_tree().create_tween()
	tween.tween_property($MarginContainer, "modulate", Color.WHITE, 2)
	
	rtl.visible_characters = 0
	rtl.visible_characters_behavior = 2
	rtl.parse_bbcode(text)
	parsedText = rtl.get_parsed_text()
	var duration = 0.05*parsedText.length()
	
	await get_tree().create_timer(0.25).timeout
	tween.tween_property(rtl, "visible_characters", parsedText.length(), duration)
	
	match hum:
		-1:
			$charles_bien.modulate = Color.TRANSPARENT
			$charles_bof.modulate = Color.TRANSPARENT
			tween = get_tree().create_tween()
			tween.tween_property($charles_bof, "modulate", Color.WHITE, 1)
		1:
			$charles_bien.modulate = Color.TRANSPARENT
			$charles_bof.modulate = Color.TRANSPARENT
			tween = get_tree().create_tween()
			tween.tween_property($charles_bien, "modulate", Color.WHITE, 1)
	
	return tween

func _input(event):
	if isFinished and event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == 1:
				quitResults.emit(self)
