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

    context 'when item is Backstage passes to a TAFKAL80ETC concert' do
      context 'when sell_in is greater than 10' do
        it 'increases quality by one after each day' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 0)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(1)
        end

        it 'never increases quality beyond 50' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 50)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(50)
        end
      end

      context 'when sell_in is less than or equal to 10 but more than 5' do
        it 'increases quality by two after each day' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(2)
        end

        it 'only raises quality to 50 when quality is at 49' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(50)
        end
      end

      context 'when sell_in is less than or equal to 5 but more than 0' do
        it 'increases quality by three after each day' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(3)
        end

        it 'only raises quality to 50 when quality is at 48 or more' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 48)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(50)
        end


      end

      context 'after sell_in' do
        it 'sets quality to 0' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 50)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(0)
        end

        it 'does not change quality' do
          item = Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 0)
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq(0)
        end
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
