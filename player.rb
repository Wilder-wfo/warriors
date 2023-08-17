require_relative "character"
require_relative "get_input"
require_relative "catalog/moves"

class Player
  include GetInput
  attr_reader :character, :name
  
  def initialize(name, character_type, character_name)
    @name = name
    @character = Character.new(character_name, character_type)
  end
  
  def select_move
    move = get_input_options("Select a move to attack", @character.moves)
    @character.current_move = Catalog::MOVES[move]
  end
end

class Bot < Player
  def initialize
    bot_characters = Catalog::CHARACTERS.select { |_name, data| data[:type] == "bot" }
    valid_characters = bot_characters.keys # [lockheed,drogon,godzilla,smaug]
    select_character = valid_characters.sample
    super("Dragon Master", select_character, select_character.capitalize)
  end
  def select_move
    move = @character.moves.sample
    @character.current_move = Catalog::MOVES[move]
  end
end

# player = Player.new("Testino","warrior","Kratos")
# player.select_move
# p player.character
