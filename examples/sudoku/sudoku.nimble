# Package
version       = "0.1.0"
author        = "Willi Kappler"
description   = "Distributed Sudoku with nim"
license       = "MIT"
srcDir        = "src"
bin           = @["sudoku"]

# Dependencies
requires "nim >= 2.0.0"

# Tasks
task checkAll, "run 'nim check' on all source files":
    exec "nim check sudoku_individual.nim"
    exec "nim check sudoku.nim"

task runSudoku, "Runs the Sudoku example":
    #exec "nim c sudoku.nim"
    exec "nim c -d:release sudoku.nim"
    exec "./sudoku --server &"
    exec "sleep 5"

    # Start some nodes
    exec "./sudoku -p=200 -i=5000 -k=1 --reset &"
    exec "sleep 1"

    exec "./sudoku -p=200 -i=5000 -k=1 --reset &"
    exec "sleep 1"

    exec "./sudoku -p=200 -i=10000 -m=1 -k=6 --limitfactor=1.001 &"
    exec "sleep 1"

    exec "./sudoku -p=200 -i=10000 -m=1 -k=6 --limitfactor=1.001 &"
    exec "sleep 1"

    #exec "./sudoku -p=200 -i=10000 -k=7 -m=1 --base=1.00 --increment=1.0 --limitend=10.0 &"
    #exec "sleep 1"

task cleanSudoku, "Clean up after calculation":
    exec "rm -f sudoku"
    exec "rm -f *.log"
    exec "rm -f *.json"

