class_name two_button_toggler
extends Node


func toggle(a:Button,b:Button):
	if a.has_focus():
		b.grab_focus()
	elif b.has_focus():
		a.grab_focus()
	else:
		a.grab_focus()
