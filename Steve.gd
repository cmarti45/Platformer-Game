extends KinematicBody2D

var velocity = Vector2(0,0)
var coins = 0

const SPEED = 240
const GRAVITY = 35
const JUMPFORCE = -1100

# warning-ignore:unused_argument
func _physics_process(delta):
	if Input.is_action_pressed("right"):
		$Sprite.play("walk")
		$Sprite.flip_h = false
		velocity.x=SPEED
	elif Input.is_action_pressed("left"):
		$Sprite.play("walk")
		$Sprite.flip_h = true
		velocity.x=-SPEED
	else:
		$Sprite.play("idle")
		velocity.x = lerp(velocity.x, 0, 0.2)
		
	velocity.y += GRAVITY
	if !is_on_floor():
		$Sprite.play("air")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	


# warning-ignore:unused_argument
func _on_fallzone_body_entered(body):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Level1.tscn")

signal coin_collected

func addCoin():
	coins += 1
	emit_signal("coin_collected")

func bounce():
	velocity.y = JUMPFORCE * 0.7
 
func ouch(var posx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = JUMPFORCE * 0.5
	if position.x < posx:
		velocity.x = JUMPFORCE * 0.75
	else:
		velocity.x = -JUMPFORCE * 0.75
	Input.action_release("left")
	Input.action_release("right")
	$Timer.start()
	
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Level1.tscn") # Replace with function body.
