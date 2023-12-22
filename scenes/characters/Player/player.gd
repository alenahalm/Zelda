extends CharacterBody2D

const SPEED = 400
var defeated = 0
var has_sword = false
var has_key = false
var attack = false
var health = 3
var is_dead = false
var is_invincible = false
var pause = false

@onready var anim = get_node("AnimationPlayer")

func _input(event):
	if event is InputEventKey:
		if attack:
			return
		if event.keycode == KEY_SPACE:
			attack = true

func _physics_process(delta):
	
	if health == 0:
		anim.play("Death")
		await get_tree().create_timer(0.3).timeout
		is_dead = true
	
	if pause:
		return
	
	if attack and has_sword:
		anim.play("Attack")
		await get_tree().create_timer(0.6).timeout
	attack = false

	var direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
		anim.play("Run")
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
		if velocity.x == 0 and velocity.y == 0:
			anim.play("Idle")
	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.x == 0 and velocity.y == 0:
			anim.play("Idle")
	if health == 0:
		anim.play("Death")
		await get_tree().create_timer(2).timeout
	if $"../..".on_pause:
		self.velocity.x = 0
		self.velocity.y = 0
	move_and_slide()
	
	
func make_invincible():
	is_invincible = true
	for i in 4:
		self.modulate.a = 0.5
		await get_tree().create_timer(0.5).timeout
		self.modulate.a = 1
		await get_tree().create_timer(0.5).timeout
	is_invincible = false
	
func change_camera(to):
	if to == 1:
		$Camera2D.limit_left = 0
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1920
		$Camera2D.limit_bottom = 1080
	
	if to == 2:
		$Camera2D.limit_left = 1920
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1920 * 2
		$Camera2D.limit_bottom = 1080
	
	if to == 3:
		$Camera2D.limit_left = 0
		$Camera2D.limit_top = 1080
		$Camera2D.limit_right = 1920
		$Camera2D.limit_bottom = 1080 * 2
	
	if to == 4:
		$Camera2D.limit_left = 1920
		$Camera2D.limit_top = 1080
		$Camera2D.limit_right = 1920 * 2
		$Camera2D.limit_bottom = 1080 * 2
		
	if to == 5:
		$Camera2D.limit_left = 1920 * 2
		$Camera2D.limit_top = 0
		$Camera2D.limit_right = 1920 * 3
		$Camera2D.limit_bottom = 1080
	pause = false
