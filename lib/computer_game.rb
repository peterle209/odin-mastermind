class ComputerGame < Game
  def initialize
    @code = nil
    @code_accuracy = nil
    @turn = 1
    @color_array = Array.new
  end

  def create_code
    puts "Please enter an ordered color code! (eg 'pink blue red green')"
    @code = gets.downcase.chomp.split(' ')
  end

  def initialize_colors
    @code.each do |color|
      @color_array.push(color)
    end
    @color_array.uniq!
    @colors = @color_array.size
    @code_accuracy = Array.new(@code.size, Game::NONE_CORRECT)
  end
  
  def create_guess
    @current_guess = Array.new(@code.size)
    @current_guess.map! {|entry| @color_array[rand(0...@colors)]}
    puts @current_guess
    @current_guess
  end

  def start_game
    create_code
    initialize_colors
    until guess
      
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