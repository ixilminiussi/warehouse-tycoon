extends Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1).timeout
	var tween = create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(tween.TRANS_EXPO)
	tween.tween_property(self, "position", Vector2(800, 874), 2)


func _on_game_game_over():
	await get_tree().create_timer(.3).timeout
	var tween = create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(tween.TRANS_EXPO)
	tween.tween_property(self, "position", Vector2(800, 1193), 2)
