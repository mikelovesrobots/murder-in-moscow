class Icon
  attr_accessor :color, :char, :bold

  def self.rand
    returning(new) do |icon|
      icon.bold = false
      icon.color = Ncurses.COLOR_PAIR(1)
      icon.char = ?.
    end
  end
end

