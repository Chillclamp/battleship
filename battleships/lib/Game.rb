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