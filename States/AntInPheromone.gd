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
        print("AntInPheromone: pheremone is there and ant is there")
        ant.move_direction = (pheromone.global_position - ant.global_position).normalized()
        
        ant.velocity = ant.move_direction * move_speed
        ant.current_pheromone = null
    else:
        transitioned.emit(self, "AntIdle")
 
func Physics_Update(_delta: float) -> void:
    pass
