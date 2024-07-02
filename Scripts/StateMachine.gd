extends Node

@export var initial_state: State

var current_state: State = null
var states: Dictionary = {}

func _ready() -> void:
    for child in get_children():
        if child is State:
            states[child.name.to_lower()] = child
            child.transitioned.connect(on_child_transition)
            #child._enter_tree()

    if initial_state:
        initial_state.Enter()
        current_state = initial_state

func _process(delta: float) -> void:
    if current_state:
        current_state.Update(delta)

func _physics_process(delta: float) -> void:
    if current_state:
        current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name: String) -> void:
    if state != current_state:
        return
    
    var new_state = states.get(new_state_name.to_lower())
    if !new_state:
        return
    
    if current_state:
        current_state.exit()

    current_state = new_state
