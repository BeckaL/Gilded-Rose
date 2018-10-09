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
      else other_items(item)
    end
  end

  def min_max_quality(item)
    return if item.name == "Sulfuras, Hand of Ragnaros"
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

end
