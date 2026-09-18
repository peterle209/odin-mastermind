class HumanGame < Game
  def initialize
    super()
    @colors = @color_array.size
  end

  def start_game
    create_code
    puts "Current Game Rules: #{@colors} colors, #{@code.size} color combination to guess."
    print "Possible colors: "
    @color_array.each do |color|
      print "#{color}, " if color != @color_array[-1]
      print "#{color}." if color == @color_array[-1]
    end
    puts
    until guess
    end
  end

  def create_code
    @code.map! {|entry| @color_array[rand(0...@colors)]}
    # puts @code
  end

  def check
    correct_indices = Array.new
    CODESIZE.times do |idx|
      puts "Guess at #{idx}: #{@current_guess[idx]}"
      # puts "Code at #{idx}: #{@code[idx]}"
      if @current_guess[idx] == @code[idx]
        @code_accuracy[idx] = ALL_CORRECT 
        correct_indices.push(idx)
      end
    end

    CODESIZE.times do |guess_index|
       @code.each_with_index do |code_entry, check_index|
        if code_entry == @current_guess[guess_index] && !correct_indices.include?(check_index) && @code_accuracy[guess_index] == Game::NONE_CORRECT
          @code_accuracy[guess_index] = COLOR_CORRECT
          correct_indices.push(check_index)
        end
      end
    end
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