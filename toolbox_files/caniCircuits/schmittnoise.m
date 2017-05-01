function acamp(save)
%schmidt trigger circuit

if nargin<1, save = 0; end


%Copyright 2001, Charles R. Sullivan
%Version 1.1, Dec., 2001

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3

makegrid(3,3)
%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addopamp(ca,5,8,9);
ca = addR(ca,6,5);
ca = addR(ca,4,5);
ca = addV(ca,1,4);
ca = addwire(ca,9,6);
ca = addwire(ca,7,8);
plot3([0 -0.5  -0.5 0 ],[ 0 0 2 2],[0 0 0 0],'k','linewidth',2)

ia = currentarrow(ia,5,4,1,0);
ia = currentarrow(ia,6,5,1,0);
%bias current, numbered current 1
%ia = currentarrow(ia,5,6,2,0);
%feedback R current, numbered 2


% calculate voltage(time)
points = 200;
t = linspace(0,200e-6,points);
t = t'; % make column, consistent with ode45 output
vin = [linspace(1,-0.1,35) linspace(-0.1,0.1,5) linspace(0.1,-0.1,5) linspace(-0.1,0.1,5) linspace(0.1,-0.53,15) linspace(-0.53,-0.2,5) linspace(-0.2,-0.6,5) linspace(-0.6,-0.3,5) linspace(-0.3,-1,20)]'*15;
vin = [vin; -vin];
    vout = zeros(size(t));
vp = vout;
vout(1) = 15;
vp(1) = 2/3*vin(1) + 1/3*vout(1);
for i = 2:points
   vp(i) = 2/3*vin(i) + 1/3*vout(i-1);
   vout(i) = -15 + 30*(vp(i) > 0);
end
z = zeros(size(t));
vm = [z z z vin vp vout z z vout];
%keyboard  
% in general create matrix with trajectories of all node voltages.


i = (vout-vin)/30;
im = [i];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.


rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ -37.5, 20]);

%%%%%%%%%%%%%RUN
if save
    saveanimation(t,vm,cvm,im,ca,ia,rate);
else
    skippause = 0;
    switchm=0;
    canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
    skippause = 1;
    for i=1:100;
    canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
    end
end
