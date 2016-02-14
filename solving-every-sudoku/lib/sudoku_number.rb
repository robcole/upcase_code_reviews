class SudokuNumber
  attr_reader :index, :value, :possible_values, :hidden_single_value
  def initialize(index: 0, value: 0)
    @index = index
    @value = value
    @possible_values = []
    @solved = false
    solve!(value) if nonzero_value?
  end

  def nonzero_value?
    @value != 0
  end

  def solve!(value = nil)
    if value || solveable?
      @value = value || @possible_values.first
      @possible_values = []
      @solved = true
      self
    end
  end

  def solveable?
    @possible_values.size == 1
  end

  def possible_values=(arr)
    @possible_values = arr unless solved?
  end

  def hidden_single_value(other_possible_values)
    possible_values - other_possible_values
  end

  def unsolved?
    @solved == false
  end

  def solved?
    @solved == true
  end

  def value=(val)
    @value = val unless solved?
  end

  def x
    coordinates[0]
  end
  alias_method :column, :x


  def y
    coordinates[1]
  end
  alias_method :row, :y

  def coordinates
    @coordinates ||= index_to_coordinates
  end

  def subgroup
    @subgroup ||= coordinates_to_subgroup
  end

  def index_to_coordinates
    y_coordinate = (index / 9)
    x_coordinate = index - (y_coordinate * 9)
    [x_coordinate, -y_coordinate]
  end

  def coordinates_to_subgroup
    vertical_index = (-y / 3) * 3
    horizontal_index = x / 3
    vertical_index + horizontal_index
  end
end
