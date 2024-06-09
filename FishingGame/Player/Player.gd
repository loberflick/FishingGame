extends CharacterBody3D


@export var SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var can_fish = true
var fishing = false
#var wave
var inventory = {
"Slot1": " ",
"Slot2": " ",
"Slot3": " ",
"Slot4": " ",
"Slot5": " ",
"Slot6": " ",
"Slot7": " ",
"Slot8": " ",
"Slot9": " ",
"Slot10": " ",
"Slot11": " ",
"Slot12": " ",
"Slot13": " ",
"Slot14": " ",
"Slot15": " ",
"Slot16": " ",
"Slot17": " ",
"Slot18": " ",
"Slot19": " ",
"Slot20": " ",
"Slot21": " ",
"Slot22": " ",
"Slot23": " ",
"Slot24": " ",
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera = get_parent().get_node("CameraRotate")

var db : SQLite

func _ready():
	#wave = load('res://Player/Wavenoise.tres')
	#heightwave()
	pass


func _physics_process(delta):
	# Add the gravity.
	$SpotLight3D.spot_angle = $CanvasLayer/HSlider.value * 30
	$SpotLight3D.light_energy = $CanvasLayer/HSlider.value * 16
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	$Sprites.rotation.y = camera.rotation.y
	
	if Input.is_action_just_pressed("Fish") && can_fish == true:
		can_fish = false
		fish()
	
	if Input.is_action_just_pressed("Inventory"):
		$CanvasLayer/UI/Inventory.visible = !$CanvasLayer/UI/Inventory.visible
	
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction && !fishing:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	velocity = velocity.rotated(Vector3.UP, camera.rotation.y)
	move_and_slide()


func fish():
	$AnimationPlayer.play("fish")
	fishing = true

func catch():
	fishing = false
	var caught_fish = Fish.find_fish()
	$CanvasLayer/AnimationPlayer.play("catch")
	print(caught_fish)
	$CanvasLayer/FishName.text = caught_fish["name"]
	$CanvasLayer/FishSprite.texture = load(caught_fish["sprite"])
	for i in inventory:
		if inventory[i] == " ":
			
			inventory[i] = caught_fish["name"]
			get_node("CanvasLayer/UI/Inventory/Main/ScrollContainer/GridContainer/" + i + "/TextureRect").texture = load(caught_fish["sprite"])
			get_node("CanvasLayer/UI/Inventory/Main/ScrollContainer/GridContainer/" + i + "/TextureRect").tooltip_text = caught_fish["description"]
			break
	

#func heightwave():
	# wave, world_pos.xz / noise_scale + TIME * time_scale)
	#var image = wave.get_image()
	# var height = image.get_data()
	# print(height)

