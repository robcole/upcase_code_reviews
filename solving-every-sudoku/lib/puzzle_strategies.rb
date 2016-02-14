class Puzzle::Strategies
  extend Forwardable
  attr_accessor :puzzle, :number
  delegate [:numbers, :rows, :columns, :subgroups] => :puzzle

  def self.run!(number:, puzzle:, strategy:)
    klass = strategy_to_klass(strategy)
    klass.new(puzzle, number).send(strategy)
  end

  def self.strategy_to_klass(strategy)
    klassname = strategy.to_s.split("_").map(&:capitalize).join("")
    Object.const_get(klassname)
  end

  private

  def initialize(puzzle, number)
    @puzzle = puzzle
    @number = number
  end

  # finds the numbers in a given subgroup, row, or column
  # shared with the number provided.
  #
  # returns the 8 remaining numbers from the row, column, or
  # subgroup.
  def scoped_sudoku_item(number, method)
    collection = send("#{method}s")
    collection.
      items.
      select { |item, _| item == number.send(method) }.
      values.
      flatten.
      reject { |num| number.index == num.index }
  end

  def row_for(number:)
    scoped_sudoku_item(number, :row)
  end

  def column_for(number:)
    scoped_sudoku_item(number, :column)
  end

  def subgroup_for(number:)
    scoped_sudoku_item(number, :subgroup)
  end
end

