require "sudoku_solver"

describe SudokuNumber do
  describe "coordinates" do
    known_coord_pairs = {
      0  => [0, 0],
      9  => [0, -1],
      24 => [6, -2],
      80 => [8, -8]
    }

    known_coord_pairs.each do |index, coords|
      it "should correctly output the position #{index} as [#{coords.to_s}]" do
        sudoku_number = SudokuNumber.new(index: index)
        expect(sudoku_number.coordinates).to eq coords
      end
    end
  end

  describe "subgroup" do
    known_subgroup_pairs = { 0 => 0, 3 => 1, 6 => 2, 9 => 0, 28 => 3 }

    known_subgroup_pairs.each do |index, subgroup|
      it "should correctly output the position #{index} as #{subgroup}" do
        sudoku_number = SudokuNumber.new(index: index)
        expect(sudoku_number.subgroup).to eq subgroup
      end
    end
  end
end
