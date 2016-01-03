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

                get_grid = grid.map { |line| line} # just return the 2D array

                expect(expected_grid_representation).to eq(get_grid)
            end
        end
    end
end
