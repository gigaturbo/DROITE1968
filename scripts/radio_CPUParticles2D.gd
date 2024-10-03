@tool
extends CPUParticles2D

@export var scaleTexture:float = 1
@export var angleTexture = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# rotation de l'image
	angle_min = angleTexture - 90  
	angle_max = angleTexture - 90
	
	direction = Vector2(cos(angleTexture* 2* PI /360), -sin(angleTexture * 2* PI /360))
	scale_amount_min = scaleTexture
	scale_amount_max = scaleTexture
