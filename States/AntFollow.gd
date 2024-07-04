class_name AntFollow extends State

@export var move_speed: float = 100.0
@onready var ant = self.get_parent().get_parent()

@onready var food := get_node("/root/Game/Food")

func enter() -> void:
    pass

func Exit() -> void:
    print("AntFollow exit")
    ant.lighten_sprite()
    pass

func Physics_Update(delta: float) -> void:
    var current_food_target = ant.current_food_target
    var fgp: Vector2 = current_food_target.global_position
    var agp: Vector2 = ant.global_position
    var direction = (fgp - agp)

    ant.turn_red()

    if direction.length() > 5:
        ant.velocity = direction.normalized() * move_speed
    
    if direction.length() < 2:
        ant.current_food_target = null
        transitioned.emit(self, "AntGoHome")
