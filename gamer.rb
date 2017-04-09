require_relative 'deck'

class Gamer

  attr_accessor :bank, :cards, :deck
  attr_reader :score

  def initialize
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
end
