function rectc(save)
%simple diode rectifier with cap, with simple ideal diode model (0.7 V drop)

%Copyright 2001-2002, Charles R. Sullivan
%Version 1.1, Jan., 2002
% V 1.2 may 2002

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

ca = addV(ca,1,4);
ca = addD(ca,4,5,1);% last number is index of on/off state in swtich matrix.
ca = addwire(ca,1,2);
ca = addC(ca,5,2);
ca = addR(ca, 6,3);
ca = addwire(ca,5,6);
ca = addwire(ca,2,3);

ia = currentarrow(ia,4,5,1,0);
ia = currentarrow(ia,2,1,1,0);
%s1 current, numbered current 1
ia = currentarrow(ia,5,2,2,0);
%cap current, numbered 2
ia = currentarrow(ia,5,6,3,0);
ia = currentarrow(ia,3,2,3,0);

% calculate voltage(time)
npoints=200*6;
t = linspace(0,1/60*6,npoints);
t = t'; % make column, consistent with ode45 output
vin=4*sin(2*pi*60*t);
Vshift = vin - 0.7;

vout = zeros(npoints,1);;
i2 = zeros(npoints,1);;
i1= zeros(npoints,1);;
i3 = zeros(npoints,1);;
for i = 2:npoints
   vout(i) = vout(i-1);
   i1(i) = 0;
   if vout(i) < Vshift(i);
      vout(i) = Vshift(i);
      i1(i) = 2*cos(2*pi*60*t(i));
      i2(i) = i2(i)+i1(i);
   else
      vout(i) = vout(i-1)*0.9975;
   end
   i2(i) = i2(i)-vout(i)/10;
   i3(i) = vout(i)/10;
end

switchm = vin>vout;
   
z = zeros(npoints,1);

vm = [z z z vin vout vout z z z];
% in general create matrix with trajectories of all node voltages.

%diode is at least partly on according to input voltage.


 % Scale so maximum current is one. 
im = [i1 i2 i3];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 35, 30]);  % azimuth and elevation

%%%%%%%%%%%%%RUN
figure(2)
plot(t,vin,t,vout,t,i1*2,t,i2*2,t,i3*2)
legend('Input voltage','Output voltage','Input current','Capacitor current','Load current')
figure(1)

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
%figure(2)
%plot(t,vin,t,vout,t,i1,t,i2,t,i3)
