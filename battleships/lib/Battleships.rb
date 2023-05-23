require File.expand_path('Board.rb', __dir__)
require File.expand_path('Game.rb', __dir__)
require File.expand_path('Player.rb', __dir__)

# main game controler
class Battleships
    # current player
    attr_accessor :current_player
    def initalise()
        @current_player = 0
    end

    # 'clear' terminal
    def clear_terminal()
        (0..100).each do 
            puts " "
        end
        puts "Player #{self.current_player}"
        puts "Enter to continue"
        gets
    end

    # display board
    def display_board(board)
        board.each do |row|
            puts row.join
        end
    end

    # get board size
    def board_setup()
        while true
            Board.board_size()
            error = Board.board_size_validation()
            break if error.empty?
            puts error
        end
    end
    
    # get ship amount
    def ship_amount_setup()
        Board.ship_max()
        while true
            Board.ship_amount()
            error = Board.ship_amount_validation()
            break if error.empty?
            puts error
        end
    end

    # player initalise
    def player_initalise(player_num)
        player = Player.new
        player.initalise()
        player.player_num = player_num
        self.current_player = player.player_num
        Battleships.clear_terminal()
        Battleships.player_ships(player)
        return player
    end

    # process for place player ships
    def player_ships(player)
        # place ships
        (1..Board.ship_amoumt_given).each do |ship|
            while true
                (0..5).each do 
                    puts " "
                end
                Battleships.display_board(player.location_board)
                coordinates = Board.coordinates_input()
                error, coordinates = Board.coordinates_validation(coordinates)
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
        Battleships.clear_terminal()
        while true
            while true
                # get coordinates
                puts "Location board"
                Battleships.display_board(player.location_board)
                puts "Attack board"
                Battleships.display_board(player.attack_board)
                coordinates = Board.coordinates_input()
                error, coordinates = Board.coordinates_validation(coordinates)
                break if error.empty?
                puts error
            end

            # attack board
            error = Game.attack(player, opponent, coordinates)
            break if error.empty?
        end
    end
end 