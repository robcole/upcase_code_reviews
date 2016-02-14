class Puzzle
  attr_accessor :puzzle_string

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def numbers
    @numbers_by_index ||= create_numbers
    @numbers_by_index.values
  end

  def puzzle_arr
    puzzle_string.gsub(/\D+/, '').split("").map(&:to_i)
  end

  def columns
    SudokuNumberGroup.columns_for(numbers)
  end

  def rows
    SudokuNumberGroup.rows_for(numbers)
  end

  def subgroups
    SudokuNumberGroup.subgroups_for(numbers)
  end

  %w(rows columns subgroups).each do |method|
    define_method("#{method}_valid?") do
      send(method).valid?
    end
  end

  def incomplete?
    numbers.map(&:value).any?(&:zero?)
  end

  def complete?
    numbers.map(&:value).none?(&:zero?)
  end

  def valid?
    rows_valid? && columns_valid? && subgroups_valid?
  end

  def unsolved_numbers
    numbers.select(&:unsolved?)
  end

  def solve_and_assign_possible_values!(filtered_numbers)
    filtered_numbers.each do |number|
      number.possible_values = call_strategy(:possible_values, number: number)
      number.solve! if number.solveable?
      replace_puzzle_number(number)
    end
  end

  def solve_puzzle!
    solve_and_assign_possible_values!(unsolved_numbers)
    unsolved_numbers.each do |number|
      solve_hidden_single!(number)
    end
  end

  def call_strategy(strategy, number:)
    Puzzle::Strategies.run!(puzzle: self,
                            number: number,
                            strategy: strategy)
  end

  def solve_hidden_single!(number)
    single = call_strategy(:hidden_singles, number: number)
    if single.size == 1
      number = number.solve!(single.first)
      replace_puzzle_number(number)
      solve_and_assign_possible_values!(unsolved_numbers)
    end
  end

  def replace_puzzle_number(number)
    @numbers_by_index[number.index] = number
  end

  def solve
    solve_puzzle!
    byebug
  end

  def solved?
    valid? && complete?
  end

  private

  def create_numbers
    puzzle_arr.each_with_index.inject({}) do |memo, (value, index)|
      memo.merge({ index => SudokuNumber.new(index: index, value: value) })
    end
  end
end
