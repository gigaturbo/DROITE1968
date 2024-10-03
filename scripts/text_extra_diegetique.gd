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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#setText("Texte de [b]test[/b], [u]test[/u] de [i]texte[/i]... Texte de [b]test[/b], [u]test[/u] de [i]texte[/i]...")
	$MarginContainer.hide()
	
func setText(ntext : String, minstant_text = instant_text, mquick = quick, mpresize_box = presize_box, mpositionning : EnumPosition = positionning):
	
	instant_text = minstant_text
	quick = mquick
	presize_box = mpresize_box
	positionning = mpositionning
	
	$MarginContainer.show()
	_bbtext = ntext
	_rtl.parse_bbcode(_bbtext)
	_rtext = _rtl.get_parsed_text()
	
	if presize_box:
		$MarginContainer.size = _rtl.size
		_cc.alignment = VERTICAL_ALIGNMENT_TOP
		_cc.vertical = true
	else:
		_cc.alignment = VERTICAL_ALIGNMENT_CENTER
	
	_rtl.visible_characters = 0
	
	setPosition()
	
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
