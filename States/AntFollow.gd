class_name AntFollow extends State

@export var move_speed: float = 100.0
@onready var ant = self.get_parent().get_parent()

@onready var food := get_node("/root/Game/Food")

func enter() -> void:
    if !food:
        food = get_tree().root.get_node("Game").get_node("Food")
        #food = $Food
        if !food:
            return
func exit() -> void:
    ant.lighten_sprite()
    pass

func Physics_Update(delta: float) -> void:
    var fgp: Vector2 = food.global_position
    var agp: Vector2 = ant.global_position
    var direction = (fgp - agp)

    ant.turn_red()

    if direction.length() > 20:
        ant.velocity = direction.normalized() * move_speed
    
    if direction.length() < 20:
        ant.current_food_target = null
        transitioned.emit(self, "AntGoHome")
