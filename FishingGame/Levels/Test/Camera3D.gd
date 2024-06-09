extends Camera3D

@onready var player =  get_parent().get_parent().get_node("Player")
@export var offset = Vector3.ZERO
var rotatable = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().global_position = lerp(get_parent().global_position, player.global_position, delta * 2)
	if Input.is_action_just_pressed("ui_left") && rotatable:
		do_rotate(PI/2)
	if Input.is_action_just_pressed("ui_right") && rotatable:
		do_rotate(-PI/2)

func do_rotate(rads):
	rotatable = false
	var rotation_tween = get_tree().create_tween()
	rotation_tween.finished.connect(enable_rotate)
	rotation_tween.tween_property(get_parent(), "rotation", get_parent().rotation + Vector3(0, rads, 0), 0.5).set_trans(Tween.TRANS_CUBIC)

func enable_rotate():
	rotatable = true
