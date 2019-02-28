require 'gosu'

class Explosion
    attr_reader :finished
    def initialize(window, x, y)
        @x = x
        @y = y
        @radius = 30
        @images = Gosu::Image.load_tiles('./images/explosions2.png', 100, 100)
        @images_index = 0 
        @finished = false
    end 

    def draw
        if @images_index < @images.count
            @images[@images_index].draw(@x - @radius, @y - @radius, 2)
            @images_index += 1
        else
            @finished = true
        end 
    end 
end 