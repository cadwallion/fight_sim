class Player
  attr_accessor :playerHp, :playerDamage
  def initialize playerHp, playerDamage
    @playerHp = playerHp
    @playerDamage = playerDamage
  end
end


class Monster
  attr_accessor :monsterHp, :monsterDamage
  def initialize(monsterHp, monsterDamage)
    @monsterHp = monsterHp
    @monsterDamage = monsterDamage
  end
end


class Fight
  def initialize player, monster
    @player = player
    @monster = monster
    @n = Random.new
  end

  def output
    puts "Player: #{@player.playerHp}    Monster: #{@monster.monsterHp}\n"
  end

  def battle
    #puts "monster damage = #{@monster.monsterDamage}"
    #puts "player damage = #{@player.playerDamage}"
    playerDamageDone = @n.rand(@monster.monsterDamage-10..@monster.monsterDamage)
    monsterDamageDone = @n.rand(@player.playerDamage-10..@player.playerDamage)
    puts "Player Damage Done = #{playerDamageDone}        Monster Damage Done = #{monsterDamageDone}\n"
    @player.playerHp -= playerDamageDone
    @monster.monsterHp -= monsterDamageDone
  end

  def check4Death
    if @player.playerHp <= 0
      puts "\nPLAYER HAS DIED!\n"
      return true
    elsif @monster.monsterHp <= 0
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
