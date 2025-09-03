extends CanvasLayer

@onready var panel = $Panel
@onready var main_menu = $Panel/VBoxContainer/MainMenu
@onready var settings_menu = $Panel/VBoxContainer/SettingsMenu

@onready var resume_button: Button = $Panel/VBoxContainer/MainMenu/Resume
@onready var reset_button: Button = $Panel/VBoxContainer/MainMenu/Reset
@onready var settings_button: Button = $Panel/VBoxContainer/MainMenu/Settings
@onready var quit_button: Button = $Panel/VBoxContainer/MainMenu/Quit

@onready var volume_slider: HSlider = $Panel/VBoxContainer/SettingsMenu/Audio/MasterVolume
@onready var back_button: Button = $Panel/VBoxContainer/SettingsMenu/Back



func _ready():
	panel.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS  # allow UI when paused

	# Connect signals
	resume_button.pressed.connect(_on_resume_pressed)
	reset_button.pressed.connect(_on_reset_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	back_button.pressed.connect(_on_back_pressed)
	volume_slider.value_changed.connect(_on_volume_changed)

	# Initialize volume slider
	var master_index = AudioServer.get_bus_index("Master")
	var current_db = AudioServer.get_bus_volume_db(master_index)
	volume_slider.value = db_to_linear(current_db)

	# Show main menu first
	_show_main_menu()

func _unhandled_input(event):
	if event.is_action_pressed("pause"): # P
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		panel.visible = false
	else:
		get_tree().paused = true
		panel.visible = true
		_show_main_menu()

# --- Button handlers ---
func _on_resume_pressed():
	toggle_pause()

func _on_reset_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_settings_pressed():
	_show_settings_menu()

func _on_quit_pressed():
	get_tree().quit()

func _on_back_pressed():
	_show_main_menu()

func _on_volume_changed(value: float):
	var master_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_index, linear_to_db(value))

# --- Helpers ---
func _show_main_menu():
	main_menu.visible = true
	settings_menu.visible = false

func _show_settings_menu():
	main_menu.visible = false
	settings_menu.visible = true
