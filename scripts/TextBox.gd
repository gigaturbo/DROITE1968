extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

# Une fenêtre de texte
# Si panelInitialSize est donné à display_text, panelInitialSize définie la taille de la fenêtre (celle-ci peut bouger si le texte est trop grand)
# S'il n'est pas donné, la fenêtre s'ajuste à la séquence de texte à afficher

var MAX_WIDTH = 512 # Only If panelInitialSize is not given to display_text : the maximum width before which a new line is began 


var text = ""
var letter_index = 0

var letter_time = 0.02
var space_time = 0.04
var punctuation_time = 0.15


signal finished_displaying()

signal buttonPressed()

func display_text(text_to_display: String, panelInitialSize:Vector2 = Vector2(0,0)):
	print(panelInitialSize)
	MAX_WIDTH /= scale.x
	if(panelInitialSize.x > 0):
		MAX_WIDTH = panelInitialSize.x
		size.x = panelInitialSize.x / scale.x
		size.y = panelInitialSize.y / scale.y
		text = text_to_display
		label.text = text_to_display
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
	else: # no initial size : the windows adjust itself
		text = text_to_display
		label.text = text_to_display
		await resized
		custom_minimum_size.x = min(size.x, MAX_WIDTH)
		
		if (size.x) >= MAX_WIDTH:
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			await resized # wait for x resized
#			await resized # wait for y resized
			custom_minimum_size.y = size.y
	
	
	label.text = ""
	_display_letter()
	

#func _setPanelScale(value):
#	panelScale = value
#	scale = Vector2(value, value)
#
#	var fontsize = $MarginContainer/Label.get("theme_override_font_sizes/font_size")
#	$MarginContainer/Label.add_theme_font_size_override("font_size", fontsize / value)

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




func _on_button_pressed():
	buttonPressed.emit()


func _on_button_mouse_entered():
	$NinePatchRectReponse.hide()
	$NinePatchRectReponseHL.show()
	$NinePatchRectReponseSEL.hide()

func _on_button_mouse_exited():
	$NinePatchRectReponse.show()
	$NinePatchRectReponseHL.hide()
	$NinePatchRectReponseSEL.hide()


func _on_button_button_down():
	$NinePatchRectReponse.hide()
	$NinePatchRectReponseHL.hide()
	$NinePatchRectReponseSEL.show()
	
func _on_button_button_up():
	$NinePatchRectReponse.hide()
	$NinePatchRectReponseHL.show()
	$NinePatchRectReponseSEL.hide()
