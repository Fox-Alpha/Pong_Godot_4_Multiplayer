extends Node2D
class_name Pong


@onready var top = %Borders/TopBorder/BorderCollision
@onready var bottom = %Borders/BottomBorder/BorderCollision
@export var DebugBoundarys : bool = false :
	set(value):
		DebugBoundarys = value
		EnableBoundarys(value)
	get:
		return DebugBoundarys

#region Engin Oberloads
func _ready() -> void:
	print("Pong Szene => _ready()")
	await get_tree().process_frame
	print("Pong Szene => _ready() => Awaited Frame set next GameState")
	Game.Game_State_Changed.emit(Game.GameStates.GAMEINITIALIZED)


func _enter_tree() -> void:
	print("Pong Szene => _enter_tree()")
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)
	Game.Game_State_Changed.emit(Game.GameStates.GAMEINITIALIZING)


func _input(event):
	# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MouseMode.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE)
			#MOUSE_BUTTON_LEFT:
				#HandleGameState()


func _unhandled_key_input(_event):
	#HandleGameState()
	pass
#endregion


#region ClassMethods
func _initstart():
	var screensize = get_viewport_rect()

	#region Top Border an Screensize anpassen
	%Borders/TopBorder.position = Vector2(screensize.get_center().x, 100)
	#endregion

	#region Bottom Border an Screensize anpassen
	%Borders/BottomBorder.position.x = screensize.get_center().x
	%Borders/BottomBorder.position.y = screensize.size.y-40
	#endregion


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("Pong Szene => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
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
	Game.Scr_Manager.Left_Player_Scored.connect(Score, CONNECT_DEFERRED)
	Game.Scr_Manager.Right_Player_Scored.connect(Score, CONNECT_DEFERRED)
	pass


func Preparing_Round() -> void:
	pass
#endregion


#region SignalMethods
func Score(_score :int):
	pass


func Game_Is_over(_ply):
	Game.hasGamestartet = false
	Game.p1_score = 0
	Game.p2_score = 0


func EnableBoundarys(value) -> void :
	if is_inside_tree():
		var DbgGrp = get_tree().get_nodes_in_group("DebugBoundarys")
		for d : Node in DbgGrp:
			d.get_child(0).set("disabled", !value)
			pass
	pass
#endregion


#region UNUSED_METHODS
func __NOTUSED__HandleGameState():
	if Game.GameState == Game.GameStates.GAMEWAITFORSTART:
		Game.Game_State_Changed.emit(Game.GameStates.GAMEISSTARTED)
		pass


func __NOTUSED__Prepare_Next_Round() -> void:
	#Reset Ball
	#Reset Paddles
	#Reset Scores in UI
	#Show Message and wait for Key Press
	pass
#endregion
