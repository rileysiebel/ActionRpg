extends Node2D


func create_grass_effect():
	var GrassEffect = load("res://Effects/grass_effect.tscn")
	var grassEffect = GrassEffect.instantiate()
	grassEffect.global_position = global_position
	var world = get_tree().current_scene
	world.add_child(grassEffect)

func _on_hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
