extends Node2D

@onready var text_n = $Node2D/RichTextLabel
@onready var rect_n = $Node2D/ColorRect

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false 
	text_n.visible_ratio=0

func set_text(text, wait_t=3):
	visible = true
	text_n.parse_bbcode(text)
	var ptext = text_n.get_parsed_text()
	var nlines = text_n.get_line_count()
	
	var duration = ptext.length() * 0.02
	var text_size = text_n.get_theme_font("normal_font").get_string_size(ptext)
	var font_size = text_n.get_theme_font_size("normal_font_size")
	print(nlines)
	text_n.size = Vector2(text_size.x, text_size.y*nlines)*font_size/16
	rect_n.size = Vector2(text_size.x, text_size.y*nlines)*font_size/16
	
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(text_n, "visible_ratio", 1, 1)
