extends Area2D

@export var walking_speed = 20
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	var pressed = false
	if Input.is_action_pressed("up"):
		$AnimatedSprite2D.play("walk")
		velocity.y = -walking_speed
		pressed = true
	if Input.is_action_pressed("down"):
		$AnimatedSprite2D.play("walking")
		velocity.y = walking_speed
		pressed = true
	if Input.is_action_pressed("left"):
		$AnimatedSprite2D.play("walking")
		velocity.x = -walking_speed
		pressed = true
	if Input.is_action_pressed("right"):
		$AnimatedSprite2D.play("walking")
		velocity.x = walking_speed
		pressed = true
	if not pressed:
		$AnimatedSprite2D.play("idle")
	position  += velocity
		
	
