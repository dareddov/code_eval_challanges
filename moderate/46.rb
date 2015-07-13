require 'prime'

File.open(ARGV[0]).readlines.map do |line|
 puts Prime.take_while { |p| p < line.to_i }.join(',')
end