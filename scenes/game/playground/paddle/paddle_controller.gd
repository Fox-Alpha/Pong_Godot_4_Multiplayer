extends CharacterBody2D

const BLUEPLAYER : Color = Color.BLUE
const REDPLAYER : Color = Color.RED
const DEFAULTCOLOR : Color = Color.WHITE

@export_range(100.0,1000.0,10.0) var SPEED = 600.0
enum Player{
	PLAYER_1,
	PLAYER_2
}
@export var PlayerPaddle = Player.PLAYER_1
@export_color_no_alpha var playercolor = DEFAULTCOLOR

@onready var PlayerLeftPosition : Vector2 = Vector2(10, get_viewport_rect().size.y/2)
@onready var PlayerRightPosition : Vector2 = Vector2(get_viewport_rect().size.x-10, get_viewport_rect().size.y/2)


func _ready():
	Game.Game_Window_Size_Changed.connect(func(): 
		PlayerLeftPosition = Vector2(10, get_viewport_rect().size.y/2)
		PlayerRightPosition = Vector2(get_viewport_rect().size.x-10, get_viewport_rect().size.y/2)
		_reset_paddle_position()
	)
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)


func _Connect_Signals() -> void:
	pass


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("Paddle Controller(%s) => _Game_State_Has_Changed(GS:%s)" % [Player.keys()[PlayerPaddle], Game.GameStates.keys()[new_gs]])
	match new_gs:
		Game.GameStates.GAMEISLOADING:
			pass
		Game.GameStates.GAMEINITIALIZING:
			pass
		Game.GameStates.GAMEINITIALIZED:
			_Game_Initializing()
			_Connect_Signals()
			pass
		Game.GameStates.GAMEWAITFORSTART:
			_reset_paddle_position()
			pass
		Game.GameStates.GAMEISSTARTED:
			pass
		Game.GameStates.GAMEMAXSCORE:
			pass
		Game.GameStates.GAMEMAXROUND:
			pass
		Game.GameStates.GAMEOVER:
			pass


func _Game_Initializing() -> void:
	if playercolor == DEFAULTCOLOR:
		playercolor = BLUEPLAYER if PlayerPaddle == Player.PLAYER_1 else REDPLAYER
	$Paddle.self_modulate = playercolor
	$Paddle.self_modulate = Game.GameLogic.get_playercolor(PlayerPaddle)


func _physics_process(delta):
	if Game.GameState != Game.GameStates.GAMEISSTARTED:
		return

	var direction : Vector2 = Vector2.ZERO
	match PlayerPaddle:
		Player.PLAYER_1:
			direction = Vector2(0, Input.get_action_strength("p1_down") - Input.get_action_strength("p1_up"))
		Player.PLAYER_2:
			direction = Vector2(0, Input.get_action_strength("p2_down") - Input.get_action_strength("p2_up"))

	if(direction):
		direction = direction.normalized()
		velocity = direction * SPEED * delta
		move_and_collide(velocity)

func _reset_paddle_position():
	position = PlayerLeftPosition if PlayerPaddle == Player.PLAYER_1 else PlayerRightPosition
	#match PlayerPaddle:
		#0:
			#position = PlayerLeftPosition
		#1:
			#position = PlayerRightPosition
