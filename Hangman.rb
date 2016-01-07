class Hangman
  attr_accessor :game_word, :hidden_word, :guess, :guesses, :win, :hidden_word_spaced, :turn, :saved_values, :exit, :game_save_names
  def play
      @exit = false
      generate_word
      @turn = 1
      puts "Do you want to load a saved game?"
      choice = gets.chomp

      if choice == "yes"
        load_game
      end
      puts "You can save the game at any time by entering SAVE"

      while @turn < 21 do
        puts "Turn #{@turn} of 20"
        puts "Your guesses: #{@guesses.join(", ")}"
        @hidden_word_spaced = @hidden_word
        @hidden_word_spaced = @hidden_word_spaced.split("")

        0.upto(@hidden_word.length - 2) do |num|
          @hidden_word_spaced[num] += " "
        end

        @hidden_word_spaced = @hidden_word_spaced.join("")
        puts @hidden_word_spaced
        player_guess
        break if @exit
        check_guess
        @turn += 1

        if win
          puts "You win!"
          break
        end

        if @turn == 21
          puts "You lose!"
          puts "The word was #{game_word}."
        end
      end
  end

  def generate_word
      @guesses = []
      f = File.open("wordsEn.txt", "r+")
      words = []
      f.each {|word| words << word}

      loop do
        @game_word = words.sample
        break if (@game_word.length > 4) && (@game_word.length < 13)
      end

      @hidden_word = ""
      @game_word.length.times {@hidden_word += "_"}
  end

  def player_guess
    puts "Guess a letter in the word. "
    @guess = gets.chomp

    if @guess == "SAVE"
      save_game
      @exit = true
    else @guesses << @guess
    end

  end

  def check_guess
      @win = false

      0.upto(@game_word.length - 1) do |num|
        if @guess == @game_word[num]
          @hidden_word[num] = @game_word[num]

          if @hidden_word == @game_word
            @win = true
            break
          end

        end
      end
  end

  def save_game
    @saved_values = [@game_word, @hidden_word, @turn, @guesses]
    puts "Create a name for your file"
    file_name = gets.chomp
    @game_save_names = File.open("Game_Save_Names.txt", "r+")
    @game_save_names.puts(file_name)
    game_save = File.new((file_name + ".txt"), "w")

    0.upto(3) do |num|
      if num == 3
        @saved_values[num].each {|guess| game_save.print(guess + ", ")}
      else game_save.puts(@saved_values[num])
      end
    end

  end

  def load_game
    puts "Type in which game you wish to load"
    @game_save_names = File.open("Game_Save_Names.txt", "r+")

    until @game_save_names.eof? do
      puts "Save File: #{@game_save_names.gets}"
    end

    file = gets.chomp
    game = File.open((file + ".txt"), "r")
    @game_word = game.gets
    @hidden_word = game.gets
    @turn = game.gets.to_i
    @guesses = game.gets.split(", ")
  end

end
game = Hangman.new
game.play
