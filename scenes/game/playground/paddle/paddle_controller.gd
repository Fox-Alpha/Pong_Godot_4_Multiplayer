extends CharacterBody2D

const BLUEPLAYER : Color = Color.DARK_BLUE
const REDPLAYER : Color = Color.DARK_RED
const DEFAULTCOLOR : Color = Color.WHITE

@export_range(100.0,1000.0,10.0) var SPEED = 600.0
@export_enum("PLAYER_1", "PLAYER_2") var PlayerPaddle = 0
@export_color_no_alpha var playercolor = DEFAULTCOLOR

var PlayerLeftPosition : Vector2 = Vector2(10, get_viewport_rect().size.y/2)
var PlayerRightPosition : Vector2 = Vector2(get_viewport_rect().size.x-10, get_viewport_rect().size.y/2)


func _ready():
	Game.Game_Window_Size_Changed.connect(func(): 
		PlayerLeftPosition = Vector2(10, get_viewport_rect().size.y/2)
		PlayerRightPosition = Vector2(get_viewport_rect().size.x-10, get_viewport_rect().size.y/2)
		_reset_position()
	)

	Game.connect("New_Game_Started", _reset_position, CONNECT_DEFERRED)
	Game.connect("Next_Round_Started", _reset_position, CONNECT_DEFERRED)

	if playercolor == DEFAULTCOLOR:
		playercolor = BLUEPLAYER if playercolor == DEFAULTCOLOR else REDPLAYER

	$Paddle.self_modulate = Game.get_playercolor(PlayerPaddle)

func _physics_process(delta):
	var direction
	match PlayerPaddle:
		PlayerPaddle.PLAYER_1:
			direction = Input.get_vector("", "", "p1_down", "p1_up")
			#direction = Vector2(0, Input.get_action_strength("p1_down") - Input.get_action_strength("p1_up"))
		PlayerPaddle.PLAYER_2:
			direction = Vector2(0, Input.get_action_strength("p2_down") - Input.get_action_strength("p2_up"))

	if(direction):
		direction = direction.normalized()
		velocity = direction * SPEED * delta
		move_and_collide(velocity)

func _reset_position():
	#var screensize = get_viewport_rect()
	# Paddle Positionen
	match PlayerPaddle:
		0:
			#position = Vector2(10, screensize.size.y/2)
			position = PlayerLeftPosition
		1:
			#position = Vector2(screensize.size.x-10, screensize.size.y/2)
			position = PlayerRightPosition
	#var col = Game.get_playercolor(PlayerPaddle)
	#$Paddle.self_modulate = col
