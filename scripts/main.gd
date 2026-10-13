extends Control

# URLs para os QR codes — substitua pelos links reais quando publicar
const APK_DOWNLOAD_URL := "https://github.com/ccarvalho-jp/Missao-Cidade-Limpa/releases/latest/download/MissaoCidadeLimpa.apk"
const WEB_PLAY_URL := "https://missao-cidade-limpa.vercel.app"

const BIN_DATA := [
	{"id": "plastico", "name": "PLÁSTICO", "asset": "res://assets/bins/bin_plastic.svg", "color": Color("#df5358")},
	{"id": "papel", "name": "PAPEL", "asset": "res://assets/bins/bin_paper.svg", "color": Color("#4388df")},
	{"id": "metal", "name": "METAL", "asset": "res://assets/bins/bin_metal.svg", "color": Color("#e9b82e")},
	{"id": "vidro", "name": "VIDRO", "asset": "res://assets/bins/bin_glass.svg", "color": Color("#36a876")},
	{"id": "organico", "name": "ORGÂNICO", "asset": "res://assets/bins/bin_organic.svg", "color": Color("#99633f")},
]
const ITEMS := [
	{"name": "Garrafa PET", "emoji": "🧴", "asset": "res://assets/trash/plastic_bottle.svg", "bin": "plastico", "tip": "Uma garrafa no mar pode machucar animais."},
	{"name": "Sacola plástica", "emoji": "🛍️", "asset": "res://assets/trash/plastic_bag.svg", "bin": "plastico", "tip": "Sacolas podem parecer comida para tartarugas."},
	{"name": "Jornal", "emoji": "📰", "asset": "res://assets/trash/paper_newspaper.svg", "bin": "papel", "tip": "Papel limpo pode virar papel novo."},
	{"name": "Caixa de papelão", "emoji": "📦", "asset": "res://assets/trash/paper_cardboard_box.svg", "bin": "papel", "tip": "Caixas limpas podem ser recicladas."},
	{"name": "Lata de refrigerante", "emoji": "🥫", "asset": "res://assets/trash/metal_soda_can.svg", "bin": "metal", "tip": "Reciclar metal economiza recursos naturais."},
	{"name": "Lata de sardinha", "emoji": "🥫", "asset": "res://assets/trash/metal_food_can.svg", "bin": "metal", "tip": "Latas no chão podem machucar os animais."},
	{"name": "Pote de vidro", "emoji": "🫙", "asset": "res://assets/trash/glass_jar.svg", "bin": "vidro", "tip": "Vidro pode ser reciclado muitas vezes."},
	{"name": "Garrafa de vidro", "emoji": "🍾", "asset": "res://assets/trash/glass_bottle.svg", "bin": "vidro", "tip": "Vidro na praia pode machucar alguém."},
	{"name": "Casca de banana", "emoji": "🍌", "asset": "res://assets/trash/organic_banana_peel.svg", "bin": "organico", "tip": "Restos de fruta podem virar adubo."},
	{"name": "Restos de fruta", "emoji": "🍎", "asset": "res://assets/trash/organic_apple_core.svg", "bin": "organico", "tip": "Casca de fruta também é resíduo orgânico."},
	{"name": "Frasco de xampu", "emoji": "🧴", "asset": "res://assets/trash/shampoo_bottle.svg", "bin": "plastico", "tip": "Frascos plásticos podem ganhar uma nova vida."},
	{"name": "Pote de iogurte", "emoji": "🥣", "asset": "res://assets/trash/yogurt_cup.svg", "bin": "plastico", "tip": "Esvazie a embalagem antes de reciclar."},
	{"name": "Frasco de detergente", "emoji": "🧼", "asset": "res://assets/trash/detergent_bottle.svg", "bin": "plastico", "tip": "Uma embalagem limpa pode ser reciclada."},
	{"name": "Balde plástico", "emoji": "🪣", "asset": "res://assets/trash/plastic_bucket.svg", "bin": "plastico", "tip": "Plástico separado ajuda a cuidar do mar."},
	{"name": "Sacola de papel", "emoji": "🛍️", "asset": "res://assets/trash/paper_bag.svg", "bin": "papel", "tip": "Papel seco é mais fácil de reciclar."},
	{"name": "Caixa de cereal", "emoji": "📦", "asset": "res://assets/trash/cereal_box.svg", "bin": "papel", "tip": "Caixas de papel podem virar outras coisas."},
	{"name": "Caderno usado", "emoji": "📒", "asset": "res://assets/trash/notebook.svg", "bin": "papel", "tip": "Recicle as folhas quando não precisar mais."},
	{"name": "Copo de papel", "emoji": "🥤", "asset": "res://assets/trash/paper_cup.svg", "bin": "papel", "tip": "Prefira copos reutilizáveis sempre que puder."},
	{"name": "Bandeja de alumínio", "emoji": "🍱", "asset": "res://assets/trash/aluminum_tray.svg", "bin": "metal", "tip": "O alumínio pode ser reciclado muitas vezes."},
	{"name": "Tampa de metal", "emoji": "🫙", "asset": "res://assets/trash/metal_lid.svg", "bin": "metal", "tip": "Tampinhas também devem ir para a coleta."},
	{"name": "Lata de conserva", "emoji": "🥫", "asset": "res://assets/trash/food_tin.svg", "bin": "metal", "tip": "Latas limpas podem voltar para a reciclagem."},
	{"name": "Papel-alumínio limpo", "emoji": "✨", "asset": "res://assets/trash/clean_foil.svg", "bin": "metal", "tip": "Metal separado não precisa ir para o lixo comum."},
	{"name": "Pote de geleia", "emoji": "🍯", "asset": "res://assets/trash/jam_jar.svg", "bin": "vidro", "tip": "Lembre de pedir ajuda para um adulto com vidro."},
	{"name": "Copo de vidro", "emoji": "🥛", "asset": "res://assets/trash/glass_cup.svg", "bin": "vidro", "tip": "Vidro quebrado deve ser cuidado por um adulto."},
	{"name": "Garrafa de molho", "emoji": "🫙", "asset": "res://assets/trash/sauce_bottle.svg", "bin": "vidro", "tip": "Garrafas de vidro podem ser recicladas."},
	{"name": "Pote de vidro", "emoji": "🏺", "asset": "res://assets/trash/glass_container.svg", "bin": "vidro", "tip": "O vidro certo vai para a lixeira verde."},
	{"name": "Casca de laranja", "emoji": "🍊", "asset": "res://assets/trash/orange_peel.svg", "bin": "organico", "tip": "Cascas podem virar adubo para as plantas."},
	{"name": "Maçã", "emoji": "🍎", "asset": "res://assets/trash/apple.svg", "bin": "organico", "tip": "Comida que sobrou é resíduo orgânico."},
	{"name": "Folhas de alface", "emoji": "🥬", "asset": "res://assets/trash/lettuce_leaves.svg", "bin": "organico", "tip": "Restos de verduras também podem virar adubo."},
	{"name": "Casca de ovo", "emoji": "🥚", "asset": "res://assets/trash/eggshell.svg", "bin": "organico", "tip": "Cascas de ovo são resíduos orgânicos."},
]

const INK := Color("#173b35")
const ITEMS_PER_ROUND := 10
const MEMORY_GAME_SCRIPT := preload("res://scripts/memory_game.gd")
var remaining: Array[Dictionary] = []
var bin_controls: Dictionary = {}
var item_controls: Array[Control] = []
var status_label: Label
var progress_label: Label
var progress_bar: ProgressBar
var items_grid: GridContainer
var dragged_index := -1
var drag_origin := Vector2.ZERO
var drag_ghost: PanelContainer
var sound_player: AudioStreamPlayer
var completed := 0
var round_total := 0


func _ready() -> void:
	sound_player = AudioStreamPlayer.new()
	add_child(sound_player)
	_build_share_screen()


func _build_game() -> void:
	for child in get_children():
		if child != sound_player:
			child.queue_free()
	remaining.clear()
	var per_category := int(ceil(float(ITEMS_PER_ROUND) / BIN_DATA.size()))
	for bin in BIN_DATA:
		var category_items: Array[Dictionary] = []
		for item in ITEMS:
			var item_data: Dictionary = item
			if item_data.bin == bin.id:
				category_items.append(item_data)
		category_items.shuffle()
		for i in range(min(per_category, category_items.size())):
			remaining.append(category_items[i].duplicate(true))
	remaining.shuffle()
	round_total = remaining.size()
	completed = 0
	bin_controls.clear()
	item_controls.clear()
	dragged_index = -1

	var background := ColorRect.new()
	background.color = Color("#eaf7ff")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 18)
	margin.add_theme_constant_override("margin_right", 18)
	margin.add_theme_constant_override("margin_top", 18)
	margin.add_theme_constant_override("margin_bottom", 16)
	add_child(margin)
	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin.add_child(layout)

	var hero := PanelContainer.new()
	hero.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	var hero_style := _panel_style(Color("#168eb2"), 20)
	hero_style.shadow_size = 5
	hero.add_theme_stylebox_override("panel", hero_style)
	layout.add_child(hero)
	var hero_row := HBoxContainer.new()
	hero_row.alignment = BoxContainer.ALIGNMENT_CENTER
	hero_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_row.add_theme_constant_override("separation", 10)
	hero.add_child(hero_row)
	hero_row.add_child(_mascot_icon(82))
	var hero_text := VBoxContainer.new()
	hero_text.add_theme_constant_override("separation", 2)
	hero_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_text.custom_minimum_size.x = 220
	hero_row.add_child(hero_text)
	hero_text.add_child(_label("MISSÃO PRAIA LIMPA", 22, Color.WHITE, HORIZONTAL_ALIGNMENT_LEFT))
	hero_text.add_child(_label("Oi! Eu sou a Tuca, sua parceira.\nVamos cuidar do oceano!", 13, Color("#e5fbff"), HORIZONTAL_ALIGNMENT_LEFT))
	progress_label = _label("0 de %d itens separados" % round_total, 15, INK, HORIZONTAL_ALIGNMENT_CENTER)
	layout.add_child(progress_label)
	progress_bar = ProgressBar.new()
	progress_bar.max_value = round_total
	progress_bar.value = 0
	progress_bar.show_percentage = false
	progress_bar.custom_minimum_size.y = 16
	var progress_fill := StyleBoxFlat.new()
	progress_fill.bg_color = Color("#23a878")
	progress_fill.set_corner_radius_all(8)
	var progress_track := StyleBoxFlat.new()
	progress_track.bg_color = Color("#cfe6e1")
	progress_track.set_corner_radius_all(8)
	progress_bar.add_theme_stylebox_override("fill", progress_fill)
	progress_bar.add_theme_stylebox_override("background", progress_track)
	layout.add_child(progress_bar)
	layout.add_child(_label("LEVE CADA ITEM ATÉ A LIXEIRA CERTA", 13, Color("#41675c"), HORIZONTAL_ALIGNMENT_CENTER))

	var bins_grid := GridContainer.new()
	bins_grid.columns = 3
	bins_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bins_grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	bins_grid.add_theme_constant_override("h_separation", 7)
	bins_grid.add_theme_constant_override("v_separation", 7)
	layout.add_child(bins_grid)
	for bin in BIN_DATA:
		var bin_box := PanelContainer.new()
		bin_box.custom_minimum_size = Vector2(0, 70)
		bin_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var bin_style := _panel_style(Color("#f8fdff"), 17)
		bin_style.border_color = bin.color
		bin_style.set_border_width_all(3)
		bin_box.add_theme_stylebox_override("panel", bin_style)
		bins_grid.add_child(bin_box)
		bin_controls[bin.id] = bin_box
		var bin_row := HBoxContainer.new()
		bin_row.alignment = BoxContainer.ALIGNMENT_CENTER
		bin_row.add_theme_constant_override("separation", 4)
		bin_row.mouse_filter = Control.MOUSE_FILTER_IGNORE
		bin_box.add_child(bin_row)
		bin_row.add_child(_bin_icon(bin, 44))
		var bin_text := _label(bin.name, 13, INK, HORIZONTAL_ALIGNMENT_CENTER)
		bin_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		bin_text.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		bin_text.mouse_filter = Control.MOUSE_FILTER_IGNORE
		bin_row.add_child(bin_text)

	var status_panel := PanelContainer.new()
	status_panel.add_theme_stylebox_override("panel", _panel_style(Color("#fff2cb"), 14))
	layout.add_child(status_panel)
	status_label = _label("Tuca: toque e arraste um item para começar!", 14, INK, HORIZONTAL_ALIGNMENT_CENTER)
	status_label.custom_minimum_size.y = 48
	status_panel.add_child(status_label)
	layout.add_child(_label("RESÍDUOS", 14, INK, HORIZONTAL_ALIGNMENT_CENTER))
	items_grid = GridContainer.new()
	items_grid.columns = 2
	items_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	items_grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	items_grid.add_theme_constant_override("h_separation", 8)
	items_grid.add_theme_constant_override("v_separation", 7)
	layout.add_child(items_grid)
	_refresh_items(items_grid)


func _refresh_items(grid: GridContainer) -> void:
	for child in grid.get_children():
		child.queue_free()
	item_controls.clear()
	for i in range(remaining.size()):
		var item: Dictionary = remaining[i]
		var card := PanelContainer.new()
		card.custom_minimum_size = Vector2(0, 58)
		card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		var card_style := _panel_style(Color.WHITE, 14)
		card_style.border_color = Color("#d8e9ec")
		card_style.set_border_width_all(1)
		card_style.shadow_size = 3
		card.add_theme_stylebox_override("panel", card_style)
		grid.add_child(card)
		item_controls.append(card)
		var row := HBoxContainer.new()
		row.alignment = BoxContainer.ALIGNMENT_CENTER
		row.add_theme_constant_override("separation", 5)
		row.mouse_filter = Control.MOUSE_FILTER_IGNORE
		card.add_child(row)
		row.add_child(_item_icon(item, 38))
		var text := _label(item.name, 14, INK, HORIZONTAL_ALIGNMENT_CENTER)
		text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		text.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		text.mouse_filter = Control.MOUSE_FILTER_IGNORE
		row.add_child(text)
		card.set_meta("item_index", i)


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			_begin_drag(event.position)
		else:
			_end_drag(event.position)
	elif event is InputEventScreenDrag:
		_move_drag(event.position)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_begin_drag(event.position)
		else:
			_end_drag(event.position)
	elif event is InputEventMouseMotion and dragged_index >= 0:
		_move_drag(event.position)


func _begin_drag(position: Vector2) -> void:
	if dragged_index >= 0 or remaining.is_empty():
		return
	for i in range(item_controls.size()):
		if is_instance_valid(item_controls[i]) and item_controls[i].get_global_rect().has_point(position):
			dragged_index = i
			drag_origin = position
			var item: Dictionary = remaining[i]
			drag_ghost = PanelContainer.new()
			drag_ghost.custom_minimum_size = Vector2(76, 76)
			var ghost_style := _panel_style(Color("#fffdf5"), 20)
			ghost_style.shadow_size = 6
			drag_ghost.add_theme_stylebox_override("panel", ghost_style)
			drag_ghost.add_child(_item_icon(item, 60))
			drag_ghost.position = position - Vector2(38, 38)
			drag_ghost.z_index = 10
			drag_ghost.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(drag_ghost)
			item_controls[i].modulate = Color(1, 1, 1, 0.35)
			status_label.text = "Solte na lixeira correta!"
			status_label.add_theme_color_override("font_color", INK)
			return


func _move_drag(position: Vector2) -> void:
	if dragged_index < 0 or not is_instance_valid(drag_ghost):
		return
	drag_ghost.position = position - Vector2(38, 38)
	for id in bin_controls:
		var bin: Control = bin_controls[id]
		bin.modulate = Color(1.12, 1.12, 1.12) if bin.get_global_rect().has_point(position) else Color.WHITE


func _end_drag(position: Vector2) -> void:
	if dragged_index < 0:
		return
	var target_id := ""
	for id in bin_controls:
		var bin: Control = bin_controls[id]
		if bin.get_global_rect().has_point(position):
			target_id = id
			break
	var item: Dictionary = remaining[dragged_index]
	if target_id != "" and target_id == item.bin:
		remaining.remove_at(dragged_index)
		completed += 1
		status_label.text = "Tuca: muito bem! %s vai na lixeira %s! 🌟\n%s" % [item.name, _bin_name(target_id), item.tip]
		status_label.add_theme_color_override("font_color", Color("#20754d"))
		_play_feedback_tone(true)
		progress_bar.value = completed
		progress_label.text = "%d de %d itens separados" % [completed, round_total]
		if completed == round_total:
			_show_completion()
		else:
			_refresh_items(items_grid)
	elif target_id != "":
		status_label.text = "Tuca dá uma dica: %s vai na lixeira %s. Vamos tentar?" % [item.name, _bin_name(item.bin)]
		status_label.add_theme_color_override("font_color", Color("#b3473f"))
		_play_feedback_tone(false)
		if dragged_index < item_controls.size():
			item_controls[dragged_index].modulate = Color.WHITE
	else:
		status_label.text = "Tuca: tudo bem! Tente arrastar de novo."
		status_label.add_theme_color_override("font_color", INK)
		if dragged_index < item_controls.size():
			item_controls[dragged_index].modulate = Color.WHITE
	for id in bin_controls:
		bin_controls[id].modulate = Color.WHITE
	if is_instance_valid(drag_ghost):
		drag_ghost.queue_free()
	drag_ghost = null
	dragged_index = -1


func _show_completion() -> void:
	var overlay := ColorRect.new()
	overlay.color = Color(0.08, 0.2, 0.16, 0.82)
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.z_index = 20
	add_child(overlay)
	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	center.z_index = 21
	add_child(center)
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(340, 300)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#f7fff9"), 24))
	center.add_child(panel)
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 16)
	panel.add_child(content)
	content.add_child(_label("🌊 PARABÉNS! 🌊", 26, INK, HORIZONTAL_ALIGNMENT_CENTER))
	content.add_child(_label("Você passou para a fase de conscientização!", 17, INK, HORIZONTAL_ALIGNMENT_CENTER))
	var next_phase := Button.new()
	next_phase.text = "JOGAR MEMÓRIA"
	next_phase.custom_minimum_size.y = 54
	next_phase.add_theme_font_size_override("font_size", 18)
	next_phase.pressed.connect(_start_memory_phase)
	content.add_child(next_phase)
	var again := Button.new()
	again.text = "REFAZER FASE 1"
	again.custom_minimum_size.y = 46
	again.add_theme_font_size_override("font_size", 16)
	again.pressed.connect(_build_game)
	content.add_child(again)


func _start_memory_phase() -> void:
	for child in get_children():
		if child != sound_player:
			child.queue_free()
	var memory_game: Control = MEMORY_GAME_SCRIPT.new()
	memory_game.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	memory_game.connect("all_pairs_found", _show_memory_completion)
	add_child(memory_game)
	memory_game.call("start_game", ITEMS)


func _show_memory_completion() -> void:
	var overlay := ColorRect.new()
	overlay.color = Color(0.08, 0.2, 0.16, 0.82)
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.z_index = 20
	add_child(overlay)
	var center := CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	center.z_index = 21
	add_child(center)
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(340, 300)
	panel.add_theme_stylebox_override("panel", _panel_style(Color("#f7fff9"), 24))
	center.add_child(panel)
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 14)
	panel.add_child(content)
	content.add_child(_label("🐢 VOCÊ CONSEGUIU! 🐢", 24, INK, HORIZONTAL_ALIGNMENT_CENTER))
	content.add_child(_label("Encontrou todos os pares e aprendeu a cuidar do mar!", 16, INK, HORIZONTAL_ALIGNMENT_CENTER))
	var replay := Button.new()
	replay.text = "JOGAR MEMÓRIA DE NOVO"
	replay.custom_minimum_size.y = 52
	replay.add_theme_font_size_override("font_size", 16)
	replay.pressed.connect(_start_memory_phase)
	content.add_child(replay)
	var restart := Button.new()
	restart.text = "RECOMEÇAR DESDE A FASE 1"
	restart.custom_minimum_size.y = 48
	restart.add_theme_font_size_override("font_size", 15)
	restart.pressed.connect(_build_game)
	content.add_child(restart)


func _label(text: String, font_size: int, color: Color, alignment: HorizontalAlignment) -> Label:
	var label := Label.new()
	label.text = text
	label.horizontal_alignment = alignment
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return label


func _item_icon(item: Dictionary, icon_size: int) -> TextureRect:
	var icon := TextureRect.new()
	icon.texture = load(item.asset) as Texture2D
	icon.custom_minimum_size = Vector2(icon_size, icon_size)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return icon


func _bin_icon(bin: Dictionary, icon_size: int) -> TextureRect:
	var icon := TextureRect.new()
	icon.texture = load(bin.asset) as Texture2D
	icon.custom_minimum_size = Vector2(icon_size, icon_size)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return icon


func _mascot_icon(icon_size: int) -> TextureRect:
	var icon := TextureRect.new()
	icon.texture = load("res://assets/ui/turtle_mascot.svg") as Texture2D
	icon.custom_minimum_size = Vector2(icon_size, icon_size)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return icon


func _bin_name(bin_id: String) -> String:
	for bin in BIN_DATA:
		if bin.id == bin_id:
			return bin.name.to_lower()
	return "correta"


func _play_feedback_tone(correct: bool) -> void:
	var sample_rate := 22050
	var duration := 0.14
	var sample_count := int(sample_rate * duration)
	var wave := AudioStreamWAV.new()
	wave.format = AudioStreamWAV.FORMAT_16_BITS
	wave.mix_rate = sample_rate
	wave.stereo = false
	var samples := PackedByteArray()
	samples.resize(sample_count * 2)
	var frequency := 740.0 if correct else 260.0
	for i in range(sample_count):
		var progress := float(i) / sample_count
		var envelope := 1.0 - progress
		var value := sin(TAU * frequency * float(i) / sample_rate) * envelope * 0.22
		samples.encode_s16(i * 2, int(value * 32767.0))
	wave.data = samples
	sound_player.stream = wave
	sound_player.play()


func _build_share_screen() -> void:
	for child in get_children():
		if child != sound_player:
			child.queue_free()

	var background := ColorRect.new()
	background.color = Color("#eaf7ff")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 24)
	margin.add_theme_constant_override("margin_right", 24)
	margin.add_theme_constant_override("margin_top", 32)
	margin.add_theme_constant_override("margin_bottom", 32)
	add_child(margin)

	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 20)
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	layout.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin.add_child(layout)

	var hero := PanelContainer.new()
	hero.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero.add_theme_stylebox_override("panel", _panel_style(Color("#168eb2"), 24))
	layout.add_child(hero)
	var hero_row := HBoxContainer.new()
	hero_row.alignment = BoxContainer.ALIGNMENT_CENTER
	hero_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_row.add_theme_constant_override("separation", 10)
	hero.add_child(hero_row)
	hero_row.add_child(_mascot_icon(82))
	var hero_text := VBoxContainer.new()
	hero_text.add_theme_constant_override("separation", 2)
	hero_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_text.custom_minimum_size.x = 220
	hero_row.add_child(hero_text)
	hero_text.add_child(_label("MISSÃO CIDADE LIMPA", 22, Color.WHITE, HORIZONTAL_ALIGNMENT_LEFT))
	hero_text.add_child(_label("Oi! Eu sou a Tuca. Compartilhe o jogo com os amigos!", 13, Color("#e5fbff"), HORIZONTAL_ALIGNMENT_LEFT))

	layout.add_child(_label("Escolha como jogar ou compartilhar:", 16, INK, HORIZONTAL_ALIGNMENT_CENTER))

	var cards_container := HBoxContainer.new()
	cards_container.alignment = BoxContainer.ALIGNMENT_CENTER
	cards_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	cards_container.add_theme_constant_override("separation", 16)
	layout.add_child(cards_container)

	_add_share_card(cards_container, "📱", "BAIXAR APK", "Instale no seu Android\ne jogue offline", APK_DOWNLOAD_URL, Color("#4388df"))
	_add_share_card(cards_container, "🌐", "JOGAR NA WEB", "Abra no navegador\nsem instalar nada", WEB_PLAY_URL, Color("#36a876"))

	var start_btn := Button.new()
	start_btn.text = "COMEÇAR AGORA"
	start_btn.custom_minimum_size.y = 56
	start_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	start_btn.add_theme_font_size_override("font_size", 18)
	start_btn.add_theme_color_override("font_color", Color.WHITE)
	start_btn.add_theme_stylebox_override("normal", _panel_style(Color("#168eb2"), 18))
	start_btn.add_theme_stylebox_override("hover", _panel_style(Color("#1fa3cb"), 18))
	start_btn.add_theme_stylebox_override("pressed", _panel_style(Color("#127a9e"), 18))
	start_btn.pressed.connect(_build_game)
	layout.add_child(start_btn)


func _add_share_card(parent: HBoxContainer, icon: String, title: String, description: String, url: String, color: Color) -> void:
	var card := PanelContainer.new()
	card.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card.size_flags_vertical = Control.SIZE_EXPAND_FILL
	card.custom_minimum_size = Vector2(0, 340)
	card.add_theme_stylebox_override("panel", _panel_style(Color("#f8fdff"), 20))
	var card_border := StyleBoxFlat.new()
	card_border.bg_color = Color("#f8fdff")
	card_border.corner_radius_top_left = 20
	card_border.corner_radius_top_right = 20
	card_border.corner_radius_bottom_left = 20
	card_border.corner_radius_bottom_right = 20
	card_border.border_color = color
	card_border.set_border_width_all(3)
	card.add_theme_stylebox_override("panel", card_border)
	parent.add_child(card)

	var card_layout := VBoxContainer.new()
	card_layout.alignment = BoxContainer.ALIGNMENT_CENTER
	card_layout.add_theme_constant_override("separation", 10)
	card_layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	card_layout.size_flags_vertical = Control.SIZE_EXPAND_FILL
	card.add_child(card_layout)

	card_layout.add_child(_label(icon, 48, color, HORIZONTAL_ALIGNMENT_CENTER))
	card_layout.add_child(_label(title, 20, INK, HORIZONTAL_ALIGNMENT_CENTER))
	card_layout.add_child(_label(description, 13, Color("#41675c"), HORIZONTAL_ALIGNMENT_CENTER))

	var qr_rect := TextureRect.new()
	qr_rect.custom_minimum_size = Vector2(180, 180)
	qr_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	qr_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	qr_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	card_layout.add_child(qr_rect)
	_load_qr_code_async(qr_rect, url)

	card_layout.add_child(_label("Aponte a câmera ou toque para copiar", 11, Color("#7a9aa0"), HORIZONTAL_ALIGNMENT_CENTER))

	var copy_btn := Button.new()
	copy_btn.text = "Copiar link"
	copy_btn.custom_minimum_size.y = 40
	copy_btn.add_theme_font_size_override("font_size", 13)
	copy_btn.add_theme_color_override("font_color", Color.WHITE)
	copy_btn.add_theme_stylebox_override("normal", _panel_style(color, 12))
	copy_btn.add_theme_stylebox_override("hover", _panel_style(color.lightened(0.15), 12))
	copy_btn.add_theme_stylebox_override("pressed", _panel_style(color.darkened(0.1), 12))
	copy_btn.pressed.connect(_copy_to_clipboard.bind(url))
	card_layout.add_child(copy_btn)


func _load_qr_code_async(qr_rect: TextureRect, url: String) -> void:
	var http := HTTPRequest.new()
	add_child(http)
	var qr_url := "https://api.qrserver.com/v1/create-qr-code/?size=300x300&margin=10&data=" + url.uri_encode()
	http.request_completed.connect(_on_qr_loaded.bind(qr_rect))
	http.request(qr_url)


func _on_qr_loaded(qr_rect: TextureRect, result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200 and body.size() > 0:
		var img := Image.create_from_data(body.size(), body.size(), false, Image.FORMAT_RGBA8, body)
		if img:
			var tex := ImageTexture.create_from_image(img)
			qr_rect.texture = tex


func _copy_to_clipboard(text: String) -> void:
	DisplayServer.clipboard_set(text)
	status_label.text = "Link copiado! 📋"
	status_label.add_theme_color_override("font_color", Color("#20754d"))
	get_tree().create_timer(2.0).timeout.connect(func():
		if is_instance_valid(status_label):
			status_label.text = "Tuca: toque e arraste um item para começar!"
			status_label.add_theme_color_override("font_color", INK)
	)


func _panel_style(color: Color, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.content_margin_left = 8
	style.content_margin_right = 8
	style.content_margin_top = 5
	style.content_margin_bottom = 5
	return style
