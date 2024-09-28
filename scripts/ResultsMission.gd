extends Node2D

var parsedText = ""

@onready var rtl = $MarginContainer/MarginContainer/RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	$charles_bien.hide()
	$charles_bof.hide()
	await set_text("okzdz fef fez grzh [b]theqgrEGQH[/b] QTH RTJRTRSTJRST okzdz fef fez" + 
			 "grzh [b]theqgrEGQH[/b] QTH RTJRTRSTJRST okzdz fef fez grzh [b]theqgrEGQH[/b]" +
			 " QTH RTJRTRSTJRST dza d azfe fzegezgqezge gqrge rgege qrg egergergeg eeg er" +
			 " QTH RTJRTRSTJRST dza d azfe fzegezgqezge gqrge rgege qrg egergergeg eeg er").finished
	
	
	
func set_text(text):
	rtl.visible_characters = 0
	rtl.visible_characters_behavior = 2
	rtl.parse_bbcode(text)
	parsedText = rtl.get_parsed_text()
	var duration = 0.02*parsedText.length()
	var tween = get_tree().create_tween()
	tween.tween_property(rtl, "visible_characters", parsedText.length(), duration)
	
	return tween

func charlesGood():
	$charles_bien.show()
	$charles_bof.hide()

func charlesBad():
	$charles_bien.hide()
	$charles_bof.show()
