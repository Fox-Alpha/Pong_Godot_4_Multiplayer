extends Node2D

@onready var top = %Borders/TopBorder/BorderCollision
@onready var bottom = %Borders/BottomBorder/BorderCollision
@export var DebugBoundarys : bool = false :
	set(value):
		DebugBoundarys = value
		EnableBoundarys(value)
	get:
		return DebugBoundarys


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.Left_Player_Scored.connect(Score, CONNECT_DEFERRED)
	Game.Right_Player_Scored.connect(Score, CONNECT_DEFERRED)
	Game.Game_Is_over.connect(Game_Is_over, CONNECT_DEFERRED)

	if DebugBoundarys:
		EnableBoundarys(DebugBoundarys)
	
	start()


func Score(_score :int):
	Game.waitForNextRound = true


func Game_Is_over(_ply):
	Game.hasGamestartet = false
	Game.p1_score = 0
	Game.p2_score = 0


func start():
	var screensize = get_viewport_rect()

	#region Top Border an Screensize anpassen
	#top.shape.size.x = screensize.size.x
	#top.shape.size.y = 20
	%Borders/TopBorder.position = Vector2(screensize.get_center().x, 100)
	#%Borders/TopBorder.position.y = 100
	#endregion

	#region Bottom Border an Screensize anpassen
	#bottom.shape.size.x = screensize.size.x
	#bottom.shape.size.y = 20
	%Borders/BottomBorder.position.x = screensize.get_center().x
	%Borders/BottomBorder.position.y = screensize.size.y-40
	#endregion


func _input(event):
	# Receives mouse button input
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) # if Input.MOUSE_MODE_VISIBLE else Input.MOUSE_MODE_VISIBLE)
			MOUSE_BUTTON_LEFT:
				HandleGameState()


func _unhandled_key_input(_event):
	HandleGameState()


func HandleGameState():
	if(!Game.hasGamestartet): # or Game.waitForNextRound):
		if(!Game.hasGamestartet):
			Game.hasGamestartet = true
			Game.emit_signal("New_Game_Started")
		if(Game.hasGamestartet  and Game.waitForNextRound):
			Game.waitForNextRound = false
			Game.emit_signal("Next_Round_Started")


func EnableBoundarys(value) -> void :
	if is_inside_tree():
		var DbgGrp = get_tree().get_nodes_in_group("DebugBoundarys")
		for d : Node in DbgGrp:
			d.get_child(0).set("disabled", !value)
			pass
	pass
