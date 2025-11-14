//When colliding with an enemy take away health and then destroy bullet
with(obj_enemy){
	hp -= other.damage
}

instance_destroy()