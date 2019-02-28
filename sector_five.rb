require 'gosu'
require_relative 'player'
require_relative 'asteroid'
require_relative 'bullet'
require_relative 'explosion'

class SectorFive < Gosu::Window
    WIDTH = 1024
    HEIGHT = 1024
    ENEMY_FREQUENCY = 0.02
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = "Sector Five"
        @player = Player.new(self)
        @asteroids = []
        @bullets = []
        @explosions = []
    end 
    
    def update
        @player.turn_left if button_down?(Gosu::KB_A)
        @player.turn_right if button_down?(Gosu::KB_D)
        @player.accelerate if button_down?(Gosu::KB_W)
        @player.move
        if rand < ENEMY_FREQUENCY
            @asteroids.push Asteroid.new(self)
        end 
        @asteroids.each do |asteroid|
            asteroid.move
        end 
        @bullets.each do |bullet|
            bullet.move 
        end 
        @asteroids.dup.each do |asteroid|
            @bullets.dup.each do |bullet|
                distance = Gosu.distance(asteroid.x, asteroid.y, bullet.x, bullet.y)
                if distance < asteroid.radius + bullet.radius
                    @asteroids.delete asteroid
                    @bullets.delete bullet 
                    @explosions.push Explosion.new(self, asteroid.x, asteroid.y)
                end 
            end 
        end 
        @explosions.dup.each do |explosion|
            @explosions.delete explosion if explosion.finished
        end 
        @asteroids.dup.each do |asteroid|
            if asteroid.y > HEIGHT + asteroid.radius
                @asteroids.delete asteroid
            end 
        end 
        @bullets.dup.each do |bullet|
            @bullets.delete bullet unless bullet.onscreen?
        end 
    end 
    
    def draw
        @player.draw 
        @asteroids.each do |asteroid|
            asteroid.draw
        end 
        @bullets.each do |bullet|
            bullet.draw
        end 
        @explosions.each do |explosion|
            explosion.draw
        end 
    end 

    def button_down(id)
        if id == Gosu::KB_SPACE
            @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
        end 
    end 
end 

window = SectorFive.new
window.show