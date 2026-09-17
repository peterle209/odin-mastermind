class Game
  CODESIZE = 4  
  DEFAULT_COLORS = ['red', 'green', 'blue', 'pink', 'purple', 'orange']
  ALL_CORRECT = 'O'
  COLOR_CORRECT = 'C'
  NONE_CORRECT = 'X'

  def initialize(player_role)
    @player_role = player_role
    @code = Array.new(CODESIZE, nil)
    @code_accuracy = Array.new(CODESIZE, nil)
    @color_array = DEFAULT_COLORS.dup
    @colors = @color_array.size
  end

  def computer_create_code
    @code.map! {|entry| @color_array[rand(0...@colors)]}
  end

  def guess
    puts "Please input your #{@colors} color guess! (eg 'red, green, blue' for a 3 color guess in those positions)"
    @current_guess = gets.downcase.gsub(/\s+/, "").split(',')
    unless validate_guess
      puts 'Please input a valid guess! (you may have guessed with the wrong number of colors)'
      @current_guess = gets.downcase.gsub(/\s+/, "").split(',')
    end
    check
  end

  def validate_guess
    unless @current_guess.size == @colors
      false
    end
    true
  end

  def check
    
  end
end