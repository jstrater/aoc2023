DIGIT_MAP = {
  '0' => 0,
  '1' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,

  # 'zero' isn't valid
  'one' => 1,
  'two' => 2,
  'three' => 3,
  'four' => 4,
  'five' => 5,
  'six' => 6,
  'seven' => 7,
  'eight' => 8,
  'nine' => 9,
}

def first_digit(raw_str)
  raise "no first digit: #{raw_str}" if raw_str.empty?

  DIGIT_MAP.each do |digit_str, digit|
    if raw_str.start_with?(digit_str)
      return digit
    end
  end

  first_digit(raw_str[1...])
end

def last_digit(raw_str)
  raise "no last digit: #{raw_str}" if raw_str.empty?

  DIGIT_MAP.each do |digit_str, digit|
    if raw_str.end_with?(digit_str)
      return digit
    end
  end

  last_digit(raw_str[...-1])
end

puts ARGF.each_line.map { |line|
  "#{first_digit(line)}#{last_digit(line)}".to_i
}.sum
