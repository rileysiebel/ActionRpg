extends Node2D

@onready var animatedSprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if Input.is_action_just_pressed("attack"):
#		animatedSprite.play("default")


func _on_animated_sprite_2d_animation_finished():
	queue_free()
