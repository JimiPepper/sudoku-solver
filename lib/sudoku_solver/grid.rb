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
        @grid = array
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
    @grid[i - 1][j - 1] = new_value
  end

  # Override the array accessor operator
  # How does it works ? : +instance[1, 1]+:: to get the cell's value at line 1 and column 1 
  def [](i, j)
    @grid[i - 1][j - 1]
  end

  # Get a line from its index
  def line(i)
    @grid[i - 1]
  end

  # Get a column from its index
  def column(j)
    self.map { |line| line[j - 1]}
  end

  # Get a sub-grid from its index
  def tensor(index)
    case index
    when 1
      minX = 0
      minY = 0
    when 2
      minX = 3
      minY = 0
    when 3
      minX = 6
      minY = 0
    when 4
      minX = 0
      minY = 3
    when 5
      minX = 3
      minY = 3
    when 6
      minX = 6
      minY = 3
    when 7
      minX = 0
      minY = 6
    when 8
      minX = 3
      minY = 6
    when 9
      minX = 6
      minY = 6
    end

    [
      [ @grid[minY][minX..(minX + 2)] ],
      [ @grid[minY + 1][minX..(minX + 2)] ],
      [ @grid[minY + 2][minX..(minX + 2)] ]
    ]
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
