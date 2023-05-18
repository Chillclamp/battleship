# class for player methods
class Player
    # initiate player
    def initalise(board_size)
        # make variable avalible outside of class
        attr_accessor :Attack_board
        attr_accessor :Location_board

        # define player boards
        @Attack_board = Board.board_creation(board_size)
        @Location_board = Board.board_creation(board_size)
    end
end

# class for board methods
class Board
    # get board size
    def board_size()
        puts "Enter board size 2-9: "
        board_size_given = gets
        return board_size_given
    end

    # validate board size 
    def board_size_validation(board_size_given)
        error = []
        begin
            if 2 <= board_size_given.to_i and board_size_given.to_i <= 9
                return error, board_size_given.to_i
            else
                error.append("Invalid board size")
            end
        rescue
            error.append("Invalid input")
        end
        return error, board_size_given
    end

    # board creation
    def board_creation(size)
        row = []
        board = []
        # first row indexing
        for column_num in 0..size
            row.append(column_num)
            row.append(' ')
        end
        board.append(row)
        # other rows
        for row_num in 0..size - 1
            row = []
            # first column indexing
            row.append(row_num + 1)
            # other columns
            for column in 0..size - 1
                row.append(' ')
                row.append('-')
            end
            board.append(row)
        end
        return board
    end

    # calculate max ship amount
    def ship_max(board_size_given)
        ship_amoumt_max = (board_size_given ** 2) / 3
        if ship_amoumt_max < 1
            ship_amoumt_max = 1
        end 
        return ship_amoumt_max.round()
    end

    # get ship amount
    def ship_amount(ship_amoumt_max)
        puts "Enter ship amount (1-#{ship_amoumt_max}): "
        ship_amoumt_given = gets
        return ship_amoumt_given
    end

    # validate ship amount
    def ship_amount_validation(ship_amount_given, ship_amoumt_max)
        error = []
        if ship_amoumt_given <= ship_amoumt_max
            return error, ship_amoumt_given
        end
        error.append("Invalid amount")
        return error, ship_amoumt_given
    end

    # get coordinates
    def coordinates_input()
        puts "\nEnter coordinates (column,row): "
        coordinates = gets
        return coordinates
    end 

    # validate coordinates
    def coordinates_validation(coordinates, max_size)
        error = []
        begin
            # valid column
            if 1 < coordinates[2].to_i and coordinates[2].to_i <= max_size
                # valid row
                if 1 < coordinates[0].to_i and coordinates[0].to_i <= max_size
                    # valid square
                    return error, coordinates
                else
                    # invalid column
                    error.append("Invalid column")
                end
            else
                # invalid row
                error.append("Invalid row")
            end
        rescue
            error.append("Invalid input")
        end
        return error, coordinates
    end
end

# class for game methods
class Game
    # initiate 'object'
    def initalise()

    end

    # ship placement - validate
    def ship_placement(player_location_board, coordinates)
        error = []
        response = []
        # validate space
        if player_location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == '-'  
            # write possition to board
            player_location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'O'  
            response.append("valid location")
        else
            error.append("invalid location")
        end
        return error, response
    end

    # ship attack
    def attack(player_attack_board, opponent_location_board, coordinates)
        # miss
        if opponent_location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == '-'  
            # write miss to board
            opponent_location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = '/'  
            player_attack_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = '/'  
            response.append("Miss")
        # hit
        elsif opponent_location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == 'O'  
            # write hit to board
            opponent_location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'X'  
            player_attack_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'X'  
            response.append("Hit")
        else
            error.append("Invalid location")
        end
        return error, response, player_attack_board, opponent_location_board 
    end
end
    

# other methods
# 'clear' terminal
def clear_terminal()
    for loops in 0..100
        puts " "
    end
end

# display board
def display_board(board)
    for row in board
        puts row.join
    end
end

# get board size
def board_size()
    puts "Enter board size 2-9: "
    board_size_given = gets
    return board_size_given
end

# GAMEPLAY
# selcet board size
# select ship amount
# place ships
# play game
    # atack opponent
    # loop til win

### PROCESS ###
# get board size
while true
    board_size_given = Board.board_size()
    error, board_size_validated = Board.board_size_validation(board_size_given)
    if error.length == 0 
        break
    else 
        puts error
    end
end

# get ship amount
ship_amoumt_max = Board.ship_max()
while true
    ship_amoumt_given = Board.ship_amount(ship_amoumt_max)
    error, ship_amount_given = Board.ship_amount_validation(ship_amoumt_given, ship_amoumt_max)
    if error.length == 0 
        break
    else 
        puts error
    end
end

# player 1
    # initalise player
    # place ships
# player 2
    # initalise player
    # place ships
# game play
    # loop until win
        # clear terminal and await player input to display player 1 content
        # player 1 attack
        # clear terminal and await player input to display player 2 content
        # player 2 attack