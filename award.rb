class Award
  attr_reader :name, :has_expired
  attr_accessor :expires_in, :quality

  def initialize(name, expires_in, quality)
    @name = name
    @quality = quality
    @expires_in = expires_in

    @has_expired = @expires_in <= 0
  end

  def update
    unless name == 'Blue Distinction Plus'
      update_expiration
      change_quality
    end
  end

  def change_quality
    return if quality <= 0 || quality > 50

    if name == 'Blue Compare' && has_expired
      @quality = 0 
      return
    end

    magnitude = has_expired ? 2 : 1
    decrement = magnitude * amount_to_decrease
    if name == 'Blue First' || name == 'Blue Compare'
      @quality = [quality + decrement, 50].min
    else
      @quality = [quality - decrement, 0].max
    end
  end

  def amount_to_decrease
    case name
    when 'Blue First'
      1
    when 'Blue Star'
      2
    when 'Blue Compare'
      if expires_in < 5
        3
      elsif expires_in < 10
        2
      else
        1
      end
    else
      1
    end
  end

  def update_expiration
    @expires_in -= 1
  end
end

# legacy code below
=begin
Award = Struct.new(:name, :expires_in, :quality)
=end