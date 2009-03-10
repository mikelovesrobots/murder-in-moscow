class Feature
  attr_accessor :icon, :name, :blocked
  alias :blocked? :blocked

  def self.rand
    returning(new) do |feature|
      feature.name = "Grass"
      feature.icon = Icon.rand
      feature.blocked = [true, false, false, false, false].rand
    end
  end
end
