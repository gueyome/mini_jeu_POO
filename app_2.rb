# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

binding.pry

def welcome
    puts "-------------------------------------------------"
    puts "Bienvenue sur 'ILS VEULENT TOUS MA POO' !      "
    puts "|Le but du jeu est d'être le dernier survivant !|"
    puts "-------------------------------------------------"
end

def init_user
    puts "Alors quel est ton blase mec/meuf?"
    user = HumanPlayer.new(gets.chomp)
end

def init_player
    puts "Création de tes ennemies en cours..."
    enemies = []
    enemies << Player.new("José")
    enemies << Player.new("Josianne")
end

def battle(user, enemies)
    # while the user and at least one bot are still alive, play the game
    while user.life_points > 0 && (enemies[0].life_points > 0 || enemies[1].life_points > 0)

        # Recap of the states of the players
        puts "Voici l'état de chaque joueur:"
        user.show_state
        enemies[0].show_state
        enemies[1].show_state
        puts "-------"
        puts "Quelle action veux-tu effectuer ?"
        puts ""
        puts "a - chercher une meilleure arme"
        puts "s - chercher à se soigner"
        puts ""
        puts "attaquer un joueur en vue :"
        puts "0 - #{enemies[0].name} a #{enemies[0].life_points} points de vie"
        puts "1 - #{enemies[1].name} a #{enemies[1].life_points} points de vie"
        puts "-------"
        
        # Get the choice from the User
        puts "Fais le bon choix now !!!"
        choice = gets.chomp
        until choice == "a" || choice == "s" || choice == "0" || choice == "1"
            puts "Merci d'indiquer un des choix ci-dessus"
            choice = gets.chomp
        end

        # Simulating the attacks
        if choice == "a"
            user.search_weapon
        elsif choice == "s"
            user.search_health_pack
        elsif choice == "0"
            if enemies[0].life_points > 0
                puts "Passons à la phase d'attaque sur le joueur 1"
                user.attacks(enemies[0])
                puts "-------------"
            end
        else 
            if enemies[1].life_points > 0
                puts "Passons à la phase d'attaque sur le joueur 2"
                user.attacks(enemies[1])
                puts "-------------"
            end
        end 

        # Enemies now attacking
        puts "Les autres joueurs t'attaquent !" if enemies.any? { |player| player.life_points > 0 }
        enemies.each do |e|
            e.attacks(user) if e.life_points > 0
        end
    end
    
    # The game is over
    if user.life_points > 0
        puts "La partie est finie. BRAVO ! TU AS GAGNE !"
    else
        puts "La partie est finie. Loser ! Tu as perdu !"
    end
end 

welcome
user = init_user
enemies = init_player
battle(user, enemies)




