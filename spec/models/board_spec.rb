require "rails_helper"
require "matrix"

RSpec.describe Board, type: :model do
  let(:matrix) { Matrix.build(3) { "_" } }
  let(:x)      { 0 }
  let(:y)      { 0 }
  let(:matrix_marked) do
    Matrix.rows([%w(x _ _), %w(_ _ _), %w(_ _ _)]).to_a
  end
  let(:matrix_full) do
    Matrix.rows([%w(x o x), %w(o o x), %w(x o o)]).to_a
  end
  let(:matrix_winning) do
    Matrix.rows([%w(x o x), %w(x x o), %w(x o x)]).to_a
  end

  describe "board" do
    b = Board.new
    context "new" do
      it { expect(b.matrix).to eq matrix }
    end

    context "mark" do
      before { b.mark(x, y, "x") }
      it { expect(b.matrix).to eq Board.new(matrix_marked).matrix }
    end

    context "not finished" do
      it do
        finished = b.finished?("x")
        expect(finished).to eq false
      end
    end

    context "finished" do
      context "board full" do
        before { b = Board.new(matrix_full) }
        it do
          finished = b.finished?("x")
          expect(finished).to eq "full"
        end
      end

      context "board won" do
        before { b = Board.new(matrix_winning) }
        it do
          finished = b.finished?("x")
          expect(finished).to eq "x"
        end
      end
    end
  end
end
