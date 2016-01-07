class MasterMind

  def start
    $player = Player.new
    $computer = Computer.new
    $player.coder_or_guesser

    if $player.guesser
      $computer.generate_code

      1.upto(12) do |num|
        puts "You are on turn #{num} out of 12."
        $player.make_code
        $computer.review_guess
        break if $computer.win
      end

      if $computer.win
        puts "You have correctly guessed the code!"
      else puts "You lose"
      end

    elsif $player.coder
      $player.make_code
      $computer.generate_code

      1.upto(12) do |num|
        puts "Turn #{num} of 12."
        if num > 1
          puts "Your code is: "
          $player.code.each {|key, value| puts "#{key}. #{value}"}
          $computer.new_code
        end

        $player.review_guess
        break if $player.comp_win
      end

      if $player.comp_win
        puts "The computer has guessed correctly!"
      else puts "You out smarted the computer!"
      end

    end
  end
end

class Player
  attr_reader :code, :guesser, :coder, :reds, :whites, :comp_win

  def coder_or_guesser
    @guesser = false
    @coder =  false
    puts "Enter 1 if you wish to play as the coder, or press 2 if you wish to play as the guesser."

    loop do
      choice = gets.chomp

      if choice == "1"
        @coder = true
        break
      elsif choice == "2"
        @guesser = true
        break
      else puts "You must enter either 1 or 2."
      end

    end
  end

  def make_code
    $colors = ["white", "blue", "green", "yellow", "orange", "red"]
    @code = {1 => "", 2 => "", 3 => "", 4 => ""}

    $colors.each_with_index do |color, index|
      puts "#{index}. #{color}"
    end

    if @guesser
      puts "Enter four DIFFERENT numbers that represent the colors you wish to include in your guess. Follow each number with a space (e.g. 1 2 3 4) "
    else puts "Enter four DIFFERENT numbers that represent the colors you wish to include in your secret code. Follow each number with a space (e.g. 1 2 3 4) "
    end
    colors_picked = gets.chomp
    code = colors_picked.split(" ")
    0.upto(3) {|num| @code[num+1] = $colors[code[num].to_i]}
    puts "You code is: "

    @code.each do |key, value|
      puts "#{key}. #{value}"
    end

  end

  def review_guess
    puts "The computer's code is: "

    $computer.code.each do |key, value|
      puts "#{key}. #{value}"
    end

    puts "How many correct colors did the computer guess in the correct position?"
    @reds = gets.chomp.to_i
    puts "How many correct colors did the computer guess in the incorrect postion?"
    @whites = gets.chomp.to_i
    @comp_win = true if @reds == 4
  end
end

class Computer
  attr_accessor :code, :reds, :whites, :win

  def generate_code
    $colors = ["white", "blue", "green", "yellow", "orange", "red"]
    @code = {1 => "", 2 => "", 3 => "", 4 => ""}
    code = []
    4.times {code << ($colors - code).sample}
    0.upto(3) {|num| @code[num+1] = code[num]}
  end

  def review_guess
    @win = false
    @reds = 0
    @whites = 0

    1.upto(4) do |num|
      if $player.code[num] == $computer.code[num]
        $computer.reds += 1
      else

        1.upto(4) do |other_num|
          if $player.code[num] == $computer.code[other_num]
            $computer.whites += 1
          end
        end

      end
    end
    puts "Reds: #{@reds}"
    puts "Whites: #{@whites}"
    @win = true if @reds == 4
  end

  def new_code
    keys = @code.keys
    guess_as_correct = []
    $player.reds.times {guess_as_correct << (keys - guess_as_correct).sample}
    change = []
    $player.whites.times {change << ((keys - guess_as_correct) - change).sample}
    switch = []
    change_colors = []
    change.each {|key| change_colors << @code[key]}

    0.upto(change.length - 1) do |num|

      loop do
        random_switch = ((keys - guess_as_correct) - switch).sample
        if random_switch != change[num]
          switch << random_switch
          break
        end
      end
      
      @code[switch[num]] = change_colors[num]
    end

    alter = ((keys - guess_as_correct) - switch)
    available_colors = $colors
    unchanged = guess_as_correct + switch
    unchanged_array = []
    0.upto(unchanged.length - 1) do |num|
      unchanged_array << @code[unchanged[num]]
    end
    available_colors -= unchanged_array
    new_colors = []
    alter.each {new_colors << (available_colors - new_colors).sample}
    0.upto(alter.length - 1) {|num| @code[alter[num]] = new_colors[num]}
  end
end

game = MasterMind.new
game.start
