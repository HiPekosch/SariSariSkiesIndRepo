extends Area3D

func _on_body_entered(body):
	if(body.is_in_group("Kite")):
		print("Coin + 1")
		queue_free()
	
func _physics_process(delta):
	rotation.y += 2.0 * delta
