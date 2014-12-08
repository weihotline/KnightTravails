## Knight's Travails
This app helps to find the shortest path for a Chess Knight from a starting position to an end position. The objective of this app is to show how to implement two algorithms of traversing a tree: **Depth First Search** (DFS) and **Breadth First Search** (BFS).

## Design
Each tree node represents a position on a board.

* **DFS** (traverses the left child until the end position is found. If it has been visited, we try to visit right child.)
* **BFS** (visits a node, then each of its children, then each of their children, etc.)

## Testing
<p>
This app is tested by running rspec.
<pre> <code>rspec spec/*
</code></pre>
</p>

## Disclaimer
This application is intended as a demo of techniques. The design pattern and specs belong to [App Academy](https://github.com/appacademy). Please feel free to contact me at <weihotline@gmail.com> if you have any questions or concerns.
