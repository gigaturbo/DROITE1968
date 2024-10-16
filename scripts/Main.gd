extends Node2D

var pauseStateOn = false
enum EnumMissions{A, B, C, D, E,
				  F, G, H, I, J,
				  K, L, M, N, O} # n=15
enum EnumMilitants{M1, M2, M3, M4, M5} # n=5
enum EnumContexts{C1, C2, C3, C4, C5, C6} # n=6

var allDays = [{"militants": [EnumMilitants.M1],
				"missions": [[EnumMissions.A, 	EnumMissions.B, EnumMissions.C]]},
		   	   {"militants": [EnumMilitants.M2, EnumMilitants.M3],
				"missions": [[EnumMissions.D, 	EnumMissions.E, EnumMissions.F],
							 [EnumMissions.G, 	EnumMissions.H, EnumMissions.I]]},
			   {"militants": [EnumMilitants.M4, EnumMilitants.M5],
				"missions": [[EnumMissions.J, 	EnumMissions.K, EnumMissions.L],
							 [EnumMissions.M, 	EnumMissions.N, EnumMissions.O]]}]

var missionContent = {EnumMissions.A: ["deguisement", "titre", "[font_size=20]Au lycée Jacques-Decour, [color=#e44424]une bande de communistes[/color] se réunit tous les midis pour organiser [b]l'arrachage de nos affiches[/b] de campagne. On a besoin d'informations à leur sujet, il faut aller les [b][u]observer discrètement[/u][/b][/font_size].\n\n[font_size=18][center] \"[i]Pourquoi espionner quand on peut effrayer ?\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.B: ["collage", "titre", "[font_size=20]La ville voisine est [color=#e44424]un bastion communiste[/color] et leur candidat y a un soutien solide. Allez [b][u]coller nos affiches[/u][/b] dans ses rues principales.[/font_size]\n\n[font_size=18][center] \"[i]Et si jamais vous croisez leurs gars, collez-leur autre chose dans la figure !\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.C: ["matraque", "titre", "[font_size=20][b]Nos militants[/b] distribuent des tracts, mais la dernière fois ça s'est mal terminé : ils [b]se sont fait cabosser[/b] par [color=#e44424]des opposants[/color]. Il faut envoyer un gars pour [b][u]les protéger[/u][/b] cette fois-ci.[/font_size]\n\n[font_size=18][center]  \"[i]Au premier regard de travers, on règle ça sans attendre.\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.D: ["collage", "titre", "[font_size=20]Il faut [b][u]recouvrir les affiches [color=#e44424]des rouges[/color][/u][/b] d'ici [b]demain matin[/b]. C’est de nuit que ce travail doit se faire, quand personne ne regarde...[/font_size]\n\n[font_size=18][center]  \"[i]La nuit, on ne sait jamais qui peut traîner dans l’ombre...\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.E: ["deguisement", "titre", "[font_size=20]Des [color=#e44424]étudiants en sociologie[/color] organisent des assemblées à la Maison des [color=#e44424]Syndicats[/color]. Ils y discutent de leurs prochaines actions et [b]recrutent des militants[/b]. Il est temps d’y envoyer quelqu’un [b][u]se fondre dans la masse et écouter[/u][/b] ce qui se dit.[/font_size]\n\n[font_size=18][center]  \"[i]Aucun vrai gaulliste ne peut se faire passer pour de la racaille...\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.F: ["collagepiege", "titre", "[font_size=20]Le visage de Charles Prairie est [b]régulièrement arraché[/b] des murs. Il faut [b][u]coller des affiches piégées[/u][/b] avec du verre pilé pour que ceux qui tentent de les retirer se [color=#e44424]blessent[/color]. Cette mission sera escortée.[/font_size]\n\n[font_size=18][center]  \"[i]Des coupures plein les mains, ça leur apprendra à toucher à ma tête !\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.G: ["machine", "titre", "[font_size=20]Cent tracts doivent être [u][b]tapés à la machine[/b][/u] pour la distribution de demain matin. C'est une tâche importante qui demande précision et rapidité.[/font_size]\n\n[font_size=18][center]  \"[i]Se battre sur le terrain ou taper à la machine, même combat !\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.H: ["manger", "titre", "[font_size=20]Nos gars ont besoin d’être soutenus dans leur effort. [u][b]Préparer des sandwichs[/b][/u] et servir du vin est une tâche essentielle, un véritable [b]acte de dévouement[/b], pour leur donner la force de continuer.[/font_size]\n\n[font_size=18][center]  \"[i]Et rien de tel qu'une touche féminine pour leur donner du baume au cœur !\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.I: ["carnet", "titre", "[font_size=20]Il faut [u][b]convaincre des gars[/b][/u] solides, motivés et athlétiques que Charles Prairie est capable de faire [b]cesser le chaos[/b]. On a besoin de militants qui [b]ne reculeront pas[/b].[/font_size]\n\n[font_size=18][center]  \"[i]Faut nous ramener des costauds, et c’est pas pour déménager des meubles...\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.J: ["matraque", "titre", "[font_size=20][b]Notre équipe de colleurs[/b] d’affiches a été malmenée hier, [b]attaquée[/b] à coup de [color=#e44424]barres de fer[/color] et de [color=#e44424]chaînes de vélo[/color]. On a besoin d’hommes solides pour [u][b]les escorter[/b][/u] ce soir. Ça va chauffer...[/font_size]\n\n[font_size=18][center]  \"[i]Nom de nom ! Si j’avais deux minutes, j’irais avec vous...\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.K: ["collage", "titre", "[font_size=20]Il faut [u][b]recouvrir les affiches de [color=#e44424]nos adversaires[/color][/b][/u] en passant derrière eux : que les leurs [b]restent à peine en place[/b]. Pas de risque de bagarre, c'est [b]une bande de mômes[/b] qu'il faut suivre.[/font_size]\n\n[font_size=18][center]  \"[i]Ces gamins sont rapides comme des lapins, mais aussi facilement impressionnables.\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.L: ["talkiewalkie", "titre", "[font_size=20]Il faut [u][b]patrouiller en ville avec six jeunes[/b][/u] cadets de Gironde, fraîchement débarqués et [b]un peu perdus[/b]. L'objectif : surveiller les alentours et repérer [color=#e44424]toute bande[/color] qui viendrait vandaliser nos affiches.[/font_size]\n\n[font_size=18][center]  \"[i]Au premier groupe suspect, pas de quartier, on leur casse la figure.\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.M: ["journal", "titre", "[font_size=20]Le journal Le Monde veut [b]interviewer un de nos militants[/b]. Il nous faut quelqu’un qui s’exprime bien pour [u][b]donner une image impeccable[/b][/u] de notre mouvement.[/font_size]\n\n[font_size=18][center]  \"[i]Les journalistes prennent ce qu’on dit et le transforment. Il faut être clair, propre et précis.\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.N: ["tract", "titre", "[font_size=20]Distribution de tracts [b]à la sortie de la messe[/b]. Le public est acquis, mais il faut [u][b]les encourager à aller voter[/b][/u] et les rassurer.[/font_size]\n\n[font_size=18][center]  \"[i]Ils savent bien, ces braves gens, que si les rouges prennent le pouvoir, ce sera l'Apocalypse.\"[/i]\nCharles Prairie[/center][/font_size]"],
					  EnumMissions.O: ["papillon", "titre", "[font_size=20]Il faut [u][b]coller des papillons[/b][/u] avec des slogans provocateurs, et [b]le faire vite[/b]. Sur les murs et bien sûr sur les affiches [color=#e44424]adverses[/color] ! C’est du [b]vandalisme[/b], donc attention à la police : discrétion et rapidité ![/font_size]\n\n[font_size=18][center]  \"[i]Ah, j’aime beaucoup celui-ci : \'La réforme oui ! La chienlit non !\'\"[/i]\nCharles Prairie[/center][/font_size]"]}

var presentations = [[["Salut, moi c'est Raymond. Charcutier à Levallois. C'est ici qu'on signe ou quoi ?"]],
				 	 [["Bonjour Monsieur, j'me présente : Nicolas, je suis en deuxième année de droit à Assas et je voudrais m'engager pour Monsieur Prairie."],
					  ["Bonjour Monsieur, je suis Marielle, championne d’escrime. J’ai l’habitude de me battre pour ce en quoi je crois, et je suis prête à m’engager ici, sans attendre."]],
				 	 [["Roger. De Bordeaux. On m’a dit qu’il y avait besoin de renforts. C’est pas sérieux ce qu’il se passe ici. Tu me dis quoi faire, et je le fais. Simple."],
				  	  ["Cher Monsieur, je suis Jacques, médecin. Je pense sincèrement que la situation en France est bien plus grave qu'on ne le pense…",
				 	   "Il est urgent de réagir, et je suis prêt à défendre notre pays."]]]

var questions = [[["Pourquoi tu milites, toi ?",
				   "Et t'es bon à quoi ?"]],
			 	 [["Pourquoi maintenant, gamin ?",
				   "Et tu sais faire quoi ?"],
				  ["C’est bien mon petit, mais pourquoi chez nous ?",
				   "Et elle sait faire quoi la championne ?"]],
			 	 [["(sa motivation n'est pas à questionner)",
				   "Bien, sur quoi on peut compter avec toi ?"],
			  	  ["Qu’est-ce qui vous motive, Monsieur ?",
				   "Et pourquoi vous ?"]]]

var reponses = [[[["C’est simple... J’en ai ras-le-bol de ces p’tits jeunes gauchistes qui foutent le bordel partout. Ces chevelus, là...",
				   "Prairie, il va les remettre à leur place. C’est un type avec du cran, comme dans les films d’espionnage que j’aime bien."],
			  	  ["Judo, karaté, boxe française. J'pense me mettre à la lutte bretonne. C’est bon pour vous ?"]]],
			 	[[["Monsieur, je réponds à l'appel du Général. Je crois qu’il est de notre devoir de jeunes Français de se lever et de participer à l'action civique."],
			   	  ["Je suis très discret, Monsieur, on ne me remarque pas… Mais je suis prêt à… à \"casser des gueules\", s'il le faut !",
				   "Enfin… je veux dire, je suis prêt à me faire respecter, à montrer que je suis un homme !"]],
			  	 [["Je n’aime pas le bazar que ces gens de gauche mettent. Moi, je crois en une droite sociale, mais bien ordonnée.",
				   "Une droite comme celle du Général et de Monsieur Prairie, c'est de ça dont la France a besoin."],
			   	  ["Je suis audacieuse et volontaire, quand il y a du travail à faire, je ne recule jamais.",
				   "Je suis sportive, aussi : l'effort et la discipline, ça me connaît !"]]],
			 	[[["..."],
			   	  ["Moi, je suis un homme de terrain. Simple. J’ai l’habitude d’encadrer des gars, je sais comment les mettre au maille... les faire bosser, quoi.",
				   "Mais ici, c’est pas comme chez nous, hein... C’est un peu la jungle..."]],
			  	 [["Le Général et ses compagnons… ce sont les seuls à saisir l’ampleur réelle de la situation. Leur vision dépasse celle des autres.",
				   "Ils comprennent les forces qui menacent notre nation. Je suis convaincu qu’eux seuls peuvent guider la France."],
			   	  ["Je m'efforce toujours de voir au-delà des apparences, là où la vérité réside. Chaque décision que je prends est un pas vers un ordre supérieur...",
				   "J'ai la conviction que tout acte participe à un grand dessein."]]]]

var scores = [[[{"text": "Raymond n'a pas tenu. Les discours de ces petits rouges l’ont rendu fou de rage, et il a flanqué une raclée à sept d’entre eux. Il est actuellement entendu par les flics.",
				 "hum":-1, "score":0},
				{"text": "Raymond a réussi à coller trois affiches avant de tomber sur des cocos. Il n'a pas pu s'empêcher de se battre avec eux... Autant dire que l’efficacité n’était pas au rendez-vous.",
			 	 "hum":0, "score":1},
				{"text": "Raymond a fait le ménage comme jamais. Les cocos ont pris la fuite et tous les témoins ont réclamé nos tracts de peur de se prendre des claques. Quelle réussite !",
			 	 "hum":1, "score":2}]],
		  	  [[{"text": "À la première bagarre, Nicolas a pris peur et s'est enfui. Il n'a réussi à poser que deux affiches et ses compagnons sont tous à l'hôpital. Une vraie planche pourrie !",
				 "hum":-2, "score":0},
				{"text": "Discret, Nicolas a tout entendu et ce qu'il a découvert l'a glacé : les étudiants parlent de \"Grand Soir\" ! Mais c’est surtout quand ils ont lu à voix haute des extraits du livre de Sartre \"L'Enfer chez les Autres\" qu'il a vraiment eu peur...",
			 	 "hum":1, "score":2},
				{"text": "Nicolas a oublié de mettre des gants et, bien entendu, il s'est coupé dès la première affiche. Résultat : du sang partout sur le visage de Charles Prairie. Pas très propre, mais ça fichera peut-être la trouille aux cocos...",
			 	 "hum":0, "score":1}],
			   [{"text": "Marielle ne tape pas vite, fait des fautes, et s’ennuie rapidement... on dirait presque un garçon ! Elle a fait vingt tracts, mais seulement sept sont exploitables. Décevant.",
			 	 "hum":0, "score":1},
				{"text": "Marielle a commencé à préparer à manger, malheureusement à la dixième remarque qu'elle a jugée déplacée, elle a rendu son tablier et a claqué la porte en critiquant Monsieur Prairie. Quinze gars pour un demi-sandwich, c'est peu...",
			 	 "hum":-1, "score":0},
				{"text": "Marielle a fait preuve de caractère, et pas qu’un peu ! Pas de charme à l'œuvre ici, mais bien sa réputation de championne et son tempérament de feu. Elle a réussi à recruter des étudiants et des ouvriers, et pas des minus !",
			 	 "hum":1, "score":2}]],
			  [[{"text": "Comme prévu, notre équipe de colleurs s’est fait tomber dessus. Roger, plein de courage, s’est jeté dans la mêlée mais l’âge ne pardonne pas. Après quelques échanges vigoureux, il a fini par prendre une belle raclée. Il a au moins fait distraction assez longtemps pour que ses compagnons se tirent en vitesse.",
				 "hum":1, "score":1},
				{"text": "Roger a chopé les petits colleurs adverses ! En un regard ils ont su qu'ils étaient cuits. Roger les a mis au boulot en les forçant à recouvrir leurs affiches avec celles de Charles Prairie. Pas un n’a bronché !",
			 	 "hum":2, "score":3},
				{"text": "Roger a patrouillé avec ses cadets et pas un ne connaissait le coin. Quand ils ont vu une bande avec des seaux de colle, ils n’ont pas hésité : ils leur ont cassé la figure ! Le problème ? C’était nos gars ! Dix de nos propres militants à l’hôpital... une honte !",
			 	 "hum":-2, "score":0}],
			   [{"text": "Catastrophe totale ! Jacques a raconté à la presse que les évènements de Mai 68 avait été orchestrés par une alliance improbable : la Chine de Mao, Israël, la CIA, Cuba, la Suisse et même la Bulgarie ! Le journaliste n’en a pas raté une miette et Charles Prairie est la risée de tout le monde.",
				 "hum":-2, "score":0},
				{"text": "À la sortie de la messe, Jacques a livré un véritable sermon mystique, parlant de la mission sacrée du Général face à l'antéchrist rouge. Les fidèles  étaient captivés ! Ils ont pris les tracts avec ferveur, on peut dire qu’il les a conquis !",
				 "hum":2, "score":3},
				{"text": "Malheureusement, Jacques n'a pas vraiment les jambes pour ce genre de course. Il s'est fait attraper par la police avant d'avoir pu finir son travail. Avec son statut et sa manière de parler, il s'en tirera sans trop de problèmes et il a tout de même réussi à coller une dizaine de papillons... c’est déjà ça.",
				 "hum":0, "score":1}]]]


var day = allDays[0]
var dayMissions = []
var	militant = null
var answers = []
var score = 0
var adminSkip = false

signal anyMissionSelected
signal anyDialogAnswered
signal anyDialogAnsweredGUI

var res_scene = preload("res://scenes/ResultsMission.tscn")

var radioMusic = true
var basevolume_theme_menu
var basevolume_theme_menu_radio

var audioAnnonces:Array[AudioStreamPlayer]

var playbuttontween:Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	$Titre.show()
	$Tuto.hide()
	$Score.hide()
	$Credits.hide()
	$Histoire.hide()
	$FX/CendrierFumee.hide()
	$FX/Lumiere.hide()
	
	# Make a list of object appear smoothly
	var appearTime = 1.0
	var objList = [$Titre.get_node("Start"), 
					$Titre.get_node("Credits"), 
					$Titre.get_node("Histoire"), 
					$CanvasLayer/MuteButton,
					$CanvasLayer/ReplayButton,
					$CanvasLayer/QuitButton
					]
					
	for o in objList:
		var colorMem = o.modulate
		o.modulate = Color.TRANSPARENT
		create_tween().tween_property(o, "modulate", colorMem, appearTime).set_trans(Tween.TRANS_QUINT)
	
	# Animate play button
	playbuttontween = create_tween().set_loops()
	playbuttontween.tween_property($Titre.get_node("Start"), "position:y", -4, 0.75).as_relative().set_trans(Tween.TRANS_LINEAR)
	playbuttontween.tween_property($Titre.get_node("Start"), "position:y", 8, 1.5).as_relative().set_trans(Tween.TRANS_LINEAR)
	playbuttontween.tween_property($Titre.get_node("Start"), "position:y", -4, 0.75).as_relative().set_trans(Tween.TRANS_LINEAR)
	
	audioAnnonces = [$Bruitages/Radio1, $Bruitages/Radio2, $Bruitages/Talkie1, $Bruitages/Talkie2, $Bruitages/Phone1, $Bruitages/Phone2]
	basevolume_theme_menu = $Musiques/Musique1.volume_db
	basevolume_theme_menu_radio = $Musiques/Musique1Radio.volume_db
	
func _process(_delta):
	processMusic()

func getMission(mmis : EnumMissions):
	var aMissionContent = missionContent[mmis]
	
	var mission = preload("res://scenes/elements/MissionItem.tscn").instantiate()
	mission.init(aMissionContent[0], aMissionContent[2])
	
	return mission

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


func getContext(mcont : EnumContexts):
		match mcont:
			EnumContexts.C1:
				return {"medium" : "talkie",
						"data": "Dissolution de l'Assemblée nationale par le général de Gaulle : François Mitterrand dénonce une dérive autoritaire !"}
			EnumContexts.C2:
				return {"medium" : "radio",
						"data": "Évènements de Mai 68 : De Gaulle a pensé démissionner avant de rester pour s'opposer à \"l’entreprise communiste totalitaire\"."}
			EnumContexts.C3:
				return {"medium" : "talkie",
						"data": "André Malraux l'a dit : si la gauche prend le pouvoir, elle se fera renverser par ses alliés révolutionnaires. Et après, c'est la dictature !"}
			EnumContexts.C4:
				return {"medium" : "phone",
						"data": "Compagnon, les renforts que tu m’as demandés de Gironde sont arrivés."}
			EnumContexts.C5:
				return {"medium" : "radio",
						"data": "Drame chez Peugeot : après 22 jours de grève, la police a investi les usines de Sochaux. Bilan tragique : 2 morts et 150 blessés."}
			EnumContexts.C6:
				return {"medium" : "radio",
						"data": "Un communiste de 18 ans a été tué près d'Arras par les membres d'un groupe de militants gaullistes..."}


func _on_titre_start_button_pressed():
	radioMusic = false # change music to the main one (music 1 with no radio mode)
	$Musiques/RadioSwitchFader.start()
	$FX/NotesMusique.hide()
	$Titre.hide()
	$Score.hide()
	$Credits.hide()
	$Histoire.hide()
	$FX/CendrierFumee.hide()
	$FX/Lumiere.hide()
	$Tuto.show()
	$Tuto.startTuto()
	
func _on_tuto_end_tuto():
	$Bureau.show()
	await create_tween().tween_property($Tuto, "modulate", Color.TRANSPARENT, 0.5).set_trans(Tween.TRANS_QUINT).finished
	$Titre.hide()
	$Tuto.hide()
	$Tuto.modulate = Color.WHITE
	$Score.hide()
	$FX/NotesMusique.hide()
	$Histoire.hide()
	$FX/CendrierFumee.hide()
	$FX/Lumiere.hide()
	$Credits.hide()
	startDays() # START OF THE FUN
	
func showContext(n):
	var	textContext = getContext(n).data
	var	medium = getContext(n).medium
	var contextPosition = null
	var fxPosition = null
	var fxAngle = null
	var rand = randi()%2
	
	var flip = false
	
	# put sound modification to normal
	AudioServer.get_bus_effect(1, 0).volume_db = 0
	
	match medium:
		"radio":
			contextPosition = $RadioLocation.position
			audioAnnonces[rand].play()
			fxPosition = Vector2(535, 484)
			fxAngle = -55
		"talkie":
			contextPosition = $TalkieLocation.position
			audioAnnonces[2 + rand].play()
			fxPosition = Vector2(71, 561)
			fxAngle = 35
		"phone":
			contextPosition = $PhoneLocation.position
			audioAnnonces[4 + rand].play()
			fxPosition = Vector2(975, 620)
			fxAngle = -75
			flip = true

	$FX/Eclairs2.position = fxPosition
	$FX/Eclairs2.animate(fxAngle)
			
	DialogManager.start_dialog(contextPosition, 
		Vector2(500,100), 
		DialogManager.TextBoxTypes.ELEC,
		[textContext], 
		-1,
		flip, 
		false,
		2)
	
	return DialogManager.inputFinished
	
func startDays():
	$Bureau.show()
	$Titre.hide()
	$Tuto.hide()
	$Score.hide()
	$Histoire.hide()
	$Credits.hide()
	$FX/NotesMusique.hide()
	
	$FX/CendrierFumee.modulate = Color.TRANSPARENT
	$FX/CendrierFumee.show()
	$FX/CendrierFumee.play()
	create_tween().tween_property($FX/CendrierFumee, "modulate", Color.WHITE, 1).set_trans(Tween.TRANS_QUINT)
	
	$FX/Lumiere.modulate = Color.TRANSPARENT
	$FX/Lumiere.show()
	$FX/Lumiere.play()
	create_tween().tween_property($FX/Lumiere, "modulate", Color.WHITE, 1).set_trans(Tween.TRANS_QUINT)
	score = 0 
	dayMissions = []
	militant = null
	answers = []
	var ncontext = 0
	
	
	if(!adminSkip):
		await get_tree().create_timer(1.5).timeout
	
	await showContext(0)
	ncontext = ncontext + 1
	
	if(!adminSkip):
		await get_tree().create_timer(0.25).timeout
	
	# Loop all days
	for i_day in allDays.size():
		day = allDays[i_day]
		
		# Instanciate militants of the day, and contexts
		for i_mil in day["militants"].size():
			
			if(i_day == 2) :
				$Musiques/Musique1.stop()
			
			# Pour les deux derniers militants, une musique spéciale
			if(i_day == 2 && i_mil == 0) :
				$Musiques/Musique2Boucle1.play()
			if(i_day == 2 && i_mil == 1) :
				$Musiques/Musique2Boucle2.play()

			$Bruitages/PorteArrive.play()
			
			# Here come militants
			var mil = getMilitant(day["militants"][i_mil]).scn.instantiate()
			mil.e_militant = day["militants"][i_mil]
			militant = mil
			add_child(mil)
			mil.show()
			mil.come_in($DoorLocation.position, $MilitantLocation.position)
			
			if(!adminSkip):
				await mil.iAmReady
			
				await get_tree().create_timer(0.2).timeout
			
				# Militant present him/herself
				await DialogManager.start_dialog($ResponseLocation.position, 
					Vector2(400,100), 
					DialogManager.TextBoxTypes.MILITANT,
					presentations[i_day][i_mil]).inputFinished
			
			if(!adminSkip):
				# Q1
				DialogManager.start_dialog($AnswerLocation.position, 
					Vector2(350,75), 
					DialogManager.TextBoxTypes.REPONSE,
					[questions[i_day][i_mil][0]],
					0
				)
				if not DialogManager.buttonPressed.is_connected(_dialog_manager_response):
					DialogManager.buttonPressed.connect(_dialog_manager_response)

				# Q2
				DialogManager2.start_dialog($AnswerLocation.position + Vector2(400, 0), 
					Vector2(350,75), 
					DialogManager2.TextBoxTypes.REPONSE,
					[questions[i_day][i_mil][1]],
					1
				)
				if not DialogManager2.buttonPressed.is_connected(_dialog_manager_response):
					DialogManager2.buttonPressed.connect(_dialog_manager_response)
				
				var rep1 = await anyDialogAnswered
				
				# He answers selected question
				await DialogManager.start_dialog($ResponseLocation.position,
					Vector2(500,150), 
					DialogManager.TextBoxTypes.MILITANT,
					reponses[i_day][i_mil][rep1]).inputFinished
				
				# Show remaining question
				DialogManager.start_dialog($AnswerLocation.position + Vector2(200, 0), 
					Vector2(350,75), 
					DialogManager.TextBoxTypes.REPONSE,
					[questions[i_day][i_mil][1-rep1]],
					0
				)
				if not DialogManager.buttonPressed.is_connected(_dialog_manager_response):
					DialogManager.buttonPressed.connect(_dialog_manager_response)
				
				var _rep2 = await anyDialogAnswered
				
				# He answers remaining question
				await DialogManager.start_dialog($ResponseLocation.position,
					Vector2(500,100), 
					DialogManager.TextBoxTypes.MILITANT,
					reponses[i_day][i_mil][1-rep1]).inputFinished

			# Now instanciate day missions of militant (disabled state)
			for i in day["missions"][i_mil].size():
				var mis = getMission(day["missions"][i_mil][i])
				mis.e_mission = day["missions"][i_mil][i]
				mis.disable()
				dayMissions.append(mis)
				mis.selected.connect(_mission_selected)
				mis.position = Vector2(100 + 220*(i+1), 680)
				add_child(mis)
				mis.show()
			
			if(!adminSkip):
				if i_day == 0 && i_mil == 0 :
					# Show tutorial panel (mission)
					await $TED.setText("")
					$TED.show()
					await $TED.setText("[center]Attribuez-lui la mission qui lui correspond\n[i][font_size=20](sauf si vous préférez échouer !)[/font_size][/i][/center]").startText().textFinished
					await $TED.mousePressed
					$TED.hide()
			
			# enable missions clicking
			for mis in dayMissions:
				mis.enable()
			
			# Await a mission select, then fire militant
			var ms = await self.anyMissionSelected
			
			# Pour les deux derniers militants, une musique spéciale
			if(i_day == 2 && i_mil == 0) :
				$Musiques/Musique2Boucle1.stop()
				$Musiques/Musique2Break1.play()
			if(i_day == 2 && i_mil == 1) :
				$Musiques/Musique2Boucle2.stop()
				$Musiques/Musique2Break2.play()
			
			for mission in dayMissions:
				if mission.e_mission == ms.e_mission:
					mission.get_selected()
					answers.append({"hum": scores[i_day][i_mil][ms.e_mission % 3]["hum"],
									"score": scores[i_day][i_mil][ms.e_mission % 3]["score"],
									"militant": militant.e_militant,
									"mission": ms.e_mission})
					var toadd = scores[i_day][i_mil][ms.e_mission % 3]["score"]
					score = score + toadd
				else:
					mission.go_away()

			$Bruitages/Zip.play()
			
			if(!adminSkip):
				await get_tree().create_timer(1.0).timeout
			
			militant.come_out($MilitantLocation.position, $DoorLocation.position)
			$Bruitages/PortePart.play()
			
			
			if(!adminSkip):
				await mil.byeBye
			
			mil.queue_free()
			
			# Show context before results
			if(!adminSkip):
				await get_tree().create_timer(0.5).timeout
			await showContext(ncontext)
			ncontext = ncontext + 1
			
			
			
			
			
			if(!adminSkip):
				await get_tree().create_timer(0.5).timeout
			
			# shut context audio when showing score
			var amp = AudioServer.get_bus_effect(1, 0)
			create_tween().tween_property(amp, "volume_db", -80, 1)
			
			# Mission results
			if(!adminSkip):
				var res = res_scene.instantiate()
				add_child(res)
				res.reset()
				res.show()
				$Bureau.hide()
				
				res.showPanel(scores[i_day][i_mil][ms.e_mission % 3]["text"],
									scores[i_day][i_mil][ms.e_mission % 3]["hum"])
				await res.tween.finished
				res.isFinished = true
				
				await res.quitResults
				res.hide()
				remove_child(res)
			
			$Bureau.show()
			# To next cycle
	
	# Show scores
	$Bureau.hide()
	$FX/CendrierFumee.hide()
	$FX/CendrierFumee.stop()
	$FX/Lumiere.hide()
	$FX/Lumiere.stop()
	$CanvasLayer/QuitButton.hide()
	$CanvasLayer/ReplayButton.hide()
	$Score.show()
	$Score.init(score, answers)
	
	
# Handle mission selection
func _mission_selected(obj):
	anyMissionSelected.emit(obj)


# for dialogs
func _dialog_manager_response(cdialog):
	var answered = cdialog.id
	DialogManager.inputCloseDialog()
	DialogManager2.inputCloseDialog()
	anyDialogAnswered.emit(answered)


# for GUI
func _dialog_manager_response_GUI(cdialog):
	var answered = cdialog.id
	DialogManagerGUI.inputCloseDialog()
	DialogManagerGUIYes.inputCloseDialog()
	DialogManagerGUINo.inputCloseDialog()
	anyDialogAnsweredGUI.emit(answered)


func processMusic():
	
	# Volume switch (0 to 1) between theme1 and theme1_radio
	var musicSwitchRelative = $Musiques/RadioSwitchFader.time_left / $Musiques/RadioSwitchFader.wait_time
	
	if !radioMusic:
		musicSwitchRelative = 1 - musicSwitchRelative
	
	var modulator = 0.1 # 0.05 will make the transition more or less smooth
	var vol_theme_menu = lerp(-60.0, basevolume_theme_menu, (musicSwitchRelative)**modulator)
	var vol_theme_menu_radio = lerp(-60.0, basevolume_theme_menu_radio, (1 - musicSwitchRelative)**modulator)
	
	if($Musiques/RadioStartWaiter.is_stopped()):
		vol_theme_menu_radio = lerp(-60.0, vol_theme_menu_radio, (1 - $Musiques/RadioStartFader.time_left / $Musiques/RadioStartFader.wait_time)** modulator)
	else:
		vol_theme_menu_radio = -60
	
	$Musiques/Musique1.set_volume_db(vol_theme_menu)
	$Musiques/Musique1Radio.set_volume_db(vol_theme_menu_radio)
	

func _on_credits_exit_credits():
	$Titre.show()
	$Tuto.hide()
	$Score.hide()
	$Credits.hide()
	$Credits.init()
	$FX/Eclairs.emitting = false
	$FX/NotesMusique.show()
	


func _on_titre_credit_button_pressed():
	$Titre.hide()
	$Tuto.hide()
	$Score.hide()
	$Credits.show()
	$Credits.init()
	$FX/NotesMusique.show()
	$FX/Eclairs.emitting = false
	
	# utile de remettre les boutons si on vient de la fin
	$CanvasLayer/MuteButton.show()
	$CanvasLayer/ReplayButton.show()
	$CanvasLayer/QuitButton.show()

func setPauseMode(mybool):
	
	if mybool:
		pauseStateOn = true
		DialogManager.blockDialog = true
		DialogManager2.blockDialog = true
		DialogManager3.blockDialog = true
		
		# Disable all buttons (except GUI ones)
		for _i:Node in getAllChildrenRecursively(self):
			if ! _i in [$CanvasLayer/MuteButton, $CanvasLayer/QuitButton, $CanvasLayer/ReplayButton, 
			DialogManagerGUIYes.text_box.get_node("MarginContainer/Label/Button"), DialogManagerGUINo.text_box.get_node("MarginContainer/Label/Button")]:
				if _i.get_class() in ["TextureButton", "Button"]:
					_i.disabled = true
		
		# Darken every node, except the GUI ones
		for _i in self.get_children():
			if "modulate" in _i:
				if ! _i in [DialogManagerGUI.text_box, DialogManagerGUIYes.text_box, DialogManagerGUINo.text_box,
				$CanvasLayer/MuteButton, $CanvasLayer/QuitButton, $CanvasLayer/ReplayButton, $CanvasLayer/AdminSkipON]:
					_i.modulate = Color(0.3,0.3,0.4)
	
	else:# QUIT PAUSE MODE
		pauseStateOn = false
		
		# CLOSE UI TEXTBOXES
		DialogManagerGUI.inputCloseDialog()
		DialogManagerGUIYes.inputCloseDialog()
		DialogManagerGUINo.inputCloseDialog()
		
		# debloquer les textbox
		DialogManager.blockDialog = false
		DialogManager2.blockDialog = false
		DialogManager3.blockDialog = false
		
		# go back to normal color
		for _i in self.get_children():
			if "modulate" in _i:
				if ! _i in [$CanvasLayer/MuteButton, $CanvasLayer/QuitButton, $CanvasLayer/ReplayButton, $CanvasLayer/AdminSkipON]:
					_i.modulate = Color(1,1,1)
		
		
		# Enable all buttons
		for _i:Node in getAllChildrenRecursively(self):
			if _i.get_class() in ["TextureButton", "Button"]:
				_i.disabled = false

func tryQuitGame():
	
	DialogManagerGUI.inputCloseDialog()
	DialogManagerGUIYes.inputCloseDialog()
	DialogManagerGUINo.inputCloseDialog()
		
	var quitwindowsize = Vector2(300, 100)
	DialogManagerGUI.start_dialog($CanvasLayer/QuitWindowLocation.position,
			quitwindowsize, DialogManager.TextBoxTypes.SIMPLETEXT, ["Quitter ?"])
	
	var shifttocenterx = 50
	var shifttocentery = -150
	DialogManagerGUIYes.start_dialog(DialogManagerGUI.text_box_position + Vector2(shifttocenterx, shifttocentery),
			Vector2(0, 0), DialogManager.TextBoxTypes.SIMPLEBUTTON, ["OUI"],
			0)
	DialogManagerGUIYes.buttonPressed.connect(_dialog_manager_response_GUI)
	DialogManagerGUINo.start_dialog(DialogManagerGUI.text_box_position 
					+ Vector2(DialogManagerGUI.text_box.size.x * DialogManagerGUI.text_box.scale.x - 50 - shifttocenterx, shifttocentery),
			Vector2(0, 0), DialogManager.TextBoxTypes.SIMPLEBUTTON, ["NON"],
			1)
	DialogManagerGUINo.buttonPressed.connect(_dialog_manager_response_GUI)
	
	
	setPauseMode(true)
	
	var rep = await anyDialogAnsweredGUI
	
	# pauseStateOn should be on because the pausemode can be exited par ailleurs
	if pauseStateOn:
		if rep == 0:
			setPauseMode(false)
			reallyQuitGame()
		elif rep == 1:
			setPauseMode(false)


func reallyQuitGame():
	DialogManagerGUI.inputCloseDialog()
	DialogManagerGUIYes.inputCloseDialog()
	DialogManagerGUINo.inputCloseDialog()
	get_tree().quit()
	
func tryReplayGame():
	
	DialogManagerGUI.inputCloseDialog()
	DialogManagerGUIYes.inputCloseDialog()
	DialogManagerGUINo.inputCloseDialog()
		
	var replaywindowsize = Vector2(500, 100)
	DialogManagerGUI.start_dialog($CanvasLayer/ReplayWindowLocation.position,
								  replaywindowsize,
								  DialogManager.TextBoxTypes.SIMPLETEXT,
								  ["Recommencez depuis le début ?"])
	
	var shifttocenterx = 75
	var shifttocentery = -150
	
	DialogManagerGUIYes.start_dialog(DialogManagerGUI.text_box_position + Vector2(shifttocenterx, shifttocentery),
									 Vector2(0, 0),
									 DialogManager.TextBoxTypes.SIMPLEBUTTON,
									 ["RECOMMENCER"],
									 2)
	if not DialogManagerGUIYes.buttonPressed.is_connected(_dialog_manager_response_GUI):
		DialogManagerGUIYes.buttonPressed.connect(_dialog_manager_response_GUI)
		
	DialogManagerGUINo.start_dialog(DialogManagerGUI.text_box_position + Vector2(DialogManagerGUI.text_box.size.x * DialogManagerGUI.text_box.scale.x - 112 - shifttocenterx, shifttocentery),
									Vector2(0, 0),
									DialogManager.TextBoxTypes.SIMPLEBUTTON,
									["CONTINUER"],
									3)
	if not DialogManagerGUINo.buttonPressed.is_connected(_dialog_manager_response_GUI):		
		DialogManagerGUINo.buttonPressed.connect(_dialog_manager_response_GUI)
	
	setPauseMode(true)
	
	var rep = await anyDialogAnsweredGUI
	
	if pauseStateOn:
		if rep == 2:
			setPauseMode(false)
			reallyReplayGame()
		elif rep == 3:
			setPauseMode(false)


func reallyReplayGame():
	# Must clear dialog box so that they dont fuck everything later : they are not in main scene so they wont be really refreshed
	DialogManager.clear()
	DialogManager2.clear()
	DialogManager3.clear()
	DialogManagerGUI.clear()
	DialogManagerGUINo.clear()
	DialogManagerGUIYes.clear()
	var mainScene = preload("res://scenes/Main.tscn")
	get_tree().change_scene_to_packed(mainScene)


func _input(event):
	
	if event.is_action_pressed("ui_cancel"):
		if pauseStateOn:
			setPauseMode(false)
		else:
			tryQuitGame()
	
	if event.is_action_pressed("admin_skip"):
		adminSkip = !adminSkip
		
		if(adminSkip):
			$CanvasLayer/AdminSkipON.show()
		else:
			$CanvasLayer/AdminSkipON.hide()


# wait before starting the radio music
func _on_radio_start_waiter_timeout():
	$Musiques/Musique1Radio.set_volume_db(-60)
	$Musiques/Musique1Radio.play()
	$Musiques/Musique1.play()
	$Musiques/RadioStartFader.start()


func _on_mute_button_pressed():
	AudioServer.set_bus_mute(0, $CanvasLayer/MuteButton.button_pressed)
	if AudioServer.is_bus_mute(0):
		$FX/NotesMusique.emitting = false
	else:
		$FX/NotesMusique.emitting = true
	

func getAllChildrenRecursively(node):
	var nodelist = node.get_children()
	for N in node.get_children():
		if N.get_child_count() > 0:
			nodelist.append_array(getAllChildrenRecursively(N))
	return nodelist

func _on_score_rejouer_pressed() -> void:
	reallyReplayGame()


func _on_score_credits_pressed() -> void:
	_on_titre_credit_button_pressed()


func _on_score_quitter_pressed() -> void:
	reallyQuitGame()


func _on_titre_histoire_button_pressed() -> void:
	$Titre.hide()
	$FX/NotesMusique.hide()
	$Histoire.show()


func _on_histoire_retour_pressed() -> void:
	$Histoire.hide()
	$Titre.show()
	$FX/NotesMusique.show()
