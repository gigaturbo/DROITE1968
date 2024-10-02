extends Node


@onready var text_box_scene_militant = preload("res://scenes/elements/textbox/TextBoxMilitant.tscn")
@onready var text_box_scene_reponse = preload("res://scenes/elements/textbox//TextBoxReponse.tscn")
@onready var text_box_scene_elec = preload("res://scenes/elements/textbox/TextBoxElec.tscn")

var dialog_lines = []
var current_line_index =  0
var text_box

enum TextBoxTypes{MILITANT, REPONSE, ELEC, TEST}

var text_box_type

var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

var panelInitialSize

var id = -1

signal textFinished
signal inputFinished

signal buttonPressed

var flip
var quickText

# flip not working yet
func start_dialog(position:Vector2, 
					apanelInitialSize:Vector2,
					type:TextBoxTypes,
					lines,
					mid=-1,
					aflip=false,
					aquickText = false):
	text_box_type = type
	flip = aflip
	
	if type == TextBoxTypes.REPONSE:
		aquickText = true
	quickText = aquickText
	
	
	if is_dialog_active:
		return
	
	id = mid
	
	panelInitialSize = apanelInitialSize
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true
	
	return self
	
func _show_text_box():
	
	match text_box_type:
		TextBoxTypes.MILITANT:
			text_box = text_box_scene_militant.instantiate()
		TextBoxTypes.REPONSE:
			text_box = text_box_scene_reponse.instantiate()
			text_box.buttonPressed.connect(_on_text_box_button_pressed)
		TextBoxTypes.ELEC:
			text_box = text_box_scene_elec.instantiate()
			if flip:
				# dont work for the moment
				var ninepatch = text_box.get_node("NinePatchRectElec")
				ninepatch.scale.x *= -1
				ninepatch.position.x += - ninepatch.scale.x * ninepatch.size.x
	
	
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position - Vector2(0, text_box.size.y)
	text_box.display_text(self, dialog_lines[current_line_index], panelInitialSize)
	text_box.quickTextSpeed = quickText
	can_advance_line = false
	

func _on_text_box_finished_displaying():
	can_advance_line = true
	textFinished.emit(self)

func inputCloseDialog():
	
	var crayon1 = get_node("../Main/Bruitages/Crayon1")
	var crayon2 = get_node("../Main/Bruitages/Crayon2")
	var crayon3 = get_node("../Main/Bruitages/Crayon3")
	var crayon4 = get_node("../Main/Bruitages/Crayon4")
	
	if text_box_type == TextBoxTypes.MILITANT:
		var tournerPage = get_node("../Main/Bruitages/TournerPage")
		crayon1.stop()
		crayon2.stop()
		crayon3.stop()
		crayon4.stop()
		tournerPage.play()
	
	
	
	if is_instance_valid(text_box):
		text_box.queue_free()
	current_line_index += 1
	if current_line_index >= dialog_lines.size():
		is_dialog_active = false
		current_line_index = 0
		inputFinished.emit(self)
		return
	
	_show_text_box()

func _on_text_box_button_pressed():
	buttonPressed.emit(self)
	

func _unhandled_input(event):
	if( event.is_action_pressed("advanced_dialog") && is_dialog_active):
		if( text_box_type == TextBoxTypes.REPONSE ):
			if(current_line_index + 1 >= dialog_lines.size() ):
				return
		
		if( can_advance_line):
			inputCloseDialog()
