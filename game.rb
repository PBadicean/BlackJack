require_relative 'gamer'
require_relative 'deck'

class Game
  METHODS = %w(add_card_user skip_move_user open_cards)

  def initialize(user_name)
    @deck = Deck.new
    @user = Gamer.new(user_name)
    @dealer = Gamer.new("dealer")
    @bank = 20
  end

  def start
    give_out_cards
    ante
    info
  end

  def give_out_cards
    2.times do
      @user.do_card
      @dealer.do_card
    end
  end

  def ante
    @user.do_ante
    @dealer.do_ante
  end

  def info
    @actions = ['1 Add cart', '2 Skip a move', '3 Open carts']
    puts "Bank deller: #{@dealer.bank}"
    puts "Your bank: #{@user.bank}"
    puts "Bank game: #{@bank}"

    puts "Your cards #{@user.cards.inspect}, your score: #{@user.score}"
    puts "dealer cards [* *]"
    move_user
  end

  def move_user
    puts ' '*80
    puts "Choose number desired action"
    puts @actions
    answer = gets.chomp.to_i
    action = METHODS[answer - 1]
    steps(answer, action)
  end

  def steps(answer, action)
    if answer >= 4
      return
    elsif answer == 3
      send(action)
      puts "You want continue Y or N"
      ans = gets.chomp
      continue if ans == 'Y'
      return if ans != 'Y'
    else
      send(action)
      move_dealer
      move_user
    end
  end

  def move_dealer
    if @dealer.score < 15
      add_card_dealer
    elsif @dealer.score > 15
      skip_move_dealer
    end
  end

  def add_card_user
    @user.do_card
    puts "#{@user.cards.last}"
    @actions.delete_at(0) if @actions.include?('1 Add cart')
  end

  def add_card_dealer
    puts 'Deller move: deller add cart'
    @dealer.do_card
  end

  def skip_move_user
    puts 'Your move: you skiped a move'
  end

  def skip_move_dealer
    puts 'Deller move: deller skiped a move'
  end

  def open_cards
    puts"Your carts and score: #{@user.cards.inspect}------#{@user.score}"
    puts"Dealer carts and score: #{@dealer.cards.inspect}------#{@dealer.score}"
    @user.open_carts(@user, @dealer)
  end

  def continue
    @user.cards = []
    @dealer.cards = []
    @user.score = 0
    @dealer.score = 0
    start
  end
end
