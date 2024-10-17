extends Area3D

var coinsCollected: int = 0
@onready var coins = $"../../CanvasLayer/Coins"
@onready var race_finished = $"../../CanvasLayer/Race Finished"

func _physics_process(delta):
	rotation.y += 2.0 * delta

func _on_body_entered(body):
	if(body.is_in_group("Kite")):
		add_points()
		queue_free()
	
func add_points():
	coinsCollected = coinsCollected + 1
	print( "Coins Collected Value: " + str(coinsCollected))
	coins.text = "Coins Collected: " + str(coinsCollected)
