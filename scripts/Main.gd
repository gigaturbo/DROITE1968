extends Node2D

enum EnumMissions{A, B, C, D, E, F, G, H, I, J}
enum EnumMilitants{M1, M2, M3, M4, M5, M6}
enum EnumContexts{C1, C2, C3}

var allDays = [{"context": EnumContexts.C1,
				"militant": EnumMilitants.M2,
				"missions": [EnumMissions.A, EnumMissions.B, EnumMissions.C]},
			   {"context": EnumContexts.C2,
				"militant": EnumMilitants.M2,
				"missions": [EnumMissions.D, EnumMissions.E, EnumMissions.F]}]

var day = allDays[0]
var dayMissions = []
var	militant = null
var answers = []

# Called when the node enters the scene tree for the first time.
func _ready():

	$MusiqueTitre.play()
	$Titre.show()
	$Tuto.hide()


func getMission(mmis : EnumMissions):
	match mmis:
		EnumMissions.A:
			return {"scn": preload("res://scenes/elements/objets/ObjCollage.tscn"),
					"data": {}}
		EnumMissions.B:
			return {"scn": preload("res://scenes/elements/objets/ObjMatraque.tscn"),
					"data": {}}
		EnumMissions.C:
			return {"scn": preload("res://scenes/elements/objets/ObjMegaphone.tscn"),
					"data": {}}
		EnumMissions.D:
			return {"scn": preload("res://scenes/elements/objets/ObjTract.tscn"),
					"data": {}}            
					
	# TODO ADD ALL

func getMilitant(mmil : EnumMilitants):
		match mmil:
			EnumMilitants.M1:
				return {"scn": preload("res://scenes/elements/militants/Militant1.tscn"),
						"data": {}}
			EnumMilitants.M2:
				return {"scn": preload("res://scenes/elements/militants/Militant2.tscn"),
						"data": {}}
#			EnumMilitants.M3:
#				return {"scn": preload("res://scenes/elements/militants/Militant1.tscn"),
#						"data": {}}
#			EnumMilitants.M4:
#				return {"scn": preload("res://scenes/elements/militants/Militant1.tscn"),
#						"data": {}}
	
	# TODO ADD ALL

func _on_titre_start_button_pressed():
	$MusiqueTitre.stop()
	
	$Titre.hide()
	$Tuto.show()
	$Tuto.startTuto()
	

func _on_tuto_end_tuto():
	$Tuto.hide()
	# START OF THE GAME
	startDays()
	
func startDays():
	
	# Clear everything before instanciating new things
	if militant:
		militant.queue_free()
	for m in dayMissions:
		m.queue_free()
	
	# Start at day 0
	day = allDays[0]
	
	# LOAD BG1 (Generic)
	var bg = preload("res://scenes/elements/Background1.tscn").instantiate()
	add_child(bg)
	
	# Instanciate militant
	var mil = getMilitant(day["militant"]).scn.instantiate()
	mil.e_militant = day["militant"]
	militant = mil
	mil.iAmReady.connect(_militant_arrived)
	add_child(mil)
	mil.show()
	mil.come_in($DoorLocation.position, $MilitantLocation.position)
	
	# Now wait for answers
	
# Handle mission selection
func _mission_selected(obj):
	print("MISSION ", obj.e_mission, " selected")
	for mission in dayMissions:
		if mission.e_mission == obj.e_mission:
			mission.get_selected()
			answers.append({"militant": militant.e_militant,
							"mission": obj.e_mission})
			print("SAVED ", answers)
			#TODO save which one was selected
		else:
			mission.go_away()
	
	var t = get_tree().create_timer(1.0)
	await t.timeout
	militant.come_out($MilitantLocation.position, $DoorLocation.position)
	
	
# Handle mission selection
func _militant_arrived(obj):
	print("MILITANT ", obj.e_militant, " arrived")
	
	# Instanciate day missions when militant arrived
	for i in day["missions"].size():
		var mis = getMission(day["missions"][i]).scn.instantiate()
		mis.e_mission = day["missions"][i]
		dayMissions.append(mis)
		mis.selected.connect(_mission_selected)
		mis.position = Vector2(200*(i+1) + 200, 700)	
		add_child(mis)
		mis.show()
	
