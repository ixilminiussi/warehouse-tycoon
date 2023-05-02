extends Control

var game_scene := preload("res://scenes/game.tscn")
var record := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$menu.queue_free()
	add_child(game_scene.instantiate())
	$AudioStreamPlayer2D2.play()
