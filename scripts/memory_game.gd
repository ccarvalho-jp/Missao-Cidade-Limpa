extends Control

signal all_pairs_found

const CATEGORY_IDS := ["plastico", "papel", "metal", "vidro", "organico"]
const CARD_BACK := "res://assets/ui/memory_card_back.svg"
const INK := Color("#173b35")

var cards: Array[Dictionary] = []
var item_pool: Array[Dictionary] = []
var opened_cards: Array[int] = []
var matched_pairs := 0
var total_pairs := 0
var attempts := 0
var locked := false
var status_label: Label
var progress_label: Label


func start_game(items: Array) -> void:
	item_pool.clear()
	for raw_item in items:
		var item: Dictionary = raw_item
		item_pool.append(item.duplicate(true))
	_show_difficulty_select()


func _show_difficulty_select() -> void:
	for child in get_children():
		child.queue_free()
	var background := ColorRect.new()
	background.color = Color("#eaf7ff")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 20)
	margin.add_theme_constant_override("margin_right", 20)
	margin.add_theme_constant_override("margin_top", 24)
	margin.add_theme_constant_override("margin_bottom", 24)
	add_child(margin)
	var layout := VBoxContainer.new()
	layout.alignment = BoxContainer.ALIGNMENT_CENTER
	layout.add_theme_constant_override("separation", 14)
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin.add_child(layout)

	var hero := PanelContainer.new()
	hero.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero.add_theme_stylebox_override("panel", _panel_style(Color("#168eb2"), 20))
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
	hero_text.add_child(_label("MEMÓRIA DO MAR", 22, Color.WHITE, HORIZONTAL_ALIGNMENT_LEFT))
	hero_text.add_child(_label("Escolha um desafio, eu vou jogar com você!", 13, Color("#e5fbff"), HORIZONTAL_ALIGNMENT_LEFT))
	layout.add_child(_label("Quanto mais pares, maior o desafio!", 16, INK, HORIZONTAL_ALIGNMENT_CENTER))

	var easy := _difficulty_button("FÁCIL", 4, Color("#40aa83"))
	easy.pressed.connect(_start_round.bind(4))
	layout.add_child(easy)
	var medium := _difficulty_button("MÉDIO", 8, Color("#348fbd"))
	medium.pressed.connect(_start_round.bind(8))
	layout.add_child(medium)
	var hard := _difficulty_button("DIFÍCIL", 12, Color("#8265b7"))
	hard.pressed.connect(_start_round.bind(12))
	layout.add_child(hard)
	layout.add_child(_label("Sem cronômetro: jogue no seu ritmo!", 14, Color("#41675c"), HORIZONTAL_ALIGNMENT_CENTER))


func _difficulty_button(level: String, pair_count: int, color: Color) -> Button:
	var button := Button.new()
	button.text = "%s    %d PARES  •  %d CARTAS" % [level, pair_count, pair_count * 2]
	button.custom_minimum_size.y = 68
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 18)
	button.add_theme_color_override("font_color", Color.WHITE)
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_stylebox_override("normal", _card_style(color))
	button.add_theme_stylebox_override("hover", _card_style(color.lightened(0.12)))
	button.add_theme_stylebox_override("pressed", _card_style(color.darkened(0.1)))
	button.add_theme_stylebox_override("focus", _card_style(color.lightened(0.12)))
	return button


func _start_round(pair_count: int) -> void:
	var categories := CATEGORY_IDS.duplicate()
	categories.shuffle()
	var chosen_items: Array[Dictionary] = []
	var used_names: Dictionary = {}
	while chosen_items.size() < pair_count:
		var before_count := chosen_items.size()
		for category in categories:
			if chosen_items.size() >= pair_count:
				break
			var candidates := _available_items(category, used_names)
			if candidates.is_empty():
				continue
			candidates.shuffle()
			var item: Dictionary = candidates[0]
			chosen_items.append(item.duplicate(true))
			used_names[item.name] = true
		if chosen_items.size() == before_count:
			break
	_build_board(chosen_items)


func _available_items(category: String, used_names: Dictionary) -> Array[Dictionary]:
	var candidates: Array[Dictionary] = []
	for item in item_pool:
		if item.get("bin", "") == category and not used_names.has(item.get("name", "")):
			candidates.append(item)
	return candidates


func _build_board(chosen_items: Array[Dictionary]) -> void:
	for child in get_children():
		child.queue_free()
	cards.clear()
	opened_cards.clear()
	matched_pairs = 0
	attempts = 0
	locked = false

	var deck: Array[Dictionary] = []
	for item in chosen_items:
		deck.append({"pair_id": item.name, "item": item.duplicate(true)})
		deck.append({"pair_id": item.name, "item": item.duplicate(true)})
	deck.shuffle()
	total_pairs = int(deck.size() / 2)

	var background := ColorRect.new()
	background.color = Color("#eaf7ff")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)

	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)
	add_child(margin)

	var layout := VBoxContainer.new()
	layout.add_theme_constant_override("separation", 8)
	layout.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	margin.add_child(layout)

	var hero := PanelContainer.new()
	hero.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero.add_theme_stylebox_override("panel", _panel_style(Color("#168eb2"), 20))
	layout.add_child(hero)
	var hero_row := HBoxContainer.new()
	hero_row.alignment = BoxContainer.ALIGNMENT_CENTER
	hero_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_row.add_theme_constant_override("separation", 10)
	hero.add_child(hero_row)
	hero_row.add_child(_mascot_icon(82))
	var hero_content := VBoxContainer.new()
	hero_content.add_theme_constant_override("separation", 1)
	hero_content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hero_content.custom_minimum_size.x = 220
	hero_row.add_child(hero_content)
	hero_content.add_child(_label("MEMÓRIA DO MAR", 22, Color.WHITE, HORIZONTAL_ALIGNMENT_LEFT))
	hero_content.add_child(_label("Encontre os pares e descubra uma dica!", 13, Color("#e5fbff"), HORIZONTAL_ALIGNMENT_LEFT))

	progress_label = _label("Pares: 0 de %d  •  Tentativas: 0" % total_pairs, 14, INK, HORIZONTAL_ALIGNMENT_CENTER)
	layout.add_child(progress_label)

	var status_panel := PanelContainer.new()
	status_panel.add_theme_stylebox_override("panel", _panel_style(Color("#fff2cb"), 14))
	status_label = _label("Tuca: vire duas cartas e procure o mesmo resíduo!", 14, INK, HORIZONTAL_ALIGNMENT_CENTER)
	status_label.custom_minimum_size.y = 38
	var status_row := HBoxContainer.new()
	status_row.add_theme_constant_override("separation", 6)
	status_panel.add_child(status_row)
	status_row.add_child(status_label)
	var scroll_up := _scroll_button("↑", "Rolar para cima")
	status_row.add_child(scroll_up)
	var scroll_down := _scroll_button("↓", "Rolar para baixo")
	status_row.add_child(scroll_down)
	layout.add_child(status_panel)

	var board_scroll := ScrollContainer.new()
	board_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	board_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	board_scroll.scroll_deadzone = 18
	layout.add_child(board_scroll)
	scroll_up.pressed.connect(_scroll_memory_board.bind(board_scroll, -1))
	scroll_down.pressed.connect(_scroll_memory_board.bind(board_scroll, 1))
	var board := GridContainer.new()
	board.columns = 4
	board.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	board.add_theme_constant_override("h_separation", 8)
	board.add_theme_constant_override("v_separation", 8)
	board_scroll.add_child(board)

	for index in range(deck.size()):
		var card_data: Dictionary = deck[index]
		var button := Button.new()
		button.custom_minimum_size = Vector2(0, 132)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.text = ""
		button.add_theme_font_size_override("font_size", 32)
		button.add_theme_color_override("font_color", Color.WHITE)
		button.add_theme_stylebox_override("normal", _card_style(Color("#31a7b7")))
		button.add_theme_stylebox_override("hover", _card_style(Color("#49bfca")))
		button.add_theme_stylebox_override("pressed", _card_style(Color("#238c9e")))
		button.add_theme_stylebox_override("focus", _card_style(Color("#49bfca")))
		board.add_child(button)

		var back_icon := TextureRect.new()
		back_icon.texture = load(CARD_BACK) as Texture2D
		back_icon.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		back_icon.offset_left = 12
		back_icon.offset_top = 12
		back_icon.offset_right = -12
		back_icon.offset_bottom = -12
		back_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		back_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		back_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		button.add_child(back_icon)

		var item: Dictionary = card_data.item
		var face_content := VBoxContainer.new()
		face_content.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		face_content.offset_left = 6
		face_content.offset_top = 6
		face_content.offset_right = -6
		face_content.offset_bottom = -6
		face_content.alignment = BoxContainer.ALIGNMENT_CENTER
		face_content.add_theme_constant_override("separation", 2)
		face_content.mouse_filter = Control.MOUSE_FILTER_IGNORE
		face_content.visible = false
		button.add_child(face_content)
		var face_icon := TextureRect.new()
		face_icon.texture = load(item.asset) as Texture2D
		face_icon.custom_minimum_size = Vector2(0, 56)
		face_icon.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		face_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		face_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		face_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
		face_content.add_child(face_icon)
		var face_name := _label(item.name, 14, INK, HORIZONTAL_ALIGNMENT_CENTER)
		face_name.custom_minimum_size.y = 34
		face_name.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		face_content.add_child(face_name)

		cards.append({
			"button": button,
			"back_icon": back_icon,
			"face_content": face_content,
			"item": item,
			"pair_id": card_data.pair_id,
			"matched": false,
		})
		button.pressed.connect(_on_card_pressed.bind(index))


func _scroll_button(glyph: String, description: String) -> Button:
	var button := Button.new()
	button.text = glyph
	button.tooltip_text = description
	button.custom_minimum_size = Vector2(44, 42)
	button.add_theme_font_size_override("font_size", 22)
	button.add_theme_color_override("font_color", Color.WHITE)
	button.add_theme_color_override("font_hover_color", Color.WHITE)
	button.add_theme_stylebox_override("normal", _card_style(Color("#348fbd")))
	button.add_theme_stylebox_override("hover", _card_style(Color("#49a9d0")))
	button.add_theme_stylebox_override("pressed", _card_style(Color("#28789f")))
	return button


func _scroll_memory_board(board_scroll: ScrollContainer, direction: int) -> void:
	var vertical_bar := board_scroll.get_v_scroll_bar()
	var max_scroll := maxf(0.0, vertical_bar.max_value - vertical_bar.page)
	board_scroll.scroll_vertical = clampi(
		board_scroll.scroll_vertical + direction * 140,
		0,
		int(max_scroll)
	)


func _on_card_pressed(index: int) -> void:
	if locked or index < 0 or index >= cards.size():
		return
	var card: Dictionary = cards[index]
	if card.matched or opened_cards.has(index):
		return
	_show_card(index)
	opened_cards.append(index)
	if opened_cards.size() == 2:
		attempts += 1
		_update_progress()
		_check_pair()


func _show_card(index: int) -> void:
	var card: Dictionary = cards[index]
	card.back_icon.visible = false
	card.face_content.visible = true
	card.button.add_theme_stylebox_override("normal", _card_style(Color("#fffdf5")))
	card.button.add_theme_stylebox_override("hover", _card_style(Color("#fffdf5")))
	card.button.add_theme_stylebox_override("pressed", _card_style(Color("#f3f8f4")))


func _hide_card(index: int) -> void:
	var card: Dictionary = cards[index]
	card.face_content.visible = false
	card.back_icon.visible = true
	card.button.add_theme_stylebox_override("normal", _card_style(Color("#31a7b7")))
	card.button.add_theme_stylebox_override("hover", _card_style(Color("#49bfca")))
	card.button.add_theme_stylebox_override("pressed", _card_style(Color("#238c9e")))


func _check_pair() -> void:
	var first_index := opened_cards[0]
	var second_index := opened_cards[1]
	var first: Dictionary = cards[first_index]
	var second: Dictionary = cards[second_index]
	if first.pair_id == second.pair_id:
		first.matched = true
		second.matched = true
		matched_pairs += 1
		status_label.text = "Tuca: par encontrado! %s" % first.item.tip
		status_label.add_theme_color_override("font_color", Color("#20754d"))
		opened_cards.clear()
		_update_progress()
		if matched_pairs == total_pairs:
			status_label.text = "Tuca: você encontrou todos os pares! 🌟"
			get_tree().create_timer(0.65).timeout.connect(func(): all_pairs_found.emit())
	else:
		locked = true
		status_label.text = "Tuca: essas cartas são diferentes. Tente lembrar dos desenhos!"
		status_label.add_theme_color_override("font_color", Color("#a45a31"))
		get_tree().create_timer(0.9).timeout.connect(_turn_back_open_cards)


func _turn_back_open_cards() -> void:
	for index in opened_cards:
		_hide_card(index)
	opened_cards.clear()
	locked = false
	status_label.text = "Tuca: tente outra combinação!"
	status_label.add_theme_color_override("font_color", INK)


func _update_progress() -> void:
	progress_label.text = "Pares: %d de %d  •  Tentativas: %d" % [matched_pairs, total_pairs, attempts]


func _label(text: String, font_size: int, color: Color, alignment: HorizontalAlignment) -> Label:
	var label := Label.new()
	label.text = text
	label.horizontal_alignment = alignment
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", color)
	return label


func _panel_style(color: Color, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.content_margin_left = 8
	style.content_margin_right = 8
	style.content_margin_top = 6
	style.content_margin_bottom = 6
	style.shadow_color = Color(0.08, 0.2, 0.28, 0.10)
	style.shadow_size = 4
	style.shadow_offset = Vector2(0, 2)
	return style


func _mascot_icon(icon_size: int) -> TextureRect:
	var icon := TextureRect.new()
	icon.texture = load("res://assets/ui/turtle_mascot.svg") as Texture2D
	icon.custom_minimum_size = Vector2(icon_size, icon_size)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return icon


func _card_style(color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = Color("#197e91")
	style.set_border_width_all(3)
	style.set_corner_radius_all(16)
	style.shadow_color = Color(0.06, 0.18, 0.25, 0.16)
	style.shadow_size = 5
	style.shadow_offset = Vector2(0, 3)
	return style
