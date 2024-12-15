extends CanvasLayer

@onready var freezebar = $MainNode/VBoxContainer/Freezebar
@onready var healthbar = $MainNode/VBoxContainer/Healthbar

func _ready():
	PlayerData.updated.connect(update_bars_ui)

func update_bars_ui():
	freezebar.value = PlayerData.Freeze
	healthbar.value = PlayerData.Health
