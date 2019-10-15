require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/game'

binding.pry

# welcome
puts "-------------------------------------------------"
puts "Bienvenue sur 'ILS VEULENT TOUS MA POO' !      "
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"

# what is your name and initialisation
puts "Alors quel est ton blase mec/meuf?"
name = gets.chomp
my_game = Game.new(name)

# game going on
while my_game.is_still_ongoing?
    my_game.show_players
    my_game.menu
    choice = gets.chomp
    my_game.menu_choice(choice)
    my_game.enemies_attack
end

# game won or lost
my_game.end_game




