require 'gosu'

class Player
  attr_reader :x, :y, :angle
  attr_accessor :speed, :score
  def initialize(x = 0, y = 0, angle = 0, speed = 1)
    @image = Gosu::Image.new("media/snake.png")
    @x = x
    @y = y
    @angle = angle
    @score = 0
    @speed = speed
  end

  def warp(x, y)
    @x, @y = x, y
  end
  
  def turn_left
    @angle = 270
  end
  
  def turn_right
    @angle = 90
  end
  
  def turn_up
    @angle = 0
  end
  
  def turn_down
    @angle = 180
  end

  def move
    @x += Gosu.offset_x(@angle, @speed)
    @y += Gosu.offset_y(@angle, @speed)
    @x %= 640
    @y %= 480
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end