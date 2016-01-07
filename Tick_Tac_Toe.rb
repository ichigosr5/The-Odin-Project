class Block
  attr_accessor :marked
end

def play
  pos_array = ["top", "mid", "bot"]
  pos_hash = {}
  pos_array.each do |pos|
    1.upto(3) do |num|
      pos_hash[pos + num.to_s] = Block.new
    end
  end

  top = [pos_hash["top1"], pos_hash["top2"], pos_hash["top3"]]
  mid = [pos_hash["mid1"], pos_hash["mid2"], pos_hash["mid3"]]
  bot = [pos_hash["bot1"], pos_hash["bot2"], pos_hash["bot3"]]

  board = [top, mid, bot]

  win = false
  player = "X"
  1.upto(9) do |num|
    puts "            #{top[0].marked}      |     #{top[1].marked}      |     #{top[2].marked}"
    puts "      ____________________________________________"
    puts "            #{mid[0].marked}      |     #{mid[1].marked}      |     #{mid[2].marked}"
    puts "      ____________________________________________"
    puts "            #{bot[0].marked}      |     #{bot[1].marked}      |     #{bot[2].marked}"

    print "It is your turn Player: #{player} "
    print "Choose a block "
    block = gets.chomp
    pos_hash[block] = player

    if num > 4
      0.upto(2) do |row_num|
        0.upto(2) do |col_num|
          if row_num == 0
            if board[0][col_num].marked == board[1][col_num].marked && board[2][col_num].marked
              win = true
            end
          end

          if col_num == 0
            if board[row_num][0].marked == board[row_num][1].marked && board[row_num][2].marked
              win = true
            end
          end

          if row_num && col_num == 0
            if board[0][0].marked == board[1][1].marked && board[2][2].marked
              win = true
            end
          end

          if (row_num == 0) && (col_num == 2)
            if board[0][2].marked == board[1][1].marked && board[2][0].marked
              win = true
            end
          end

        end
      end
    end
    break if win
    if player == "X"
      player = "O"
    else player = "X"
    end
  end
  if win
    puts "            #{top[0].marked}      |     #{top[1].marked}      |     #{top[2].marked}"
    puts "      ____________________________________________"
    puts "            #{mid[0].marked}      |     #{mid[1].marked}      |     #{mid[2].marked}"
    puts "      ____________________________________________"
    puts "            #{bot[0].marked}      |     #{bot[1].marked}      |     #{bot[2].marked}"
    puts "Player: #{player} wins!"
  else puts "It is a tie!"
end
end
play
