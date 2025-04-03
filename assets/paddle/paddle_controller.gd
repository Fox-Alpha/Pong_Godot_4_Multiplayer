extends CharacterBody2D


@export_range(100.0,1000.0,10.0) var SPEED = 300.0

@export_enum("Player_1", "Player_2") var PlayerPaddle = 0

@export_color_no_alpha var playercolor

func _ready():
	Game.connect("New_Game_Started", _reset_position, CONNECT_DEFERRED)
	Game.connect("Next_Round_Started", _reset_position, CONNECT_DEFERRED)


func _process(_delta):
	
	pass


func _physics_process(delta):
	var direction
	match PlayerPaddle:
		0:
			direction = Vector2(0, Input.get_action_strength("p1_down") - Input.get_action_strength("p1_up"))
		1:
			direction = Vector2(0, Input.get_action_strength("p2_down") - Input.get_action_strength("p2_up"))

	if(direction):
		direction = direction.normalized()
		velocity = direction * SPEED * delta
		move_and_collide(velocity)

func _reset_position():
	var screensize = get_viewport_rect()
	
	# Paddle Positionen
	match PlayerPaddle:
		0:
			position = Vector2(10, screensize.size.y/2)
		1:
			position = Vector2(screensize.size.x-10, screensize.size.y/2)
	var col = Game.get_playercolor(PlayerPaddle)
	$Paddle.self_modulate = col
