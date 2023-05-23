# class for board methods
class Board
    # make variable avalible outside of class
    attr_accessor :attack_board
    attr_accessor :location_board
    attr_accessor :board_size_given
    attr_accessor :board
    attr_accessor :ship_amoumt_given
    attr_accessor :ship_amoumt_max

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
        (0..self.board_size_given).each do |column_num|
            row.append(column_num)
            row.append(' ')
        end
        board.append(row)
        # other rows
        (0..self.board_size_given - 1).each do |row_num|
            row = []
            # first column indexing
            row.append(row_num + 1)
            # other columns
            (0..self.board_size_given - 1).each do |column|
                row.append(' ')
                row.append('-')
            end
            board.append(row)
        end
        return board
    end

    # calculate max ship amount
    def ship_max()
        @ship_amoumt_max = (((self.board_size_given ** 2) / 1.5).round()).to_i
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
            # change ship_amoumt_given to integer in method
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
        begin
          column = coordinates[0].to_i
          row = coordinates[2].to_i
          if (1..board_size_given).include?(column) && (1..board_size_given).include?(row)
            return [], coordinates
          else
            return ["Invalid column"] unless (1..board_size_given).include?(column)
            return ["Invalid row"] unless (1..board_size_given).include?(row)
          end
        rescue
          return "Invalid input"
        end
    end
end

# class for player methods
class Player
    # make variable avalible outside of class
    attr_accessor :attack_board
    attr_accessor :location_board
    attr_accessor :ship_hits

    # initiate player
    def initalise()
        # define player boards
        @attack_board = Game_board.board_creation() 
        @location_board = Game_board.board_creation() 
        @ship_hits = 0
    end
end

# class for game methods
class Game
    # ship placement - validate
    def ship_placement(player, coordinates)
        # validate space
        if player.location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] == '-'  
            # write possition to board
            player.location_board[coordinates[2].to_i][(coordinates[0].to_i * 2) ] = 'O'  
            return []
        else
            return ["invalid location"]
        end
    end

    # ship attack
    def attack(player, opponent, coordinates)
        # miss
        row = coordinates[2].to_i
        column = coordinates[0].to_i * 2
        if opponent.location_board[row][column] == '-'  
            # write miss to board
            opponent.location_board[row][column] = '/'  
            player.attack_board[row][column] = '/'  
            # error
            return []
        # hit
        elsif opponent.location_board[row][column] == 'O'  
            # write hit to board
            opponent.location_board[row][column] = 'X'  
            player.attack_board[row][column] = 'X'
            player.ship_hits += 1 
            # error
            return []
        else
            # error
            return ["Invalid location"]
        end 
    end
end


# main game controler
class Battleships
    # other methods
    # 'clear' terminal
    def clear_terminal()
        (0..100).each do 
            puts " "
        end
        puts "Player #{self.player_num}"
        puts "Enter to continue"
        gets
    end

    # display board
    def display_board(board)
        board.each do |row|
            puts row.join
        end
    end

    # process for place player ships
    def player_ships(player)
        # place ships
        (1..Game_board.ship_amoumt_given).each do |ship|
            while true
                (0..5).each do 
                    puts " "
                end
                Board.display_board(player.location_board)
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
    def player_turn(player, opponent)
        clear_terminal()
        while true
            while true
                # get coordinates
                puts "Location board"
                Board.display_board(player.location_board)
                puts "Attack board"
                Board.display_board(player.attack_board)
                coordinates = Game_board.coordinates_input()
                error, coordinates = Game_board.coordinates_validation(coordinates)
                break if error.empty
                puts error
            end

            # attack board
            error = Game.attack(player, opponent, coordinates)
            break if error.empty
        end
    end

    ### PROCESS ###
    Game_board = Board.new
    Game = Game.new

    # get board size
    def board_setup()
        while true
            Game_board.board_size()
            error = Game_board.board_size_validation()
            break if error.empty 
            puts error
        end
    end

    # get ship amount
    def ship_amount_setup()
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
    end

    def player_setup()
        # player 1
        clear_terminal()
        Player = Player.new
        Player.initalise()
        player_ships(Player)
        return player
    end

    # game play
    # loop until win - DO SOMETHING WITH THIS
    while true
        # player 1 turn
        self.player_num = 1
        player_turn(Player1, Player2)

        # if won
        if Player1.ship_hits == Game_board.ship_amoumt_given
            puts "\n\n\nplayer 1 won\n"
            break
        end

        # player 2 turn
        self.player_num = 2
        player_turn(Player2, Player1)

        # if won
        if Player2.ship_hits == Game_board.ship_amoumt_given
            puts "\n\n\nplayer 2 won\n"
            break
        end
    end

    # display both board at end
    (0..Player1.location_board.length - 1).each do |rows|
        puts "#{Player1.location_board[rows].join}           #{Player2.location_board[rows].join}"
end