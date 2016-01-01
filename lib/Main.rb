require 'colorize'
require 'json'
require_relative 'math/Matrix.rb'
require_relative 'game/Grid.rb'

puts ":: MATRIX".light_blue

matrix = Matrix.new(3)
puts matrix
puts "\n"

3.times do |i|
  puts "Line #{i + 1} : #{matrix.line(i + 1).join(' ')}"
end

puts "\n:: GRID".light_blue

sudoku_grid = Grid.new()
puts sudoku_grid
puts "\n"

sudoku_grid[3].set(1, 1 , 0)

puts sudoku_grid

Grid.completion(sudoku_grid)
Grid.completed?(sudoku_grid)

json_grid = json.parse("grid.json")
puts json_grid
