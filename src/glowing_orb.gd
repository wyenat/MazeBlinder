extends CharacterBody2D

var mouse_position = null
var direction = Vector2()
var decay = 0
var can_boost = true

@export var acceleration = 5
@export var red_boost = 30
@export var orange_boost = 10
@export var green_boost = 5
@export var yellow_boost = 1
@export var max_speed = 500

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
	decay = (max_speed - sqrt(velocity.length_squared()))/max_speed
	velocity *= decay
	velocity += (direction * get_acceleration())*decay
	position += velocity/3


func _on_boost_timer_timeout():
	$AnimatedSprite2D.play("green")
	can_boost = true


func _on_animated_sprite_2d_animation_finished():
	print("Finished!")
	if $AnimatedSprite2D.animation == "orange":
		$AnimatedSprite2D.play("yellow")
	if $AnimatedSprite2D.animation == "red":
		$AnimatedSprite2D.play("orange")
	
