#daily programmer challenge 335 intermediate scoring a cribbage game

#method declarations

#methods to deal with the data

def read_file_to_array
	File.readlines(ARGV.first).to_s
end

def slice_string(input)
	input.slice(2,14).split(/,/)
end

def make_numbers_array(cards)
	card_nums = cards.collect {|card| card.chop}
	a = card_nums.collect do |card|
		case card
		when "A"
			card = 1
		when "J"
			card = 11
		when "Q"
			card = 12
		when "K"
			card = 13
		else 
			card = card.to_i
		end
	end
	a.sort!
end

#first converts face cards to make numerical scoring simple
def remove_face_cards(a)
	a_15s = a.collect do |card|
		if card == 11 || card == 12 || card == 13
			card = 10
		else
			card = card
		end
	end
end

#methods to calculate the score
 
def check_for_Nobs(input)
	nobs_score = 0
	jack_suit = input[15]
	test_string = input.slice(0,11)
	test_array = test_string.split(/,/)
	if test_string.include? ("J")
		test_array.each do |card|
			type = card.slice(0)
			suit = card.slice(1)
			if type == "J" && suit == jack_suit
				nobs_score +=1
			end
		end
	end
	nobs_score
end

def finding_multiples
	multiples_score = 0
	unique = a.uniq
	case a.length-unique.length
	when 3
		multiples_score+=12
	when 2
		#distinguish between two pairs and a group of 3
		if (a[0]==a[1] && a[1]==a[2]) || (a[1]==a[2] && a[2]==a[3] || a[2]==a[3] && a[3]==a[4])
			multiples_score+=4
		else
			multiples_score+=2
		end
	when 1
		multiples_score+=2
	end
	multiples_score
end


#find consecutive cards
def find_consecutives
	consecutives_score = 0
	a.collect do |card|
		if a.include? (card+1)
			if a.include? (card+2)
				if a.include? (card+3)
					if a.include? (card+4)
						consecutives_score+=5
					else
						consecutives_score+=4
					end
				else
					consecutives_score+=3
				end
			end
		end
	end
	consecutives_score
end

def calculate_15s(a_15s)
	fifteens_score=0
	combos_2 = a_15s.combination(2).to_a
	combos_3 = a_15s.combination(3).to_a
	combos_4 = a_15s.combination(4).to_a
	combos_2.collect do |combo|
		if combo.inject(:+) == 15
			fifteens_score += 2
		end
	end
	combos_3.collect do |combo|
		if combo.inject(:+) == 15
			fifteens_score += 2
		end
	end
	combos_4.collect do |combo|
		if combo.inject(:+) == 15
			fifteens_score += 2
		end
	end
	fifteens_score
end

def compare_suits
	suits_score = 0
	card_suit = cards.collect {|card| card.slice(1)}
	if card_suit.length-card_suit.uniq.length == 4
		suits_score+=5
	else
		card_suit.pop
		if card_suit.length-card_suit.uniq.length == 3
			suits_score+=4
		end
	end
	suits_score
end

#program starts here
input = read_file_to_array
score = 0
cards = slice_string(input)
numbers = make_numbers_array(cards)
no_face_cards = remove_face_cards(numbers)
score+=check_for_Nobs(input)
puts "Score after Nobs check is " + score.to_s
score+=multiples_score
puts "Score after checking for pairs is " + score.to_s
score+=find_consecutives
puts "Score after checking for runs is " + score.to_s
score+=calculate_15s(numbers)
puts "Score after checking for 15s is " + score.to_s
score+=suits_score(cards)
puts "Score after checking for cards of same suit is " + score.to_s
puts "Final score is " + score.to_s
