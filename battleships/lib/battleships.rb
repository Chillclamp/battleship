# class for board methods
class Board
    # make variable avalible outside of class
    attr_accessor :Attack_board
    attr_accessor :Location_board
    attr_accessor :board_size_given
    attr_accessor :board
    attr_accessor :ship_amoumt_given
    attr_accessor :ship_amoumt_max

    # initalise
    def initalise()

    end

    # get board size
    def board_size()
        puts "Enter board size 2-9: "
        @board_size_given = gets
    end

    # validate board size 
    def board_size_validation()
        error = []
        begin
            if 2 <= self.board_size_given.to_i and self.board_size_given.to_i <= 9
                self.board_size_given = self.board_size_given.to_i
                return error
            else
                error.append("Invalid board size")
            end
        rescue
            error.append("Invalid input")
        end
        return error
    end

    # board creation
    def board_creation()
        row = []
        board = []
        # first row indexing
        for column_num in 0..self.board_size_given
            row.append(column_num)
            row.append(' ')
        end
        board.append(row)
        # other rows
        for row_num in 0..self.board_size_given - 1
            row = []
            # first column indexing
            row.append(row_num + 1)
            # other columns
            for column in 0..self.board_size_given - 1
                row.append(' ')
                row.append('-')
            end
            board.append(row)
        end
        return board
    end

    # calculate max ship amount
    def ship_max()
        @ship_amoumt_max = (((self.board_size_given ** 2) / 2.5).round()).to_i
        if self.ship_amoumt_max < 1
            self.ship_amoumt_max = 1
        end 
    end

    # get ship amount
    def ship_amount()
        puts "Enter ship amount (1-#{self.ship_amoumt_max}): "
        self.ship_amoumt_given = gets
    end

    # validate ship amount
    def ship_amount_validation()
        begin
            self.ship_amoumt_given = self.ship_amoumt_given.to_i
            if self.ship_amoumt_given <= self.ship_amoumt_max
                return []
            end
            return "Invalid amount"
        rescue
            return "Invalid amount"
        end
    end

    # get coordinates
    def coordinates_input()
        puts "\nEnter coordinates (column,row): "
        coordinates = gets
        return coordinates
    end 

    # validate coordinates
    def coordinates_validation(coordinates)
        error = []
        begin
            # valid column
            if 1 <= coordinates[2].to_i and coordinates[2].to_i <= self.board_size_given
                # valid row
                if 1 <= coordinates[0].to_i and coordinates[0].to_i <= self.board_size_given
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

# class for player methods
class Player
    # make variable avalible outside of class
    attr_accessor :Attack_board
    attr_accessor :Location_board
    attr_accessor :ship_hits

    # initiate player
    def initalise()
        # define player boards
        @Attack_board = Game_board.board_creation() 
        @Location_board = Game_board.board_creation() 
        @ship_hits = 0
    end
end

# class for game methods
class Game
    # initiate 'object'
    def initalise()

    end

    # ship placement - validate
    def ship_placement(player, coordinates)
        # validate space
        if player.Location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == '-'  
            # write possition to board
            player.Location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'O'  
            return []
        else
            return ["invalid location"]
        end
    end

    # ship attack
    def attack(player, opponent, coordinates)
        # miss
        if opponent.Location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == '-'  
            # write miss to board
            opponent.Location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = '/'  
            player.Attack_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = '/'  
            # error
            return []
        # hit
        elsif opponent.Location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == 'O'  
            # write hit to board
            opponent.Location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'X'  
            player.Attack_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'X'
            player.ship_hits += 1 
            # error
            return []
        else
            # error
            return ["Invalid location"]
        end 
    end
end
    

# other methods
# 'clear' terminal
def clear_terminal(player_num)
    for loops in 0..100
        puts " "
    end
    puts "Player #{player_num}"
    puts "Enter to continue"
    gets
end

# display board
def display_board(board)
    for row in board
        puts row.join
    end
end

# player ships
def player_ships(player)
    # place ships - OPTIMISE
    for ship in 1..Game_board.ship_amoumt_given
        while true
            for space in 0..5
                puts " "
            end
            display_board(player.Location_board)
            coordinates = Game_board.coordinates_input()
            error, coordinates = Game_board.coordinates_validation(coordinates)
            if error.length == 0
                break
            end
            puts error
        end
        Game.ship_placement(player, coordinates)
    end
end

# player turn
def player_turn(player, opponent, player_num)
    clear_terminal(player_num)
    while true
        while true
            # get coordinates
            puts "Location board"
            display_board(player.Location_board)
            puts "Attack board"
            display_board(player.Attack_board)
            coordinates = Game_board.coordinates_input()
            error, coordinates = Game_board.coordinates_validation(coordinates)
            if error.length == 0
                break
            end
            puts error
        end

        # attack board
        error = Game.attack(player, opponent, coordinates)
        if error.length == 0
            break
        end
    end
end

### PROCESS ###
Game_board = Board.new
Game = Game.new
# get board size
while true
    Game_board.board_size()
    error = Game_board.board_size_validation()
    if error.length == 0 
        break
    else 
        puts error
    end
end

# get ship amount
Game_board.ship_max()
while true
    Game_board.ship_amount()
    error = Game_board.ship_amount_validation()
    if error.length == 0 
        break
    else 
        puts error
    end
end

# player 1
clear_terminal(1)
Player1 = Player.new
Player1.initalise()
player_ships(Player1)

# player 2
clear_terminal(2)
Player2 = Player.new
Player2.initalise()
player_ships(Player2)


# game play
# loop until win
while true
    # player 1 turn
    player_turn(Player1, Player2, 1)

    # if won
    if Player1.ship_hits == Game_board.ship_amoumt_given
        puts "\n\n\nplayer 1 won"
        break
    end

    # player 2 turn
    player_turn(Player2, Player1, 2)

    # if won
    if Player2.ship_hits == Game_board.ship_amoumt_given
        puts "\n\n\nplayer 2 won"
        break
    end
end

# display both board at end
for rows in 0..Player1.Location_board.length - 1
    puts "#{Player1.Location_board[rows].join}           #{Player2.Location_board[rows].join}"
end