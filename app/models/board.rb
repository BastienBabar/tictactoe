require 'matrix'

class Board
  attr_accessor :matrix

  def initialize(matrix=nil)
    matrix ? @matrix = Matrix.rows(matrix) : @matrix = Matrix.build(3) { '_' }
  end

  def mark(x, y, symbol)
    @matrix.send(:[]=, x, y, symbol)
  end

  def finished?(symbol)
    if won? symbol
      true
    elsif board_full?
      'full'
    else
      false
    end
  end

  def board_full?
    self.fields.all? { |field| self.marked?(field) }
  end

  def marked?(field)
    @matrix[*field] != '_'
  end

  def winning_adjacency?(symbol, sequence)
    /#{symbol}{3}/ === sequence.join
  end

  def fields
    @matrix.each_with_index.map { |_, *field| field }
  end

  def rows
    @matrix.to_a
  end

  def columns
    @matrix.transpose.to_a
  end

  def diagonals
    (right_diagonals + left_diagonals).map { |diagonal| diagonal.map { |field| @matrix[*field] } }
  end

  def right_diagonals
    fields.group_by { |x, y| x - y }.values
  end

  def left_diagonals
    fields.group_by { |x, y| x + y }.values
  end

  def won?(symbol)
    (self.rows + self.columns + self.diagonals).any? do |sequence|
      winning_adjacency?(symbol, sequence)
    end
  end
end
