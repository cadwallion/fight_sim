module PlayerAttributes
  attr_accessor :hp, :damage
 
  def attack(defender, action = :punch)
    n = Random.new
    done = n.rand(@damage-10..@damage)
    case action
    when :punch
      # DO PUNCH
      modified = (done * 0.8).to_i
    when :kick
      # DO KICK
      modified = (done * 0.3).to_i
    when :basic
      # DO BASIC
      modified = (done * 0.1).to_i
    end
    defender.hp -= modified
    return modified
  end

  def initialize hp, damage
    @hp = hp
    @damage = damage
  end
end

class Player
  include PlayerAttributes
  #attr_accessor :playerHp, :playerDamage
  #def initialize playerHp, playerDamage
    #@playerHp = playerHp
    #@playerDamage = playerDamage
  #end
end


class Monster
  include PlayerAttributes
  #attr_accessor :monsterHp, :monsterDamage
  #def initialize(monsterHp, monsterDamage)
    #@monsterHp = monsterHp
    #@monsterDamage = monsterDamage
  #end
end


class Fight
  def initialize player, monster
    @player = player
    @monster = monster
    @n = Random.new
  end

  def output
    #puts "Player: #{@player.playerHp}    Monster: #{@monster.monsterHp}\n"
    puts "Player: #{@player.hp}    Monster: #{@monster.hp}\n"
  end

  def battle
    #puts "monster damage = #{@monster.monsterDamage}"
    #puts "player damage = #{@player.playerDamage}"
    #playerDamageDone = @n.rand(@monster.monsterDamage-10..@monster.monsterDamage)
    #monsterDamageDone = @n.rand(@player.playerDamage-10..@player.playerDamage)
   
    choiceLoop = 0
        choice = ''
	while choice.upcase != "Q" do
  	  puts "Would you like to [K]ick [P]unch or [Q]uit = "
    	  choice = gets.chomp
	  if choice.upcase == "K"
    	    playerDamageDone = @player.attack(@monster, :kick)
            break
	  elsif choice.upcase == "P"
	    playerDamageDone = @player.attack(@monster, :punch)
            break
	  elsif choice.upcase == "Q" 
	    playerDamageDone = @player.attack(@monster, :basic)
            break
          else
            puts "Invalid entry"
	  end
    end
    monsterDamageDone = @monster.attack(@player)
    puts "Player Damage Done = #{playerDamageDone}        Monster Damage Done = #{monsterDamageDone}\n"
    #@player.playerHp -= playerDamageDone
    #@monster.monsterHp -= monsterDamageDone
  end

  def check4Death
    if @player.hp <= 0
      puts "Players health is = #{@player.hp}"
      puts "\nPLAYER HAS DIED!\n"
      return true
    elsif @monster.hp <= 0
      puts "Monsters health is = #{@monster.hp}"
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
