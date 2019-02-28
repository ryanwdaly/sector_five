require 'gosu'

class Player
    ROTATION_SPEED = 6
    ACCELERATION = 2.5
    FRICTION = 0.9
    attr_reader :x, :y, :angle, :radius
    def initialize(window)
        @x = 320
        @y = 266
        @angle = 0
        @image = Gosu::Image.new('./images/ship.png')
        @velocity_x = 0 
        @velocity_y = 0 
        @radius = 40
        @window = window
    end 

    def draw
        #Gosu::Image,draw_rot() draws the image roted by any angle, 
        # measured in degrees (x, y, z, angle)
        @image.draw_rot(@x, @y, 1, @angle)
    end         

    def turn_right
        @angle += ROTATION_SPEED
    end 

    def turn_left
        @angle -= ROTATION_SPEED
    end 

    def move
        @x += @velocity_x
        @y += @velocity_y
        @velocity_x *= FRICTION
        @velocity_y *= FRICTION
        if @x > @window.width - @radius
            @velocity_x = 0 
            @x = @window.width - @radius
        end 
        if @x < @radius
            @velocity_x = 0 
            @x = @radius
        end 
        if @y > @window.height - @radius
            @velocity_y = 0 
            @y = @window.height - @radius
        end 
    end 

    def accelerate
        #Gosu.offset_x() takes the angle and an amount as arguments 
        # and returns the amount in the x degrees 
        @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
        @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
    end 
end 