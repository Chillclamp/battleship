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

    def attack(player, opponent, coordinates)
        row, column = parse_coordinates(coordinates)
    
        if valid_attack(opponent.location_board, row, column)
            hit = opponent.location_board[row][column] == 'O'
            update_board(opponent.location_board, coordinates, hit ? 'X' : '/')
            update_board(player.attack_board, coordinates, hit ? 'X' : '/')
            player.ship_hits += 1 if hit
            []
        else
            ['Invalid location']
        end
    end
    
    private
    # Check if the attack location is valid
    def valid_attack(board, row, column)
        board[row][column] == '-' || board[row][column] == 'O'
    end

    # Update the board with the given value at the specified coordinates
    def update_board(board, coordinates, value)
        row, column = parse_coordinates(coordinates)
        board[row][column] = value
    end

    # Parse the coordinates into row and column indices
    def parse_coordinates(coordinates)
        row = coordinates[2].to_i
        column = coordinates[0].to_i * 2
        [row, column]
    end
end