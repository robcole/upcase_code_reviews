require_relative "../lib/validator"

describe Puzzle do
  let(:valid_file) { File.read("spec/fixtures/valid_complete.sudoku") }
  let(:puzzle_string) { "8 5 9 |6 1 2 |4 3 7\n7 2 3 |8 5 4 |1 6 9" }
  let(:puzzle) { Puzzle.new(puzzle_string) }
  let(:arr) { [8, 5, 9, 6, 1, 2, 4, 3, 7, 7, 2, 3, 8, 5, 4, 1, 6, 9] }

  describe "#puzzle_arr" do
    it "should convert the puzzle into an array of numbers" do
      expect(puzzle.puzzle_arr).to eq arr
    end
  end

  describe "#numbers" do
    it "should create a sudoku number for each number in the puzzle" do
      all_numbers = puzzle.numbers.all? { |n| n.is_a? SudokuNumber }
      expect(all_numbers).to be_truthy
    end

    it "should create the right number for each number in the puzzle" do
      values = puzzle.numbers.map(&:value)
      expect(values).to eq arr
    end
  end

  describe "#rows_valid?" do
    context "when any row is invalid" do
      it "should return false" do
        file = File.read("spec/fixtures/invalid_due_to_row_dupe.sudoku")
        invalid_row_puzzle = Puzzle.new(file)
        expect(invalid_row_puzzle.rows_valid?).to be_falsey
      end
    end

    context "when the rows are all valid"  do
      it "should return true" do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        valid_row_puzzle = Puzzle.new(file)
        expect(valid_row_puzzle.rows_valid?).to be_truthy
      end
    end
  end

  describe "#columns_valid?" do
    context "when any column is invalid" do
      it "should return false" do
        file = File.read("spec/fixtures/invalid_due_to_column_dupe.sudoku")
        invalid_column_puzzle = Puzzle.new(file)
        expect(invalid_column_puzzle.columns_valid?).to be_falsey
      end
    end

    context "when the columns are all valid"  do
      it "should return true" do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        valid_column_puzzle = Puzzle.new(file)
        expect(valid_column_puzzle.columns_valid?).to be_truthy
      end
    end
  end

  describe "#incomplete" do
    context "when a puzzle is incomplete" do
      it "should return true" do
        file = File.read("spec/fixtures/valid_incomplete.sudoku")
        valid_incomplete = Puzzle.new(file)
        expect(valid_incomplete.incomplete?).to be_truthy
      end
    end

    context "when a puzzle is complete" do
      it "should return false" do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        valid_complete = Puzzle.new(file)
        expect(valid_complete.incomplete?).to be_falsey
      end
    end
  end

  describe "#subgroups_valid?" do
    context "when any subgroup is invalid" do
      it "should return false" do
        file = File.read("spec/fixtures/invalid_due_to_subgroup_dupe.sudoku")
        invalid_subgroup_puzzle = Puzzle.new(file)
        expect(invalid_subgroup_puzzle.subgroups_valid?).to be_falsey
      end
    end

    context "when the subgroups are all valid"  do
      it "should return true" do
        file = File.read("spec/fixtures/valid_complete.sudoku")
        valid_subgroup_puzzle = Puzzle.new(file)
        expect(valid_subgroup_puzzle.subgroups_valid?).to be_truthy
      end
    end
  end
end
