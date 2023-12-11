extends RigidBody2D
var player = null
var points = 0
const DOOR_COST = 800
@onready var label = $Label
@onready var close_button = $UpgradeMenu/MarginContainer/HBoxContainer/NoButton
@onready var buy_button = $UpgradeMenu/MarginContainer/HBoxContainer/YesButton
@onready var menu = $UpgradeMenu
func _ready():
	label.visible = false
	label.text = "Buy Door [%d]" % DOOR_COST
	menu.visible = false
func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and label.visible == true:
		print("lol")
		menu.show()
		label.visible = false

func _on_body_entered(body):
	label.visible = true
	player = body
	points = player.points
	menu.show()


func _on_body_exited(body):
	label.visible = false
	menu.hide()


func _on_close_button_pressed():
	menu.hide()


func _on_buy_button_pressed():
	if (player.points>=DOOR_COST):
		player.on_get_points(DOOR_COST*-1)
		queue_free()
