TRANSFORMATIONS = {
    'ONE HUNDRED' => 100.00,
    'FIFTY' => 50.00,
    'TWENTY' => 20.00,
    'TEN' => 10.00,
    'FIVE' => 5.00,
    'TWO' => 2.00,
    'ONE' => 1.00,
    'HALF DOLLAR' => 0.50,
    'QUARTER' => 0.25,
    'DIME' => 0.10,
    'NICKEL' => 0.05,
    'PENNY' => 0.01,
}
File.open(ARGV[0]).readlines.map do |line|
  arr = line.strip.split(';').map { |number| number.to_f }
  rest_money = (arr[1] - arr[0]).round(2)

  @bills = []
  if rest_money == 0
    puts 'ZERO'
    next
  end
  if rest_money < 0
    puts 'ERROR'
    next
  end

  TRANSFORMATIONS.each do |name, value|
    if value <= rest_money
      count_bills = (rest_money / value).to_i
      count_bills.times { @bills << name }
      rest_money = (rest_money - (value * count_bills)).round(2)
    end
  end
  puts @bills.join(',')
end