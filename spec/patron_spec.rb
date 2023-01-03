require './lib/patron'

describe Patron do
  let(:patron) {Patron.new("Bob", 20)}

  describe '#initialize' do
    it 'exists' do
      expect(patron_1).to be_a(Patron)
    end

    it 'has attributes' do
      expect(patron_1.name).to eq('Bob')
      expect(patron_1.spending_money).to eq(20)
      expect(patron_1.interests).to eq([])
    end
  end
end