extends Button


func _ready():
	pass


func _on_PlayButton_focus_entered():
	pass # Replace with function body.


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Level1.tscn")
