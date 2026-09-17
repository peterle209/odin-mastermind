class Game
  CODESIZE = 4  
  MAXTURNS = 12
  ALL_CORRECT = 'O'
  COLOR_CORRECT = 'C'
  NONE_CORRECT = 'X'

  def initialize()
    @code = Array.new(CODESIZE, nil)
    @code_accuracy = Array.new(CODESIZE, NONE_CORRECT)
    @current_guess = nil
    @turn = 1
  end

  def check
    correct_indices = Array.new
    CODESIZE.times do |idx|
      puts "Guess at #{idx}: #{@current_guess[idx]}"
      puts "Code at #{idx}: #{@code[idx]}"
      if @current_guess[idx] == @code[idx]
        @code_accuracy[idx] = ALL_CORRECT 
        correct_indices.push(idx)
      end
    end

    CODESIZE.times do |guess_index|
       @code.each_with_index do |code_entry, check_index|
        if code_entry == @current_guess[guess_index] && !correct_indices.include?(check_index) && @current_guess[guess_index] == NONE_CORRECT
          @code_accuracy[guess_index] = COLOR_CORRECT
          correct_indices.push(check_index)
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
    return true if @turn > MAXTURNS
    false
  end
end