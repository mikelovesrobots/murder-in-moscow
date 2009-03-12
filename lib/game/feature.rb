class Feature
  attr_accessor :icon, :name, :blocked
  alias :blocked? :blocked

  def initialize(attributes={})
    attributes.each do |attr, value|
      instance_variable_set("@#{attr}", value)
    end
  end

  def self.rand
    grass = { :icon => Icon.grass, :blocked => false }
    rock_wall = { :icon => Icon.rock_wall, :blocked => true }

    new [grass, grass, grass, grass, grass, rock_wall].rand
  end

  def self.rock_wall
    new :icon => Icon.rock_wall, :blocked => true 
  end
end
