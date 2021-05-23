extends KinematicBody2D

const MOVE_SPEED = 50

var player = null # a reference to the player so we can move relative to them
#variables for moving right question 1
var player_hasnt_moved = true
#variable holder for players initial position 
var initial_player_pos = Vector2.ZERO
#following variable bool for question 4 and 7
var following = false

func _ready():
	add_to_group("enemies") # add this Node to the enemies group

func _physics_process(delta):
	if player == null: # if we can't find a player, we can't chase them
		return
	else:
		#initial move right question 1
		if player_hasnt_moved == true:
			position += Vector2(MOVE_SPEED * delta, 0.0)
		if initial_player_pos != player.position:
			player_hasnt_moved = false
		#question 4, 7 following
		if following == true:
			#now following
			var follow_vector = Vector2.ZERO
			#question 2 & 3 get the refernce to the players position and enemys position and the difference
			#use that reference to move towards the enemy
			follow_vector = self.position.direction_to(player.position)
			print(str(self.name) + " direction to player is " + str(follow_vector))
			self.move_and_collide(follow_vector * MOVE_SPEED * delta)
		if following == false:
			position = Vector2(self.position)
	
func set_player(p):
	player = p
	#set initial player pos
	initial_player_pos = player.position
