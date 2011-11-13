class Fighter
  attr_accessor :hp, :damage

  def initialize hp, damage
    @hp = hp
    @damage = damage
  end

  def attack(defender)
    n = Random.new
    done = n.rand(@damage-10..@damage)
    defender.hp -= done
    return done
  end
end
class Player < Fighter
  
end


class Monster < Fighter
end


class Fight
  def initialize player, monster
    @player = player
    @monster = monster
  end

  def output
    puts "Player: #{@player.hp}    Monster: #{@monster.hp}\n"
  end

  def battle
    monsterDamageDone = @monster.attack(@player)
    playerDamageDone = @player.attack(@monster)
    puts "Player Damage Done = #{playerDamageDone}        Monster Damage Done = #{monsterDamageDone}\n"
  end

  def check4Death
    if @player.hp <= 0
      puts "\nPLAYER HAS DIED!\n"
      return true
    elsif @monster.hp <= 0
      puts "\nMONSTER HAS DIED!\n"
      return true
    else
      return false
    end
  end
end

player = Player.new 100, 50
monster = Monster.new 100, 30
fight = Fight.new player, monster


while !fight.check4Death do
  fight.output
  #puts "BEFORE BATTLE"
  fight.battle
  #puts "AFTER BATTLE"
end
