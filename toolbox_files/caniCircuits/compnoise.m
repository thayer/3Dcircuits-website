function compnoise(save)
%comparator circuit with noise on the input--
%use to motivate use of schmitt trigger circuit (schmittnoise.m)

if nargin<1, save = 0; end


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

ca = addopamp(ca,5,8,9);
ca = addwire(ca,4,5);
ca = addV(ca,1,4);
ca = addwire(ca,9,6);
ca = addwire(ca,7,8);
plot3([0 -0.5  -0.5 0 ],[ 0 0 2 2],[0 0 0 0],'k','linewidth',2)


%bias current, numbered current 1
%ia = currentarrow(ia,5,6,2,0);
%feedback R current, numbered 2


% calculate voltage(time)
points = 200;
t = linspace(0,200e-6,points);
t = t'; % make column, consistent with ode45 output
vin = [linspace(1,-0.1,35) linspace(-0.1,0.1,6) linspace(0.1,-0.1,6) linspace(-0.1,0.1,6) linspace(0.1,-0.1,6) linspace(-0.1,0.1,6) linspace(0.1,-1,35)]'*15;
vin = [vin; flipud(vin)];
vout = 15*( (vin>0) - (vin<0));
z = zeros(size(t));
vm = [z z z vin vin vout z z vout];
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
