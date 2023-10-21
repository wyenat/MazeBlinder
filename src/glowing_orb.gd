extends Area2D

var velocity = Vector2()
var mouse_position = null
var direction = null
var decay = 0
@export var acceleration = 20
@export var max_speed = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	direction = (mouse_position - position).normalized()
	decay = (max_speed - sqrt(velocity.length_squared()))/max_speed
	velocity *= decay
	velocity += (direction * acceleration)*decay
	print("For velocity : ", velocity, " decay is ", decay)
	position += velocity
