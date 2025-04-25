extends CharacterBody2D

const SPEED : float = 200.0
var _speed : float = 0.0
var ballspeed : Vector2 = Vector2.ZERO

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	print("Ball Szene => _ready()")
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)


func _Game_State_Has_Changed(new_gs : Game.GameStates) -> void:
	print("Ball Szene => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
	match new_gs:
		Game.GameStates.GAMEISLOADING:
			pass
		Game.GameStates.GAMEINITIALIZING:
			pass
		Game.GameStates.GAMEINITIALIZED:
			_speed = SPEED
			_Connect_Signals()
			velocity = _randomize_ball_direction()
			pass
		Game.GameStates.GAMEWAITFORSTART:
			reset_ball_position()
			pass
		Game.GameStates.GAMEISSTARTED:
			pass
		Game.GameStates.GAMEMAXSCORE:
			pass
		Game.GameStates.GAMEMAXROUND:
			pass
		Game.GameStates.GAMEOVER:
			pass


func _Connect_Signals():
	#Game.Game_Prepare_Round.connect(reset_ball_position, CONNECT_DEFERRED)
	#Game.Game_Prepare_Next_Round.connect(reset_ball_position, CONNECT_DEFERRED)
	pass


func _enter_tree() -> void:
	print("Ball Szene => _enter_tree()")


func _physics_process(delta):
	if Game.GameState != Game.GameStates.GAMEISSTARTED:
		return

	_speed = clampf(_speed * 1.1, SPEED, 700.0)
	ballspeed =  velocity * delta * _speed
	ballspeed = ballspeed.clamp(Vector2(-15, -15), Vector2(15, 15))
	var collision = move_and_collide(ballspeed)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	if Game.DebugControl:
		Game.DebugControl.SetDebugText.emit("Ball Vector (%.3f / %.3f - Speed %d)" % [ballspeed.x, ballspeed.y, _speed]) #str(ballspeed)


func reset_ball_position():
	position =  get_viewport_rect().get_center()
	velocity = _randomize_ball_direction()
	_speed = SPEED


func _randomize_ball_direction() -> Vector2:
	var direction : Vector2 = Vector2.ZERO
	rng.randomize()
	direction.x = [-1,1][rng.randi() % 2]
	direction.y = [-0.8, 0.8][rng.randi() % 2]
	return direction


func _on_visible_on_screen_notifier_2d_screen_exited():
	if(!Game.GameStates.GAMEISSTARTED):
		return

	if(position.x < 0):
		Game.Scr_Manager.Right_Player_Scored.emit(1)
	else:
		Game.Scr_Manager.Left_Player_Scored.emit(1)
