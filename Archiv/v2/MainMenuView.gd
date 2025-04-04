extends VBoxContainer

@export var maingamemenu : Control
@export var startnewgamemenu : Control
@export var settingsmenu : Control

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_start_pressed():
	maingamemenu.visible = false
	startnewgamemenu.visible = true
	settingsmenu.visible = false
#	get_tree().change_scene_to_file("res://Pong_40.tscn")


func _on_button_settings_pressed():
	maingamemenu.visible = false
	startnewgamemenu.visible = false
	settingsmenu.visible = true


func _on_button_quit_pressed():
	get_tree().quit()
