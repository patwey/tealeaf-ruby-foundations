VALID_CHOICES = %w(rock paper scissors spock lizard)

def prompt(message)
  puts "=> #{message}"
end

def win?(first, second)
  case first
  when 'rock'
    (second == 'scissors' || second == 'lizard')
  when 'paper'
    (second == 'rock' || second == 'spock')
  when 'scissors'
    (second == 'paper' || second == 'lizard')
  when 'lizard'
    (second == 'paper' || second == 'spock')
  else
    (second == 'rock' || second == 'scissors')
  end
end

def display_results(user, computer)
  if win?(user, computer)
    prompt("You won!")
  elsif win?(computer, user)
    prompt("You lose.")
  else
    prompt("It's a draw!")
  end
end

def format_choice(choice)
  case choice
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 's'
    'scissors'
  when 'S'
    'spock'
  when 'l'
    'lizard'
  else
    choice
  end
end

def tally_scores(arr, user, computer)
    if win?(user, computer)
      arr[0] += 1
    elsif win?(computer, user)
      arr[1] += 1
    end
    arr
end

def display_scores(arr)
  prompt("You have a score of #{arr[0]}")
  prompt("The computer has a score of #{arr[1]}")
end

def display_winner(arr)
  if arr[0] == 5
    prompt("You win!")
  elsif arr[1] == 5
    prompt("The computer wins.")
  end
end

scores = [0,0]

prompt("Welcome to RPSSL! First to 5 Wins!")

loop do
  loop do
    user_choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}\n(Or type the first letter of the word - 'S' for Spock)")
      user_choice = format_choice(gets.chomp)
      if VALID_CHOICES.include?(user_choice.downcase)
        break
      else
        prompt("Oh no, that's not a valid choice")
      end
    end

    computer_choice = VALID_CHOICES.sample
    prompt("You chose #{user_choice}, and the computer chose #{computer_choice}")

    display_results(user_choice, computer_choice)
    scores = tally_scores(scores, user_choice, computer_choice)
    display_scores(scores)
    display_winner(scores)
    break if (scores[0] == 5 || scores[1] == 5)
  end

  prompt("Do you want to play again? (Y/N)")
  break unless gets.chomp.downcase.start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
