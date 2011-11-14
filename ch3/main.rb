$:.push File.join(File.dirname(__FILE__))
require 'monster'
require 'player'
require 'gosu'

module ZOrder
  Background, UI = *0..1
end

class GameWindow < Gosu::Window
  def initialize(player, monster)
    super(640, 480, false)
    self.caption = "Fight Simulator Game"

    @player = player
    @monster = monster
    @winner = nil
    @action_log = []
    @action_inprogress = false

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)  
  end

  def update
    checkForDeath 
  end

  def draw
    @font.draw("Player: #{@player.hp}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    @font.draw("Monster: #{@monster.hp}", 500, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)

    @action_log.each_index do |idx|
      @font.draw(@action_log[idx].log, 10, ((idx+1)*15)+140, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    end

    if @winner.nil?
      @font.draw("Press to attack:", 400, 400, ZOrder::UI, 1.0, 1.0, 0xffffff00)
      @font.draw("[ K ] - Kick", 450, 420, ZOrder::UI, 1.0, 1.0, 0xffffff00)
      @font.draw("[ P ] - Punch", 450, 440, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    else
      @font.draw("#{@winner.class.name.upcase} WINS", 270, 120, ZOrder::UI, 1.0, 1.0, 0xffffff00)
    end
  end

  def checkForDeath
    if @player.hp <= 0
      @winner = @monster
      return true
    elsif @monster.hp <= 0
      @winner = @player
      return true
    else
      return false
    end
  end

  def button_down(id)
    close if id == Gosu::KbEscape
  end

  def battle(id)
    case id
    when Gosu::KbK
      attack_type = :kick
    when Gosu::KbP
      attack_type = :punch
    end

    @action_log << @player.attack(@monster, attack_type)
    @action_log << @monster.attack(@player)
  end

  def button_up(id)
    if [Gosu::KbK, Gosu::KbP].include? id
      battle(id)
    end
  end
end

player = Player.new 100, 50
monster = Monster.new 100, 50

window = GameWindow.new(player, monster)
window.show
