require 'pry'
class Card
	attr_accessor :card
	def initialize(suit, rank)
		@card = "#{rank}#{suit}"
	end


	def face_card?
		face_card = ["K", "Q", "J"]
		face_card.include?(@card[0])
	end
end
