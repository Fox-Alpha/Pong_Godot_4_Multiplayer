extends Control





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


func _on_button_start_pressed():
	settingsmenu.visible = !settingsmenu.visible


func _on_button_quit_pressed():
	get_tree().quit()
