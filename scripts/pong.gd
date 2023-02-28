extends Node2D

@onready var top = $Border/TopBorder/BorderCollision
@onready var bottom = $Border/BottomBorder/BorderCollision



# Called when the node enters the scene tree for the first time.
func _ready():
	Game.connect("Left_Player_Scored", Score, CONNECT_DEFERRED)
	Game.connect("Right_Player_Scored", Score, CONNECT_DEFERRED)
	Game.connect("Game_Is_over", Game_Is_over, CONNECT_DEFERRED)

	start()

func Score(_score :int):
	Game.waitForNextRound = true


func Game_Is_over(_ply):
	Game.hasGamestartet = false
	Game.p1_score = 0
	Game.p2_score = 0

func start():
	var screensize = get_viewport_rect()

	# Paddle Positionen
	%Left.position = Vector2(10, screensize.size.y/2)
	%Right.position = Vector2(screensize.size.x-10, screensize.size.y/2)

	# Optische Mittellinie an ScreenSize anpassen
	%Separator_Middle.position = screensize.get_center()
	var sizeto=Vector2(5,screensize.size.y-100)
	var size=%Separator_Middle.texture.get_size()
	var scalevactor=sizeto/size
	%Separator_Middle.scale = scalevactor
	
	# Obere Linie
	%Separator_Top.position.x = screensize.get_center().x
	%Separator_Top.position.y = 60
	var sizetoTOP=Vector2(5, screensize.size.x)
	var sizeTOP=%Separator_Top.texture.get_size()
	var scalevactorTOP=sizetoTOP/sizeTOP
	%Separator_Top.scale = scalevactorTOP
	
	# Untere Linie
	%Separator_Bottom.position.x = screensize.get_center().x
	%Separator_Bottom.position.y = screensize.size.y-60
	var sizetoBOT=Vector2(5, screensize.size.x)
	var sizeBOT=%Separator_Bottom.texture.get_size()
	var scalevactorBOT=sizetoBOT/sizeBOT
	%Separator_Bottom.scale = scalevactorBOT

	# Top Border an Screensize anpassen
	top.shape.size.x = screensize.size.x
	top.shape.size.y = 20
	$Border/TopBorder.position.x = screensize.get_center().x
	$Border/TopBorder.position.y = 40

	# Bottom Border an Screensize anpassen
	bottom.shape.size.x = screensize.size.x
	bottom.shape.size.y = 20
	$Border/BottomBorder.position.x = screensize.get_center().x
	$Border/BottomBorder.position.y = screensize.size.y-40


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
	if(!Game.hasGamestartet or Game.waitForNextRound):
		if(!Game.hasGamestartet):
			Game.hasGamestartet = true
			Game.emit_signal("New_Game_Started")
		if(Game.waitForNextRound):
			Game.waitForNextRound = false
			Game.emit_signal("Next_Round_Started")
