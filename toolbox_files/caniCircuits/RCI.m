% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
makegrid(3,3)

%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
ca = cell(0);
ca = addI(ca,1,4);
ca = addR(ca,2,5);
ca = addcap(ca,3,6);
ca = addwire(ca,1,3);
ca = addwire(ca,4,6);

ia = cell(0);
ia = currentarrow(ia,4,5,1,2);
%define a current arrow from node 4 to node 5, numbered current 1
ia = currentarrow(ia,5,2,2,2);
%another current arrow, numbered current 2
ia = currentarrow(ia,5,6,3,2);


% calculate voltage(time)
t = linspace(0,1);
t = t'; % make column, consistent with ode45 output
v1 =  1*(1- exp(-5*t));

vm = v1*[0 0 0 1 1 1 0 0 0];
%keyboard
% ones indicate nodes that get that voltage as a function of time.  
% in general create matrix with trajectories of all node voltages.


R=1;% 1 ohm resistor just for nice scaling for now.
im = [ones(size(t)) v1 1-v1]/R;
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.


rate = 10;

%%%%%%%%%SET UP 
vm=aniset(vm);

%%%%%%%%%%%%%RUN
canimate(t,vm,vm,im,ca,ia,rate);
