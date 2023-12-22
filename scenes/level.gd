extends Node2D

var on_pause = false

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			on_pause = !on_pause

func _ready():
	$UI/Message.text = "Get the sword!"
	$UI/Message.visible = true
	await get_tree().create_timer(3).timeout
	$UI/Message.visible = false

func _process(delta):
	
	if on_pause:
		$UI/Background.visible = true
		$Player/Player.velocity.x = 0
		$Player/Player.velocity.y = 0
		$Enemies/Samurai.velocity.x = 0
		$Enemies/Samurai.velocity.y = 0
		$Enemies/Samurai2.velocity.x = 0
		$Enemies/Samurai2.velocity.y = 0
		$Enemies/Samurai3.velocity.x = 0
		$Enemies/Samurai3.velocity.y = 0
	else:
		$UI/Background.visible = false
	if $Player/Player.health == 2:
		$UI/Health3.global_position.x = -100
	
	if $Player/Player.health == 1:
		$UI/Health2.global_position.x = -100
		
	if $Player/Player.health == 0:
		$UI/Health1.global_position.x = -100
	
	if $Player/Player.is_dead:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	
	if $Player/Player.has_sword:
		if !$UI/HasSword.visible:
			$UI/Message.text = "Now find the key!"
			$UI/Message.visible = true
			await get_tree().create_timer(3).timeout
			$UI/Message.visible = false
			$UI/HasSword.visible = true
	
	if $Player/Player.has_key:
		if !$UI/HasKey.visible:
			$UI/HasKey.visible = true
			$UI/Message.text = "Look!"
			$UI/Message.visible = true
			$Door/Door.is_opening = true
			await get_tree().create_timer(3).timeout
			$UI/Message.visible = false


func _on_border_body_exited(body):
	if body.name == "Player":
		var ind = 0
		if body.global_position.x < 1920 and body.global_position.y < 1080:
			ind = 1
		if body.global_position.x > 1920 and body.global_position.y < 1080:
			ind = 2
		if body.global_position.x < 1920 and body.global_position.y > 1080:
			ind = 3
		if body.global_position.x > 1920 and body.global_position.y > 1080:
			ind = 4

		body.pause = true
		await get_tree().create_timer(0.5).timeout
		body.change_camera(ind)

func _on_border_body_entered(body):
	if body.name.begins_with("Samurai"):
		body.follow = false
		body.reset = true

var back_from_dungeon = false
var visited_dungeon = false
func _on_portal_body_entered(body):
	if !back_from_dungeon and body.name == "Player":
		body.global_position.x = 4800
		body.global_position.y = 900
		body.change_camera(5)


func _on_portal_from_body_entered(body):
	if visited_dungeon and body.name == "Player":
		body.global_position.x = 700
		body.global_position.y = 200
		body.change_camera(1)

func _on_portal_from_body_exited(body):
	visited_dungeon = false #true
	back_from_dungeon = false #false

func _on_portal_body_exited(body):
	back_from_dungeon = true # true
	visited_dungeon = true # false


func _on_sword_taken_body_entered(body):
	if body.name == "Player":
		body.has_sword = true
		$SwordTaken/Sword.visible = false


func _on_key_taken_body_entered(body):
	if body.name == "Player":
		print("Player in key")
		if body.defeated < 3:
			$UI/Message.text = "Defeat all enemies!!"
			$UI/Message.visible = true
			await get_tree().create_timer(3).timeout
			$UI/Message.visible = false
		else:
			body.has_key = true
			$KeyTaken/Key.visible = false


func _on_ruby_taken_body_entered(body):
	if $RubyTaken.visible:
		$RubyTaken.visible = false
		$UI/Message.text = "FINISH!"
		$UI/Message.visible = true
		await get_tree().create_timer(1).timeout
		$UI/Message.visible = false
		get_tree().change_scene_to_file("res://scenes/win.tscn")
