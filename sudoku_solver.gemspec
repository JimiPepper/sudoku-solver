Gem::Specification.new do |gem|
    gem.name            = 'sudoku_solver'
    gem.license         = 'MIT'
    gem.summary         = 'A simple solver for sudoku\'s game written in Ruby'
    gem.author          = 'Romain Philippon'
    gem.email           = 'maitre.jiraya@live.fr'
    gem.require_paths   = ['lib', 'data']
    gem.files           = ['lib/sudoku_solver.rb', 'lib/sudoku_solver/grid.rb']
    gem.homepage        = 'https://github.com/JimiPepper/sudoku-solver'
    gem.version         = '0.0.0'
    gem.executables     = ['sudoku_solver']
end
