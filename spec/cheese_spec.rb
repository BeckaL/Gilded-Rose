require 'cheese'
require 'item'
require 'gilded_rose'


describe Cheese do

  context 'when item is Aged Brie' do
    context 'before sell_in' do
      it 'raises quality by one after a day' do
        item = Cheese.new("Aged Brie", 1, 0, 'normal')
        item.update
        expect(item.quality).to eq(1)
      end

      it 'never raises quality beyond 50' do
        item = Cheese.new("Aged Brie", 1, 50, 'normal')
        item.update
        expect(item.quality).to eq(50)
      end
    end

    context 'after sell_in' do
      it 'raises quality by two after a day' do
        item = Cheese.new("Aged Brie", 0, 0, 'normal')
        item.update
        expect(item.quality).to eq(2)
      end

      it 'only raises quality to 50 when quality is at 49' do
        item = Cheese.new("Aged Brie", 0, 49, 'normal')
        item.update
        expect(item.quality).to eq(50)
      end
    end
  end
  
  context 'when item is Aged Cheddar' do
    it 'improves in quality by 3 after its sell-in date' do
      item = Cheese.new('Aged Cheddar', 0, 47, 'normal')
      item.update
      expect(item.quality).to eq 50
    end
  end

end
