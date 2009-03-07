class MenuScreen < MimScreen::Base
  def after_render_screen
    center(12, "Murder in Moscow")
    center(16, "( Press a key to begin )")
  end

  def main_loop(screen)
    # wait for a keystroke
    screen.getch 

    PlayScreen.new screen
  end
end
