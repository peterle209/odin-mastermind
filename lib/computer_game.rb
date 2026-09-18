class ComputerGame < Game
  def initialize
    @code = nil
    @code_accuracy = nil
    @turn = 1
    @color_array = Array.new
    @correct_color = Array.new
  end

  def create_code
    puts "Please enter an ordered color code! (eg 'pink blue red green')"
    @code = gets.downcase.chomp.split(' ')
    @correct_both = Array.new(@code.size) {Game::NONE_CORRECT}
  end

  def initialize_colors
    @code.each do |color|
      @color_array.push(color)
    end
    @color_array.uniq!
    @colors = @color_array.size
    @code_accuracy = Array.new(@code.size) {Game::NONE_CORRECT}
  end
  
  def create_guess
    @current_guess = Array.new(@code.size)
    @correct_both.each_with_index do |color,index|
      if color == @code[index]
        @current_guess[index] = color
      end
    end 
    @correct_color.each do |color|
      while true
        random_index = rand(@code.size)
        puts @current_guess[random_index]
        if @current_guess[random_index].nil?
          @current_guess[random_index] = color
          break
        end
      end
    end
    @current_guess.map! do |entry| 
      if entry.nil?
        @color_array[rand(0...@colors)] 
      else
        entry
      end
    end
    @correct_color.clear
    puts
    @current_guess
  end

  def start_game
    create_code
    initialize_colors
    until guess
    end
  end

  def check
    correct_indices = Array.new
    @code.size.times do |idx|
      print "Guess at #{idx}: #{@current_guess[idx]}, "
      puts "Code at #{idx}: #{@code[idx]}"
      if @current_guess[idx] == @code[idx]
        @code_accuracy[idx] = ALL_CORRECT 
        @correct_both[idx] = @code[idx]
        correct_indices.push(idx)
      end
    end

    @code.size.times do |guess_index|
       @code.each_with_index do |code_entry, check_index|
        if code_entry == @current_guess[guess_index] && !correct_indices.include?(check_index) && @code_accuracy[guess_index] == Game::NONE_CORRECT
          @code_accuracy[guess_index] = COLOR_CORRECT
          correct_indices.push(check_index)
          @correct_color.push(code_entry)
        end
      end
    end
  end

  def guess
    print "Turn ##{@turn}: "
    create_guess
    check
    display_code_accuracy
    @turn += 1
    if win?
      puts "Computer has guessed correctly!" 
      return true
    elsif loss?
      puts "Computer has failed to guess in time!"
      return true
    end
    reset_code_accuracy
    false
  end
end