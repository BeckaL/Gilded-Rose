class Pass

  attr_reader :quality, :sell_in

  def initialize(type, sell_in, quality, conjured)
    @type = type
    @sell_in = sell_in
    @quality = quality
    @conjured = conjured
  end

  def update
    @sell_in -= 1
    update_quality
    min_max_quality
  end

  def magic_multiplier
    multiplier = {'normal' => 1,
                  'conjured' => 2,
                  'ultraconjured' => 3}
    return multiplier[@conjured]
  end

  def update_quality
    multiplier = magic_multiplier
    @quality += 1 * multiplier if @sell_in > 10
    @quality += 2 * multiplier if @sell_in.between?(6, 10)
    @quality += 3 * multiplier if @sell_in.between?(0, 5)
    @quality = 0 * multiplier if @sell_in < 0
  end

  def min_max_quality
    @quality = 50 if @quality > 50
  end

end
