extends Node

@export var next_level : Resource


func _ready():
	var bg = get_node_or_null("Bg")
	if bg != null and bg is AnimatedSprite2D:
		bg.play()
