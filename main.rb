#daily programmer challenge 335 intermediate scoring a cribbage game

#method declarations
def read_file_to_array
	File.readlines(ARGV.first).to_s
end

def slice_string(input)
	input.slice(2,14).split(/,/)
end

#check for Nobs 
def check_for_Nobs(input)
	jack_suit = input[15]
	test_string = input.slice(0,11)
	test_array = test_string.split(/,/)
	if test_string.include? ("J")
		test_array.each do |card|
			type = card.slice(0)
			suit = card.slice(1)
			if type == "J" && suit == jack_suit
				score +=1
			end
		end
	end
end

puts "Score after Nobs check is " + score.to_s

#create array of just the numbers, substituting for face cards to make them sortable
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

#finding multiples
unique = a.uniq
case a.length-unique.length
when 3
	score+=12
when 2
	#distinguish between two pairs and a group of 3
	if (a[0]==a[1] && a[1]==a[2]) || (a[1]==a[2] && a[2]==a[3] || a[2]==a[3] && a[3]==a[4])
		score+=4
	else
		score+=2
	end
when 1
	score+=2
end
puts "Score after checking for pairs is " + score.to_s

#find consecutive cards
a.collect do |card|
	if a.include? (card+1)
		if a.include? (card+2)
			if a.include? (card+3)
				if a.include? (card+4)
					score+=5
				else
					score+=4
				end
			else
				score+=3
			end
		end
	end
end
puts "Score after checking for runs is " + score.to_s

#finds combinations that add up to 15

#first converts face cards to make numerical scoring simple
a_15s = a.collect do |card|
	if card == 11 || card == 12 || card == 13
		card = 10
	else
		card = card
	end
end

#then calculates combinations and sums each option
combos_2 = a_15s.combination(2).to_a
combos_3 = a_15s.combination(3).to_a
combos_4 = a_15s.combination(4).to_a
combos_2.collect do |combo|
	if combo.inject(:+) == 15
		score += 2
	end
end
combos_3.collect do |combo|
	if combo.inject(:+) == 15
		score += 2
	end
end
combos_4.collect do |combo|
	if combo.inject(:+) == 15
		score += 2
	end
end

puts "Score after checking for 15s is " + score.to_s

#finds cards of same suit
card_suit = cards.collect {|card| card.slice(1)}
if card_suit.length-card_suit.uniq.length == 4
	score+=5
else
	card_suit.pop
	if card_suit.length-card_suit.uniq.length == 3
		score+=4
	end
end

puts "Score after checking for cards of same suit is " + score.to_s

puts "Final score is " + score.to_s

#program starts here
input = read_file_to_array
score = 0
cards = slice
check_for_Nobs(cards)
