extends Control

@onready var start_options = %StartOptions
@onready var container_multiplayer_options = %ContainerMultiplayerOptions
@onready var multiplayer_host = %MultiplayerHost
@onready var multiplayer_client = %MultiplayerClient



# var _node_name = "Main"
## Seperate MeinMenu in own ViewScene
## TODO: Move ButtonPressed events here

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_button_start_hot_seat_pressed():
	get_tree().change_scene_to_file("res://Pong_40.tscn")


func _on_button_multiplayer_options_pressed():
	container_multiplayer_options.visible = !container_multiplayer_options.visible


func _on_button_join_server_pressed():
	multiplayer_client.visible = true
	multiplayer_host.visible = false


func _on_button_create_server_pressed():
	multiplayer_host.visible = true
	multiplayer_client.visible = false


func _on_button_start_pressed():
	start_options.visible = !start_options.visible
