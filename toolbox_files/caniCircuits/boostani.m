function boostani(rr,cap,d, save)
%BoostANI(rr,cap,d)
%Runs an animation of a boost converter with 
%ripple ratio rr.
%relative cap value cap (about 5 gives visible ripple with rr = 1)
%duty cycle d


%Copyright 2001-2002, Charles R. Sullivan
%Version 1.2, March, 2002

if nargin<4, save = 0; end

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 9 10 11 12
% 5  6   7   8
% 1 2   3    4

makegrid(3,4)


%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addV(ca,1,5);
ca = addwire(ca,1,4);
ca = addL(ca,6,5);
ca = addC(ca,7,3);
ca = addswitch(ca,6,2,1);
ca = addd(ca,6,7,2);
ca = addwire(ca,7,8);
ca = addR(ca, 8, 4);

ia = currentarrow(ia,6,7,1,0);
%diode current, numbered current 1
ia = currentarrow(ia,7,3,4,0);
%cap current, numbered 4
ia = currentarrow(ia,2,6,2,0);
%s1 current, 2
ia = currentarrow(ia,5,6,3,0);
%L current, 3

ia = currentarrow(ia,7,8,5,0);
%Output current

% calculate voltage(time)
t = linspace(0,200e-6,100);
t = t'; % make column, consistent with ode45 output
vin=10;
dp = 1-d;
Vout = vin/dp;
vx = [zeros(round(100*d),1); ones(100-round(100*d),1)]*Vout;
z = zeros(100,1);
vin = ones(100,1)*vin;
Vout = ones(100,1)*Vout;

vm = [z z z z vin vx Vout Vout z z z z];
%keyboard  
% in general create matrix with trajectories of all node voltages.

%switch states based on vx voltage.
switch1 = vx==0;
switch2 = ~switch1;
switchm = [switch1 switch2];


idc=0.5; %somewhat arbitrary choice.
iL = [linspace(1-rr/2,1+rr/2,round(100*d)),linspace(1+rr/2,1-rr/2,100-round(100*d))]'*idc;
idcout = idc*dp;
id = iL.*switch2;
ic = id - idcout;
% currents are [ diode, s1, L, cap, load]
im = [id    -iL.*switch1   iL     ic    idcout*ones(size(t))];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

figure(2)
plot(im)
figure(1)

%Make output ripple
Vr = cumsum(ic)/cap  + Vout;

vm(:,7) = Vr;
vm(:,8) = Vr;

%Adjust Iout to ripple too:
im(:,5) = Vr./Vout*idcout;

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 30, 45]);

%%%%%%%%%%%%%RUN

%%%%%%%%%%%%%RUN
if save
    saveanimation(t,vm,cvm,im,ca,ia,rate,switchm);
else
   skippause = 0;
   canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
   skippause = 1;
   for i=1:100;
      canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
   end
end


