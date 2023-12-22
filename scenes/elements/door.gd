extends AnimatableBody2D


var is_open = false
var is_opening = false

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	is_open = $"../../Player/Player".has_key
	if is_opening:
		get_node("AnimatedSprite2D").play("Opening")
		await get_tree().create_timer(1).timeout
		is_opening = false
		is_open = true
	if is_open:
		get_node("AnimatedSprite2D").play("Open")
	else:
		get_node("AnimatedSprite2D").play("Closed")


func _on_player_detection_body_entered(body):
	if body.name == "Player" and body.has_key:
		body.global_position.x = 5500
		body.global_position.y = 300
		await get_tree().create_timer(1).timeout
		body.change_camera(5)
		$"../../RubyTaken".visible = true
