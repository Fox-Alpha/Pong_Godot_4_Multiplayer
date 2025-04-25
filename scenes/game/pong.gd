extends Node2D

@onready var top = %Borders/TopBorder/BorderCollision
@onready var bottom = %Borders/BottomBorder/BorderCollision
@export var DebugBoundarys : bool = false :
	set(value):
		DebugBoundarys = value
		EnableBoundarys(value)
	get:
		return DebugBoundarys


func _ready() -> void:
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)
	print("Pong Szene => _ready()")
	await get_tree().process_frame
	print("Pong Szene => _ready() => Awaited Frame set next GameState")
	Game.Game_State_Changed.emit(Game.GameStates.GAMEINITIALIZED)


func _enter_tree() -> void:
	Game.Game_State_Changed.emit(Game.GameStates.GAMEINITIALIZING)
	print("Pong Szene => _enter_tree()")


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("Pong Szene => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
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


# Called when the node enters the scene tree for the first time.
func __ready():
	Game.Game_Is_over.connect(Game_Is_over, CONNECT_DEFERRED)
	Game.Game_Prepare_Round.connect(Preparing_Round, CONNECT_DEFERRED)
	Game.Game_Prepare_Next_Round.connect(_Prepare_Next_Round)
	_initstart()
	Game.Game_State_Changed.emit(Game.GameStates.GAMEWAITFORSTART)
	
	if DebugBoundarys:
		EnableBoundarys(DebugBoundarys)


func _initstart():
	var screensize = get_viewport_rect()

	#region Top Border an Screensize anpassen
	%Borders/TopBorder.position = Vector2(screensize.get_center().x, 100)
	#endregion

	#region Bottom Border an Screensize anpassen
	%Borders/BottomBorder.position.x = screensize.get_center().x
	%Borders/BottomBorder.position.y = screensize.size.y-40
	#endregion


func Preparing_Round() -> void:
	pass


func Score(_score :int):
	#Game.waitForNextRound = true
	Game.Game_State_Changed.emit(Game.GameStates.GAMEWAITFORSTART)
	pass


func Game_Is_over(_ply):
	Game.hasGamestartet = false
	Game.p1_score = 0
	Game.p2_score = 0


func _input(event):
	# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED if Input.mouse_mode == Input.MouseMode.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_LEFT:
				HandleGameState()


func _unhandled_key_input(_event):
	#HandleGameState()
	pass


func HandleGameState():
	if Game.GameState == Game.GameStates.GAMEWAITFORSTART:
		Game.Game_State_Changed.emit(Game.GameStates.GAMEISSTARTED)
		pass


func EnableBoundarys(value) -> void :
	if is_inside_tree():
		var DbgGrp = get_tree().get_nodes_in_group("DebugBoundarys")
		for d : Node in DbgGrp:
			d.get_child(0).set("disabled", !value)
			pass
	pass


func _Prepare_Next_Round() -> void:
	#Reset Ball
	#Reset Paddles
	#Reset Scores in UI
	#Show Message and wait for Key Press
	pass
