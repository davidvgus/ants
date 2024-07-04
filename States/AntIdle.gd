#godot 4.2.2
class_name AntIdle extends State

@export var move_speed: float = 100.0
@export var move_direction: Vector2 = Vector2.ZERO

@onready var ant = self.get_parent().get_parent()
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
    print("AntIdle Enter")
    randomize_wander()

func Exit() -> void:
    pass

func Update(_delta: float) -> void:
    if wander_time > 0:
        wander_time -= _delta
    else:
        randomize_wander()

func randomize_direction():
    return Vector2(randf_range( - 1.0, 1.0), randf_range( - 1.0, 1.0)).normalized()

func Physics_Update(_delta: float) -> void:
    if ant:
        #ant.velocity = move_direction * move_speed

        var screen_size = get_viewport().size
        var buffer = 10.0

    # Randomize direction slightly to avoid getting stuck

          # Adjust for horizontal screen bounds with buffer
        if ant.global_position.x < buffer:
            move_direction.x = abs(move_direction.x) # Ensure positive direction
            ant.global_position.x = buffer
        elif ant.global_position.x > screen_size.x - buffer:
            move_direction.x = -abs(move_direction.x) # Ensure negative direction
            ant.global_position.x = screen_size.x - buffer

        # Adjust for vertical screen bounds with buffer
        if ant.global_position.y < buffer:
            move_direction.y = abs(move_direction.y) # Ensure positive direction
            ant.global_position.y = buffer
        elif ant.global_position.y > screen_size.y - buffer:
            move_direction.y = -abs(move_direction.y) # Ensure negative direction
            ant.global_position.y = screen_size.y - buffer

        # Apply random direction after ensuring the ant is within bounds
        #move_direction += randomize_direction()
        ant.velocity = move_direction.normalized() * move_speed

    #move_and_slide(move_direction * move_speed)
    var direction = (food.global_position - ant.global_position)
    if direction.length() < 220:
        print("AntIdle: Transitioning to AntFollow")
        transitioned.emit(self, "AntFollow")
