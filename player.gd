extends Area2D

signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

var is_right_ui_pressed = false
var is_left_ui_pressed = false
var is_up_ui_pressed = false
var is_down_ui_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right") or is_right_ui_pressed:
		velocity.x += 1
	if Input.is_action_pressed("move_left") or is_left_ui_pressed:
		velocity.x -= 1
	if Input.is_action_pressed("move_down") or is_down_ui_pressed:
		velocity.y += 1
	if Input.is_action_pressed("move_up") or is_up_ui_pressed:
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

"""
func reset_direction_ui_pressed():
	is_right_ui_pressed = false
	is_left_ui_pressed = false
	is_up_ui_pressed = false
	is_down_ui_pressed = false
"""

func _on_hud_up_ui_button_down() -> void:
	is_up_ui_pressed = true


func _on_hud_up_ui_button_up() -> void:
	is_up_ui_pressed = false


func _on_hud_down_ui_button_down() -> void:
	is_down_ui_pressed = true


func _on_hud_down_ui_button_up() -> void:
	is_down_ui_pressed = false


func _on_hud_left_ui_button_down() -> void:
	is_left_ui_pressed = true


func _on_hud_left_ui_button_up() -> void:
	is_left_ui_pressed = false


func _on_hud_right_ui_button_down() -> void:
	is_right_ui_pressed = true


func _on_hud_right_ui_button_up() -> void:
	is_right_ui_pressed = false
