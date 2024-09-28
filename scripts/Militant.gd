extends Node2D

var e_militant = -1

const COME_IN_DUR = 2

signal iAmReady
signal byeBye

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color.TRANSPARENT
#	come_in(Vector2(20,20), Vector2(200,200))

func come_in(from, to):
	self.position = from
	var tween = Engine.get_main_loop().create_tween().bind_node(self)
	tween.parallel().tween_property(self, "position", to, COME_IN_DUR)
	tween.parallel().tween_property(self, "modulate", Color.WHITE, COME_IN_DUR/2.0)
	await tween.finished
	iAmReady.emit(self)

func come_out(from, to):
	self.modulate = Color.WHITE
	self.position = from
	var tween = Engine.get_main_loop().create_tween().bind_node(self)
	tween.parallel().tween_property(self, "position", to, COME_IN_DUR)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, COME_IN_DUR/1.3)
	await tween.finished
	byeBye.emit(self)
	
