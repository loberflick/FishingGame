extends Node


var db : SQLite

func _ready():
	var dir = DirAccess.open("res://")
	dir.copy("res://Fish/fish.db", "user://fish.db")

func find_fish():
	db = SQLite.new()
	db.path = "user://fish.db"
	db.open_db()
	var select = db.select_rows("Fishes", "" ,["*"] )
	var rand_select = randi_range(0,len(select)-1)
	return select[rand_select]

