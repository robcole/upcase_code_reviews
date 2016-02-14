class HiddenSingles < Puzzle::Strategies
  def hidden_singles
    ozp = subgroup_zeroes.map(&:possible_values).flatten.uniq
    singles = number.possible_values - ozp
    singles.tap do |singles|
      puts "single found: #{number.inspect}" if singles.size == 1
    end
  end

  private

  def subgroup_zeroes
    subgroup_for(number: number).select { |number| number.value.zero? }
  end
end
