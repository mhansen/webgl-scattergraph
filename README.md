The goal: Create a scatterplot library using WebGL that's good enough to use on markhansen.co.nz/scatter.fm.

Motivation: scrolling in a canvas/flot graph is too slow. The scrolling is all done in software, and thousands of data points are iterated through in the javascript layer. By putting all the points on the graphics card, then scrolling by just updating the camera matrix, we should get significant speedups.
