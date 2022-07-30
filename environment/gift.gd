extends RigidBody2D

onready var spr_gift_node : AnimatedSprite = $spr_gift

func _ready() -> void:
	spr_gift_node.frame= randi() % 1

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()




func _on_gift_body_entered(body) -> void:
	if body is Player:
		GLOBALS.emit_signal("gift_picked")
		queue_free()
	
