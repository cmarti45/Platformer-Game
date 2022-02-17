extends KinematicBody2D

var velocity = Vector2()
export var intelligent = true
export var facingRight = false
var direction =  -1
var speed = 50
const FALLSPEED = 20
var lastWall
func _ready():
	$floorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	if facingRight: flip()
	$AnimatedSprite.play("crawling")
	if intelligent:
		set_modulate(Color(1.2,0.5,1))


func _physics_process(delta):
	if is_on_wall() or (!$floorChecker.is_colliding() and is_on_floor() and intelligent): flip()
	velocity.y += FALLSPEED
	velocity.x = direction * speed
	velocity = move_and_slide(velocity, Vector2.UP)

func flip():
	$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
	direction = -direction
	$floorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction


func _on_topChecker_body_entered(body):
	$AnimatedSprite.play("squashed")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0,false)
	$topChecker.set_collision_layer_bit(4, false)
	$topChecker.set_collision_mask_bit(0, false)
	$sidesChecker.set_collision_layer_bit(4, false)
	$sidesChecker.set_collision_mask_bit(0, false)
	$Timer.start()
	body.bounce()
	


func _on_sidesChecker_body_entered(body):
	body.ouch(position.x)


func _on_Timer_timeout():
	queue_free()
