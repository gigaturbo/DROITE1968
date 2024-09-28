extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

# Une fenêtre de texte
# Si panelInitialSize est donné à display_text, panelInitialSize définie la taille de la fenêtre (celle-ci peut bouger si le texte est trop grand)
# S'il n'est pas donné, la fenêtre s'ajuste à la séquence de texte à afficher

var MAX_WIDTH = 256 # Only If panelInitialSize is not given to display_text : the maximum width before which a new line is began 


var text = ""
var letter_index = 0

var letter_time = 0.02
var space_time = 0.04
var punctuation_time = 0.15

var previous_size_y = 0

signal finished_displaying()

enum EnumContexts{window1, window2, window3}

var type = 3

func _ready():
	match type:
		1:
			$NinePatchRect1.show()
			$NinePatchRect2.hide()
			$NinePatchRect3.hide()
		2:
			$NinePatchRect1.hide()
			$NinePatchRect2.show()
			$NinePatchRect3.hide()
		3:
			$NinePatchRect1.hide()
			$NinePatchRect2.hide()
			$NinePatchRect3.show()
			

func display_text(text_to_display: String, panelInitialSize:Vector2 = Vector2(0,0)):
	if(panelInitialSize.x > 0):
		MAX_WIDTH = panelInitialSize.x
		global_position.y -= panelInitialSize.y - size.y
		size.x = panelInitialSize.x
		size.y = panelInitialSize.y
		text = text_to_display
		label.text = text_to_display
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
	else: # no initial size : the windows adjust itself
		text = text_to_display
		label.text = text_to_display
		await resized
		custom_minimum_size.x = min(size.x, MAX_WIDTH)
		
		if size.x >= MAX_WIDTH:
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			await resized # wait for x resized
#			await resized # wait for y resized
			custom_minimum_size.y = size.y
		
		# Adjust window position
#		global_position.x -= size.x / 2
#		global_position.y -= size.y + 24
	
	
	previous_size_y = size.y
	label.text = ""
	_display_letter()
	


func _on_letter_display_timer_timeout():
	_display_letter()


func _display_letter():
	
	
#	global_position.y -= size.y - previous_size_y
#	previous_size_y = size.y
	
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


