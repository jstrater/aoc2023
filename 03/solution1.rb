def adjacent_symbols?(lines, num_row, num_start_col, num_end_col)
  start_row = [num_row - 1, 0].max
  end_row = [num_row + 2, lines.size].min
  start_col = [num_start_col - 1, 0].max
  end_col = [num_end_col + 1, lines[0].size].min

  # This will also scan the number itself just to keep the code simple
  found = false
  (start_row...end_row).each do |row|
    (start_col...end_col).each do |col|
      print lines[row][col]
      found = true if /^[^0-9.]$/.match?(lines[row][col])
    end
    puts
  end
  puts found
  puts

  return found
end

lines = ARGF.readlines.map(&:chomp)

sum = 0

lines.each_with_index do |line, row|
  line.to_enum(:scan, /\d+/).each do |_|
    match = Regexp.last_match
    start_col = match.begin(0)
    end_col = match.end(0)
    num = match[0].to_i

    if adjacent_symbols?(lines, row, start_col, end_col)
      sum += num
    end
  end
end

puts sum
