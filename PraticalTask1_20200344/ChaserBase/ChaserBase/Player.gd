extends KinematicBody2D

const MOVE_SPEED = 300
var has_moved = false
onready var enemies = []
onready var furtherest_enemy = null

func _ready():
	yield(get_tree(), "idle_frame") # wait for scene tree to load before continuing
	get_tree().call_group("enemies", "set_player", self) # call set_player method on all Nodes in the "enemies" group
	#question 5 assign a array of enemy nodes to variable enemies
	enemies = get_tree().get_nodes_in_group("enemies")

func _physics_process(delta):
	var move_vec = Vector2()
	if Input.is_action_pressed("move_up"):
		move_vec.y -= 1
		has_moved = true
	if Input.is_action_pressed("move_down"):
		move_vec.y += 1
		has_moved = true
	if Input.is_action_pressed("move_left"):
		move_vec.x -= 1
		has_moved = true
	if Input.is_action_pressed("move_right"):
		move_vec.x += 1
		has_moved = true
	move_vec = move_vec.normalized()
	move_and_collide(move_vec * MOVE_SPEED * delta)

	#question 6
	#player has moved find the furtherest enemy and follow
	if has_moved == true:
		#loop through whole list and find furtherest enemy
		for enemy in enemies:
			enemy.following = false
			#if first loop set furtherest enemy to first enemy node
			if furtherest_enemy == null:
				furtherest_enemy = enemy
			if enemy.position.distance_to(self.position) > furtherest_enemy.position.distance_to(self.position):
				furtherest_enemy = enemy
		#set the new furtherst enemy to follow
		furtherest_enemy.following = true
		print("Node name: " + str(furtherest_enemy.name) + " distance to player: " + str(furtherest_enemy.position.distance_to(self.position)))
