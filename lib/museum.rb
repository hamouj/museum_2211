class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
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

  def admit(patron)
    patrons.push(patron)
  end

  def patrons_by_exhibit_interest
    hash = Hash.new {|hash, key| hash[key] = []}
    exhibits.each do |exhibit|
      patrons.each do |patron|
        patron.interests.each do |interest|
          hash[exhibit] << patron if interest == exhibit.name
            if hash[exhibit].nil?
              hash[exhibit] = []
            end
        end
      end
    end
    hash
  end
end