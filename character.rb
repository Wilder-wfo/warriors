require_relative "catalog/characters"

class Character
  attr_reader :name, :experience, :moves, :speed
  attr_accessor :current_move
  
  def initialize(name, type)
    
    char_details = Catalog::CHARACTERS[type]
    @name = name
    @type = type
    @experience = char_details[:base_exp]
    @max_health = char_details[:base_stats][:hp]
    @speed = char_details[:base_stats][:speed]
    @moves = char_details[:moves]
    @health = nil
    @current_move = nil
  end

  def prepare_for_battle
    @health = @max_health
    @current_move = nil
  end

  def receive_damage(damage)
    @health -= damage
  end

  def fainted?
    !@health.positive?
  end
  
  def attack(other)
    hits = @current_move[:accuracy] >= rand(1..100)
    puts "#{@name} uses #{@current_move[:name]}"
    if hits
      other.receive_damage(@current_move[:power])
      puts "Hits #{other.name} and caused #{@current_move[:power]} damage"
    else
      puts "#{@name} failed to hit #{other.name} and didn't cause any damage"
    end
  end
  
  def increase_experience(defeated_character)
    @experience += defeated_character.experience * 0.2
  end
end
