extends KinematicBody2D

onready var sprite := $character_follow_sprite

const DISTANCE_THRESHOLD := 3.0

export var max_speed := 700.0
export var slow_radious := 200.0
var _velocity := Vector2.ZERO

var target_golbal_position: Vector2 = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_click"):
        self.target_golbal_position = self.get_global_mouse_position()
        self.set_physics_process(true)


func _ready() -> void:
    self.set_physics_process(false)


func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_click"):
        self.target_golbal_position = self.get_global_mouse_position()

    if self.global_position.distance_to(self.target_golbal_position) < self.DISTANCE_THRESHOLD:
        if not Input.is_action_pressed("ui_click"):
            self.set_physics_process(false)
            return

    self._velocity = Stearing.arrive_to(
        self._velocity,
        self.global_position,
        self.target_golbal_position,
        self.max_speed,
        self.slow_radious
    )

    self._velocity = self.move_and_slide(self._velocity)
    self.sprite.rotation = self._velocity.angle() + PI / 2.0
