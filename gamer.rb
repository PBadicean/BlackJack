require_relative 'deck'

class Gamer

  attr_accessor :bank, :cards, :deck, :score

  def initialize(name)
    @deck = Deck.new
    @bank = 100
    @database = []
    @cards = []
    @score = 0
  end

  def add_cart
    do_card(1)
    card = @cards.last
     if card.include?('tuz')
       if @score > 10
        @deck.all_cards[card] == 1
      end
      end
  end

  def do_card(count)
    count.times do |card|
      card = @deck.all_cards.keys.sample
      @score += @deck.all_cards[card]
      @cards << card
    end
  end

  def open_carts(player1, player2)
    if player1.score > player2.score && player1.score < 22
      puts "YOU WIN!!!"
      player1.bank += 20
    elsif player1.score == player2.score
      puts "DRAW"
      player1.bank += 10
      player2.bank += 10
    else
      puts "YOU LOSE!!!"
      player2.bank += 20
    end
  end
end
