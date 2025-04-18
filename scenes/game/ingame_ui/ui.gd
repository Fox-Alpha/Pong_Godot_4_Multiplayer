extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	Game.Game_State_Changed.connect(_Game_State_Has_Changed)


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("UI Szene ==> _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
	match new_gs:
		Game.GameStates.GAMEISLOADING:
			pass
		Game.GameStates.GAMEINITIALIZING:
			pass
		Game.GameStates.GAMEINITIALIZED:
			_Connect_Signals()
			_Game_Initialized()
			pass
		Game.GameStates.GAMEWAITFORSTART:
			#Show Center Message ?
			pass
		Game.GameStates.GAMEISSTARTED:
			Next_Round_Started()
			pass
		Game.GameStates.GAMEOVER:
			pass


func _Connect_Signals() -> void:
	# Global Signals
	Game.Scr_Manager.Left_Player_Scored.connect(ScoreLeft, CONNECT_DEFERRED)
	Game.Scr_Manager.Right_Player_Scored.connect(ScoreRight, CONNECT_DEFERRED)
	######


func _Game_Initialized():
	%PlayerScoreLeft.text = "%0*d" % [3,Game.Scr_Manager.p1_score]
	%PlayerScoreRight.text = "%0*d" % [3,Game.Scr_Manager.p2_score]

	var p : String = ""
	#p = Game.playerdic["player1"]
	%LabelP1Name.text = p if (!p.is_empty()) else "P1"

	p = ""
	#p = Game.playerdic["player2"]
	%LabelP2Name.text = p if (!p.is_empty()) else "P2"


func Next_Round_Started():
	%PlayerScoreLeft.text = "%0*d" % [3,Game.Scr_Manager.p1_score]
	%PlayerScoreRight.text = "%0*d" % [3,Game.Scr_Manager.p2_score]
	pass


func ScoreLeft(_score : int):
	%PlayerScoreLeft.text = "%0*d" % [3,Game.Scr_Manager.p1_score]


func ScoreRight(_score : int):
	%PlayerScoreRight.text = "%0*d" % [3,Game.Scr_Manager.p2_score]
