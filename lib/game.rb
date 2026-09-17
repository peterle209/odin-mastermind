class Game
  CODESIZE = 4  
  MAXTURNS = 12
  DEFAULT_COLORS = ['red', 'green', 'blue', 'pink', 'purple', 'orange']
  ALL_CORRECT = 'O'
  COLOR_CORRECT = 'C'
  NONE_CORRECT = 'X'

  def initialize(player_role)
    @player_role = player_role
    @code = Array.new(CODESIZE, nil)
    @code_accuracy = Array.new(CODESIZE, NONE_CORRECT)
    @color_array = DEFAULT_COLORS.dup
    @colors = @color_array.size
    @turn = 1
  end

  def computer_create_code
    @code.map! {|entry| @color_array[rand(0...@colors)]}
    puts @code
  end

  def guess
    puts "Current Game Rules: #{@colors} colors, #{@code.size} color combination to guess."
    puts "Turn ##{@turn}: Please input your guess (eg 'red, green, blue' for a guess in those positions)"
    @current_guess = gets.downcase.gsub(/\s+/, "").split(',')
    unless validate_guess
      puts 'Please input a valid guess! (you may have guessed with the wrong number of colors)'
      @current_guess = gets.downcase.gsub(/\s+/, "").split(',')
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
    resetCodeAccuracy
  end

  def validate_guess
    unless @current_guess.size == @colors
      false
    end
    true
  end

  def check
    correct_indices = Array.new
    CODESIZE.times do |idx|
      if @current_guess[idx] == @code[idx]
        @code_accuracy[idx] = ALL_CORRECT 
        correct_indices.push(idx)
      end
    end

    CODESIZE.times do |i|
       @code.each_with_index do |code_entry, idx|
        if code_entry == @current_guess[i] && !correct_indices.include?(idx)
          @code_accuracy[i] = COLOR_CORRECT
          correct_indices.push(idx)
        end
      end
    end
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
    return true if turn > MAXTURNS
    false
  end
end