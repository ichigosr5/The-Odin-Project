class Block
  attr_accessor :position, :right_relative, :left_relative, :top_relative ,:bottom_relative

  def initialize(position)
    @position = position
  end
end

def create_chess_board(pos)
  $chess_board ||= {}
  return $chess_board[pos] unless $chess_board[pos].nil?
  $chess_board[pos] = Block.new(pos)
  ($chess_board[pos].top_relative = create_chess_board([pos[0], pos[1] + 1])) if pos[1] < 8
  ($chess_board[pos].right_relative = create_chess_board([pos[0] + 1, pos[1]])) if pos[0] < 8
  ($chess_board[pos].left_relative = create_chess_board([pos[0] - 1, pos[1]])) if pos[0] > 1
  ($chess_board[pos].bottom_relative = create_chess_board([pos[0], pos[1] - 1])) if pos[1] > 1
  return $chess_board[pos]
end

def knight_moves(start, stop, first = true)
  if start == stop
      path = []
      square = start
      ($moves[start] + 1).times do |num|
         path.unshift(square)
         square = $came_from[square]
      end
      puts "You made it in #{$moves[start]} moves! Here is your path: "
      path.each {|square| puts square.to_s}
      return nil
  end

  $came_from ||= {}
  $will_visit ||= []
  $will_visit -= [start] unless first
  $visited ||= []
  $visited << start
  $moves ||= {}
  $moves[start] = 0 if first
  x = start[0]
  y = start[1]
  valid_moves = ($chess_board.keys - ($will_visit + $visited)).select do |s|
    (((s[0] == x + 1) || (s[0] == x - 1)) && ((s[1] == y + 2) || (s[1] == y - 2))) ||
    (((s[0] == x + 2) || (s[0] == x - 2)) && ((s[1] == y + 1) || (s[1] == y - 1)))
  end
  valid_moves.each do |square|
    $will_visit << square if $will_visit.none? {|square2| square2 == square}
    $came_from[square] = start
    $moves[square] = $moves[start] + 1
  end
  $queue ||= []
  $queue -= [$queue[0]] unless $queue.empty?
  $queue += valid_moves
  knight_moves($queue[0], stop, false)
end

create_chess_board([1,1])
knight_moves([5,3], [3,3])
