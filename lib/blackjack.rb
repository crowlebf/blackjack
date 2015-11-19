require_relative 'deck'
require_relative 'hand'
require_relative 'card'

class Game
	attr_reader :deck, :player_hand, :dealer_hand
	def initialize
		@deck = Deck.new
		@player = Hand.new
		@dealer = Hand.new
		@player_value = 0
		@dealer_value = 0
	end


	def deal_hand
		@player.cards << @deck.deal
		@dealer.cards << @deck.deal
		@player_value = @player.value
		@dealer_value = @dealer.value
	end

	def player_add_card
		puts ""
		@player.cards << @deck.deal
		card_dealt = @player.cards[-1]
		@player_value = @player.value
		puts "Player was dealt #{card_dealt.card}"
		puts "Player score: #{@player_value}"
		puts ""
	end

	def dealer_add_card
		puts ""
		@dealer.cards << @deck.deal
		card_dealt = @dealer.cards[-1]
		@dealer_value = @dealer.value
		puts "Dealer was dealt #{card_dealt.card}"
		puts "Dealer score: #{@dealer_value}"
		puts ""
	end

	def player_hit?
		@player_bust = false
		prompt = "Hit or stand (H/S): "
		print prompt
		response = gets.chomp
		while response.downcase != "s" && response.downcase != "h"
			print "Please type either 'S' or 'H': "
			response = gets.chomp
		end
		while response.downcase == "h"
			if @player_value <= 21
				player_add_card
				if @player_value > 21
					puts ""
					puts "Bust! You lose..."
					@player_bust = true
					break
				else
					print prompt
					response = gets.chomp
				end
			end
		end
		@player_value = @player.value
		if response.downcase == "s"
			puts ""
			puts "Player score: #{@player_value}"
			puts ""
			puts ""
		end
	end

	def dealer_hit?
		@dealer_bust = false
		while @dealer_value <= 16
			dealer_add_card
			if @dealer_value >= 17
				break
			end
		end
		if @dealer_value > 21
			@dealer_bust = true
			puts "Dealer busts!"
			puts ""
		else
			puts ""
			puts "Dealer stands"
			puts ""
		end
	end

	def winner
		if @dealer_value == @player_value 
			puts "Push!"
		elsif @dealer_value > @player_value && @dealer_bust == false || @player_bust == true
			puts "Dealer wins."
		else
			puts "You win!"
		end
	end



	def play
		deal_hand
		deal_hand
		puts "Welcome to Blackjack!"
		puts ""
		puts "Player was dealt #{@player.cards[0].card}"
		puts "Player was dealt #{@player.cards[1].card}"
		puts "Player score: #{@player_value}"
		puts ""
		player_hit?
		if @player_value > 21
			puts ""
		else	
			puts ""
			puts "Dealer was dealt #{@dealer.cards[0].card}"
			puts "Dealer was dealt #{@dealer.cards[1].card}"
			puts "Dealer score: #{@dealer_value}"
			dealer_hit?
			winner
		end
	end
end

my_game = Game.new
my_game.play
