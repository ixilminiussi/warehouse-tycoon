extends Control

var score
var balance
var game_scene = preload("res://scenes/game.tscn")

func initialize(score_, balance_):
	score = score_
	balance = balance_
	var yes = false
	if get_parent().record < score: 
		get_parent().record = score
		yes = true
	
	$gameover_label/Label.text = "You went bankrupt on order " + str(score + 1) + " with " + str(balance) + " in your balance"
	$truck/ScoreLabel.text = "Score: " + str(score)
	$truck/RecordLabel.text = "Record: " + str(get_parent().record) if yes else "New Record: " + str(get_parent().record) + "!"


func _on_play_button_pressed():
	$truck.leave()
	$gameover_label.leave()
	await get_tree().create_timer(3).timeout
	get_parent().add_child(game_scene.instantiate())
	queue_free()
	$truck/AudioStreamPlayer2D2.play()
	


func _on_quit_button_pressed():
	$truck/AudioStreamPlayer2D2.play()
	get_tree().quit()
