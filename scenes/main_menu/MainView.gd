extends Control

@onready var start_options = %StartOptions
#@onready var container_multiplayer_options = %ContainerMultiplayerOptions
#@onready var multiplayer_host = %MultiplayerHost
#@onready var multiplayer_client = %MultiplayerClient

@export_subgroup("SubPanels", "MainMenu")
@export var MainMenuSubViewPanes : Dictionary[String, NodePath] = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	Game.Game_State_Changed.emit(Game.GameStates.MAINMENU)


func _on_button_start_hot_seat_pressed():
	var err = get_tree().change_scene_to_file(Game.GameMainScene.resource_path)
	if err != OK:
		print("Fehler bim laden der Szene: %s" % error_string(err))
		Game.Game_State_Changed.emit(Game.GameStates.GAMELOADINGERROR)
		return
	#ToDo: Switch to Local Game Options before starting
	Game.Game_State_Changed.emit(Game.GameStates.GAMEISLOADING)
	pass


func _exit_tree() -> void:
	print("MeinMenu Unloading => _exit_tree()")


func _on_button_multiplayer_options_pressed():
	#ToDo: Switch to Multiplayer Game Options before starting
	pass


func _on_button_start_pressed():
	start_options.visible = !start_options.visible
