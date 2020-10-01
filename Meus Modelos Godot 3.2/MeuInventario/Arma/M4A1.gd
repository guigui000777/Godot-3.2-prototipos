extends RigidBody

func _init():
	self.apply_impulse(Vector3(global_transform.origin.x,global_transform.origin.y,global_transform.origin.z),Vector3(0,Vector3.UP.y + 50,Vector3.FORWARD.z + 15))
	pass
