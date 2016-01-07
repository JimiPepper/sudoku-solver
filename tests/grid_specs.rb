require 'sudoku_solver/grid'

describe SudokuSolver::Grid do

    describe '.initialize' do
        context 'given no parameter when instantiating a Grid object' do
            it 'create an empty sudoku\'s grid' do
                grid = SudokuSolver::Grid.new
                expected_grid_representation = [
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                    [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
                ]

                get_grid = grid.map { |line| line } # just return the 2D array

                expect(expected_grid_representation).to eq(get_grid)
            end
        end

        context 'given a 2D array when instantiating a Grid object' do
            it 'create a grid filled exactly the same way' do
                provided_array_parameter = [
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    [],
                    []
                ]

                counter = 1
                0.upto(8) do |i|
                    0.upto(8) do |j|
                        provided_array_parameter[i][j] = counter
                        counter += 1
                    end
                end

                grid = SudokuSolver::Grid.new(provided_array_parameter)
                get_grid = grid.map { |line| line }

                expect(provided_array_parameter).to eq(get_grid)
            end
        end
    end
end
