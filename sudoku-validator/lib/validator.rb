require "byebug"
require_relative "./sudoku_number"
require_relative "./puzzle"

class Validator
  attr_reader :puzzle_string, :puzzle

  def initialize(puzzle_string)
    @puzzle = Puzzle.new(puzzle_string)
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    if puzzle.valid? && puzzle.incomplete?
      "This sudoku is valid, but incomplete."
    elsif puzzle.valid?
      "This sudoku is valid."
    else
      "This sudoku is invalid."
    end
  end
end
