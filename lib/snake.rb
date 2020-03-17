require 'gosu'
require_relative 'player'
require_relative 'apple'
require_relative 'body'

class Snake < Gosu::Window
  SCREEN_HEIGHT = 480
  SCREEN_WIDTH = 640
  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT
    self.caption = "Snake Game"
    @background_image = Gosu::Image.new("media/space.png", :tileable => true)
    @font = Gosu::Font.new(self, "Futura", 30)

    @player = Player.new
    @player.warp(SCREEN_HEIGHT / 2, SCREEN_WIDTH / 2)
    @body = [@player]
    @apple = Apple.new
    @apple.warp(rand(0..640), rand(0..480))
    @gameplay = true
  end


  # Game Logic ----------------------------------
  def collision_with_apple?
    apple_x = ((@apple.x - 20)..(@apple.x + 20))
    apple_y = ((@apple.y - 20)..(@apple.y + 20))
    apple_x.include?(@player.x) && apple_y.include?(@player.y)
  end

  def collision_with_body?
    @body.each do |body_part|
      body_x = ((body_part.x - 15)..(body_part.x + 15))
      body_y = ((body_part.y - 15)..(body_part.y + 15))
      body_x.include?(@player.x) && body_y.include?(@player.y)
    end
  end

  def collision_with_wall?
    player_x = ((@player.x - 15)..(@player.x + 15))
    player_y = ((@player.y - 15)..(@player.y + 15))
    player_x.include?(SCREEN_WIDTH) || player_y.include?(SCREEN_HEIGHT)
  end


  def add_score
    @player.score += 1
    @player.speed += 0.5
    @body << Body.new(@body[-1])
    @body[-1].warp
    @apple.warp(rand(20..620), rand(20..460))
  end

  def end_game
    @body.each { |b| b.speed = 0 }
    @gameplay = false
  end
  # ---------------------------------------------

  def update
    @player.turn_left if (Gosu.button_down?(Gosu::KB_LEFT) || Gosu::button_down?(Gosu::GP_LEFT))
    @player.turn_right if (Gosu.button_down?(Gosu::KB_RIGHT) || Gosu::button_down?(Gosu::GP_RIGHT))
    @player.turn_up if (Gosu.button_down?(Gosu::KB_UP) || Gosu::button_down?(Gosu::GP_BUTTON_0))
    @player.turn_down if (Gosu.button_down?(Gosu::KB_DOWN) || Gosu::button_down?(Gosu::GP_BUTTON_1))

    @body.each { |b| b.move }
    add_score if collision_with_apple?
    end_game if collision_with_wall?
    p "X: #{@player.x}"
    p "Y: #{@player.y}"
  end

  def draw
    @player.draw
    @body.each { |b| b.draw }
    @apple.draw
    @background_image.draw(0, 0, 0)
    if @gameplay
      @font.draw_text(@player.score, 5, 5, 3, 1, 1)
    else
      @font.draw_text("END GAME: You scored #{@player.score}. Congratulations!", 5, 5, 3, 1, 1)
    end
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end
end