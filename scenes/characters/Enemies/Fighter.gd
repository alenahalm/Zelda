extends CharacterBody2D

var SPEED = 100
var follow = false
var attack = false
var player 

func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta):
	if attack:
		velocity.x = 0
		velocity.y = 0
		get_node("AnimatedSprite2D").play("Attack")
	elif follow:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
		get_node("AnimatedSprite2D").play("Run")
		get_node("AnimatedSprite2D").flip_h = (direction.x < 0)
	else:
		velocity.x = 0
		velocity.y = 0
		get_node("AnimatedSprite2D").play("Idle")
	move_and_slide()

func _on_player_detection_body_entered(body):
	print("attack zone entered")
	if body.name == "Player":
		follow = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		follow = false

func _on_attack_body_entered(body):
	if body.name == "Player":
		attack = true


func _on_attack_body_exited(body):
	if body.name == "Player":
		attack = false
