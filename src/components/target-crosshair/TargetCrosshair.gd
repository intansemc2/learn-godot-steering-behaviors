extends Area2D

onready var targetAnimationPlayer: AnimationPlayer = $"target-animation-player"


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_click"):
        self.targetAnimationPlayer.play("fade_in")


func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_click"):
        self.global_position = self.get_global_mouse_position()


func _on_TargetCrosshair_body_entered(body: Node) -> void:
    if not Input.is_action_pressed('ui_click'):
        self.targetAnimationPlayer.play("fade_out")
