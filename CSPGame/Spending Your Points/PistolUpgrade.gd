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

@onready var label = $Label
@onready var upgrade_menu = $UpgradeMenu

signal updatePoints

func _ready(): 
	label.visible = false
	
func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and label.visible == true:
		upgrade_menu.visible = true
		label.visible = false

func _on_body_entered(body):
	label.visible = true
	player = body
	upgrade_menu.position = player.global_position
	points = player.points
	
	
func _on_body_exited(body):
	label.visible = false
	upgrade_menu.visible = false
	#exchangeDone = false

func _on_tier_1_pressed():
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
			
