class HumanGame < Game
    def initialize
      super
    end

    def start_game
    puts "Current Game Rules: #{@colors} colors, #{@code.size} color combination to guess."
    guess
    end

    def create_code
    @code.map! {|entry| @color_array[rand(0...@colors)]}
    puts @code
    end

    def guess
    puts "Turn ##{@turn}: Please input your guess (eg 'red green blue' for a guess in those positions)"
    @current_guess = gets.downcase.chomp.split(' ')
    unless validate_guess
      puts 'Please input a valid guess! (you may have guessed with the wrong number of colors)'
      @current_guess = gets.downcase.chomp.split(' ')
    end
    check
    display_code_accuracy
    @turn += 1
    if win?
      puts "Congrats!" 
      return true
    elsif loss?
      puts "Good effort!"
      return true
    end
    reset_code_accuracy
    false
    end


end