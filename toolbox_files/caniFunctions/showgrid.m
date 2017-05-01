function grid = showgrid(n,m);
%Returns the n by m grid for the circuit nodes
%Node numbers are l-r across the bottom row, l-r across the next row, etc.
%Has n rows, m columns
%Not needed by animation system, just FYI

%Version 1.2, March 2002.

vector = 1:(n*m);
grid = reshape(vector,n,m);

%xes = [ 0 1 2 0 1 2 0 1 2];
%ys =  [ 0 0 0 1 1 1 2 2 2];