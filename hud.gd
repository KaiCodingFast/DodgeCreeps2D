extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

signal up_ui_button_down
signal up_ui_button_up
signal down_ui_button_down
signal down_ui_button_up
signal left_ui_button_down
signal left_ui_button_up
signal right_ui_button_down
signal right_ui_button_up

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_direction_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	hide_direction_ui()
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(0.5).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	show_direction_ui()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()


func show_direction_ui():
	$DownUi.show()
	$LeftUi.show()
	$RightUi.show()
	$UpUi.show()


func hide_direction_ui():
	$DownUi.hide()
	$LeftUi.hide()
	$RightUi.hide()
	$UpUi.hide()


func _on_up_ui_button_down() -> void:
	up_ui_button_down.emit()


func _on_up_ui_button_up() -> void:
	up_ui_button_up.emit()


func _on_down_ui_button_down() -> void:
	down_ui_button_down.emit()


func _on_down_ui_button_up() -> void:
	down_ui_button_up.emit()


func _on_left_ui_button_down() -> void:
	left_ui_button_down.emit()


func _on_left_ui_button_up() -> void:
	left_ui_button_up.emit()


func _on_right_ui_button_down() -> void:
	right_ui_button_down.emit()


func _on_right_ui_button_up() -> void:
	right_ui_button_up.emit()
