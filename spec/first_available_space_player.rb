require 'player'

class FirstAvailableSpacePlayer < Player
  def initialize(mark)
    super(mark) 
  end

  def make_move(board)
    board.make_move(board.available_spaces.first, @mark)
  end
end
