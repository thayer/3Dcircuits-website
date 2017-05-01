function buckani(rr,cap,d, save)
%BUCKANI(rr,cap,d)
%Runs an animation of a buck converter with 
%ripple ratio rr.
%relative cap value cap (about 5 gives visible ripple with rr = 1)
%duty cycle d
%
%%BUCKANI(rr,cap,d,save)
% saves the animation as an uncompressed avi file if 'save' is set to one.

%Copyright 2001, Charles R. Sullivan
%Version 1.2, Dec., 2002

if nargin<4, save = 0; end   % Sets it up to not save anything if save has not been specified.

makegrid(3,4) % Sets up a grid of circuit nodes.
% Components may be placed between any of the numbered nodes
% in this grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 9 10 11 12
% 5  6   7   8
% 1 2   3    4

%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

%Add components between specified nodes.
ca = addV(ca,1,5);
ca = addwire(ca,5, 9);
ca = addwire(ca,9,10);
ca = addwire(ca,1,4);
ca = addL(ca,7,6);
ca = addC(ca,7,3);
ca = addswitch(ca,10,6,1);  %last argument sets "switch number" to be used in specifying switching pattern.
ca = addswitch(ca,6,2,2);
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
t = linspace(0,200e-6,100);   %Sets up a vector of evenly spaced time points
t = t'; % make column, consistent with ode45 output
vin=10;
dp = 1-d;   %duty cycle of second switch.
vx = [ones(100*d,1); zeros(100*dp,1)]*vin;  %voltage at swtiching node.
z = zeros(100,1); % zero vector for later use.
vin = ones(100,1)*vin;  %Make vin a vector.
vout = d*vin;   % Sets vout constant--later we'll add ripple.


vm = [z z z z vin vx vout vout vin vin z z];    
% in general create matrix with trajectories of all node voltages.

%switch states based on vx voltage.
switch1 = vx>0;
switch2 = ~switch1;
switchm = [switch1 switch2];


idc=0.5; %i = 1 is max that can be displayed cleanly--this leaves some room for ripple.
iL = [linspace(1-rr/2,1+rr/2,100*d),linspace(1+rr/2,1-rr/2,100*dp)]'*idc;  % Calculate ripple
im = [-iL.*switch1    iL.*switch2    -iL     (iL-idc)     -idc*ones(size(t))];  
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

%Make output ripple:
iC = iL - idc;
Vr = cumsum(iC)/cap  + vout;

vm(:,7) = Vr;
vm(:,8) = Vr;

%Adjust Iout to ripple too:
im(:,5) = Vr./vout*idc;

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;  % separate matrix for colors; could add scaling here if desired.

view([ 30, 20+d*40]);   % Experiment to find good viewing angle.  Best angle depends on duty cycle.

%%%%%%%%%%%%%RUN
if save
    saveanimation(t,vm,cvm,im,ca,ia,rate,switchm);
else
   skippause = 0;   % Don't skip the pause at the start of the animation.
   canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
  %Completed animation of one cycle; now do 100 more or until user terminates.
   skippause = 1;
   for i=1:100;
      canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
   end
end