extends ManagerBaseClass
class_name ScoreManager

#region Variables
var currentround : int = 1
var maxrounds : int = 3
#endregion

#region SCORES
var MaxScore : int = 10
var p1_score :int = 0 :
	set (value):
		p1_score = value
	get:
		return p1_score
var p2_score : int = 0 :
	set (value):
		p2_score = value
	get:
		return p2_score
#endregion

var playerdic : Dictionary = {"player1":"", "player2":"", "Rounds":1}

#region SIGNALS
signal Left_Player_Scored(score : int)
signal Right_Player_Scored(score : int)
#endregion

func _ready() -> void:
	print("ScoreManager => _ready()")
	super()
	Left_Player_Scored.connect(_Left_Player_Scored, CONNECT_DEFERRED )
	Right_Player_Scored.connect(_Right_Player_Scored, CONNECT_DEFERRED )
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)


func _enter_tree() -> void:
	print("ScoreManager => _enter_tree()")
	Game.Register_SCORE_Manager.emit(self.get_instance_id())
	pass

#####
func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("ScoreManager => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
	match new_gs:
		Game.GameStates.GAMEISLOADING:
			pass
		Game.GameStates.GAMEINITIALIZING:
			pass
		Game.GameStates.GAMEINITIALIZED:
			_Connect_Signals()
			pass
		Game.GameStates.GAMEWAITFORSTART:
			pass
		Game.GameStates.GAMEISSTARTED:
			pass
		Game.GameStates.GAMEMAXSCORE:
			pass
		Game.GameStates.GAMEMAXROUND:
			pass
		Game.GameStates.GAMEOVER:
			pass


func _Connect_Signals() -> void:
	pass


func _Left_Player_Scored(scorevalue : int = 1) -> void:
	p1_score += scorevalue
	if Check_Score_State(p1_score):
		pass


func _Right_Player_Scored(scorevalue : int = 1) -> void:
	p2_score += scorevalue
	if Check_Score_State(p2_score):
		pass

#####

func _Check_Round_Win_State():
	if(MaxScore == p1_score):
		pass # emit_signal("Game_Is_over", playerdic["player1"])
	elif(MaxScore == p2_score):
		pass # emit_signal("Game_Is_over", playerdic["player2"])


func Check_Max_Round_State() -> bool:
	return currentround == maxrounds+1


func Check_Score_State(score) -> bool:
	return MaxScore == score

#####

#func _check_next_round() -> bool:
	#if _check_score_state(p1_score) or _check_score_state(p2_score):
		#Game.Game_Prepare_Next_Round.emit()
		#return true
	#else:
		#return false
