extends Node

const DEFAULT_MASS := 2.0
const DEFAULT_MAX_SPEED := 400.0

const DEFAULT_SLOW_RADIOUS := 200.0
const DEFAULT_SLOW_RATIO := 0.8

static func follow(
    velocity: Vector2,
    global_position: Vector2,
    target_position: Vector2,
    max_speed := DEFAULT_MAX_SPEED,
    mass := DEFAULT_MASS
) -> Vector2:
    var desired_velocity := (target_position - global_position).normalized() * max_speed
    var steering_velocity := (desired_velocity - velocity) / mass
    return steering_velocity

static func arrive_to(
    velocity: Vector2,
    global_position: Vector2,
    target_position: Vector2,
    max_speed := DEFAULT_MAX_SPEED,
    slow_radious := DEFAULT_SLOW_RADIOUS,
    mass := DEFAULT_MASS,
    slow_ratio := DEFAULT_SLOW_RATIO
) -> Vector2:
    var to_target := global_position.distance_to(target_position)
    var desired_velocity := (target_position - global_position).normalized() * max_speed

    if to_target < slow_radious:
        if slow_ratio <= 0 || slow_ratio >= 1:
            slow_ratio = DEFAULT_SLOW_RATIO
        desired_velocity *= (to_target / slow_radious) * slow_ratio + (1.0 - slow_ratio)

    var steering_velocity := (desired_velocity - velocity) / mass
    return steering_velocity
