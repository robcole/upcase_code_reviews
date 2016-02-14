class PossibleValues < Puzzle::Strategies
  def possible_values
    (1..9).to_a - unavailable_values
  end

  def unavailable_values
    [rows, columns, subgroups].inject([]) do |arr, group|
      arr.push group.values(number)
    end.flatten.uniq
  end
end
