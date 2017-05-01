function iinamp(g,a)
%inverting op amp animation
% g is nominal gain; 
% a is op-amp gain; defaults to 10,000
if nargin < 2, a=1e4; end

%Copyright 2001, Charles R. Sullivan
%Version 1.1, Dec., 2001
%update to 1.2 June 2002

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
makegrid(3,3)


%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addopamp(ca,2,5,6);
ca = addR(ca,6, 5);
if(g>1e4)
   ca = addwire(ca,5,4);
else
   ca = addR(ca,5,4);
end
ca = addI(ca,1,4);
ca = addwire(ca,1,2);

ia = currentarrow(ia,4,5,1,0);
%input R current, numbered current 1
ia = currentarrow(ia,5,6,2,0);
%feedback R current, numbered 2


% calculate voltage(time)
points = 150;
t = linspace(0,200e-6,points);
t = t'; % make column, consistent with ode45 output
vin = [linspace(1,-1,points/2) linspace(-1,1,points/2)]';
v1 = vin/((a+1)/g + 1);
vout = -a*v1;
z = zeros(points,1);

vm = [z z z vin v1 vout z z z];
%keyboard  
% in general create matrix with trajectories of all node voltages.


i = vin;
im = [i i];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.


rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 40, 20]);

%%%%%%%%%%%%%RUN
skippause = 0;
canimate(t,vm,cvm,im,ca,ia,rate,vm,skippause);
skippause = 1;
for i=1:100;
canimate(t,vm,cvm,im,ca,ia,rate,vm,skippause);
end
