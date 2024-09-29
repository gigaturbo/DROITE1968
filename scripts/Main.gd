extends Node2D

enum EnumMissions{A, B, C, D, E,
				  F, G, H, I, J,
				  K, L, M, N, O} # n=15
enum EnumMilitants{M1, M2, M3, M4, M5} # n=5
enum EnumContexts{C1, C2, C3, C4, C5} # n=5

var allDays = [{"contexts": [EnumContexts.C1],
				"militants": [EnumMilitants.M1],
				"missions": [[EnumMissions.A, EnumMissions.B, EnumMissions.C]]},
			   {"contexts": [EnumContexts.C2, EnumContexts.C3],
				"militants": [EnumMilitants.M2, EnumMilitants.M3],
				"missions": [[EnumMissions.D, EnumMissions.E, EnumMissions.F],
							 [EnumMissions.G, EnumMissions.H, EnumMissions.I]]},
				{"contexts": [EnumContexts.C4, EnumContexts.C5],
				"militants": [EnumMilitants.M4, EnumMilitants.M5],
				"missions": [[EnumMissions.J, EnumMissions.K, EnumMissions.L],
							 [EnumMissions.M, EnumMissions.N, EnumMissions.O]]}]

var day = allDays[0]
var dayMissions = []
var	militant = []
var	contexts = []
var answers = []

signal anyMissionSelected

# Called when the node enters the scene tree for the first time.
func _ready():

	$MusiqueTitre.play()
	$Titre.show()
	$Tuto.hide()


func getMission(mmis : EnumMissions):
	match mmis:
		EnumMissions.A:
			return {"scn": preload("res://scenes/elements/missions/MissionA.tscn"),
					"data": {}}
		EnumMissions.B:
			return {"scn": preload("res://scenes/elements/missions/MissionB.tscn"),
					"data": {}}
		EnumMissions.C:
			return {"scn": preload("res://scenes/elements/missions/MissionC.tscn"),
					"data": {}}
		EnumMissions.D:
			return {"scn": preload("res://scenes/elements/missions/MissionD.tscn"),
					"data": {}}            
		EnumMissions.E:
			return {"scn": preload("res://scenes/elements/missions/MissionE.tscn"),
					"data": {}}
		EnumMissions.F:
			return {"scn": preload("res://scenes/elements/missions/MissionF.tscn"),
					"data": {}}
		EnumMissions.G:
			return {"scn": preload("res://scenes/elements/missions/MissionG.tscn"),
					"data": {}}
		EnumMissions.H:
			return {"scn": preload("res://scenes/elements/missions/MissionH.tscn"),
					"data": {}}
		EnumMissions.I:
			return {"scn": preload("res://scenes/elements/missions/MissionI.tscn"),
					"data": {}} 
	# TODO ADD ALL / CHANGE

func getMilitant(mmil : EnumMilitants):
		match mmil:
			EnumMilitants.M1:
				return {"scn": preload("res://scenes/elements/militants/Militant1.tscn"),
						"data": {}}
			EnumMilitants.M2:
				return {"scn": preload("res://scenes/elements/militants/Militant2.tscn"),
						"data": {}}
			EnumMilitants.M3:
				return {"scn": preload("res://scenes/elements/militants/Militant3.tscn"),
						"data": {}}
			EnumMilitants.M4:
				return {"scn": preload("res://scenes/elements/militants/Militant4.tscn"),
						"data": {}}
			EnumMilitants.M5:
				return {"scn": preload("res://scenes/elements/militants/Militant5.tscn"),
						"data": {}}

	# TODO ADD ALL

func getContext(mcont : EnumContexts):
		match mcont:
			EnumContexts.C1:
				return {"scn": preload("res://scenes/elements/contexts/Contexte1.tscn"),
						"data": {}}
			EnumContexts.C2:
				return {"scn": preload("res://scenes/elements/contexts/Contexte2.tscn"),
						"data": {}}
			EnumContexts.C3:
				return {"scn": preload("res://scenes/elements/contexts/Contexte3.tscn"),
						"data": {}}
			EnumContexts.C4:
				return {"scn": preload("res://scenes/elements/contexts/Contexte4.tscn"),
						"data": {}}
			EnumContexts.C5:
				return {"scn": preload("res://scenes/elements/contexts/Contexte5.tscn"),
						"data": {}}
						

	# TODO ADD ALL

func _on_titre_start_button_pressed():
	$MusiqueTitre.stop()
	$Titre.hide()
	$Tuto.show()
	$Tuto.startTuto()
	
func _on_tuto_end_tuto():
	$Tuto.hide()
	startDays() # START OF THE FUN
	
func startDays():
	
	# Clear everything before instanciating new things
	if militant:
		militant.queue_free()
	for m in dayMissions:
		m.queue_free()
	
	# LOAD BG1 (Generic)
	var bg = preload("res://scenes/elements/Background1.tscn").instantiate()
	add_child(bg)
	
	# Loop all days
	for i_day in allDays.size():
		var day = allDays[i_day]
		
		# Instanciate militants of the day, and  contexts
		for i_mil in day["militants"].size():
			
#			# Context sequence before militant
			var	con = getContext(day["contexts"][i_mil]).scn.instantiate()
			add_child(con)
			con.position = $ContexteLocation.position
			con.startContext()
			await con.contextEnded
			con.hide()
			
			# Here come militants
			var mil = getMilitant(day["militants"][i_mil]).scn.instantiate()
			mil.e_militant = day["militants"][0]
			militant = mil
			add_child(mil)
			mil.show()
			mil.come_in($DoorLocation.position, $MilitantLocation.position)
			await mil.iAmReady
			print("MILITANT ", mil.e_militant, " arrived")
			
			await get_tree().create_timer(0.2).timeout
			
			var d = DialogManager.start_dialog($AnswerLocation.position, 
				Vector2(500,300), 
				DialogManager.TextBoxTypes.REPONSE,
				["bjr competence ?"])
			
			await d.inputFinished
			
			
			# Instanciate day missions when militant has arrived
			for i in day["missions"][0].size():
				var mis = getMission(day["missions"][0][i]).scn.instantiate()
				mis.e_mission = day["missions"][0][i]
				dayMissions.append(mis)
				mis.selected.connect(_mission_selected)
				mis.position = Vector2(200*(i+1) + 200, 700)	
				add_child(mis)
				mis.show()
			
			# Await a mission select and fire militant
			var ms = await self.anyMissionSelected
			
			print("MISSION ", ms.e_mission, " selected")
			for mission in dayMissions:
				if mission.e_mission == ms.e_mission:
					mission.get_selected()
					answers.append({"militant": militant.e_militant,
									"mission": ms.e_mission})
					print("SAVED ", answers)
				else:
					mission.go_away()


			var t1 = get_tree().create_timer(0.2)
			await t1.timeout

			var t = get_tree().create_timer(1.0)
			await t.timeout
			militant.come_out($MilitantLocation.position, $DoorLocation.position)
			
			await mil.byeBye
			
			# Mission results
			
			
			
			
			# To next cycle
	
	
# Handle mission selection
func _mission_selected(obj):
	anyMissionSelected.emit(obj)
#	
#
#

