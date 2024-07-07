#godot 4.2.2 
class_name AntInPheromone extends State

@export var move_speed: float = 100.0
#@export var move_direction: Vector2 = Vector2.ZERO

@onready var ant = self.get_parent().get_parent()
@onready var game = get_node("/root/Game")
@onready var pheromone = null

func Enter() -> void:
    pass

func Exit() -> void:
    pass

func Update(_delta: float) -> void:
    ant.turn_purple()
    pheromone = ant.current_pheromone

    if pheromone:
        var direction_from_rotation = Vector2.RIGHT.rotated(pheromone.rotation)

        ant.move_direction = direction_from_rotation.rotated( - (PI / 2))
        ant.velocity = ant.move_direction * move_speed
        ant.current_pheromone = null
    else:
        transitioned.emit(self, "AntIdle")
 
func Physics_Update(_delta: float) -> void:
    pass
