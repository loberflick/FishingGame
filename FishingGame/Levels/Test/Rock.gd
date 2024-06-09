extends StaticBody3D



@onready var camera = get_parent().get_node("CameraRotate")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite3D.rotation.y = camera.rotation.y

