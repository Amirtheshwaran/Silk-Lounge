function Approach(value, target, amount){
	//smooth changes towards target goal
	if (value < target) {
		return min(value + amount, target)
	} else if (value > target) {
		return max(value - amount, target)
	} else {
		return value
	}
	
}