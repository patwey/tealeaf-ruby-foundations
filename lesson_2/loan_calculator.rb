def valid_loan_amount?(amt)
  amt.to_f != 0 # loan must be a number that is greater than zero
end

def valid_apr?(apr)
  apr.to_f != 0 # apr must be greater than zero (for now)
end

def valid_loan_duration?(duration)
  duration.to_i != 0
end

def apr_to_monthly_ir(apr)
  apr.to_f / 100 / 12
end

def loan_years_to_months(loan_years)
  loan_years.to_i * 12
end

def calculate_monthly_payment(amt, monthly_ir, months)
  amt.to_f *
    (monthly_ir * (1 + monthly_ir)**months) /
    ((1 + monthly_ir)**months - 1)
end

puts "Welcome to the Loan Calculator"
loop do
  loan_amount = 0
  apr = 0
  loan_years = 0
  loop do
    puts "What is the amount of your loan?"
    loan_amount = gets.chomp # a string
    valid_loan_amount?(loan_amount) ? break : puts("Oops, that's not a valid loan amount")
  end
  loop do
    puts "What is your Annual Percentage Rate (APR) (Ex: 5.6 for 5.6%)?"
    apr = gets.chomp # a string representing the percentage * 100
    valid_apr?(apr) ? break : puts("Hmm, that's not a valid APR")
  end
  loop do
    puts "What is the duration of your loan (in years)?"
    loan_years = gets.chomp # a string
    valid_loan_duration?(loan_years) ? break : puts("Oh no, that's not a valid loan duration")
  end

  monthly_ir = apr_to_monthly_ir(apr)
  loan_months = loan_years_to_months(loan_years)
  monthly_payment = calculate_monthly_payment(loan_amount, monthly_ir, loan_months)
  puts "Your monthly payment is $#{monthly_payment.round(2)}"

  puts "Would you like to calculate another loan payment? Enter (Y) to continue."
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

puts "Thank you. Goodbye!"
