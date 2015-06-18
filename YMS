#=================================================================================
#
#     YMS Yuuta Menu System
#         2015 (C)opyright Yuuta Kirishima
#
#
#=================================================================================

class Scene_Menu < Scene_MenuBase
  def start
    super
    create_menu_background
    create_command_window
    create_gold_window
    create_timer_window
    create_location_window
    create_status_window
  end
  def create_menu_background
    @menu_background = Sprite.new
    @menu_background.bitmap = Cache.system('menu_bg')
  end
  def dispose_menu_background
    @menu_background.bitmap.dispose
    @menu_background.dispose
  end
  def terminate
    super
    dispose_background
    dispose_menu_background
  end
  def create_gold_window
    @gold_window = Window_Gold.new
  end
  def create_timer_window
    @timer_window = Window_Timer.new
  end
  def create_location_window
    @location_window = Window_Location.new
  end
  def create_command_window
    @command_window = Window_MenuCommand.new
    @command_window.set_handler(:item,    method(:command_item))
    @command_window.set_handler(:skill,    method(:command_personal))
    @command_window.set_handler(:equip,    method(:command_personal))
    @command_window.set_handler(:status,    method(:command_personal))
    @command_window.set_handler(:formation,    method(:command_formation))
    @command_window.set_handler(:save,    method(:command_save))
    @command_window.set_handler(:game_end,    method(:command_game_end))

    @command_window.set_handler(:cancel,    method(:return_scene))
  end
  def create_status_window
    @status_window = Window_MenuStatus.new(217, 13)
  end
end
class Window_MenuCommand < Window_Command
  def initialize
    super(29, 105)
    self.opacity = 0 if SceneManager.scene_is?(Scene_Menu)
    select_last
  end
  def window_width
    return 160
  end
  def window_height
    return 192
  end
  def make_command_list
    add_command(Vocab::item,   :item,   main_commands_enabled)
    add_command(Vocab::skill,   :skill,   main_commands_enabled)
    add_command(Vocab::equip,   :equip,   main_commands_enabled)
    add_command(Vocab::status,   :status,   main_commands_enabled)
    add_command(Vocab::formation,   :formation,   formation_enabled)
    add_command(Vocab::save,   :save,   save_enabled)
    add_command(Vocab::game_end,   :game_end)

  end
  def alignment
    return 1
  end
end
class Window_MenuStatus < Window_Selectable
  def initialize(x, y)
    super(x, y, window_width, window_height)
    @pending_index = -1
    self.opacity = 0 if SceneManager.scene_is?(Scene_Menu)
    refresh
  end
  def window_width
    return 384
  end
  def window_height
    return 416
  end
  def item_height
    return (height - standard_padding * 2) / 4
  end
  def draw_item(index)
    actor = $game_party.members[index]
    enabled = $game_party.battle_members.include?(actor)
    rect = item_rect(index)
    draw_item_background(index)
    draw_actor_face(actor, rect.x + 1, rect.y + 1, enabled)
    draw_actor_simple_status(actor, rect.x, rect.y)
  end
  def draw_actor_simple_status(actor, x, y)
    draw_actor_name(actor, x + 108, y + 12)
    draw_actor_level(actor, x + 108, y + 36)
    draw_actor_icons(actor, x + 108, y + 60)
    draw_actor_class(actor, x + 228, y + 12)
    draw_actor_hp(actor, x + 228, y + 36)
    draw_actor_mp(actor, x + 228, y + 60)
  end
  def draw_face(face_name, face_index, x, y, enabled = true)
    bitmap = Cache.face(face_name)
    rect = Rect.new(face_index % 4 * 96, face_index / 4 * 96, 96, 96)
    contents.blt(x, y, bitmap, rect, enabled ? 255 : translucent_alpha)
    bitmap.dispose
  end
  def draw_actor_name(actor, x, y, width = 112)
    change_color(hp_color(actor))
    draw_text(x, y, width, 24, actor.name)
  end
  def draw_actor_level(actor, x, y)
    change_color(system_color)
    draw_text(x, y, 32, line_height, Vocab::level_a)
    change_color(normal_color)
    draw_text(x + 56 - 24, y, 24, 24, actor.level, 2)
  end
  def draw_actor_icons(actor, x, y, width = 96)
    icons = (actor.state_icons + actor.buff_icons)[0, ((24/24)*width)/24]
    icons.each_with_index {|n, i| draw_icon(n, x + 24 * (i % (width / 24)), y + 24 * (i / (width / 24))) }
  end
  def draw_actor_class(actor, x, y, width = 112)
    change_color(normal_color)
    draw_text(x, y, width, 24, actor.class.name)
  end
  def draw_actor_hp(actor, x, y, width = 124)
    draw_gauge(x, y, width, actor.hp_rate, hp_gauge_color1, hp_gauge_color2)
    change_color(system_color)
    draw_text(x, y, 30, line_height, Vocab::hp_a)
    draw_current_and_max_values(x, y, width, actor.hp, actor.mhp,
    hp_color(actor), normal_color)
    end
  def draw_actor_mp(actor, x, y, width = 124)
    draw_gauge(x, y, width, actor.mp_rate, mp_gauge_color1, mp_gauge_color2)
    change_color(system_color)
    draw_text(x, y, 30, line_height, Vocab::mp_a)
    draw_current_and_max_values(x, y, width, actor.mp, actor.mmp,
    mp_color(actor), normal_color)
  end
end
class Window_MenuActor < Window_MenuStatus
  def initialize
    super(0, 0)
    self.visible = false
  end
  def window_height
    Graphics.height
  end
end
class Window_Gold < Window_Base
  def initialize
    super(138, 423, window_width, 48)
    self.opacity = 0 if SceneManager.scene_is?(Scene_Menu)
    refresh
  end
  def window_width
    return 160
  end
  def refresh
    contents.clear
    change_color(system_color)
    draw_text(4, 0, contents_width - 8, line_height, 'Gold')
    cx = text_size(currency_unit).width
    change_color(normal_color)
    draw_text(4, contents_height - line_height, contents.width - 8 - cx - 2, line_height, value, 2)
    change_color(system_color)
    draw_text(4, contents_height - line_height, contents.width - 8, line_height, currency_unit, 2)
  end
end
class Window_Location < Window_Base
  def initialize
    super(476, 420, window_width, 48)
    self.opacity = 0 if SceneManager.scene_is?(Scene_Menu)
    refresh
  end
  def window_width
    return 160
  end
  def refresh
    contents.clear
    change_color(system_color)
    draw_text(4, 0, contents_width - 8, line_height, 'Locate')
    change_color(normal_color)
    draw_text(4, contents_height - line_height, contents_width - 8, line_height, $game_map.display_name, 2)
  end
  def open
    refresh
    super
  end
end
class Window_Timer < Window_Base
  def initialize
    super(307, 422, window_width, 48)
    self.opacity = 0 if SceneManager.scene_is?(Scene_Menu)
    refresh
  end
  def window_width
    return 160
  end
  def refresh
    contents.clear
    change_color(system_color)
    draw_text(4, 0, contents_width - 8, line_height, 'Time')
    change_color(normal_color)
    draw_playtime(4, contents_height - line_height, contents.width - 8, 2)
  end
  def open
    refresh
    super
  end
  def draw_playtime(x, y, width, align)
    draw_text(x, y, width, line_height, $game_system.playtime_s, align)
  end
  def update
    refresh
  end
end

