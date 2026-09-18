require_relative 'lib/game.rb'
require_relative 'lib/computer_game.rb'
require_relative 'lib/human_game.rb'

def get_input
  puts "Please decide if you would like to play as the code maker or code breaker (input maker/breaker)"
  user_input = gets.chomp.downcase
  while true
    break if user_input == 'maker' || user_input == 'breaker'
    puts "Please check your input for mispellings (input exactly maker OR breaker)"
    user_input = gets.chomp.downcase
  end
  user_input
end

user_input = get_input

if user_input == 'maker'
  game = ComputerGame.new
  game.start_game
else
  game = HumanGame.new
  game.start_game
end


