require 'ostruct'

class AttackAction
  def initialize(attacker, defender)

  end

  def to_s
    
  end
end

module PlayerAttributes
  attr_accessor :hp, :damage
 
  def attack(defender, action = :slap)
    n = Random.new
    result = OpenStruct.new
    done = n.rand(@damage-10..@damage)
    case action
    when :punch
      result.damage = (done * 0.8).to_i
    when :kick
      result.damage = (done * 0.3).to_i
    when :slap
      result.damage = (done * 0.1).to_i
    end

    defender.hp -= result.damage
    result.log = "#{self.class.name} performed a #{action} for #{result.damage} damage"
    return result
  end

  def initialize hp, damage
    @hp = hp
    @damage = damage
  end
end
