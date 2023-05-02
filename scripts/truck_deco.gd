extends Control

const leaving_sound = preload("res://assets/sounds/car_leaving.wav")
const arriving_sound = preload("res://assets/sounds/car_arriving.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.stream = arriving_sound
	$AudioStreamPlayer2D.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(1112, 496), 3)

func leave():
	$AudioStreamPlayer2D.stream = leaving_sound
	$AudioStreamPlayer2D.play()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(2200, 496), 3)


func _on_quit_button_pressed():
	pass # Replace with function body.
