class_name AntIdle extends State

@export var ant: CharacterBody2D
@export var move_speed: float = 100.0
@export var move_direction: Vector2 = Vector2.ZERO

@onready var food = get_node("/root/Game/Food")

var wander_time: float = 0

func randomize_wander():
    if move_direction != Vector2.ZERO:
        # Get the current direction's angle
        var current_angle = move_direction.angle()
        
        # Generate a random angle within a 180-degree arc (-90 to 90 degrees in radians)
        var angle_offset = randf_range( - PI / 8, PI / 8)
        
        # Calculate the new direction by rotating the current direction by the random angle offset
        move_direction = Vector2(cos(current_angle + angle_offset), sin(current_angle + angle_offset)).normalized()
    else:
        # If the current direction is Vector2.ZERO, just pick a random direction as before
        move_direction = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)).normalized()

    #move_direction = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)).normalized()

    wander_time = randf_range(0.01, .1)

func Enter() -> void:
    randomize_wander()

func Exit() -> void:
    pass

func Update(_delta: float) -> void:
    if wander_time > 0:
        wander_time -= _delta
    else:
        randomize_wander()

func Physics_Update(_delta: float) -> void:
    if ant:
        ant.velocity = move_direction * move_speed

        var screen_size = get_viewport().size
        var next_position = ant.global_position + move_direction * move_speed * _delta
        
        # Check for horizontal screen boundaries
        if next_position.x < 0 or next_position.x > screen_size.x:
            move_direction.x = -move_direction.x # Reverse horizontal direction
        
        # Check for vertical screen boundaries (if needed)
        if next_position.y < 0 or next_position.y > screen_size.y:
            move_direction.y = -move_direction.y # Reverse vertical direction
    
    #move_and_slide(move_direction * move_speed)
    var direction = (food.global_position - ant.global_position)
    if direction.length() < 200:
        transitioned.emit(self, "AntFollow")
