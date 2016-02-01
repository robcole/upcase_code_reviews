class SudokuNumber
  attr_reader :index, :value
  def initialize(index: 0, value: 0)
    @index = index
    @value = value
  end

  def x
    coordinates[0]
  end

  def y
    coordinates[1]
  end

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
