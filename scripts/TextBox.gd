extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

var MAX_WIDTH = 526


var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

#func _ready():
#	display_text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et posuere magna. Nulla eget finibus nibh. Pellentesque libero elit, malesuada ac nisl a, pharetra bibendum ligula. Donec dapibus eget purus id convallis. Suspendisse lacus arcu, interdum ac ex sed, feugiat volutpat enim.")

func display_text(text_to_display: String, panelInitialSize:Vector2 = Vector2(0,0)):
	if(panelInitialSize.x > 0):
		MAX_WIDTH = panelInitialSize.x
		size.x = panelInitialSize.x
		size.y = panelInitialSize.y
		
	text = text_to_display
	label.text = text_to_display
	
	await resized
	
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # wait for x resized
		await resized # wait for y resized
		custom_minimum_size.y = size.y + 24
		
#	global_position.x -= size.x / 2
#	global_position.y -= size.y + 24
	
	label.text = ""
	_display_letter()
	


func _on_letter_display_timer_timeout():
	_display_letter()


func _display_letter():
	label.text += text[letter_index]
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?", ";", ":":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
