require_relative "catalog/characters"
require_relative "get_input"
require_relative "player"
require_relative "battle"

# rubocop:disable Style/MixinUsage
include GetInput
# rubocop:enable Style/MixinUsage

def select_character
  characters = Catalog::CHARACTERS.select { |_name, data| data[:type] == "player" }
  valid_characters = characters.keys # ["warrior", "magician"]
  get_input_options("Choose a character:", valid_characters)
end

name = get_input("What's your name?")
character = select_character
character_name = get_input("Give your character a name:")

player = Player.new(name, character, character_name)
bot = Bot.new
battle = Battle.new(player,bot)
battle.start
