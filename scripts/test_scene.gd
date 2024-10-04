extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	await $TextExtraDiegetique.setText("Beinvenu dans la mission lol dans la mission lol ACAB a+ lo dazddzdaz d adzddz zdz mission lol dans la mission lol ACAB a+ lo dazddzdaz d adzddz zdz mission lol dans la mission lol ACAB a+ lo dazddzdaz d adzddz zdz",
								 $Marker2D.position).startText().textFinished
	
	await get_tree().create_timer(1).timeout
	
	await $TextExtraDiegetique.setText("Message 3 lol dfefz gfz gz zgftzzt'jn f fzedlsd  idjzp",
								 $Marker2D.position).startText().textFinished

	
	pass # Replace with function body.
