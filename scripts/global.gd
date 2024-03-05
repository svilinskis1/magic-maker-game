extends Node

var player
var total_money = 0
var level = 1
var next_level = 500

var apples_collected = 0
var spag_collected = 0

const apple_worth = 10
const spag_worth = 20

func reset_level():
	apples_collected = 0
	spag_collected = 0

func update_money_total(earned):
	total_money += earned
	if total_money >= next_level:
		level += 1
		next_level *= 2
	
