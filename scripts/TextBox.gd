extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

# Une fenêtre de texte
# Si panelInitialSize est donné à display_text, panelInitialSize définie la taille de la fenêtre (celle-ci peut bouger si le texte est trop grand)
# S'il n'est pas donné, la fenêtre s'ajuste à la séquence de texte à afficher

var MAX_WIDTH = 512 # Only If panelInitialSize is not given to display_text : the maximum width before which a new line is began 


var text = ""
var letter_index = 0

var quickTextSpeed = false
var letter_time = 0.007
var space_time = 0.01
var punctuation_time = 0.2


var myDialogManager

# audio
var crayons:Array[AudioStreamPlayer]
var crayon1:AudioStreamPlayer
var crayon2:AudioStreamPlayer
var crayon3:AudioStreamPlayer
var crayon4:AudioStreamPlayer
var tournerPage:AudioStreamPlayer

signal finished_displaying()

signal buttonPressed()

var buttonHoverScaleRatio = 1.3

func display_text(aDialogManager, text_to_display: String, panelInitialSize:Vector2 = Vector2(0,0)):
	myDialogManager = aDialogManager
	crayon1 = get_node("../Bruitages/Crayon1")
	crayon2 = get_node("../Bruitages/Crayon2")
	crayon3 = get_node("../Bruitages/Crayon3")
	crayon4 = get_node("../Bruitages/Crayon4")
	crayons=[crayon1, crayon2, crayon3, crayon4]
	
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
	
	
	if myDialogManager.text_box_type == myDialogManager.TextBoxTypes.MILITANT:
		if(!crayon1.playing && !crayon2.playing && !crayon3.playing && !crayon4.playing):
			crayons[randi() % 4].play()
	
	if quickTextSpeed:
		label.text = text
		letter_index = text.length()
	else:
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
	match myDialogManager.text_box_type:
		myDialogManager.TextBoxTypes.REPONSE:
			$NinePatchRectReponse.hide()
			$NinePatchRectReponseHL.show()
			$NinePatchRectReponseSEL.hide()
		myDialogManager.TextBoxTypes.SIMPLEBUTTON:
			# offset pivot point to scale in relation to the center of the text
			position += (pivot_offset - size * 0.5)*0.5
			pivot_offset = size * 0.5
			scale *= buttonHoverScaleRatio

func _on_button_mouse_exited():
	
	match myDialogManager.text_box_type:
		myDialogManager.TextBoxTypes.REPONSE:
			$NinePatchRectReponse.show()
			$NinePatchRectReponseHL.hide()
			$NinePatchRectReponseSEL.hide()
		myDialogManager.TextBoxTypes.SIMPLEBUTTON:
			# offset pivot point to scale in relation to the center of the text
			position += (pivot_offset - size * 0.5)*0.5
			pivot_offset = size * 0.5
			scale /= buttonHoverScaleRatio


func _on_button_button_down():
	$NinePatchRectReponse.hide()
	$NinePatchRectReponseHL.hide()
	$NinePatchRectReponseSEL.show()
	
func _on_button_button_up():
	$NinePatchRectReponse.hide()
	$NinePatchRectReponseHL.show()
	$NinePatchRectReponseSEL.hide()


func _unhandled_input(event):
	
	if event.is_action_pressed("quick_advance_dialog"):
		quickTextSpeed = !quickTextSpeed 
