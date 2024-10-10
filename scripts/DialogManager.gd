extends Node


@onready var text_box_scene_militant = preload("res://scenes/elements/textbox/TextBoxMilitant.tscn")
@onready var text_box_scene_reponse = preload("res://scenes/elements/textbox/TextBoxReponse.tscn")
@onready var text_box_scene_simplebutton = preload("res://scenes/elements/textbox/TextBoxSimpleButton.tscn")
@onready var text_box_scene_simpletext = preload("res://scenes/elements/textbox/TextBoxSimpleText.tscn")
@onready var text_box_scene_elec = preload("res://scenes/elements/textbox/TextBoxElec.tscn")

var dialog_lines = []
var current_line_index =  0
var text_box

enum TextBoxTypes{MILITANT, REPONSE, ELEC, TEST, SIMPLEBUTTON, SIMPLETEXT}

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

var blockDialog = false

# flip not working yet
# aquickText true if the text should be instantly shown
func start_dialog(position:Vector2, 
					apanelInitialSize:Vector2,
					type:TextBoxTypes,
					lines,
					mid=-1,
					aflip=false,
					aquickText = false):
	text_box_type = type
	flip = aflip
	
	if type in [TextBoxTypes.REPONSE, TextBoxTypes.SIMPLEBUTTON, TextBoxTypes.SIMPLETEXT]:
		aquickText = true
	quickText = aquickText
	
	
	if is_dialog_active:
		print("Dialog manager is already active. Cannot start new dialog")
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
			# Texte avec encart, cliquable
			text_box = text_box_scene_reponse.instantiate()
			text_box.buttonPressed.connect(_on_text_box_button_pressed)
		TextBoxTypes.SIMPLEBUTTON:
			# Texte sans encart, cliquable
			text_box = text_box_scene_simplebutton.instantiate()
			text_box.buttonPressed.connect(_on_text_box_button_pressed)
		TextBoxTypes.SIMPLETEXT:
			# Texte avec encart, non cliquable
			text_box = text_box_scene_simpletext.instantiate()
		TextBoxTypes.ELEC:
			text_box = text_box_scene_elec.instantiate()
			if flip:
				# dont work for the moment
				text_box.get_node("NinePatchRectElec").hide()
				text_box.get_node("NinePatchRectElecFlip").show()
	
	
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.get_node("Main").add_child(text_box)
	text_box.global_position = text_box_position - Vector2(0, text_box.size.y)
	text_box.display_text(self, dialog_lines[current_line_index], panelInitialSize)
	text_box.quickTextSpeed = quickText
	can_advance_line = false
	

func _on_text_box_finished_displaying():
	can_advance_line = true
	textFinished.emit(self)

func inputCloseDialog():
	
	if text_box_type == TextBoxTypes.MILITANT:
		get_node("../Main/Bruitages/Crayon1").stop()
		get_node("../Main/Bruitages/Crayon2").stop()
		get_node("../Main/Bruitages/Crayon3").stop()
		get_node("../Main/Bruitages/Crayon4").stop()
		get_node("../Main/Bruitages/TournerPage").play()
	
	
	
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
	if blockDialog:
		return
	
	if( event.is_action_pressed("advanced_dialog") && is_dialog_active):
		# do not close dialoge for response and simple button
		if( text_box_type in [TextBoxTypes.REPONSE, TextBoxTypes.SIMPLEBUTTON, TextBoxTypes.SIMPLETEXT] ):
			if(current_line_index + 1 >= dialog_lines.size() ):
				return
		
		if(can_advance_line):
			inputCloseDialog()


func clear():
	blockDialog = false
	text_box_type = null
	id = -1
	is_dialog_active = false
	can_advance_line = false
	quickText = false
	flip = false
	current_line_index = 0
	
	if is_instance_valid(text_box):
		text_box.queue_free()
