extends Node2D

var e_militant = -1

const COME_IN_DUR = 2.5
const COME_OUT_DUR = 2

signal iAmReady
signal byeBye

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color.TRANSPARENT
	self.scale= Vector2(0.6,0.6)

func come_in(from, to):
	self.scale= Vector2(0.6,0.6)
	self.modulate = Color.TRANSPARENT
	self.position = from
	var tween = Engine.get_main_loop().create_tween().bind_node(self)
	tween.tween_property(self, "modulate", Color.WHITE, 1.0*COME_IN_DUR/3.0)
	tween.tween_property(self, "position", to, 2.0*COME_IN_DUR/3.0)
	tween.parallel().tween_property(self, "scale", Vector2(1,1), 2.0*COME_IN_DUR/3.0)
	await tween.finished
	iAmReady.emit(self)

func come_out(from, to):
	self.modulate = Color.WHITE
	self.position = from
	var tween = Engine.get_main_loop().create_tween().bind_node(self)
	tween.tween_property(self, "position", to, 2.0*COME_OUT_DUR/3.0)
	tween.parallel().tween_property(self, "scale", Vector2(0.6,0.6), 2.0*COME_IN_DUR/3.0)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 1.0*COME_IN_DUR/3.0)
	await tween.finished
	byeBye.emit(self)
	
