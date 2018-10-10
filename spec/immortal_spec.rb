require 'immortal'

describe Immortal do

  context 'object is Yulfuras' do

    it "doesn't degrade when sell in is greater than 0" do
      yulf = Immortal.new('Yulfuras, Foot of Zeus', 4, 60, 'normal')
      yulf.update
      expect(yulf.quality).to eq 60
    end


    it "doesn't degrade when sell in is less than 0" do
      yulf = Immortal.new('Yulfuras, Foot of Zeus', -1, 60, 'normal')
      yulf.update
      expect(yulf.quality).to eq 60
    end

    it "sell in does not change" do
      yulf = Immortal.new('Yulfuras, Foot of Zeus', 4, 60, 'normal')
      yulf.update
      expect(yulf.sell_in).to eq 4
    end

  end

    context 'object is Sulfuras' do

      it "doesn't degrade when sell in is greater than 0" do
        yulf = Immortal.new("Sulfuras, Hand of Ragnaros", 4, 80, 'normal')
        yulf.update
        expect(yulf.quality).to eq 80
      end


      it "doesn't degrade when sell in is less than 0" do
        yulf = Immortal.new("Sulfuras, Hand of Ragnaros", -1, 80, 'normal')
        yulf.update
        expect(yulf.quality).to eq 80
      end

      it "sell in does not change" do
        yulf = Immortal.new("Sulfuras, Hand of Ragnaros", 4, 80, 'normal')
        yulf.update
        expect(yulf.sell_in).to eq 4
      end

  end

end
