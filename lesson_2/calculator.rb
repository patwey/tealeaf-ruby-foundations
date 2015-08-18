def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

name = ''
loop do
  prompt("Welcome to Calculator. Enter your name:")
  name = gets.chomp
  name.empty? ? prompt("Be sure to use a valid name.") : break
end

prompt("Hi #{name}!")

loop do # main loop
  num1 = ''
  loop do
    prompt("What's the first number?")
    num1 = gets.chomp
    valid_number?(num1) ? break : prompt("Hmm... that doesn't look like a valid number")
  end
  num2 = ''
  loop do
    prompt("What's the second number?")
    num2 = gets.chomp
    valid_number?(num2) ? break : prompt("Hmm... that doesn't look like a valid number")
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
    MSG
  prompt(operator_prompt)
  operator = ''
  loop do
    operator = gets.chomp
    %w(1 2 3 4).include?(operator) ? break : prompt("Please enter 1, 2, 3, or 4")
  end
  prompt("#{operation_to_message(operator)}...")
  result = case operator
           when '1'
             num1.to_i + num2.to_i
           when '2'
             num1.to_i - num2.to_i
           when '3'
             num1.to_i * num2.to_i
           when '4'
             num1.to_f / num2.to_f
           end
  prompt("The result is #{result}")
  prompt("Do you want to perform another calculation? (Y to calculate again)")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using the calculator. Goodbye!")
