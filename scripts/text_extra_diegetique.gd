extends Node2D

var _bbtext : String = ""
var _rtext : String = ""

var _LTIME = 0.007
var _STIME = 0.01
var _PTIME = 0.2
var _QFACTOR = 3

signal textFinished

enum EnumPosition {CENTER, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}

@onready var _rtl = $MarginContainer/MarginContainer/CenterContainer/RichTextLabel
@onready var _cc = $MarginContainer/MarginContainer/CenterContainer
@onready var _timer = $Timer

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
	
func setText(ntext : String, position : Vector2 = self.position, show = true):
	
	_rtl.custom_minimum_size = Vector2(minimum_width, 0)
	_rtl.update_minimum_size()
	
	_bbtext = ntext
	_rtl.push_font_size(font_size)
	_rtl.push_color(font_color)
	_rtl.append_text(_bbtext)
	_rtext = _rtl.get_parsed_text()
	_rtl.pop()
	_rtl.pop()
	_rtl.update_minimum_size()
	
	print(_rtl.get_combined_minimum_size())
	
	if presize_box:
		$MarginContainer.size = _rtl.get_combined_minimum_size()
		_cc.alignment = VERTICAL_ALIGNMENT_TOP
		_cc.vertical = true
	else:
		_cc.alignment = VERTICAL_ALIGNMENT_CENTER
	
	_rtl.visible_characters = 0
	
	setPosition(position)
	
	if show:
		$MarginContainer.show()
	
func startText():
	
	$MarginContainer.show()
	
	if not instant_text:
		_nextLetter()
	else:
		_rtl.visible_ratio = 1
		textFinished.emit()

func setPosition(pos : Vector2 = self.position):
	match positionning:
		EnumPosition.CENTER:
			self.position = pos - $MarginContainer.size/2
		EnumPosition.BOTTOM_RIGHT:
			self.position = pos - $MarginContainer.size
		EnumPosition.BOTTOM_LEFT:
			self.position = pos - $MarginContainer.size * Vector2(0,1)
		EnumPosition.TOP_RIGHT:
			self.position = pos - $MarginContainer.size * Vector2(1,0)

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
