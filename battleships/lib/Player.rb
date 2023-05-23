require File.expand_path('Board.rb', __dir__)

# class for player methods
class Player
    # make variable avalible outside of class
    attr_accessor :attack_board
    attr_accessor :location_board
    attr_accessor :player_num
    attr_accessor :ship_hits

    # initiate player
    def initalise()
        # define player boards
        @attack_board = Board.board_creation() 
        @location_board = Board.board_creation()
        @player_num = 0
        @ship_hits = 0
    end
end