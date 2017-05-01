function makegrid(n,m);
%Returns the n by m grid for the circuit nodes
%Node numbers are l-r across the bottom row, l-r across the next row, etc.
%Has n rows, m columns
%Too see what the grid is, use showgrid

%Version 1.2, March 2002.

%This is a somewhat bizarre way to set up a vector of x coordinates and a vector of
%y coordinates as in the 3x3 example below.
%xes = [ 0 1 2 0 1 2 0 1 2];
%ys =  [ 0 0 0 1 1 1 2 2 2];
matrix = ones(m,1)*(0:(n-1));
ys = reshape(matrix,1,n*m);

matrix = ones(n,1)*(0:(m-1));
xes = reshape(matrix',1,m*n);


%put the variables xes and ys into  global variables, which are accessed by each "add" function
% and by "currentarrow"
global CANI_XES CANI_YS;
CANI_XES = xes;
CANI_YS = ys;

