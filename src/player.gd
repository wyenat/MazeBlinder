extends CharacterBody2D

@export var walking_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Input.get_vector("left", "right", "up", "down").normalized()*walking_speed
	if velocity.is_zero_approx():
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = velocity.x < 0
	move_and_slide()
		
	
