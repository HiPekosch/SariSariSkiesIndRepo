extends Node3D

var coinsCollected 
var place
@onready var player = $"../Player"
@onready var starting_timer = $"../StartingTimer"
@onready var race_finished = $"../CanvasLayer/Race Finished"

var isRaceDone = false


#need a coroutine for delayed start 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_tree().paused = true
	start_countdown()

func start_countdown():
	print("Hello world")
	starting_timer.start()
	
	 # Loop for the countdown
	while !starting_timer.is_stopped():
		print(starting_timer.time_left)
		await starting_timer.timeout
		
	get_tree().paused = false
	
	
	print("Go!")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_end_zone_body_entered(body):
	if(body.is_in_group("player") && !isRaceDone):
		print("You Win!")
		race_finished.visible = true
		race_finished.text = ("You win!")
		isRaceDone = true
		
	if(body.is_in_group("racer") && !isRaceDone):
		print("You Lose!")
		race_finished.visible = true
		race_finished.text = ("You lose!")
		isRaceDone = true
		
		
