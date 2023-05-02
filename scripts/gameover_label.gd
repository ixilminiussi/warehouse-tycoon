extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.2).timeout
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(52, 104), 2)

func leave():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(-880, 104), 2)
