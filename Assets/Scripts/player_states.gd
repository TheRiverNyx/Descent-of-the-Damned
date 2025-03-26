extends AnimationTree
enum PlayerState{
	DEAD,
	IDLE,
	WALKING,
	RUNNING,
	ROLLING,
	HURT
}

var currentState: PlayerState

func change_to_walking():
	currentState=PlayerState.WALKING
func change_to_running():
	currentState=PlayerState.RUNNING
