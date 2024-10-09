extends Node2D

var _bbtext : String = ""
var _rtext : String = ""

var _LTIME = 0.007
var _STIME = 0.01
var _PTIME = 0.2
var _QFACTOR = 3

signal textFinished
signal mousePressed

enum EnumPosition {CENTER, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}

@onready var _rtl = $MarginContainer/MarginContainer/CenterContainer/RichTextLabel
@onready var _cc = $MarginContainer/MarginContainer/CenterContainer
@onready var _timer = $Timer
var _finalSize = null
var _finalState = 0
var _started = false

@export var instant_text : bool = false
@export var quick : bool = false
@export var presize_box : bool = true
@export var positionning : EnumPosition = EnumPosition.TOP_LEFT
@export var font_size : int = 20
@export var font_color : Color = Color.WHITE
@export var minimum_width : int = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer.hide()

func _process(_delta: float) -> void:
	
	# State loop
	if _finalState == 0: 				  # Needs resizing, prepare box
		$MarginContainer.modulate = Color.TRANSPARENT
		$MarginContainer.show()
		_rtl.visible_ratio = 1
		_finalState = 1
	elif _finalState == 1: 				  # Save valid size
		_finalSize = $MarginContainer.size
		_finalState = 2
		if presize_box:
			$MarginContainer.custom_minimum_size = _finalSize
			_cc.alignment = VERTICAL_ALIGNMENT_TOP
			_cc.vertical = true
		$MarginContainer.hide()
		$MarginContainer.modulate = Color.WHITE
	elif _finalState == 2: 				  # Reset to initial state 
		_rtl.visible_characters = 0
		_finalState = 3
	elif _finalState == 3:				  # Ready to start
		_finalState = 4
	elif _finalState == 4 and _started:	  # Started
		_finalState = 5
		_textStart()
		

func setText(ntext : String, _nposition : Vector2 = self.position):
	
	_bbtext = ntext
	_rtl.clear()
	_rtl.push_font_size(font_size)
	_rtl.push_color(font_color)
	_rtl.append_text(_bbtext)
	_rtext = _rtl.get_parsed_text()
	_rtl.pop()
	_rtl.pop()
	_rtl.visible_characters = 0
	
	$MarginContainer.custom_minimum_size = Vector2(minimum_width, 0)
	
	match positionning:
		EnumPosition.CENTER:
			$MarginContainer.anchors_preset = Control.PRESET_CENTER
		EnumPosition.BOTTOM_RIGHT:
			$MarginContainer.anchors_preset = Control.PRESET_BOTTOM_RIGHT
		EnumPosition.BOTTOM_LEFT:
			$MarginContainer.anchors_preset = Control.PRESET_BOTTOM_LEFT
		EnumPosition.TOP_RIGHT:
			$MarginContainer.anchors_preset = Control.PRESET_TOP_RIGHT
	
	# Set state to dirty
	_finalState = 0 
	_started = false
	
	# For chaining
	return self
	
func startText():
	# Set state to dirty but started
	_started = true
	_finalState = 0 
	
	# For chaining
	return self

func _textStart():
	
	_rtl.visible_characters = 0
	$MarginContainer.show()
		
	if not instant_text:
		_nextLetter()
	else:
		_rtl.visible_ratio = 1
		textFinished.emit()

func removeDialog():
	queue_free()

func _nextLetter():
	
	if _rtl.visible_characters < _rtl.get_total_character_count() -1:
		
		_rtl.visible_characters += 1
		
		match _rtext[_rtl.visible_characters]:
			"!", ".", ",", "?", ";", ":":
				_timer.start(_PTIME if not quick else _PTIME/_QFACTOR)
			" ":
				_timer.start(_STIME if not quick else _STIME/_QFACTOR)
			_:
				_timer.start(_LTIME if not quick else _LTIME/_QFACTOR)
	
	else:
		_rtl.visible_ratio = 1
		textFinished.emit()


func _on_timer_timeout() -> void:
	_nextLetter()
	
func _input(event):
	if(event.is_action_pressed("Lclick_TED") and _rtl.visible_ratio == 1):
		mousePressed.emit(self)
