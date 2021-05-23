#question 8, 9, 10
extends "res://Enemy.gd"

#enemy 4
onready var range_enemy = get_node("Enemy4")
#range distance
const RANGE_DISTANCE = 150
var direction_away = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#question 10 move away function
#check every frame whether to move away
func _process(delta):
	direction_away = player.position.direction_to(self.position) * MOVE_SPEED
	#move from player player	
	if self.position.distance_to(player.position) < 150:
		move_and_slide(direction_away)	
