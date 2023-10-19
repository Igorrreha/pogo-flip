extends CharacterBody2D


@export var _pogo_jump_pad_area: Area2D
@export var _jump_force = 400.0

var _gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	_pogo_jump_pad_area.body_entered.connect(_on_pogo_jump_pad_area_body_entered)


func _on_pogo_jump_pad_area_body_entered(body: PhysicsBody2D) -> void:
	velocity = Vector2.UP.rotated(rotation) * _jump_force
	move_and_slide()
	print("collision")


func _physics_process(delta: float) -> void:
	update_rotation()
	_apply_gravity(delta)
	move_and_slide()


func _apply_gravity(frame_delta: float) -> void:
	if not is_on_floor():
		velocity.y += _gravity * frame_delta


func update_rotation() -> void:
	rotation = get_global_mouse_position().angle_to_point(global_position) + PI / 2
