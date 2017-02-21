require "test_helper"

class BoardTest < ActiveSupport::TestCase
  test "new" do
    matrix = Matrix.build(3) { "_" }
    x = 0
    y = 0
    matrix_marked = Matrix.rows([%w(x _ _), %w(_ _ _), %w(_ _ _)]).to_a
    matrix_full = Matrix.rows([%w(x o x), %w(o o x), %w(x o o)]).to_a
    matrix_winning = Matrix.rows([%w(x o x), %w(x x o), %w(x o x)]).to_a
    
    b = Board.new
    assert_equal b.matrix, matrix

    b.mark(x, y, "x")
    assert_equal Board.new(matrix_marked).matrix, b.matrix

    finished = b.finished?("x")
    assert_equal false, finished

    b = Board.new(matrix_full)
    finished = b.finished?("x")
    assert_equal finished, "full"

    b = Board.new(matrix_winning)
    finished = b.finished?("x")
    assert_equal finished, true
  end
end
