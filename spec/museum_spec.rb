require './lib/museum'
require './lib/patron'
require './lib/exhibit'

describe Museum do
  let(:dmns) {Museum.new("Denver Museum of Nature and Science")}
  let(:gems_and_minerals) {Exhibit.new({name: "Gems and Minerals", cost: 0})}
  let(:dead_sea_scrolls) {Exhibit.new({name: "Dead Sea Scrolls", cost: 10})}
  let(:imax) {Exhibit.new({name: "IMAX",cost: 15})}
  let(:patron_1) {Patron.new("Bob", 20)}
  let(:patron_2) {Patron.new("Sally", 20)}
  let(:patron_3) {Patron.new("Johnny", 5)}

  describe '#initialize' do
    it 'exists' do
      expect(dmns).to be_a(Museum)
    end

    it 'has attributes' do
      expect(dmns.name).to eq("Denver Museum of Nature and Science")
      expect(dmns.exhibits).to eq([])
    end
  end

  describe '#add_exhibit(exhibit)' do
    it 'adds exhibits to the museum' do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)

      expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
    end
  end

  describe '#recommend_exhibits(patron)' do
    before(:each) do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
    end
    it 'lists exhibits a patron is interested in' do
      patron_1.add_interest("Dead Sea Scrolls")
      patron_1.add_interest("Gems and Minerals")
      patron_2.add_interest("IMAX")

      expect(dmns.recommend_exhibits(patron_1)).to eq([dead_sea_scrolls, gems_and_minerals])
      expect(dmns.recommend_exhibits(patron_2)).to eq([imax])
    end
  end

  describe '#admit(patron)' do
    before(:each) do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
      patron_1.add_interest("Gems and Minerals")
      patron_1.add_interest("Dead Sea Scrolls")
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3.add_interest("Dead Sea Scrolls")
    end

    it 'lists patrons who have been admitted to the museum' do
      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)
      
      expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    end
  end

  describe '#patrons_by_exhibit_interest' do
    before(:each) do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)
      patron_1.add_interest("Gems and Minerals")
      patron_1.add_interest("Dead Sea Scrolls")
      patron_2.add_interest("Dead Sea Scrolls")
      patron_3.add_interest("Dead Sea Scrolls")
    end

    it 'creates a hash of each exhibit and interested patrons' do
      expected_hash = {
        gems_and_minerals => [patron_1],
        dead_sea_scrolls => [patron_1, patron_2, patron_3],
        imax => []
      }
      expect(dmns.patrons_by_exhibit_interest).to eq(expected_hash)
    end
  end
end