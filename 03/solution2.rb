require 'set'

# Somehow this all worked on the first run. No errors and the answer was correct. 🤯

def digit?(str)
  /^\d$/.match?(str)
end

def number_at(lines, target_row, target_col, visited)
  return nil unless digit?(lines[target_row][target_col])
  return nil if visited.include?([target_row, target_col])

  # walk backward to the start of the number
  start_col = target_col
  while start_col > 0 && digit?(lines[target_row][start_col-1])
    start_col -= 1
  end

  # walk forward off the end of the number, marking characters as visited
  end_col = start_col
  while end_col < lines[0].size && digit?(lines[target_row][end_col])
    visited.add([target_row, end_col])
    end_col += 1
  end

  num = lines[target_row][start_col...end_col].to_i
end

def adjacent_numbers(lines, gear_row, gear_col)
  start_row = [gear_row - 1, 0].max
  end_row = [gear_row + 2, lines.size].min
  start_col = [gear_col - 1, 0].max
  end_col = [gear_col + 2, lines[0].size].min
  visited = Set[]

  nums = []
  (start_row...end_row).each do |row|
    (start_col...end_col).each do |col|
      nums << number_at(lines, row, col, visited)
    end
  end

  nums.compact
end

lines = ARGF.readlines.map(&:chomp)

sum = 0
lines.each_with_index do |line, row|
  line.to_enum(:scan, /\*/).each do |_|
    match = Regexp.last_match
    col = match.begin(0)

    nums = adjacent_numbers(lines, row, col)
    if nums.size == 2
      sum += nums[0] * nums[1]
    end
  end
end

puts sum
