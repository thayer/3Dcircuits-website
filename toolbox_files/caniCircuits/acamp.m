function acamp(save)
%bad ac coupled op amp animation

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
ca = addR(ca,9, 8);
ca = addR(ca,7,8);
ca = addV(ca,1,4);
ca = addC(ca,4,5);
ca = addwire(ca,1,3);
plot3([0 -0.5  -0.5 0 ],[ 0 0 2 2],[0 0 0 0],'k','linewidth',2)

ia = currentarrow(ia,5,4,1,0);
%bias current, numbered current 1
%ia = currentarrow(ia,5,6,2,0);
%feedback R current, numbered 2


% calculate voltage(time)
points = 400;
t = linspace(0,200e-6,points);
t = t'; % make column, consistent with ode45 output
vin = [linspace(1,-1,points/20) linspace(-1,1,points/20)]';
vin = [vin;vin;vin;vin;vin];
vin = [vin;vin]*1.5;
vp = vin + linspace(0,10,points)';
vout = vp*3;
vout = min(15,vout);
vminus = vout/3;
z = zeros(size(t));
vm = [z z z vin vp z z vminus vout];
%keyboard  
% in general create matrix with trajectories of all node voltages.


i = 0.2*ones(size(t));
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
    saveanimation(t,vm,cvm,im,ca,ia,rate,vm);
else
    skippause = 0;
    canimate(t,vm,cvm,im,ca,ia,rate,vm,skippause);
end
