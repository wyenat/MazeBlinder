extends CharacterBody2D

var mouse_position = null
var direction = Vector2()
var decay = 0
var can_boost = true
var collision = 0

@export var red_boost = 500
@export var orange_boost = 300
@export var green_boost = 100
@export var yellow_boost = 50
@export var max_speed = 10000

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("green")
	
func get_acceleration():
	if $AnimatedSprite2D.animation == "green":
		return green_boost
	if $AnimatedSprite2D.animation == "yellow":
		return yellow_boost
	if $AnimatedSprite2D.animation == "red":
		return red_boost
	if $AnimatedSprite2D.animation == "orange":
		return orange_boost

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if can_boost and Input.is_action_pressed("boost"):
		$BoostTimer.start()
		can_boost = false
		$AnimatedSprite2D.play("red")
	mouse_position = get_global_mouse_position()
	direction = (mouse_position - position).normalized()
	if collision > 0:
		direction = direction.bounce(get_last_slide_collision().get_normal())
	decay = (max_speed - sqrt(velocity.length_squared()))/max_speed
	velocity *= decay
	velocity += (direction * get_acceleration())*decay
	move_and_slide()
	collision = get_slide_collision_count()
	


func _on_boost_timer_timeout():
	$AnimatedSprite2D.play("green")
	can_boost = true


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "orange":
		$AnimatedSprite2D.play("yellow")
	if $AnimatedSprite2D.animation == "red":
		$AnimatedSprite2D.play("orange")
	
