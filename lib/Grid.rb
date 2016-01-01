require_relative '../math/Matrix.rb'

class Grid
  def initialize()
    @grid = [
      [ Matrix.new(3), Matrix.new(3), Matrix.new(3) ],
      [ Matrix.new(3), Matrix.new(3), Matrix.new(3) ],
      [ Matrix.new(3), Matrix.new(3), Matrix.new(3) ]
    ]
  end

  def [](index)
    i = (index - 1) / 3
    j = (index - 1) % 3

    @grid[i][j]
  end

  def line(index)
    line = Array.new()
    i = (index - 1) / 3
    j = (index - 1) % 3

    @grid[i].each { |matrix| line.push(matrix.line(j + 1)) }

    line.flatten
  end

  def column(index)
    column = Array.new()
    i = (index - 1) / 3
    j = (index - 1) % 3

    3.times do |k|
      column.push(@grid[k][i].column(j + 1))
    end

    column.flatten
  end

  def self.completion(grid)
    zeros = 0
    1.upto(9) { |index| zeros += grid.line(index).select{ |elem| elem == 0 }.size }
    puts "Zeros : #{zeros}"
    puts ((81 - zeros) / 81.0 * 100).to_i
  end

  def self.completed?(grid)
    bool = false

    1.upto(9) do |index|
      line = grid.line(index).sort
      col = grid.column(index).sort
      matrix = [ grid[index].line(1), grid[index].line(2), grid[index].line(3)].flatten.sort

      1.upto(9) { |k| bool = bool or (line[k] == k and col[k] == k and matrix[k] == k)}
    end

    puts bool
  end

  def to_s()
    resp = ""

    for i in 0..2
      prepGridStr = Array.new(3, "")
      @grid[i].each do |matrix|
        for k in 0..2
          prepGridStr[k] += "| "
          matrix.line(k + 1).each { |elem| prepGridStr[k] += "#{elem} " }
        end
      end

      24.times do resp += "-" end
      resp += "\n"
      for k in 0..2
        resp += "#{prepGridStr[k]}|\n"
      end
    end

    24.times do resp += "-" end
    resp += "\n"

    resp
  end
end
