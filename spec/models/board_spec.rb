require 'rails_helper'
require 'matrix'

RSpec.describe Board, type: :model do
  let(:matrix) { Matrix.build(3) { '_'} }
  let(:x)      { 0 }
  let(:y)      { 0 }
  let(:matrix_marked) { Matrix.rows([['x','_','_'],['_','_','_'],['_','_','_']]).to_a }
  let(:matrix_full) { Matrix.rows([['x','o','x'],['o','o','x'],['x','o','o']]).to_a }
  let(:matrix_winning) { Matrix.rows([['x','o','x'],['x','x','o'],['x','o','x']]).to_a }

  describe 'board' do
    b = Board.new
    context 'new' do
      it { expect(b.matrix).to eq matrix }
    end

    context 'mark' do
      before { b.mark(x, y, 'x') }
      it { expect(b.matrix).to eq Board.new(matrix_marked).matrix }
    end

    context 'not finished' do
      it {
        finished = b.finished?('x')
        expect(finished).to eq false
      }
    end

    context 'finished' do
      context 'board full' do
        before { b = Board.new(matrix_full) }
        it {
          finished = b.finished?('x')
          expect(finished).to eq 'full'
        }
      end

      context 'board won' do
        before { b = Board.new(matrix_winning) }
        it {
          finished = b.finished?('x')
          expect(finished).to eq 'x'
         }
      end
    end
  end
end
