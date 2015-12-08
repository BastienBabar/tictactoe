class PlayerList
  Player = Struct.new(:symbol, :name)
  attr_accessor :players, :current_player

  def initialize(x, o, current_player=0)
    p1 = Player.new('x', x)
    p2 = Player.new('o', o)
    @players = [p1, p2]
    @current_player = current_player
  end

  def current
    @players[@current_player]
  end

  def next!
    @current_player = (@current_player + 1) % 2
  end
end
