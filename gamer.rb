require_relative 'deck'

class Gamer
  GAIN = 20
  HALF = 10
  ANTE = 10

  attr_accessor :bank, :cards, :deck, :score

  def initialize(name)
    @deck = Deck.new
    @bank = 100
    @cards = []
    @score = 0
  end

  def do_ante
    @bank -= ANTE
  end

  def add_card
    do_card
    card = @cards.last
    if card.include?('tuz')
      if @score > 11
        @deck.all_cards[card] == 1
      end
    end
  end

  def do_card
    card = @deck.all_cards.keys.sample
    @score += @deck.all_cards[card]
    @cards << card
  end

  def open_carts(player1, player2)
    if player1.score > player2.score && player1.score < 22
      puts "YOU WIN!!!"
      player1.bank += GAIN
    elsif player1.score == player2.score
      puts "DRAW"
      player1.bank += HALF
      player2.bank += HALF
    else
      puts "YOU LOSE!!!"
      player2.bank += GAIN
    end
  end
end
