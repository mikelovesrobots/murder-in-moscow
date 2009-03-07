module MimScreen
  module TextFormatting
    def center(row, text)
      start_col = ((cols) - text.size) / 2
      @screen.mvaddstr row, start_col, text
    end
    
    def right_justify row, text
      @screen.mvprintw row, 0, "%#{cols}s", text
    end

    def left_justify row, text
      @screen.mvprintw row, 0, "%-#{cols}s", text
    end
  end
end
