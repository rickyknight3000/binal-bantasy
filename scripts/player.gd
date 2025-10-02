extends CharacterBody2D

const TILE_SIZE := 16
var walk_tween_speed:= 0.250
var current_dir := "down"
var is_moving := false
var input_dir: Vector2
var player_pos_tween: Tween

@onready var player_anim: AnimatedSprite2D = $Warrior

#movement
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if !player_pos_tween or !player_pos_tween.is_running():
		input_dir = Vector2.ZERO
		if Input.is_action_pressed("move_left"):
			current_dir = "left"
			play_anim(1)
			if !$left.is_colliding():
				input_dir = Vector2.LEFT
				move()
		elif Input.is_action_pressed("move_right"):
			current_dir = "right"
			play_anim(1)
			if !$right.is_colliding():
				input_dir = Vector2.RIGHT
				move()
		elif Input.is_action_pressed("move_up"):
			current_dir = "up"
			play_anim(1)
			if !$up.is_colliding():
				input_dir = Vector2.UP
				move()
		elif Input.is_action_pressed("move_down"):
			current_dir = "down"
			play_anim(1)
			if !$down.is_colliding():
				input_dir = Vector2.DOWN
				move()
		else:
			play_anim(0)

func move():
	if input_dir:
		if is_moving == false:
			is_moving = true
			player_pos_tween = create_tween()
			player_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
			player_pos_tween.tween_property(self, "position", position + input_dir * TILE_SIZE, walk_tween_speed)
			player_pos_tween.tween_callback(move_false)

func move_false():
	is_moving = false

#animation
func play_anim(movement):
	var dir = current_dir

	if dir == "up":
		if movement == 0:
			player_anim.play("warrior_idle_back")
		elif movement == 1:
			player_anim.play("warrior_walk_back")
	
	if dir == "down":
		if movement == 0:
			player_anim.play("warrior_idle_front")
		elif movement == 1:
			player_anim.play("warrior_walk_front")
	
	if dir == "left":
		player_anim.flip_h = false
		if movement == 0:
			player_anim.play("warrior_idle_side")
		elif movement == 1:
			player_anim.play("warrior_walk_side")
	
	if dir == "right":
		player_anim.flip_h = true
		if movement == 0:
			player_anim.play("warrior_idle_side")
		elif movement == 1:
			player_anim.play("warrior_walk_side")
