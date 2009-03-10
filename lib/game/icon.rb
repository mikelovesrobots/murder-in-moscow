class Icon
  attr_accessor :color, :char, :bold

  def initialize(attributes={})
    attributes.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end
  
  def self.grass
    new(
      :bold => false,
      :color => Ncurses.COLOR_PAIR(2),
      :char => ?.
    )
  end

  def self.rock_wall
    new(
      :bold => false,
      :color => Ncurses.COLOR_PAIR(1),
      :char => ?#
    )
  end 
end

