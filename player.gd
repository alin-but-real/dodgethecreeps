extends Area2D

@export var speed = 400 #pixels/sec movement speed 
var screen_size #game window size

func _ready(): #runs once at startup
	screen_size = get_viewport_rect().size

func _process(delta): #runs every frame
	var velocity = Vector2.ZERO #player movement vector, reset to zero initially before frame changes it
	if Input.is_action_pressed("move_up"):
		velocity.y += 1
	if Input.is_action_pressed("move_down"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized * speed #if player moving diagonally, normalize the vector then times it by speed
		$AnimatedSprite2D.play() # $ = get_node()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
