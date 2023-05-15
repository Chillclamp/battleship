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
    
    # ship placement
    def ship_placement(board_size)
        response = []
        begin
            pos = Board.coord_validation(0, board_size)
            if self.Location_board[pos[2].to_i][(pos[0].to_i * 2) ] == '-'  
                # write possition to board
                self.Location_board[pos[2].to_i][(pos[0].to_i * 2) ] = 'O'  
                return "valid location"
            else
                return "invalid location"
            end
        rescue
            return "invalid input"
        end
    end
end

# class for board methods
class Board
    # board creation
    def board_creation(size)
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

    # get board size
    def board_size()
        puts "Enter board size 2-9: "
        board_size_given = gets
        return board_size_given
    end
    # validate board size 

    # calculate max ship amount
    # get ship amount
    def board_size(ship_amoumt_max)
        puts "Enter ship amount (1-#{ship_amoumt_max}): "
        ship_amoumt_given = gets
        return ship_amoumt_given
    end
    # validate ship amount

end

# class for game methods
class game
    # initiate 'object'
    def initalise()

    end

    # get coordinates
    # validate coordinates
    def coord_validation(min_size, max_size)
        # get coordinates
        begin ##HERE
            puts "\nEnter coordinates (column,row): "
            pos = gets
            # valid column
            if (min_size - 1) < pos[2].to_i and pos[2].to_i < (max_size + 1)
                # valid row
                if (min_size - 1) < pos[0].to_i and pos[0].to_i < (max_size + 1)
                    # valid square
                    return pos
                else
                    # invalid column
                    return "Invalid column"
                end
            else
                # invalid row
                return "Invalid row"
            end
        rescue
            return "Invalid input"
        end
    end

    # ship attack
    def attack(opponent_location_board)
        hit = false
        begin
            # get input
            pos = coord(board_size)
            if opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] == '-'  
                # write miss to board
                opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] = '/'  
                self.Attack_board[pos[2].to_i][(pos[0].to_i * 2) ] = '/'  
                puts "Miss"
            elsif opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] == 'O'  
                # write hit to board
                opponent_location_board[pos[2].to_i][(pos[0].to_i * 2) ] = 'X'  
                self.Attack_board[pos[2].to_i][(pos[0].to_i * 2) ] = 'X'  
                puts "Hit"
                hit = true
            else
                puts "Invalid location"
            end
        rescue
            puts "Invalid input"
        end
        return opponent_location_board, hit
    end
end
    end
    

# other methods
# 'clear terminal'
def clear_terminal()
    for loops in 0..100
        puts " "
    end
end

# GAMEPLAY
# selcet board size
# select ship amount
# play game

### PROCESS ###
# get board size
# make board
# get ship amount
# 

# show player board
puts "\nYour locations"
display_board(self.Location_board)
# show opponent board
puts "\nYour attacks"
display_board(self.Attack_board)