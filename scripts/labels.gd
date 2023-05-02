extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(tween.TRANS_EXPO)
	tween.tween_property(self, "position", Vector2(0, 92), 2)



func _on_game_game_over():
	var tween = create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(tween.TRANS_EXPO)
	tween.tween_property(self, "position", Vector2(-700, 92), 2)


