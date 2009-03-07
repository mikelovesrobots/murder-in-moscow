class MenuScreen < MimScreen::Base
  attr_accessor :screen

  def after_render_screen
    center(10, "Murder in Moscow")
  end

  def main_loop(screen)
    screen.getch # wait for a keystroke
  end

end
