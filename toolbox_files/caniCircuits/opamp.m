function opamp(p,m,g,rate)
%OPAMP(p,m,g)
%inverting op amp animation
% p is amplitude of ac signal on plus input; 
% m is amplitude of ac signal on minus input
% g is the gain
% Can set p = m, or p = -m, or p=0, m=1, or vice versa, to demo
% diff amp concept.
if nargin <4, rate=50; end

%Copyright 2001, Charles R. Sullivan
%Version 1.1, Jan., 2001
%update to 1.2, june 2002

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
ca = addR(ca,6,9);
ca = addV(ca,4,5);
ca = addV(ca,1,2);
ca = addwire(ca,1,7);
ca = addwire(ca,7,9);

ia = currentarrow(ia,6,9,1,0);
%input R current, numbered current 1

% calculate voltage(time)
points = 350;
t = linspace(0,200e-6,points);
t = t'; % make column, consistent with ode45 output
vin = [linspace(1,-1,points/2) linspace(-1,1,points/2)]';
vout = g*vin*(p-m);
z = zeros(points,1);

vm = [z p*vin z z m*vin vout z z z];
%keyboard  
% in general create matrix with trajectories of all node voltages.

i = vout/5;
im = [i];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.


rate = 80;

%%%%%%%%%SET UP 
junk=aniset([5,-5]); %fool it that five is the max, so it is always in that range.
vm=vm/5;
cvm=vm;
cvm = (cvm.*(cvm<1)+(cvm>=1));
cvm = (cvm.*(cvm>-1)+ -1*(cvm<=-1));
figure(1)

view([ 40, 20]);

%%%%%%%%%%%%%RUN
skippause = 0;
canimate(t,vm,cvm,im,ca,ia,rate,vm,skippause);
skippause = 1;
for i=1:100;
canimate(t,vm,cvm,im,ca,ia,rate,vm,skippause);
end
