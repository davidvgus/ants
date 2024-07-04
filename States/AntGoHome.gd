class_name AntGoHome extends State

@export var move_speed: float = 100.0
@onready var home := get_node("/root/Game/Home")

@onready var ant = self.get_parent().get_parent()

func _ready() -> void:
    pass

func Enter() -> void:
    print("AntGoHome Enter")
    if !home:
        print(home.name)
        if !home:
            return

func Exit() -> void:
    print("AntGoHome Exit")
    if ant:
        ant.lighten_sprite()

func Physics_Update(delta: float) -> void:
    print(self.name)
    #ant = self.get_parent().get_parent()
    ant.darken_sprite(0.7)
    var hgp: Vector2 = home.global_position
    var agp: Vector2 = ant.global_position
    var direction = (hgp - agp)
    ant.velocity = direction.normalized() * move_speed
    if direction.length() < 10:
            transitioned.emit(self, "AntIdle")
