class_name AntIdle extends State

@export var ant: CharacterBody2D
@export var move_speed: float = 100.0

@onready var food = get_node("/root/Game/Food")
var move_direction: Vector2 = Vector2.ZERO
var wander_time: float = 0

func randomize_wander():
    move_direction = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)).normalized()
    wander_time = randf_range(1, 3)

func Enter() -> void:
    randomize_wander()

func exit() -> void:
    pass

func Update(_delta: float) -> void:
    if wander_time > 0:
        wander_time -= _delta
    else:
        randomize_wander()

func Physics_Update(_delta: float) -> void:
    print("AntIdle Physics_Update")
    if ant:
        ant.velocity = move_direction * move_speed
    
    var direction = (food.global_position - ant.global_position)
    if direction.length() < 200:
        transitioned.emit(self, "AntFollow")
