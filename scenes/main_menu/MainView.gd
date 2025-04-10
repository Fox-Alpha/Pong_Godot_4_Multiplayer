extends Control

@onready var start_options = %StartOptions
#@onready var container_multiplayer_options = %ContainerMultiplayerOptions
#@onready var multiplayer_host = %MultiplayerHost
#@onready var multiplayer_client = %MultiplayerClient

@export_subgroup("SubPanels", "MainMenu")
@export var MainMenuSubViewPanes : Dictionary[String, NodePath] = {}

# var _node_name = "Main"
## Seperate MeinMenu in own ViewScene
## TODO: Move ButtonPressed events here

# Called when the node enters the scene tree for the first time.
#func _ready():
	#preload("res://scenes/game/playground/ball/ball_body.tscn")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#pass


func _on_button_start_hot_seat_pressed():
	var err = get_tree().change_scene_to_file("res://scenes/game/Pong_40.tscn")
	if err != OK:
		print("Fehler bim laden der Szene: %s" % error_string(err))
	#ToDo: Switch to Local Game Options before starting
	pass
	


func _on_button_multiplayer_options_pressed():
	#ToDo: Switch to Multiplayer Game Options before starting
	pass


func _on_button_start_pressed():
	start_options.visible = !start_options.visible
