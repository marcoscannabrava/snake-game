require 'gosu'
require_relative 'player'

class Body < Player
  def initialize(previous_block)
    @image = Gosu::Image.new("media/snake.png")
    @previous_block = previous_block
    @angle = @previous_block.angle
    @speed = @previous_block.speed
    @x = @previous_block.x
    @y = @previous_block.y
    @tracks = { x: [@x], y: [@y] }
  end

  def warp
    offset = 20
    case @previous_block.angle
    when 0
      @y = @previous_block.y - offset
    when 90
      @x = @previous_block.x - offset
    when 180
      @y = @previous_block.y + offset
    when 270
      @x = @previous_block.x + offset
    end
  end

  def move
    @x = @tracks[:x][-1]
    @y = @tracks[:y][-1]
    @tracks[:x] << @previous_block.x
    @tracks[:y] << @previous_block.y
    @x %= 640
    @y %= 480
  end
end