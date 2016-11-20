require_relative "tile"

class Board
  attr_reader :grid
  def initialize(bomb_count = 10)
    @grid = (Array.new(9) { Array.new(9) { Tile.new } })
    @bomb_count = bomb_count
  end

  def set_pos
    grid.each_with_index do |row, idx1|
      row.each_with_index do |cell, idx2|
        cell.set_pos([idx1, idx2])
      end
    end
  end

  def run
    set_pos
    plant_bombs(@bomb_count)
    render
  end

  def plant_bombs(bomb_count)
    counter = 0
    until counter == bomb_count
      pos = [rand(9), rand(9)]
      if valid_plant?(pos)
        self[pos].bomb
        counter += 1
      end
    end

  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    grid[row][col] = value
  end

  def render
    display = []
    grid.each do |row|

      row.each do |cell|
        if cell.flagged
          display << "[f] "
        else
          if cell.revealed
            display << (cell.bombed ? "[X] " : "[#{cell.neighbor_bomb_count(self)}] ")
          else
            display << "[ ] "
          end
        end
      end
      display << "\n"
    end
    puts display.join("")
  end

  def neighbors(pos)
    row, col = pos
    all_neighbor_positions = []
    all_directions = {
      left: [row, col - 1],
      right: [row, col + 1],
      up: [row - 1, col],
      down: [row + 1, col],
      up_left: [row - 1, col - 1],
      up_right: [row - 1, col + 1],
      down_left: [row + 1, col - 1],
      down_right: [row + 1, col + 1]
    }
    all_directions.values.each do |pos|
      if valid_pos?(pos)
        all_neighbor_positions << pos
      end
    end
    all_neighbor_positions
  end

  def valid_pos?(pos)
    begin
      if self[pos]
        true
      end
    rescue
      false
    end
  end


  def valid_plant?(pos)
    self[pos].bombed ? false : true
  end

end

board = Board.new
board.run
