class Game
  CODESIZE = 4  
  MAXTURNS = 12
  ALL_CORRECT = 'O'
  COLOR_CORRECT = 'C'
  NONE_CORRECT = 'X'
  DEFAULT_COLORS = ['red', 'green', 'blue', 'pink', 'purple', 'orange']

  def initialize()
    @code = Array.new(CODESIZE, nil)
    @code_accuracy = Array.new(CODESIZE) {Game::NONE_CORRECT}
    @current_guess = nil
    @color_array = DEFAULT_COLORS.dup
    @turn = 1
  end

  def reset_code_accuracy
    @code_accuracy.map! {|entry| entry = NONE_CORRECT}
  end

  def display_code_accuracy
    @code_accuracy.each_with_index do |entry,idx|
      print "Entry #{idx} of guess: "
      puts "Correct color and position" if entry == ALL_CORRECT
      puts "Correct color, wrong positon" if entry == COLOR_CORRECT
      puts "Wrong color and position" if entry == NONE_CORRECT
    end
  end

  def win?
    win = true
    @code_accuracy.each do |entry|
      win = false unless entry == ALL_CORRECT
    end
    win
  end

  def loss?
    return true if @turn > MAXTURNS
    false
  end
end