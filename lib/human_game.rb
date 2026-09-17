class HumanGame < Game
  DEFAULT_COLORS = ['red', 'green', 'blue', 'pink', 'purple', 'orange']

  def initialize
    super()
    @color_array = DEFAULT_COLORS.dup
    @colors = @color_array.size
  end

  def start_game
    create_code
    puts "Current Game Rules: #{@colors} colors, #{@code.size} color combination to guess."
    until guess
    end
  end

  def create_code
    @code.map! {|entry| @color_array[rand(0...@colors)]}
    puts @code
  end

  def validate_guess
    unless @current_guess.size == @code.size
      return false
    end
    true
  end
  def guess
    puts "Turn ##{@turn}: Please input your guess (eg 'red green blue' for a guess in those positions)"
    @current_guess = gets.downcase.chomp.split(' ')
    until validate_guess
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