class Offset
  attr_reader :price, :mass
  
  def initialize(mass)
    @mass = mass
  end
  
  def price
    mass * PRICE_PER_KG_IN_DOLLARS
  end
  
  PRICE_PER_KG_IN_DOLLARS = 0.0110231131 # $10/ton
end
