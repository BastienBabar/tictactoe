class PlayerList
  Player = Struct.new(:symbol, :name)
  def initialize x, o
    p1 = Player.new("x", x)
    p2 = Player.new("o", o)
    @players = [p1, p2]
    @current_player = 0
  end

  def current
    @players[@current_player]
  end

  def next!
    @current_player = (@current_player + 1) % 2
  end
end
