"""
A Path2D and PathFollow2D which trends can follow to demonstrate activity over time.

It's possible a line2D is better suited for this, but whatever. (time pressure)
"""


extends Path2D

var current_week : int = 0
var trend_name: String
var trend : Gene



var color : Color

func _ready():
	#set_temporal_position(0)
	call_deferred("start")

func start(gene_node):
	set_random_color()
	trend = gene_node
	trend_name = gene_node.name
	populate_curve(Game.week)

func set_random_color():
	var colors : Array = [
		Color.red,
		Color.blueviolet,
		Color.purple,
		Color.greenyellow,
		Color.antiquewhite,
		Color.bisque,
		Color.aliceblue

	]
	color = colors[randi()%colors.size()]


func populate_curve(weeks):
	for week in range(weeks):
		var horizontal_spacing : int = 100
		curve.add_point(Vector2(week * horizontal_spacing, trend.get_temporal_value(week)))

func set_temporal_position(week):
	# set the offset of the path follower
	$PathFollow2D.set_unit_offset(float(week/Game.week)) # not exact, but close enough





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()



func advance():
	current_week = min(current_week+1, Game.week)

func _draw():
	var point : Vector2 = Vector2.ZERO
	var last_point : Vector2 = Vector2.ZERO

	for point_num in curve.get_point_count():
		point = curve.get_point_position(point_num)
		if point_num > 0:
			last_point = curve.get_point_position(point_num-1)
		draw_line(last_point, point, color, 1, true)
		last_point = point





