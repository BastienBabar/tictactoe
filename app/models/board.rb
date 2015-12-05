class Board
  def initialize
    @matrix = Matrix.build(3) { " " }
  end

  def mark x, y, symbol
    @matrix.send(:[]=, *field, symbol)
  end

  def finished? symbol
    if won? symbol
      symbol
    elsif board_full?
      'full'
    else
      false
    end

  end

  private
  def won? symbol
    (@matrix.rows + @matrix.columns + @matrix.diagonals).any? do |sequence|
      winning_adjacency?(symbol, sequence)
    end
  end

  def winning_adjacency? symbol, sequence
    /#{symbol}{3,}/ === sequence.join
  end

  def board_full?
    @matrix.each.map { |field| field === " " }.count === 0
  end

  def rows
    @matrix.to_a
  end

  def columns
    @matrix.transpose.to_a
  end

  def diagonals
    (right_diagonals + left_diagonals)
        .map { |diagonal| diagonal.map { |field| @matrix[*field] } }
  end

  def right_diagonals
    fields.group_by { |x, y| x - y }.values
  end

  def left_diagonals
    fields.group_by { |x, y| x + y }.values
  end
end
