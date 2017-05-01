function discbuckani(r,cap,d, save)
%DISCBUCKANI(r,cap,d)
%Runs an animation of a buck converter with 
%output resistor r;  r = 1 for edge of discontinuous mode
%relative cap value cap (about 5 gives visible ripple with rr = 1)
%duty cycle d
%set save to one to save an uncompressed avi animation 


%Copyright 2001, Charles R. Sullivan
%Version 1.2, Dec., 2001

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
ca = addwire(ca,5, 9);
ca = addwire(ca,9,10);
ca = addwire(ca,1,4);
ca = addL(ca,7,6);
ca = addC(ca,7,3);
ca = addswitch(ca,10,6,1);
ca = addD(ca,2,6,2);
ca = addwire(ca,7,8);
ca = addR(ca, 8, 4);

ia = currentarrow(ia,10,9,1,0);
%s1 current, numbered current 1
ia = currentarrow(ia,7,3,4,0);
%cap current, numbered 4
ia = currentarrow(ia,2,6,2,0);
%s2 current, 2
ia = currentarrow(ia,7,6,3,0);
%L current, 3

ia = currentarrow(ia,7,8,5,0);
%Output current

% calculate voltage(time)
t = linspace(0,200e-6,100);
t = t'; % make column, consistent with ode45 output
T=100;
vin=10;
L=25;
dp = 1-d;

if dp > 2*L/r/T;
    %disc mode
    disc = 1;
    vout = -d^2*vin*r*T/4/L + d*vin*sqrt(r*T/2/L + r^2*T^2*d^2/16/L^2);
    d2 = d*(vin-vout)/vout;
else
    %cont mode
    disc=0;
    vout = d*vin;
    d2 = dp;
    rr = d*(vin-vout)*T/L   /    (vout/r);
end

vx = [ones(round(100*d),1)*vin; zeros(round(100*d2),1); ones( 100-round(100*d)-round(100*d2), 1)*vout];
z = zeros(100,1);
vin = ones(100,1)*vin;
vout = ones(100,1)*vout;

vm = [z z z z vin vx vout vout vin vin z z];
%keyboard  
% in general create matrix with trajectories of all node voltages.

%switch states based on vx voltage.
switch1 = vx==vin(1);
switch2 = vx ==0;
switchm = [switch1 switch2];

idc=vout(1)/r;
if disc
     ipeak = (vin(1)-vout(1))*d*T/L;
     iL = [linspace(0,ipeak,round(100*d)),linspace(ipeak,0,round(100*d2)),zeros( 1,100-round(100*d)-round(100*d2)) ]';     
 else
     iL = [linspace(1-rr/2,1+rr/2,round(100*d)),linspace(1+rr/2,1-rr/2,100-round(100*dp))]'*idc;
 end
%keyboard
im = [-iL.*switch1    iL.*switch2    -iL     (iL-idc)     idc.*ones(size(t))];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

%scale im to 0.5 as nominal dc output current when r = 1;
inom = d*vin(1)/1;
im = im/inom*0.5;

%Make output ripple:
iC = iL - idc;
Vr = cumsum(iC)/cap/20;
avgVr = sum(Vr)/length(Vr);
Vrac = Vr - avgVr;
Vr = Vrac + vout;

vm(:,7) = Vr;
vm(:,8) = Vr;
vm(:,6) = switch1.*vin + ~switch2.*~switch1.*Vr;

%Adjust Iout to ripple too:
im(:,5) = Vr./vout.*im(:,5);


rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ -20, 20]);

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


