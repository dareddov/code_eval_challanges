require 'prime'

File.open(ARGV[0]).readlines.map do |line|
 prime_numbers_for_range =  Prime.take_while { |p| p < line.to_i }.join(',')
  puts prime_numbers_for_range
end