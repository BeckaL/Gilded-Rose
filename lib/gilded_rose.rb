class GildedRose

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      decrease_sell_in(item)
      initial_quality_change(item)
      min_max_quality(item)
    end
  end

  def decrease_sell_in(item)
    item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"
  end

  def initial_quality_change(item)
    case item.name
    when "Aged Brie" then aged_brie(item)
      when "Sulfuras, Hand of Ragnaros" then sulfuras(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_pass(item)
      when "Conjured item" then conjured_item(item)
      when "Aged Cheddar" then aged_cheddar(item)
      when 'Yulfuras, Foot of Zeus' then yulfuras(item)
      when 'Ultraconjured' then ultraconjured(item)
      else other_items(item)
    end
  end

  def min_max_quality(item)
    name = item.name
    return if name == 'Sulfuras, Hand of Ragnaros' || name == 'Yulfuras, Foot of Zeus'
    item.quality = MIN_QUALITY if item.quality < MIN_QUALITY
    item.quality = MAX_QUALITY if item.quality > MAX_QUALITY
  end

  def sulfuras(item)
  end

  def aged_brie(item)
    item.sell_in < 0 ? item.quality += 2 : item.quality += 1
  end

  def backstage_pass(item)
    item.quality += 1 if item.sell_in > 10
    item.quality += 2 if item.sell_in.between?(6, 10)
    item.quality += 3 if item.sell_in.between?(0, 5)
    item.quality = 0 if item.sell_in < 0
  end

  def other_items(item)
    item.sell_in < 0 ? item.quality -= 2 : item.quality -= 1
  end

  def conjured_item(item)
    item.sell_in < 0 ? item.quality -= 4 : item.quality -= 2
  end

  def aged_cheddar(item)
    item.quality += 3 if item.sell_in < 0
  end

  def yulfuras(item)
  end

  def ultraconjured(item)
    item.sell_in < 0 ? item.quality -= 6 : item.quality -= 3
  end

end
