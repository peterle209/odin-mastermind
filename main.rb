require_relative 'lib/game.rb'

test = Game.new('guesser')
test.computer_create_code
until test.start_game
  
end
