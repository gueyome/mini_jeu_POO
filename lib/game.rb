class Game
    attr_accessor :human_player, :enemies

    def initialize(human_player)
        @human_player = HumanPlayer.new(human_player)
        @enemies = [Player.new("Justin"), Player.new("Jupiter"), Player.new("Julie"), Player.new("Jules")]
    end

    def kill_player(player_id)
        @enemies.delete(player_id)
    end

    def is_still_ongoing?
       return @human_player.life_points > 0 && @enemies.any? { |enemy| enemy.life_points > 0 }
    end

    def show_players
        puts "------"
        puts "#{@human_player.name} a #{@human_player.life_points} points de vie et une arme de niveau #{@human_player.weapon_level}"
        puts "Il reste #{@enemies.size} joueurs bots restants dans la partie"
        puts "------"
    end

    def menu
        puts "Quelle action veux-tu effectuer ?"
        puts ""
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner"
        puts ""
        puts "attaquer un joueur en vue :"
        @enemies.each_with_index { |enemy, index| puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie" }
        puts "-------"
    end

    def menu_choice(choice)
        # Simulating the attacks
        if choice == "a"
            @human_player.search_weapon
        elsif choice == "s"
            @human_player.search_health_pack
        else 
            puts "Passons à la phase d'attaque sur le joueur #{@enemies[choice.to_i].name}"
            @human_player.attacks(@enemies[choice.to_i])
            if @enemies[choice.to_i].life_points < 0
                kill_player(@enemies[choice.to_i])
            end
        end
    end

    def enemies_attack
        puts "Les autres joueurs t'attaquent !" if @enemies.size > 0
        @enemies.each { |enemy| enemy.attacks(@human_player) }
    end

    def end_game
        if @human_player.life_points > 0
            puts "La partie est finie. BRAVO ! TU AS GAGNE !"
        else
            puts "La partie est finie. Loser ! Tu as perdu !"
        end
    end
end



