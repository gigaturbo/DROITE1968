extends Node2D

@onready var e1 = $e1
@onready var e2 = $e2
@onready var e3 = $e3


func _ready() -> void:
	reset()


func reset():
	e1.modulate = Color.TRANSPARENT
	e2.modulate = Color.TRANSPARENT
	e3.modulate = Color.TRANSPARENT


func animate(angle: int):
	
	rotation_degrees = angle
	
	e3.modulate = Color.WHITE
	e1.modulate = Color.TRANSPARENT
	e2.modulate = Color.TRANSPARENT
	await get_tree().create_timer(0.25).timeout
	
	e3.modulate = Color.TRANSPARENT
	e1.modulate = Color.WHITE
	e2.modulate = Color.TRANSPARENT
	await get_tree().create_timer(0.25).timeout
	
	e3.modulate = Color.TRANSPARENT
	e1.modulate = Color.TRANSPARENT
	e2.modulate = Color.WHITE
	await get_tree().create_timer(0.25).timeout
	
	e3.modulate = Color.TRANSPARENT
	e1.modulate = Color.TRANSPARENT
	e2.modulate = Color.TRANSPARENT
	
	await get_tree().create_timer(0.5).timeout
