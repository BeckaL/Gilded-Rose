# Don't change anything in this file

class Item
  attr_accessor :name, :sell_in, :quality, :conjured

  def initialize(name, sell_in, quality, conjured)
    @name = name
    @sell_in = sell_in
    @quality = quality
    @conjured = conjured
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end

end
