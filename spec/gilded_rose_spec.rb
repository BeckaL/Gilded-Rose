require 'gilded_rose'
require 'item'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      item = Item.new("foo", 0, 0)
      GildedRose.new([item]).update_quality
      expect(item.name).to eq "foo"
    end

    it "lowers the sell_in by one after a day" do
      item = Item.new("item", 1, 0)
      GildedRose.new([item]).update_quality
      expect(item.sell_in).to eq 0
    end

    it "never lowers quality below 0" do
      item = Item.new("item", 0, 0)
      GildedRose.new([item]).update_quality
      expect(item.quality).to eq(0)
    end

    context 'when item is generic' do
      context 'before sell_in' do
        it 'lowers quality by one after one day' do
          item = Item.new("item", 1, 1)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(0)
        end
      end

      context 'after sell_in' do
        it 'lowers quality by two after a day' do
          item = Item.new("item", 0, 2)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(0)
        end
      end
    end



    context 'when item is Sulfuras, Hand of Ragnaros' do
      it 'does not change sell_in' do
        item = Item.new("Sulfuras, Hand of Ragnaros", 1, 80)
        GildedRose.new([item]).update_quality
        expect(item.sell_in).to eq(1)
      end

      it 'does not change quality' do
        item = Item.new("Sulfuras, Hand of Ragnaros", 1, 80)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq(80)
      end
    end

    context 'when item is conjured' do
      it 'degrades to 48 when quality is at 50' do
        item = Item.new("Conjured item", 5, 50)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 48
      end

      it 'degrades twice as fast when past sell_in date' do
        item = Item.new("Conjured item", 0, 50)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 46
      end
    end



    context 'when item is Yulfuras' do

      it 'never degrades' do
        item = Item.new('Yulfuras, Foot of Zeus', 0, 50)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 50
      end

      it 'doesn\'t degrade even when above 50' do
        item = Item.new('Yulfuras, Foot of Zeus', 0, 80)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 80
      end
    end

    context 'when item is ultra conjured' do

      it 'degrades three times as fast as normal items after sell_in' do
        item = Item.new('Ultraconjured', 0, 50)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 44
      end

      it 'degrades three times as fast as normal items before sell_in' do
        item = Item.new('Ultraconjured', 1, 50)
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 47
      end
    end
  end
end
