#godot 4.2.2
class_name AntIdle extends State

@export var move_speed: float = 100.0
@export var move_direction: Vector2 = Vector2.ZERO

@onready var ant = self.get_parent().get_parent()
@onready var food = get_node("/root/Game/Food")
@onready var game = get_node("/root/Game")
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
func add_to_path():
    if !ant:
        return
    else:
        ant.path.append(ant.global_position)
        if game.enable_nav_points:
            ant.drop_nav_point()

func Enter() -> void:
    randomize_wander()
    if ant:
        ant.lighten_sprite()

func Exit() -> void:
    pass
    
func connect_to_pheromone(pheromone):
    pheromone.connect("pheromone_entered", Callable(self, "_on_body_entered"))

func Update(_delta: float) -> void:
#    var pheromones = get_tree().get_nodes_in_group("pheromones")
#    for pheromone in pheromones:
#        if not is_connected("pheromone_entered", Callable(pheromone, "_on_body_entered")):
#            connect_to_pheromone(pheromone)
    if wander_time > 0:
        wander_time -= _delta
    else:
        randomize_wander()
        add_to_path()

func randomize_direction():
    return Vector2(randf_range( - 1.0, 1.0), randf_range( - 1.0, 1.0)).normalized()

func Physics_Update(_delta: float) -> void:
    
    if ant:
        ant.lighten_sprite()
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
    #var direction = (food.global_position - ant.global_position)
    #if direction.length() < 50:
    #    transitioned.emit(self, "AntFollow")
func _enter_tree():
    var food_nodes = get_tree().get_nodes_in_group("food")
    for food_node in food_nodes:
        food_node.connect("ant_entered", Callable(self, "_on_ant_entered_food"))

func _on_ant_entered_food(ant_body, food):
    if ant_body == ant:
        ant.current_food_target = food
        transitioned.emit(self, "AntFollow")

func _on_body_entered(body: Node2D) -> void:
    if body is Ant:
        print("on_Pheromone_body_entered: antidle: inside pheromone area")
        pass
