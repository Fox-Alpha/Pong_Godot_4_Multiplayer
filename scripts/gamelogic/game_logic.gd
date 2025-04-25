extends Node
class_name PongGameLogic

enum Players {
	PLAYER_1,
	PLAYER_2
}

func _ready() -> void:
	print("GameLogic => _ready()")
	pass


func _enter_tree() -> void:
	print("GameLogic => _enter_tree()")
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)
	Game.Register_Game_Logic.emit(self.get_instance_id())
	pass


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("GameLogic => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
	match new_gs:
		Game.GameStates.GAMEISLOADING:
			pass
		Game.GameStates.GAMEINITIALIZING:
			pass
		Game.GameStates.GAMEINITIALIZED:
			_Connect_Signals()
			Game.Game_State_Changed.emit(Game.GameStates.GAMEWAITFORSTART)
			pass
		Game.GameStates.GAMEWAITFORSTART:
			pass
		Game.GameStates.GAMEISSTARTED:
			pass
		Game.GameStates.GAMEOVER:
			pass


func _Connect_Signals() -> void:
	Game.Scr_Manager.Left_Player_Scored.connect(Score, CONNECT_DEFERRED)
	Game.Scr_Manager.Right_Player_Scored.connect(Score, CONNECT_DEFERRED)
	pass


func Score(_score :int):
	#check for max score
	Game.Scr_Manager.Check_Score_State()
	#Game.Game_State_Changed.emit(Game.GameStates.GAMEMAXSCORE)
	#check for max round
	Game.Scr_Manager.Check_Max_Round_State()
	#Game.Game_State_Changed.emit(Game.GameStates.GAMEMAXROUND)
	#check win / GameOver
	#Game.Game_State_Changed.emit(Game.GameStates.GAMEOVER)
	# Sonst Warten auf start
	print("GameLogic => Score()::Changing GS:%s " % Game.GameStates.keys()[Game.GameStates.GAMEWAITFORSTART])
	Game.Game_State_Changed.emit(Game.GameStates.GAMEWAITFORSTART)
	pass



func get_playercolor(_ply:int) -> Color:
	#Todo Save Player color in Dictionary for next Round
	#var col = playerdic["colors"][ply]
	randomize()
	return Color.from_rgba8(randi_range(0, 255), randi_range(0, 255), randi_range(0, 255))# col


#func update_player_dict(p1:String = "P1", p2:String  = "P2", m_score:int = 10, m_rounds:int = 3, colors:Array = [Color.DARK_BLUE, Color.ORANGE_RED]):
	#playerdic.clear()
	#playerdic = {"player1":p1, "player2":p2, "max_rounds":m_rounds, "max_score": m_score, "colors":colors}

	#for r in range(1, m_rounds):
		#var roundname = "round_{rnd}".format({"rnd":str(r)})
		#playerdic[roundname] = {"p1": 0, "p2":0, "won": "NONE"}
	#pass
