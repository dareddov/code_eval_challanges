File.open(ARGV[0]).readlines.map do |line|
  array = line.split
  regexp_pattern = "\\A#{array.shift.gsub('.', '\.').gsub('*', '.*').gsub('?', '.')}\\z"
  regexp_method = Regexp.new(regexp_pattern)
  valid_file_names = array.select { |file_name| file_name =~ regexp_method }.join(' ')

  puts valid_file_names.empty? ? '-' : valid_file_names
end