class SudokuNumberGroup
  attr_accessor :type, :items

  def self.columns_for(numbers)
    new(numbers: numbers, type: :columns)
  end

  def self.subgroups_for(numbers)
    new(numbers: numbers, type: :subgroups)
  end

  def self.rows_for(numbers)
    new(numbers: numbers, type: :rows)
  end

  def initialize(numbers:, type:)
    @type = type
    @items ||= numbers.group_by(&key)
  end

  def key
    self.class.key_lookup[type]
  end

  def find_scoped_attributes(number:, attribute:)
    index = number.send(key)
    items[index].reject { |item| item.index == number.index }.map(&attribute)
  end

  def values(number)
    find_scoped_attributes(number: number, attribute: :value)
  end

  def possible_values(number)
    find_scoped_attributes(number: number, attribute: :possible_values)
  end

  def numbers_valid?(item_numbers)
    nonzero_numbers = item_numbers.map(&:value).reject(&:zero?)
    nonzero_numbers.size == nonzero_numbers.uniq.size
  end

  def valid?
    items.all? { |(_index, numbers)| numbers_valid?(numbers) }
  end

  def self.key_lookup
    { rows: :y, columns: :x, subgroups: :subgroup }
  end
end
