require_relative "board"

class Tile

  attr_reader :bombed, :revealed, :flagged, :pos
  # attr_accessor :pos

  def initialize
    @bombed = false
    @revealed = false
    @flagged  = false
    # @board = board
    @pos = nil
  end
  #
  # def self.set_board(board)
  #   @board = board
  #   board.grid.each_with_index do |row, idx1|
  #     row.each_with_index do |cell, idx2|
  #       cell.set_pos([idx1, idx2])
  #     end
  #   end
  # end

  def set_pos(pos)
    @pos = pos
  end

  def reveal
    @revealed = true
  end

  def neighbors
    all_neighbors = []
    neighbor_positions = @board.neighbors(self.pos)
    neighbor_positions.each do |pos|
      all_neighbors << board[pos]
    end
    all_neighbors
  end

  def neighbor_bomb_count(board)
    @board = board

    count = 0
    # neighbors = neighbors(@board)

    neighbors.each do |tile|
      if tile.bombed
        count += 1
      end
    end
    count
  end

  def bomb
    @bombed = true
  end

  def flag
    @flagged = true
  end

end
