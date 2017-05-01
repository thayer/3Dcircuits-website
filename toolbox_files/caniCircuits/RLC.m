% RLC circuit animation.

% ca is cell array--each column is data for one graphics object.
% {graphics handle; [n1, n2]; zv matrix; color select; aux data}
% A given component may use several graphics objects, and thus
% use several columns (e.g., two plates of cap).
% zv matrix gives the relationship between each 
% z point of the object and each node voltage, color vector has a 1 in the 
% position of the node voltage that controls the color of the object,
% if any.

%%%%%%%%Set up and clear figure%%%%%%%%%%%
makegrid(3,3)
aninit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 1 2 3
% 4 5 6
% 7 8 9

ca = addwire(ca,2,1);
ca = addcap(ca,2,5);
ca = addR(ca,4,5);
ca = addL(ca,1,4);



% calculate voltage(time)
t = linspace(0,10,300);
t = t'; % make column, consistent with ode45 output
R = 1;
L = 1;
C = 1;
zeta = R/2*sqrt(L/C);
wn = sqrt(1/L/C);
wd = wn*sqrt(1-zeta^2);
p = wd*j - zeta*wn;
iL = real(exp(p*t));
vC = real(1/p*exp(p*t));
vR = R*iL;

zer = zeros(size(t));
vm = [ zer zer  zer vC-vR vC zer zer zer zer];
%keyboard
% ones indicate nodes that get that voltage as a function of time.  
% in general create matrix with trajectories of all node voltages.

% ia is similar to ca, but 
% {graphics handle; [n1, n2];zv matrix; current number ;Arrx;xpos;Arry;ypos}


ia = currentarrow(ia,4,1,1,2);
%define a current arrow from node 4 to node 5, numbered current 1
ia = currentarrow(ia,5,4,1,2);
%another current arrow, numbered current 1


R = 1; % 1 ohm resistor just for nice scaling for now.
im = vR/R*[1 1];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.

%%%%%%%%%SET UP 
vm = aniset(vm);

rate = 40;
cvm=vm/max(max(abs(vm)));
canimate(t,vm,cvm,im,ca,ia,rate);

%%%%%%%%%%%%%%%%%%%%END OF MAIN
