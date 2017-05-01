function bridger(save)
%bridge rectifier, with simple ideal diode model (0.7 V drop)

%Copyright 2002, Charles R. Sullivan
%Version 1.2, May., 2002

if nargin<1, save=0; end


% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3

makegrid(3,3)

%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addV(ca,4,7);
ca = addwire(ca,1,4);
ca = addD(ca,2,5,1);
ca = addD(ca,8,5,2);
ca = addD(ca,6,3,2);
ca = addD(ca,6,9,1);
% last number is index of on/off state in swtich matrix.
ca = addwire(ca,1,3);
ca = addwire(ca,7,9);
ca = addR(ca,5,6);

ia = currentarrow(ia,7,8,1,0);
ia = currentarrow(ia,2,1,1,0);
%s1 current, numbered current 1
ia = currentarrow(ia,8,5,2,0);
ia = currentarrow(ia,6,3,2,0);
ia = currentarrow(ia,3,2,2,0);
%current, numbered 2

ia = currentarrow(ia,5,2,3,0);
ia = currentarrow(ia,9,6,3,0);
ia = currentarrow(ia,8,9,3,0);

ia = currentarrow(ia,5,6,4,0);

% calculate voltage(time)
npoints=200;
t = linspace(0,1/60,npoints);
t = t'; % make column, consistent with ode45 output
vin=4*sin(2*pi*60*t);
vpos = vin>0;
Vshiftp = vin - 0.7;
Vshiftn = vin +0.7;
DA_fully_on = Vshiftp > 0.7;
DB_fully_on = Vshiftn < -0.7;
mpv = ((~DA_fully_on)&(~DB_fully_on)).*vin/2;

Vrleft = DA_fully_on .* Vshiftp - DB_fully_on.*0.7 + mpv;
Vrright = DB_fully_on .* Vshiftn + DA_fully_on.*0.7 + mpv;
z = zeros(npoints,1);

vm = [z z z z Vrleft Vrright  vin vin vin];
% in general create matrix with trajectories of all node voltages.

%diode is at least partly on according to input voltage.
switch1 = vin>0;
switchm = [~switch1 switch1];


i2=(Vshiftp-0.7)/2.6.*DA_fully_on; % Scale so maximum current is one.
i3=-(Vshiftn+0.7)/2.6.*DB_fully_on;
i4 = i2+i3;
i1 = i2-i3;
im = [i1 i2 -i3 i4];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 60, 30]);  % azimuth and elevation

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

%skippause = 0;
%canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
%skippause = 1;
%for i=1:100;
%canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
%end
