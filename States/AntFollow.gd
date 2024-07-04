class_name AntFollow extends State

@export var move_speed: float = 100.0
@onready var ant = self.get_parent().get_parent()

@onready var food := get_node("/root/Game/Food")

func enter() -> void:
    print("AntFollow Enter")
    if !food:
        food = get_tree().root.get_node("Game").get_node("Food")
        print(food.name)
        #food = $Food
        if !food:
            print("No food found")
            return
func exit() -> void:
    ant.lighten_sprite(255)
    pass

func Physics_Update(delta: float) -> void:
    var fgp: Vector2 = food.global_position
    var agp: Vector2 = ant.global_position
    var direction = (fgp - agp)
    ant.turn_red()

    if direction.length() > 20:
        ant.velocity = direction.normalized() * move_speed
    
    if direction.length() < 20:
        print("AntFollow: Transitioning to AntGoHome")
        transitioned.emit(self, "AntGoHome")
