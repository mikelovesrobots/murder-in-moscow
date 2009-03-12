class Tile
  attr_accessor :lit, :feature
  alias :lit? :lit

  def initialize
    self.lit = false
  end

  def blocked?
    feature.blocked?
  end

  def self.rand
    returning(new) do |tile|
      tile.feature = Feature.rand
    end
  end

  def self.rock_wall
    returning(new) do |tile|
      tile.feature = Feature.rock_wall
    end
  end
    
end

