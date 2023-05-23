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