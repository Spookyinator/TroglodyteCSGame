extends Area2D
var player = null
var points = 0
var hasBoughtFirst = false
var hasBoughtSecond = false
#exchangeDone--checks if player has bought
#something already so the upgrader doesn't just
#take all your money.
var exchangeDone = false
const FIRST_UPGRADE = 500
const SECOND_UPGRADE = 1500

signal updatePoints
func _on_body_entered(body):
	player = body
	points = player.points
	if (not exchangeDone):
		if (not hasBoughtFirst and points >= FIRST_UPGRADE):
			exchangeDone = true
			player.on_get_points(FIRST_UPGRADE*-1)
			player.get_upgrade(0,1)
			hasBoughtFirst = true
		elif (hasBoughtFirst and not hasBoughtSecond and points >= SECOND_UPGRADE):
			exchangeDone = true
			player.on_get_points(SECOND_UPGRADE*-1)
			hasBoughtSecond = true
			player.get_upgrade(0,2)
			#print("Player has %d points after buying the second pistol upgrade" % player.points)
	

	


func _on_body_exited(body):
	exchangeDone = false
