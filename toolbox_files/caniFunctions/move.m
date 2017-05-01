function [xnew,ynew] = move(x,y,x1,y1)
% move component at 0,0, axis y, 
% feature locations x1,y1
% to new coordinates centered halfway between xes in
% x and ys in y, with axis whereever axis of 

v=[x1;y1];
rotate = [0 1;-1 0];

%keyboard

if y(1) > y(2) & x(1) == x(2)
   %need 180
   v = rotate*rotate*v;
elseif y(1) < y(2) & x(1) == x(2)
   %already oriented right
elseif y(1) == y(2) & x(1) > x(2)
   v = rotate^3*v;  
elseif y(1) == y(2) & x(1) < x(2)
   v = rotate*v;     
else
   error('Non Manhattan Geometry Specified')
end
  
  
xr = v(1,:);
yr = v(2,:);
  
xnew = xr + mean(x);
ynew = yr +mean(y);
 
