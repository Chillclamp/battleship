require File.expand_path('Board.rb', __dir__)
require File.expand_path('Game.rb', __dir__)
require File.expand_path('Battleships.rb', __dir__)

# setup
Board = Board.new
Game = Game.new
Battleships = Battleships.new
Battleships.initalise()

# game settings
Battleships.board_setup()
Battleships.ship_amount_setup()

# initalise players
Player1 = Battleships.player_initalise(1)
Player2 = Battleships.player_initalise(2)
players = [Player1, Player2]

# game play
while true
    # player turn
    Battleships.current_player = players[0].player_num
    Battleships.player_turn(players[0], players[1])

    # if player won
    if players[0].ship_hits == Board.ship_amoumt_given
        puts "\n\n\nplayer #{players[0].player_num} won\n"
        break
    end

    # swap attacker and opponent
    players = [players[1], players[0]]
end

# display both board at end
(0..Player1.location_board.length - 1).each do |rows|
    puts "#{Player1.location_board[rows].join}           #{Player2.location_board[rows].join}"
end