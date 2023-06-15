require_relative 'Board'
require_relative 'Game'
require_relative 'Battleships'


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
