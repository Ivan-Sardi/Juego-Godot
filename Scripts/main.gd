extends Node2D


func Click(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("Click izquierdo"):
		print("le di click")
