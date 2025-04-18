extends ManagerBaseClass
class_name UiManager


func _ready() -> void:
	print("UiManager => _ready()")
	Game.Game_Window_Size_Changed.connect(func(): 
		pass
	)
	Game.Game_State_Changed.connect(_Game_State_Has_Changed)
	pass


func _enter_tree() -> void:
	print("UiManager => _enter_tree()")
	Game.Register_UI_Manager.emit(self.get_instance_id())
	pass


func _Game_State_Has_Changed(new_gs : Game.GameStates ): 
	print("UI Manager => _Game_State_Has_Changed(GS:%s)" % Game.GameStates.keys()[new_gs])
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
	pass
