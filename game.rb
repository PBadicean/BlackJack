require_relative 'gamer'
require_relative 'deck'

class Game
  COMANDS = %w(add_cart_user skip_move_user open_carts)

  def initialize
    @deck = Deck.new
    @user = Gamer.new
    @deller = Gamer.new
  end

  def start
    @actions_user = ['1 Add cart', '2 Skip a move', '3 Open carts']
    @user.bank -= 10
    @deller.bank -=  10
    @bank_game = 20
    puts '>'*80
    puts "Bank deller: #{@deller.bank}"
    puts "Your bank: #{@user.bank}"
    puts "Bank game: #{@bank_game}"
    cards_user
    cards_deller
    score_user
    comands
  end

  def comands
    puts ' '*80
    puts "Choose number desired action"
    puts @actions_user
    answer = gets.chomp.to_i - 1
    action = COMANDS[answer]
    if action == 'open_carts'
      @bank_game = 0
      open_carts
    else
      send(action)
    end
  end

  def cards_user
    puts ' '*160
    @user.do_card(2)
    puts 'Your cards'
    puts "   #{@user.cards.inspect}"
  end

  def cards_deller
    puts ' '*80
    @deller.do_card(2)
    puts 'Cards deller'
    puts ' *' * @deller.cards.size
  end

  def score_user
    puts ' '*80
    puts 'Your score'
    puts @user.score
  end

  def add_cart_user
    puts ' '*80
    puts 'Your move: you add cart'
    @user.do_card(1)
    puts "#{@user.cards.last}"
    @actions_user.each_with_index do |value, index|
    @actions_user.delete(@actions_user[index]) if value == '1 Add cart'
    end
    move_deller
  end

  def move_deller
    if @deller.score < 12
      add_cart_deller
    else
      skip_move_deller
    end
  end

  def add_cart_deller
    puts ' '*80
    puts 'Deller move: deller add cart'
    @deller.do_card(1)
    puts puts "#{@deller.cards.last}"
    comands
  end

  def skip_move_user
    puts ' '*80
    puts 'Your move: you skiped a move'
    move_deller
  end

  def skip_move_deller
    puts ' '*80
    puts "Deller move: deller skiped a move"
    comands
  end

  def open_carts
    puts '<'*80
    puts "Your carts and score"
    puts "#{@user.cards.inspect}---------#{@user.score}"

    puts "Deller carts and score"
    puts "#{@deller.cards.inspect}---------#{@deller.score}"

    if @user.score > @deller.score && @user.score < 22
      puts "YOU WIN!!!"
      @user.bank += 20
    elsif @user.score == @deller.score
      puts "DRAW"
      @user.bank += 10
      @deller.bank += 10
    else
      puts "YOU LOSE!!!"
      @deller.bank += 20
    end
    continue
  end

  def continue
    puts ' '*50
    puts 'You want continue game 1 else 2'
    answer = gets.chomp.to_i
    if @user.bank == 0
      puts "You can't continue game"
      return
    elsif answer == 1
      @user.cards = []
      @deller.cards = []
      start
    else
      return
    end
  end
end

my_play = Game.new
puts ' ♥ ♣ ♦ ♠'*10
puts 'Game is Black Jack, fortune'
puts 'Write your name'
name = gets.chomp
puts '1: Start play or 2: Escape'
answer = gets.chomp.to_i
if answer == 1
  my_play.start
else
  return
end
