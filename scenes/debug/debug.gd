extends Control

@onready var debug: Label = $Debug

signal SetDebugText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%ResetButton.pressed.connect(func(): Game.Game_Reseted.emit())
	Game.DebugControl = self
	SetDebugText.connect(_SetDebugText)


func _SetDebugText(DbgText : String) -> void:
	debug.text = DbgText
	pass
