class Puzzle
  attr_accessor :puzzle_string

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def numbers
    @numbers ||= create_numbers
  end

  def puzzle_arr
    puzzle_string.gsub(/\D+/, '').split("").map(&:to_i)
  end

  def columns
    @columns ||= numbers.group_by(&:x)
  end

  def rows
    @rows ||= numbers.group_by(&:y)
  end

  def subgroups
    @subgroups ||= numbers.group_by(&:subgroup)
  end

  def rows_valid?
    rows.values.all? { |row| valid_items?(row) }
  end

  def columns_valid?
    columns.values.all? { |column| valid_items?(column) }
  end

  def subgroups_valid?
    subgroups.values.all? { |subgroup| valid_items?(subgroup) }
  end

  def incomplete?
    numbers.map(&:value).any?(&:zero?)
  end

  def valid?
    rows_valid? && columns_valid? && subgroups_valid?
  end

  private

  def valid_items?(group)
    nonzero_numbers = group.map(&:value).reject(&:zero?)
    nonzero_numbers.size == nonzero_numbers.uniq.size
  end

  def create_numbers
    puzzle_arr.each_with_index.map do |value, index|
      SudokuNumber.new(index: index, value: value)
    end
  end
end
