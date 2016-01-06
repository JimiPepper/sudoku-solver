require 'sudoku_solver'

# Is the sudoku's grid representation. More technically, it is
# simply a 2D array-wrapper which includes two iterator (each 
# and map) and several other methods. It uses the tensor, so to 
# get or set a value of a cell you need to give the line index (
# ( 1..9) and the column index (1..9 as welll).
class SudokuSolver::Grid
  # Instanciate a Grid object, if no parameter is given
  # it creates an empty cell, otherwise if an array is
  # provided, set the grid using this array
  def initialize(array = [])
    if array.empty?
        @grid = [
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
          [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
        ]
    else
        first_dimension_analysis = array.size == 9
        second_dimension_analysis = array.map { |sub_array| sub_array.class != Array and sub_array.size == 9 }

        if first_dimension_analysis && second_dimension_analysis.all?
            @grid = array
        else
            raise ArgumentError, 'You provide an overkill array for building a sudoku\'s grid'
        end
    end
  end

  # Compute the grid's completion in percentage by counting
  # the remaining empty cells
  def self.completion(instance)
    zeros = 0
    instance.each { |line| zeros += line.select{ |elem| elem == 0 }.size }
    puts ((81 - zeros) / 81.0 * 100).to_i
  end

  # Checks if the grid is completed, it means that :
  #  + Each line has only one digit between 1..9
  #  + Each column has only one digit between 1..9
  #  + Each 3*3 sub-grid has only one digit between 1..9
  def self.completed?(instance)
    self.atomicCompleted?(instance, 9)
  end

  # Checks recursively if the grid is completed
  def self.atomicCompleted?(instance, index)
    if index == 0
      return true
    else
      expected = Array (1..9)

      line = instance.line(index).sort
      col = instance.column(index).sort
      tensor = instance.tensor(index).flatten.sort

      expected == line and expected == col and expected == tensor and self.atomicCompleted?(instance, index - 1)
    end
  end

  # Override the each iterator in order to loop over
  # all lines in the grid 
  def each(&block)
    @grid.each(&block)
    self
  end

  # Override the map iterator in order to loop over
  # all lines in the grid and return a value from them
  def map(&block)
    @grid.map(&block)
  end

  # Override the array affectation operator
  # How does it works ? : +instance[1, 1] = 9 +:: to set the cell at line 1 and column 1 to value 9 
  def []=(i, j, new_value)
    if i.between?(1, 9) and j.between?(1, 9)
        @grid[i - 1][j - 1] = new_value
    else
        raise ArgumentError, 'Use the tensor notation to set one of cell\'s value (indexes must be between 1 and 9, inclusive)'
    end
  end

  # Override the array accessor operator
  # How does it works ? : +instance[1, 1]+:: to get the cell's value at line 1 and column 1 
  def [](i, j)
    if i.between?(1, 9) and j.between?(1, 9)
        @grid[i - 1][j - 1]
    else
        raise ArgumentError, 'Use the tensor notation to set one of cell\'s value (indexes must be between 1 and 9, inclusive)'
    end
  end

  # Get a line from its index
  def line(i)
    if i.between?(1, 9)
        @grid[i - 1]
    else
        raise ArgumentError, 'Use the tensor notation to set one of the tensor\'s line (indexes must be between 1 and 9, inclusive)'
    end
  end

  # Get a column from its index
  def column(j)
    if j.between?(1, 9)
        self.map { |line| line[j - 1]}
    else
        raise ArgumentError, 'Use the tensor notation to set one of the tensor\'s line (indexes must be between 1 and 9, inclusive)'
    end
  end

  # Get a sub-grid from its index
  def tensor(index)
    if index.between?(1, 9)
        min_x = (index - 1) % 3 * 3
        min_y = ((index - 1) / 3) * 3
        [
          [ @grid[min_y][min_x..(min_x + 2)] ],
          [ @grid[min_y + 1][min_x..(min_x + 2)] ],
          [ @grid[min_y + 2][min_x..(min_x + 2)] ]
        ]
    else
        raise ArgumentError, 'A sudoku\'s grid has only 9 3*3 sub-grids, use an index between 1 and 9'
    end
  end

  def to_s()
    output = lambda do |str|
      str += " "
      23.times { str += "-" }
      str + "\n"
    end

    resp = ""
    resp = output.call(resp)

    self.each do |line|
      inter = Array.new()
      line.each_slice(3) { |sliced| inter.push(sliced.join(' ')) }
      resp += "| " + inter.join(' | ') + " |\n"
    end

    resp = output.call(resp)
  end
end
