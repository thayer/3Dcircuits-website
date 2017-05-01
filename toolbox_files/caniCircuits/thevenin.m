function thevenin()
% simple circuit for thevenin theory demo

%Copyright 2002, Charles R. Sullivan
%Version 1.1, Jan., 2002
%v 1.2 update 6/02

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
makegrid(3,3)

%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addV(ca,1,4);
ca = addR(ca,4,5);
ca = addwire(ca,1,2);
ca = addR(ca,5,2);

ia = currentarrow(ia,4,5,1,0);
%R current, numbered current 1
ia = currentarrow(ia,5,2,2,0);
%out current, numbered 2

% calculate voltage(time)
npoints=1;
t = 0;
t = t'; % make column, consistent with ode45 output
vin=10;
z = zeros(npoints,1);

vm = [z z z vin 2 z z z z];
% in general create matrix with trajectories of all node voltages.

im = [0.4 0.4];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 50, 12]);  % azimuth and elevation

%%%%%%%%%%%%%RUN
skippause = 0;
canimate(t,vm,cvm,im,ca,ia,rate);
