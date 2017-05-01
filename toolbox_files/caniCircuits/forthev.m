function forthev()
% simple circuits for thevenin theory

%Copyright 2002, Charles R. Sullivan
%Version 1.1, Jan., 2002
%update to 1.2 june 2002

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
makegrid(3,3)


%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addI(ca,1,4);
ca = addwire(ca,4,5);
ca = addR(ca,5,2);
ca = addwire(ca,1,3);
ca = addR(ca,9,6);
ca = addwire(ca,5,8);
ca = addwire(ca,8,9);
ca = addR(ca,6,3);

ia = currentarrow(ia,4,5,1,0);
%in current, numbered current 1
ia = currentarrow(ia,5,2,2,0);
%shunted current, numbered 2
ia = currentarrow(ia,5,8,3,0);
%out current, numbered 3
ia = currentarrow(ia,9,6,3,0);
%out current, numbered 3

% calculate voltage(time)
npoints=1;
t = 0;
t = t'; % make column, consistent with ode45 output
iin = 1; %actually 10 mA, but...
z = zeros(npoints,1);

vm = [z z z 6 6 2 10 6 6 ];
% in general create matrix with trajectories of all node voltages.

im = [iin 0.6 0.4];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 50, 12]);  % azimuth and elevation

%%%%%%%%%%%%%RUN
skippause = 1;
canimate(t,vm,cvm,im,ca,ia,rate);
