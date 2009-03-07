class MenuScreen < MimScreen::Base
  attr_accessor :screen

  def after_render_screen
    center(12, "Murder in Moscow")
    center(16, "( Press a key to begin )")
  end

  def main_loop(screen)
    screen.getch # wait for a keystroke
  end

end
