require 'test_helper'

class PlayerListTest < ActiveSupport::TestCase
  test 'new' do
    p1 = PlayerList::Player.new("x", "Player X")
    p2 = PlayerList::Player.new("o", "Player O")

    pl = PlayerList.new("Player X", "Player O", 0)
    assert_equal pl.players, [p1, p2]
    assert_equal pl.current_player, 0
    assert_equal pl.current, p1
  end

  test 'next' do
    p2 = PlayerList::Player.new("o", "Player O")
    pl = PlayerList.new("Player X", "Player O", 0)
    pl.next!
    assert_equal pl.current, p2
  end
end
