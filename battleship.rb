# initalise game
BEGIN {
    puts "Battleships in Ruby"
}

# after game won
END {
    puts "\n\nEnd of game"
}

# template
class Player
    # make variable avalible outside of class
    attr_accessor :Attack_board
    attr_accessor :Location_board

    # show play board
    def display_board(board)
        for i in board
            puts i.join
        end
    end

    # coordinates validation
    def coord(board_size)
        puts "Enter coordinates (column,row): "
        pos = gets
        # valid column
        if 0 < pos[2].to_i and pos[2].to_i < board_size + 1
            # valid row
            if 0 < pos[0].to_i and pos[0].to_i < board_size + 1
                # valid square
                return pos
            else
                puts "invalid row"
            end
        else
            puts "invalid column"
        end
    end

    # player setup
    def player_setup(board_size, ship_count)
        puts "player setup"
        # define boards
        @Attack_board = board(board_size)
        @Location_board = board(board_size)
        # place ship on board
        for i in 0..(ship_count - 1)
            controller = true
            # vlaidate enterd location
            while controller do
                begin
                    puts "\n\nShip #{i + 1}"
                    # show current ship locations
                    display_board(self.Location_board)
                    pos = coord(board_size)
                    if self.Location_board[pos[2].to_i][(pos[0].to_i * 2) ] == '-'  
                        # write possition to board
                        self.Location_board[pos[2].to_i][(pos[0].to_i * 2) ] = 'O'  
                        puts "valid location"
                        controller = false
                    else
                        puts "invalid location"
                    end
                rescue
                    puts "invalid input"
                end
            end
        end
    end

    # attack
    def turn(opponent_location_board, board_size)
        controller = true
        hit = false
        while controller do
            begin
                # show player board
                puts "\nYour locations"
                display_board(self.Location_board)
                # show opponent board
                puts "\nYour attacks"
                display_board(self.Attack_board)
                # get input
                pos = coord(board_size)
                if opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] == '-'  
                    # write miss to board
                    opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] = '/'  
                    self.Attack_board[pos[2].to_i][(pos[0].to_i * 2) ] = '/'  
                    puts "Miss"
                    controller = false
                elsif opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] == 'O'  
                    # write hit to board
                    opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] = 'X'  
                    self.Attack_board[pos[2].to_i][(pos[0].to_i * 2) ] = 'X'  
                    puts "Hit"
                    hit = true
                    controller = false
                else
                    puts "Invalid location"
                end
            rescue
                puts "Invalid input"
            end
        end
        return opponent_location_board, hit
    end
end

# board setup
def board(size)
    row = []
    board = []
    # first row indexing
    for i in 0..size
        row.append(i)
        row.append(' ')
    end
    board.append(row)
    # other rows
    for r in 0..size - 1
        row = []
        # first column indexing
        row.append(r + 1)
        # other columns
        for c in 0..size - 1
            row.append(' ')
            row.append('-')
        end
        board.append(row)
    end
    return board
end

# game play
def game(ship_count, board_size)
    player1_hit = 0
    player2_hit = 0
    while true do
        # player 1 turn
        puts "\n\n\n\n\nPlayer 1"
        Player2.Location_board, hit = Player1.turn(Player2.Location_board, board_size)
        # if player1 hit player2
        if hit
            player1_hit += 1
            # determin when games over (all opponent ships sunk)
            unless player1_hit < ship_count
                break
            end
        end
        # player 2 turn
        puts "\n\n\n\n\nPlayer 2"
        Player1.Location_board, hit = Player2.turn(Player1.Location_board, board_size)
        # if player2 hit player1
        if hit
            player2_hit += 1
            # determin when games over (all opponent ships sunk)
            unless player2_hit < ship_count
                break
            end
        end
    end
end

# settings for game
def game_settings()
    # get board size
    while true
        begin
            puts "\nEnter game board size (2 - 9): "
            board_size = gets.to_i
            # if correct size
            if 1 < board_size and board_size < 10
                break
            else
                puts "Invalid input"
            end
        rescue
            puts "Invalid input"
        end
    end
    # get ship amount
    while true
        begin
            max_ship = ((board_size ** 2) / 2.5).round
            puts "Enter ship amount (1 - #{max_ship})"
            ship_count = gets.to_i
            if 0 < board_size and board_size < max_ship + 1
                break
            else
                puts "Invalid input"
            end
        rescue
            puts "Invalid input"
        end
    end
    return board_size, ship_count
end

# run start
board_size, ship_count = game_settings()
Player1 = Player.new
Player1.player_setup(board_size, ship_count)
Player2 = Player.new
Player2.player_setup(board_size, ship_count)

# game play
game(ship_count, board_size)
