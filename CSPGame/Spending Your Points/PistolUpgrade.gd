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
@onready var tier_1 = $UpgradeMenu/MarginContainer/VBoxContainer/Tier1
@onready var tier_2 = $UpgradeMenu/MarginContainer/VBoxContainer/Tier2
signal updatePoints

func _ready(): 
	#label.visible = false
	#upgrade_menu.visible = false
	tier_2.disabled = true
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
	print("PRESSED")
	if (not hasBoughtFirst and points >= FIRST_UPGRADE):
		exchangeDone = true
		player.on_get_points(FIRST_UPGRADE*-1)
		player.get_upgrade(0,1)
		print("le upgrade bought!!1")
		hasBoughtFirst = true
		tier_1.disabled = true
		tier_2.disabled = false
			
func _on_tier_2_pressed():
	if (hasBoughtFirst and not hasBoughtSecond and points >= SECOND_UPGRADE):
		print("le upgrade bought!!2")
		exchangeDone = true
		player.on_get_points(SECOND_UPGRADE*-1)
		hasBoughtSecond = true
		player.get_upgrade(0,2)
		tier_2.disabled = true
			
