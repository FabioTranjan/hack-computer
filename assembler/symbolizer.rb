require './helper'
require './constants'

# Class responsible to symbolize parsed lines
class Symbolizer
  def initialize(parsed)
    @parsed = parsed
    @symbols = PREDEFINED_SYMBOLS.clone
    @last_memory = 16
    @parsed_symbols = 0
  end

  def symbolize
    first_pass
    second_pass
    @parsed
  end

  def first_pass
    @parsed.each_with_index do |line, index|
      include_label(line, index) if line.include?('(') && line.include?(')')
    end
  end

  def second_pass
    @parsed.each do |line|
      p line
      try_symbol(line) if line[0] == A_SYMBOL && Helper.has_alphabetic_char?(line)
    end
  end

  def include_label(line, index)
    symbol = line[1..-2]
    @symbols[symbol] = Helper.to_binary_16(index - @parsed_symbols)
    @parsed = @parsed - [line]
    @parsed_symbols = @parsed_symbols + 1
  end

  def try_symbol(line)
    symbol = line[1..-1]
    symbol_found = @symbols[symbol]
    return if symbol_found

    @symbols[symbol] = Helper.to_binary_16(@last_memory)
    @last_memory = @last_memory + 1
  end

  def symbols
    @symbols
  end
end
