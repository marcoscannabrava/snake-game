require 'gosu'

class Apple
  attr_reader :x, :y
  def initialize
    @image = Gosu::Image.new("media/apple.png")
    @x = @y = 0.0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw_rot(@x, @y, 1, 0)
  end
end