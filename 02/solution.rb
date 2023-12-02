require 'pp'

# Returns a map of game id integers to lists of count hashes.
# A count hash maps colors to integer counts.
def parse_counts(subsets_str)
  subset_strs = subsets_str.split(';').map(&:strip)

  subset_strs.map do |subset_str|
    count_strs = subset_str.split(',').map(&:strip)

    colors_to_counts = {
      "red" => 0,
      "green" => 0,
      "blue" => 0,
    }
    count_strs.each do |count_str|
      match = /^(\d+) ([a-z]+)$/.match(count_str)
      raise "failed to parse color count: #{count_str}" unless match

      count = match[1].to_i
      color = match[2]
      colors_to_counts[color] = count
    end
    colors_to_counts
  end
end

# Takes a count list and returns a new map of colors to the maximum number seen
# for each one.
def max_counts(colors_to_counts_list)
  colors_to_counts_list.each_with_object({}) do |colors_to_counts, colors_to_max_counts|
    colors_to_counts.each do |color, count|
      prev_max = colors_to_max_counts[color] || 0
      colors_to_max_counts[color] = [prev_max, count].max
    end
  end
end

def parse_line(line)
  match = /^Game (\d+): (.*)$/.match(line)
  raise "failed to parse line: #{line}" unless match

  game_id = match[1].to_i
  puts "Game #{game_id}"

  counts_list = parse_counts(match[2])
  pp counts_list

  max_counts = max_counts(counts_list)
  pp max_counts
  puts

  return game_id, max_counts
end

parsed_lines = ARGF.each_line.map { |line| parse_line(line) }

puts "Part 1 answer:"
puts parsed_lines.map { |game_id, max_counts|
  if max_counts["red"] <= 12 && max_counts["green"] <= 13 && max_counts["blue"] <= 14
    game_id
  else
    0
  end
}.sum
puts

puts "Part 2 answer:"
puts parsed_lines.map { |_, max_counts|
  max_counts.values.inject(1, :*)
}.sum
