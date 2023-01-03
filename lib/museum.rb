class Museum
  attr_reader :name, :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits.push(exhibit)
  end

  def recommend_exhibits(patron)
    patron.interests.flat_map do |interest|
      exhibits.select do |exhibit|
        exhibit.name == interest
      end
    end
  end
end