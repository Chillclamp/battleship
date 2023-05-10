# initalise game
BEGIN {
    # attr_accessor :Player1
    # attr_accessor :Player2
    # OVER HALL
    puts "1 ship \n3x3 grid"
}

# after game won
END {
    puts "end of game"
}

# template
class Player
    attr_accessor :Attack_board
    attr_accessor :Location_board
    def initialize()
        # define boards
        @Attack_board = [['x', 1, 2, 3], [1, '-', '-', '-'], [2, '-', '-', '-'], [3, '-', '-', '-']]
        @Location_board = [['x', 1, 2, 3], [1, '-', '-', '-'], [2, '-', '-', '-'], [3, '-', '-', '-']]
    end

    # show play board
    def display_board(board)
        for i in board
            puts i.join
        end
    end

    # coordinates validation
    def coord()
        puts "Enter coordinates (column,row): "
        pos = gets
        # valid column
        if 0 < pos[2].to_i and pos[2].to_i < 5 # CHANGE TO BOARD SIZE
            # valid row
            if 0 < pos[0].to_i and pos[0].to_i < 5 # CHANGE TO BOARD SIZE
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
    def player_setup()
        puts "player setup"
        # place ship on board
        $ship_count = 1 # ONLY FOR TEST
        for i in 0..($ship_count - 1)
            controller = true
            # vlaidate enterd location
            while controller do
                begin
                    puts "\n\nShip #{i + 1}"
                    # show current ship locations
                    display_board(self.Location_board)
                    pos = coord()
                    if self.Location_board[pos[2].to_i][pos[0].to_i] == '-' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                        # WRITE POSITION TO BOARD
                        self.Location_board[pos[2].to_i][pos[0].to_i] = 'O' # REMOVE -1 IF LABEL IS ADDED TO BOARD
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
    def turn(opponent_location_board)
        puts ("\n\nturn")
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
                pos = coord()
                if opponent_location_board[pos[2].to_i][pos[0].to_i] == '-' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                    # WRITE MISS TO BOARD
                    opponent_location_board[pos[2].to_i][pos[0].to_i] = '/' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                    self.Attack_board[pos[2].to_i][pos[0].to_i] = '/' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                    puts "Miss"
                    controller = false
                elsif opponent_location_board[pos[2].to_i][pos[0].to_i] == 'O' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                    # WRITE HIT TO BOARD
                    opponent_location_board[pos[2].to_i][pos[0].to_i] = 'X' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                    self.Attack_board[pos[2].to_i][pos[0].to_i] = 'X' # REMOVE -1 IF LABEL IS ADDED TO BOARD
                    puts "Hit"
                    hit = true
                    controller = false
                else
                    puts "Invalid location"
                end
                return opponent_location_board, hit
            rescue
                puts "Invalid input"
            end
        end
    end
end

# game play
def game()
    # determin when games over (all ships sunk)
    player1_hit = 0
    player2_hit = 0
    while true do
        # player1 turn
        Player2.Location_board, hit = Player1.turn(Player2.Location_board)
        # if player1 hit player2
        if hit
            player1_hit += 1
            player1_hit < $ship_count
            break
        end
        # player 2 turn
        Player1.Location_board, hit = Player2.turn(Player1.Location_board)
        # if player2 hit player1
        if hit
            player2_hit += 1
            player2_hit < $ship_count
            break
        end
        puts "\n\nPlayer1 hit count #{player1_hit}/#{$ship_count}"
        puts "Player2 hit count #{player2_hit}/#{$ship_count}\n\n"
    end
end

# run start
Player1 = Player.new
Player1.player_setup()
Player2 = Player.new
Player2.player_setup()
game()