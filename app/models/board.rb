require 'matrix'

class Board
  attr_accessor :matrix

  # new Matrix object with 3 rows and 3 columns - classic tic tac toe
  def initialize(matrix=nil)
    matrix ? @matrix = Matrix.rows(matrix) : @matrix = Matrix.build(3) { '_' }
  end

  # use send Object method to force the Matrix edit to add a new mark - X or O
  def mark(x, y, symbol)
    @matrix.send(:[]=, x, y, symbol)
  end

  # check if board is full or someone won!
  def finished?(symbol)
    if won? symbol
      true
    elsif board_full?
      'full'
    else
      false
    end
  end

  # functions to check if board is full
  def board_full?
    self.fields.all? { |field| self.marked?(field) }
  end

  # is there any '_' left?
  def marked?(field)
    @matrix[*field] != '_'
  end

  # get all fields in the Matrix object
  def fields
    @matrix.each_with_index.map { |_, *field| field }
  end

  # check if current symbol make a win
  def won?(symbol)
    (self.rows + self.columns + self.diagonals).any? do |sequence|
      winning_adjacency?(symbol, sequence)
    end
  end

  # any sequence sent is true?
  # checking rows, columns and diagonals
  def winning_adjacency?(symbol, sequence)
    /#{symbol}{3}/ === sequence.join
  end

  def rows
    @matrix.to_a
  end

  def columns
    @matrix.transpose.to_a
  end

  # get all possible diagonals in the Matrix object
  def diagonals
    (right_diagonals + left_diagonals).map { |diagonal| diagonal.map { |field| @matrix[*field] } }
  end

  def right_diagonals
    fields.group_by { |x, y| x - y }.values
  end

  def left_diagonals
    fields.group_by { |x, y| x + y }.values
  end

end
