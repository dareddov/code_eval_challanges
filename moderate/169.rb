File.open(ARGV[0]).readlines.map do |line|
  array = line.split
  regexp = array[0].gsub('.', '\.').gsub('*', '.*').gsub('?', '.')
  file_names = array.drop(1)
  value = file_names.select { |file_name| file_name =~ Regexp.new("\\A#{regexp}\\z") }.join(' ')

  puts value.empty? ? '-' : value
end