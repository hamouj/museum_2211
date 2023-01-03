class Museum
  attr_reader :name, :exhibits, :patrons, :winner

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @winner = nil
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
          hash[exhibit] = [] if hash[exhibit].nil?
        end
      end
    end
    hash
  end

  def ticket_lottery_contestants(exhibit)
    patrons_by_exhibit_interest[exhibit].select do |patron|
      patron.spending_money < exhibit.cost
    end
  end

  def draw_lottery_winner(exhibit)
    @winner = ticket_lottery_contestants(exhibit).sample
  end

  def announce_lottery_winner(exhibit)
    if winner.nil?
      'No winners for this lottery'
    else
      "#{winner.name} has won the #{exhibit.name} exhibit lottery"
    end
  end
end