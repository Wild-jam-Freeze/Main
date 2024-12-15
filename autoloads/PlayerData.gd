extends Node

signal updated

var Health := 100
const MAXHEALTH := 100

var Freeze := 0
const MAXFREEZE := 100

##Health subtract function, returns remaining Health
func subtract_health(amount: int) -> int:
	updated.emit()
	Health -= amount
	return Health

##Health add function, returns updated health
func add_health(amount: int) -> int:
	updated.emit()
	Health = min(MAXHEALTH, Health + amount)
	return Health

##Freeze subtract function, returns remaining freeze
func subtract_freeze(amount: int) -> int:
	updated.emit()
	Freeze -= amount
	return Freeze

##freeze add function, returns updated freeze
func add_freeze(amount: int) -> int:
	updated.emit()
	Freeze = min(MAXFREEZE, Freeze + amount)
	return Freeze
