#godot 4.2.KEY_2
class_name AntGoHome extends State

@export var move_speed: float = 100.0
@onready var home := get_node("/root/Game/Home")

@onready var ant = self.get_parent().get_parent()

func _ready() -> void:
    pass

func Enter() -> void:
    if !home:
        return

func Exit() -> void:
    ant.lighten_sprite()
    pass

func Physics_Update(delta: float) -> void:
    ant.turn_green()

    #var hgp: Vector2 = home.global_position
    #var agp: Vector2 = ant.global_position
    #var direction = (hgp - agp)
    #ant.velocity = direction.normalized() * move_speed

    if ant.path.size() > 0:
        #var target_point = ant.path[0]
        var target_point = ant.path[ant.path.size() - 1]
        var direction = (target_point - ant.global_position)
        ant.velocity = direction.normalized() * move_speed

        print("ant.angle: ", rad_to_deg(ant.velocity.angle()))
        ant.drop_pheromone(ant.velocity.angle())

        if direction.length() < 1:
            ant.path.remove_at(ant.path.size() - 1)
            if ant.path.size() == 0:
                ant.current_food_target = null
                #ant.last_pheromone_position = null
                transitioned.emit(self, "AntIdle")
