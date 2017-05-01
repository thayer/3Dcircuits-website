function diodedemo(s)

%simple diode rectifier, with simple ideal diode model (0.7 V drop)

%Copyright 2002, Charles R. Sullivan
%Version 1.1, Jan., 2002
%update to 1.2 jun 2002

if nargin > 0
    save = 1;
else
    save = 0;
end

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
ca = addR(ca,5,2);

ia = currentarrow(ia,4,5,1,0);
%s1 current, numbered current 1
ia = currentarrow(ia,5,2,2,0);
%cap current, numbered 2

% calculate voltage(time)
npoints=200;
t = linspace(0,1/60,npoints);
t = t'; % make column, consistent with ode45 output
vin=4*sin(2*pi*60*t);
Vshift = vin - 0.7;
D_fully_on = Vshift > 0;
Vr = D_fully_on .* Vshift;
z = zeros(npoints,1);

vm = [z z z vin Vr z z z z];
% in general create matrix with trajectories of all node voltages.

%diode is at least partly on according to input voltage.
switch1 = vin>0;
switchm = [switch1];


i=Vr/3.3; % Scale so maximum current is one. 
im = [i i];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

rate = 20;

%%%%%%%%%SET UP 
vm=aniset(vm);
cvm=vm;

view([ 35, 30]);  % azimuth and elevation

%%%%%%%%%%%%%RUN
if save
    [filename,pname]=uiputfile('*.avi', 'Choose file to save animation in (AVI format)');
    olddir = cd;
    cd(pname);
    cavimate(t,vm,cvm,im,ca,ia,rate,switchm,filename);
    cd(olddir);
else
    skippause = 0;
    canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
    skippause = 1;
    for i=1:100;
    canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
    end
end
