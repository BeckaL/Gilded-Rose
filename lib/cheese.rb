class Cheese

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
    mature_degraders = {'Aged Brie' => 2, 'Aged Cheddar' => 3}
    normal_degrader = 1
    multiplier = magic_multiplier
    mature_degrader = mature_degraders[@type]
    return @quality += normal_degrader * multiplier if @sell_in >= 0
    @quality += mature_degrader * multiplier
  end

  def min_max_quality
    @quality = 50 if @quality > 50
  end

end

my_cheese = Cheese.new('Aged Cheddar', -1, 47, 'normal')
my_cheese.update
p my_cheese
