class_name PointLabel extends Label

const sell_sound = preload("res://assets/sounds/sell.wav") as AudioStreamWAV
var score = 0
func _init(lab : String, score_ : int, g_position : Vector2):
	score = score_
	position = g_position
	text = "+" + lab if score > 0 else lab
	if score < 0: modulate = Color.html("e15e6b")
	if score == 0: modulate = Color.html("7c524f")
	if score > 0: modulate = Color.html("774ac6")
	if score >= 25: modulate = Color.html("4992d6")
	if score >= 100: modulate = Color.html("a5c578")
	if score >= 250: modulate = Color.html("deb663")
	
	z_index = 30

func _ready():
	var tween = get_tree().create_tween()
	tween.set_ease(tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "modulate.a", 0, 1)
	tween.tween_property(self, "position", global_position + Vector2(0, -120), 1)
	tween.tween_callback(self.queue_free)
	
	if score >= 0: 
		var player = get_tree().get_first_node_in_group("main_player")
		player.stream = sell_sound
		player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
