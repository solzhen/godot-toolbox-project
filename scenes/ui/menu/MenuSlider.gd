tool
extends HBoxContainer

#############################################################
# SIGNALS
signal slider_changed(value)

#############################################################
# NODES
onready var label:Label = $Label
onready var slider:HSlider = $HSlider

#############################################################
# CUSTOMIZATION
export(String) var caption = "None"
export(String) var persistence_uid_path = "none"

export(int) var value_min = 0
export(int) var value_max = 100
export(int) var value_step = 5

# Determines wether to put initial focus on this button
export(bool) var grabs_focus = false

#############################################################
# LIFECYCLE
func _ready():
	label.text = caption

	slider.min_value = int(value_min)
	slider.max_value = int(value_max)
	slider.step = int(value_step)
	slider.value = PersistenceMngr.get_val_from_ui_path(persistence_uid_path)
	
	if grabs_focus:
		slider.grab_focus()

#############################################################
# CALLBACKS	
func _on_HSlider_value_changed(value):
	PersistenceMngr.set_val_from_ui_path(persistence_uid_path, value)
	emit_signal("slider_changed", slider.value)
