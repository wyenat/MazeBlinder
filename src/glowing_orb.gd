extends CharacterBody2D

var mouse_position = null
var direction = Vector2()
var decay = 0

var can_boost = true

var is_bouncing = false
var can_bounce = true

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

func decay_speed():
	decay = (max_speed - sqrt(velocity.length_squared()))/max_speed
	velocity *= decay

func bounce():
	can_bounce = false
	$BounceTimer.start()
	$UnbounceTimer.start()
	is_bouncing = true
	$AnimatedSprite2D.play("yellow")
	direction = direction.bounce(get_last_slide_collision().get_normal())
	velocity = direction * velocity.length()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	decay_speed()
	if is_bouncing:
		move_and_slide()
		return
	if can_boost and Input.is_action_pressed("boost"):
		$BoostTimer.start()
		can_boost = false
		$AnimatedSprite2D.play("red")
	mouse_position = get_global_mouse_position()
	direction = (mouse_position - position).normalized()
	if can_bounce and get_slide_collision_count() > 0:
		bounce()
		return
	velocity += (direction * get_acceleration())
	move_and_slide()
	

func _on_boost_timer_timeout():
	$AnimatedSprite2D.play("green")
	can_boost = true


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "orange":
		$AnimatedSprite2D.play("yellow")
	if $AnimatedSprite2D.animation == "red":
		$AnimatedSprite2D.play("orange")
	
func _on_bounce_timer_timeout():
	$AnimatedSprite2D.play("green")
	is_bouncing = false


func _on_unbounce_timer_timeout():
	can_bounce = true
