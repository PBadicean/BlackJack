require_relative 'game'

puts ' ♥ ♣ ♦ ♠'*10
puts 'Game is Black Jack, fortune'
puts 'Write your name'
name = gets.chomp
my_play = Game.new(name)
puts '1: Start play or 2: Escape'
answer = gets.chomp.to_i
if answer == 1
  my_play.start
else
  return
end
