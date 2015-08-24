require 'pry'

DECK = [%w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace),
        %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace),
        %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace),
        %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)]

def prompt(msg)
  puts "=> #{msg}"
end

def draw_card!(deck)
  suit = rand(0..3)
  value = rand(0..deck[suit].size - 1)
  card = deck[suit][value]
end

def deal_hand(deck)
  hand = []
  2.times { hand << draw_card!(deck) }
  hand
end

def display_cards(person, hand)
  output = "#{person.capitalize}'s cards: "
  if person == 'dealer'
    output += 'Hidden, '
    hand.each_with_index do |card, index|
      if index != 0
        if index != (hand.size - 1)
          output += "#{card}, "
        else
          output += "#{card}"
        end
      end
    end
  else
    hand.each_with_index do |card, index|
      if index != (hand.size - 1)
        output += "#{card}, "
      else
        output += "#{card}"
      end
    end
  end
  prompt(output)
end

def calculate_score(hand)
  score = 0
  ace_count = 0
  hand.each do |card|
    case card
    when 'Ace'
      score += 11
      ace_count += 1
    when 'Jack', 'Queen', 'King'
      score += 10
    else
      score += card.to_i
    end
  end
  if score > 21 && ace_count != 0
    ace_count.times do
      score -= 10
      break if score <= 21
    end
  end
  score
end

def display_score(person, score)
  prompt("#{person.capitalize}'s score: #{score}")
end

def twenty_one?(score)
  score == 21
end

prompt("Welcome to Twenty-One! What's your name?")
name = gets.chomp

deck_instance = DECK.map { |cards| cards }

player_hand = deal_hand(deck_instance)
dealer_hand = deal_hand(deck_instance)

display_cards(name, player_hand)
display_cards('dealer', dealer_hand)

player_score = calculate_score(player_hand)
dealer_score = calculate_score(dealer_hand)

display_score(name, player_score)

if twenty_one?(player_score)
  if twenty_one?(dealer_score)
    prompt("It's a tie!")
  else
    prompt("Twenty-One!")
  end
else
  loop do
    prompt("Would you like to hit? (y/n)")
    hit = gets.chomp.downcase
    if hit == 'y'
      card = draw_card!(deck_instance)
      player_hand << card
      player_score = calculate_score(player_hand)
      display_score(name, player_score)
      if twenty_one?(player_score)
        prompt("Twenty-One!")
        break
      elsif player_score > 21
        prompt("Bust!")
        break
      end
    else
      break
    end
  end
  display_score(name, player_score)
end

loop do
  dealer_score = calculate_score(dealer_hand)
  if dealer_score < 17
    card = draw_card!(deck_instance)
    dealer_hand << card
    prompt("Dealer must hit. Dealer recieved: #{card}")
  elsif twenty_one?(dealer_score)
    break
  elsif dealer_score > 21
    prompt("Bust!")
    break
  else
    break
  end
end

display_score('dealer', dealer_score)
