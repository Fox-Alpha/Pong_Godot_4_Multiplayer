extends Node

#region ScenesAndNodes
var GameMainScene : PackedScene = preload("res://scenes/game/pong.tscn")
var DebugControl : Control :
	set (value):
		DebugControl = value
	get:
		return DebugControl
#endregion

#region GameStates
#var isMultiplayerGame : bool = false
enum GameStates {
	NOTDEFINED,
	GAMELOADINGERROR,
	MAINMENU,
	GAMEISLOADING,
	GAMEINITIALIZING,
	GAMEINITIALIZED,
	GAMEWAITFORSTART,
	GAMEISSTARTED,
	GAMEMAXSCORE,
	GAMEMAXROUND,
	GAMEOVER,
}
var GameState : GameStates = GameStates.NOTDEFINED
#endregion

@onready var rng : RandomNumberGenerator = RandomNumberGenerator.new()


#region ##### Beispiel Setter / Getter
#var sprite_offset : Vector2 = Vector2.ZERO :
#	set (value):
#		sprite_offset = on_sprite_offset_change(value)
#	get:
#		return sprite_offset
#
#func on_sprite_offset_change(value: Vector2) -> Vector2:
#	return Vector2.ZERO
#endregion #####

#region Signals
signal Game_Window_Size_Changed
signal Game_State_Changed(gs : GameStates)
signal Game_Max_Score_Reached
signal Game_Max_Round_Reached

signal Register_Game_Logic(instanceid : int)
signal Register_UI_Manager(instanceid : int)
signal Register_SCORE_Manager(instanceid : int)
#endregion

#region GAMEMANAGER
var GameLogic : Node
var Scr_Manager : ManagerBaseClass
var UI_Manager : ManagerBaseClass
#endregion

#signal Update_Player_Dict(p1:String, p2:String,score:int,rounds:int)

func _ready() -> void:
	print("Global Autoload => _ready()")
	get_tree().get_root().size_changed.connect(func(): Game_Window_Size_Changed.emit())
	get_tree().get_root().tree_exited.connect(_Game_is_closing)
	Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)
	Register_SCORE_Manager.connect(_Register_SCORE_Manager, CONNECT_ONE_SHOT)
	Register_UI_Manager.connect(_Register_UI_Manager, CONNECT_ONE_SHOT)
	Register_Game_Logic.connect(_Register_Game_Logic, CONNECT_ONE_SHOT)


func _exit_tree() -> void:
	print("Global Autoload => _exit_tree()")


func _Game_is_closing() -> void: 
	print("Global Autoload => GameScene::_exiting_tree()")


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_ENTER_TREE:
			print("Global Autoload => _notification()::NOTIFICATION_ENTER_TREE")
			pass
		NOTIFICATION_EXIT_TREE:
			print("Global Autoload => _notification()::NOTIFICATION_EXIT_TREE")
			pass


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	if GameState == new_gs: return

	GameState = new_gs 
	print("Global Autoload => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
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
		Game.GameStates.GAMEOVER:
			pass


func _Connect_Signals() -> void:
	Game_Max_Score_Reached.connect(_Game_Max_Score_Reached)
	Game_Max_Round_Reached.connect(_Game_Max_Round_Reached)
	pass


func _Register_SCORE_Manager(IID : int) -> void:
	if is_instance_id_valid(IID):
		print("Global => _Register_SCORE_Manager()")
		Scr_Manager = instance_from_id(IID)
	else:
		Game_State_Changed.emit(GameStates.GAMELOADINGERROR)
		print("Global => ERROR: _Register_SCORE_Manager()")


func _Register_UI_Manager(IID : int) -> void:
	if is_instance_id_valid(IID):
		print("Global => _Register_UI_Manager()")
		UI_Manager = instance_from_id(IID)
	else:
		Game_State_Changed.emit(GameStates.GAMELOADINGERROR)
		print("Global => ERROR: _Register_UI_Manager()")


func _Register_Game_Logic(IID : int) -> void:
	if is_instance_id_valid(IID):
		print("Global => _Register_Game_Logic()")
		GameLogic = instance_from_id(IID)
	else:
		Game_State_Changed.emit(GameStates.GAMELOADINGERROR)
		print("Global => ERROR: _Register_Game_Logic()")


func _Game_Max_Score_Reached() -> void:
	Game_State_Changed.emit(GameStates.GAMEMAXSCORE)
	pass


func _Game_Max_Round_Reached() -> void:
	Game_State_Changed.emit(GameStates.GAMEMAXROUND)
	pass


########

#func __ready():
	#get_tree().get_root().size_changed.connect(func(): Game_Window_Size_Changed.emit())
	#Game_State_Changed.connect(_Game_State_Changed)
	#
	#Game_Prepare_Next_Round.connect(_Prepare_Next_Round)
	#Game_Max_Round_Reached.connect(_Game_Is_over, CONNECT_DEFERRED)
	#Game_Is_over.connect(_Game_Is_over, CONNECT_DEFERRED)
	#Left_Player_Scored.connect(_Player_has_Scored)
	#Right_Player_Scored.connect(_Player_has_Scored)
	#
	#New_Game_Started.connect(func(): pass)
	#Next_Round_Started.connect(func(): pass)
	#Game_Reseted.connect(func(): pass)
	#Game_Prepare_Round.connect(func(): pass)


#func _Game_Is_over(ply):
	#var roundname = "round_{rnd}".format({"rnd":str(currentround)})
#
	#playerdic[roundname] = {"p1": p1_score, "p2":p2_score, "won": ply}
	#currentround += 1
	#pass
