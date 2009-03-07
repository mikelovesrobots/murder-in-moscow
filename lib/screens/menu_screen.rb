class MenuScreen < MimScreen::Base
  def main_loop(screen)
    screen.getch # wait for a keystroke
  end
end
