extends CharacterBody2D

@export var walking_speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	var pressed = false
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walking")
		velocity.y = -walking_speed
		pressed = true
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walking")
		velocity.y = walking_speed
		pressed = true
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = true
		velocity.x = -walking_speed
		pressed = true
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = false
		velocity.x = walking_speed
		pressed = true
	if not pressed:
		$AnimatedSprite2D.play("idle")
	move_and_collide(velocity)
		
	
