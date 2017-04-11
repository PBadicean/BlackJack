require_relative 'gamer'
require_relative 'deck'

class Game
  COMANDS = %w(add_cart_user skip_move_user open_carts)

  def initialize(user_name)
    @deck = Deck.new
    @user = Gamer.new(user_name)
    @dealer = Gamer.new("dealer")
  end

  def start
    @user.do_card(2)
    @dealer.do_card(2)
    @user.bank -= 10
    @dealer.bank -=  10
    @bank_game = 20
    date
  end

  def date
    @actions_user = ['1 Add cart', '2 Skip a move', '3 Open carts']
    puts "Bank deller: #{@dealer.bank}"
    puts "Your bank: #{@user.bank}"
    puts "Bank game: #{@bank_game}"

    puts "Your cards #{@user.cards.inspect}, your score: #{@user.score}"
    puts "dealer cards [* *]"
    comands
  end

  def comands
    puts ' '*80
    puts "Choose number desired action"
    puts @actions_user
    answer = gets.chomp.to_i - 1
    action = COMANDS[answer]
    send(action)
  end

  def add_cart_user
    # добавит карту и удалит команду из списка команд
    @user.do_card(1)
    puts "#{@user.cards.last}"
    @actions_user.each_with_index do |action, index|
    @actions_user.delete(@actions_user[index]) if action == '1 Add cart'
    end
    move_deller
  end

  def move_deller
    add_cart_deller if @dealer.score < 15
    skip_move_deller if @dealer.score > 15
    end
  end

  def add_cart_deller
    puts 'Deller move: deller add cart'
    @deller.do_card(1)
    comands
  end

  def skip_move_user
    puts 'Your move: you skiped a move'
    move_deller
  end

  def skip_move_deller
    puts 'Deller move: deller skiped a move'
    comands
  end

  def open_carts
    puts"Your carts and score: #{@user.cards.inspect}------#{@user.score}"
    puts"Dealer carts and score: #{@dealer.cards.inspect}------#{@dealer.score}"
    @user.open_carts(@user, @dealer)
    continue
  end

  def continue
    puts 'You want continue game 1 else 2'
    answer = gets.chomp.to_i
    if answer == 1
      @user.cards = []
      @dealer.cards = []
      @user.score = 0
      @dealer.score = 0
      start
    else
      return
    end
  end
end
