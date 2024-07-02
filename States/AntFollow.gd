class_name AntFollow extends State

@export var ant: CharacterBody2D
@export var move_speed: float = 1.0

var food: Area2D = null

func Enter() -> void:
    if !food:
        food = get_tree().root.get_node("Game").get_node("Food")
        #food = $Food
        if !food:
            print("No food found")
            return
func exit() -> void:
    pass

func Physics_Update(delta: float) -> void:
    var direction = (food.global_position - ant.global_position)

    if direction.length() > 75:
        ant.velocity = direction * move_speed
    else:
        ant.velocity = Vector2.ZERO
    
    if direction.length() > 300:
        transitioned.emit(self, "AntIdle")
