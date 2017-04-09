class Deck
  attr_accessor :all_cards

  def initialize
    @all_cards = {}
    name_carts = { 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8,
                  9 => 9,10 => 10,'valet' => 10,'dama' => 10,'karol' => 10,
                  'tuz' => 11
    }
    name_carts.each do |cart, value|
      @all_cards ["#{cart}♥"] = value
      @all_cards ["#{cart}♣"] = value
      @all_cards ["#{cart}♦"] = value
      @all_cards ["#{cart}♠"] = value
    end
  end
end
