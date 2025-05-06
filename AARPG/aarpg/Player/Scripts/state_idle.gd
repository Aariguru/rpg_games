class_name State_Idle extends State

# Called when the node enters the scene tree for the first time.


func Enter() -> void:
	player.UpdateAnimation("idle")
	pass

func Exit() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func Process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	return null
	

func Physics(_delta : float ) -> State:
	return null


func HandleInput(_event: InputEvent) -> State:
	return null
