require 'colorize'
require 'json'

# It is the entry point to run sudoku solver application
class SudokuSolver
    # Is the only method to launch the gem
    def self.run()
        self.test()
    end

    private
    
    # Test classes' functionnalities used in this application
    # to check their behaviour
    def self.test()
        sudoku_grid = Grid.new()
        puts sudoku_grid

        sudoku_grid[1, 1] = 1
        puts "\n"

        puts sudoku_grid

        Grid.completion(sudoku_grid)

        if Grid.completed?(sudoku_grid)
          puts "Terminé"
        else
          puts "Bosse encore"
        end

        json = JSON.parse(File.read('data/grid.json'))
        json.each { |line| puts line.join(' ') }
        puts json.class.name
        sudogrid = Grid.new(Marshal.load(Marshal.dump(json))) # not huge concerned about performance for deep-copying
        sudogrid[9, 1] = 9
        puts sudogrid
        json.each { |line| puts line.join(' ') }
    end
end

require 'sudoku_solver/grid'
