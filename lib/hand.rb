require_relative 'card'

class Hand
	attr_accessor :cards
	def initialize
		@cards = []
	end

	def value
		@value = 0
		@cards.each do |card_object|
			if card_object.face_card?
				@value += 10
			elsif card_object.card[0] == "A"
				if @value + 11 <= 21
					@value += 11
				else
					@value += 1
				end
			else
				@value += card_object.card.to_i
			end
		end
		return @value
	end
end
