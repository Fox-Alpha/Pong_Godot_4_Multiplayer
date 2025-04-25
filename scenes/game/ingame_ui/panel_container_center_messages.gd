extends PanelContainer

const ANYKEYMESSAGE : String ="Press Any Key to start"
const GAMEOVER : String ="Game Over"
const NEXTROUND : String ="Next Round"

@onready var _game_message_label: Label = %GameMessageLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.Game_State_Changed.connect(_Game_State_Has_Changed, CONNECT_DEFERRED)
	pass # Replace with function body.


func _Game_State_Has_Changed(new_gs : Game.GameStates ): 
	print("Panel Center Message Szene => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
	match new_gs:
		Game.GameStates.GAMEINITIALIZED:
			_Connect_Signals()
			_Set_Center_Message(ANYKEYMESSAGE)
			visible = true
			pass
		Game.GameStates.GAMEISSTARTED:
			visible = false
			pass
		Game.GameStates.GAMEWAITFORSTART:
			_Set_Center_Message(ANYKEYMESSAGE)
			visible = true
			pass
		Game.GameStates.GAMEMAXSCORE:
			pass
		Game.GameStates.GAMEMAXROUND:
			_Set_Center_Message(NEXTROUND)
			visible = true
			pass
		Game.GameStates.GAMEOVER:
			_Set_Center_Message(GAMEOVER)
			visible = true
			pass


func _Connect_Signals() -> void:
	pass


func _Set_Center_Message(message : String) -> void:
	_game_message_label.text = message
	pass


func _gui_input(event: InputEvent) -> void:
#func _input(event):
	# Receives mouse button input

	if event is InputEventMouseButton:
		if Game.GameState != Game.GameStates.GAMEWAITFORSTART:
			return
		match event.button_index:
			MOUSE_BUTTON_RIGHT:
				if Game.GameState == Game.GameStates.GAMEWAITFORSTART:
					Game.Game_State_Changed.emit(Game.GameStates.GAMEISSTARTED)
					return
			MOUSE_BUTTON_LEFT:
				if Game.GameState == Game.GameStates.GAMEWAITFORSTART:
					Game.Game_State_Changed.emit(Game.GameStates.GAMEISSTARTED)
					return
				pass


#func _unhandled_key_input(event: InputEvent) -> void:
#func _unhandled_input(_event: InputEvent) -> void:
	#if Game.GameState == Game.GameStates.GAMEWAITFORSTART:
		#Game.Game_State_Changed.emit(Game.GameStates.GAMEISSTARTED)
		#return
#
	#if Game.GameState != Game.GameStates.GAMEISSTARTED:
		#return
