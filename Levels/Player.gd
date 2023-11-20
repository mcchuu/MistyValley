extends CharacterBody2D

# Gets the velocity and makes it visiable in the inpector 
@export var move_speed : float = 100
# allows editing starting pos in inpector at startup
@export var starting_direction : Vector2 = Vector2(0,1)
# gets reference to animation tree and stores reference in animation_tree 
@onready var animation_tree = $AnimationTree
# gets playback from animation tree 
# to travel between blend space based on if the character is moving 
@onready var state_machine = animation_tree.get("parameters/playback")

#setting up for when the script runs
func _ready():
	update_animation_parameters(starting_direction)
	
func _physics_process(delta):
# gets input code
	var input_direction = Vector2(
# arrow cancels out the other if both are pressed
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
# update velocity
	velocity = input_direction * move_speed
	
# move and slide  func uses velocity of Charbody to move Player on map
	move_and_slide()
	pick_new_state()
# gets move input and updates direction 
func update_animation_parameters(move_input : Vector2):
# does not change animation parameter without move input HELP =/=
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		
# chooses state blend based on what is happening wih the player
func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")


func _on_button_pressed():
	pass # Replace with function body.
