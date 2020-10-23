# Game-Of-Life


![GameOfLifeGif](https://user-images.githubusercontent.com/59428583/97030480-10cbee80-151c-11eb-8bd0-3d81a574ae9d.gif)

<h1>Conways Game of life is a cellular automaton. Invented by John Horton Conway, it's evolution is determined by it's initial state.</h1>

<h2>The Rules</h2>

1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

<h2>About The Game</h2>

This game was created using Swift and utilizing the frameworks UIKit, Foundation. Using a collection view, during each iteration each cell will check it's eight neighboring cells (left, right, up, down, diagonals) it will determine that cells next state based on the rules stated above. From there it will prepare the next array to be displayed in the collection view.

