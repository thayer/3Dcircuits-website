%Simple, non-animated dc circuit to show visualization works.

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
makegrid(3,3)

% ca is cell array--each column is data for one graphics object.
% {graphics handle; [n1, n2]; zv matrix; color select; aux data}
% A given component may use several graphics objects, and thus
% use several columns (e.g., two plates of cap).
% zv matrix gives the relationship between each 
% z point of the object and each node voltage, color vector has a 1 in the 
% position of the node voltage that controls the color of the object,
% if any.

%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

ca = addV(ca,1,4);
ca = addwire(ca,4,7);
ca = addwire(ca,7,8);
ca = addR(ca,8,5);
ca = addR(ca,5,2);
ca = addR(ca,6,3);
ca = addwire(ca,1,3);
ca = addwire(ca,5,6);



% calculate voltage(time)
t = 0;
t = t'; % make column, consistent with ode45 output

%6.25/6/10 divide

vm = 10*[0 0 0 1 .375 .375 1 1 0];
%keyboard
% ones indicate nodes that get that voltage as a function of time.  
% in general create matrix with trajectories of all node voltages.

% ia is similar to ca, but 
% {graphics handle; [n1, n2];zv matrix; current number ;Arrx;xpos;Arry;ypos}

%%%ia = cell(3,0);
%%%ia = currentarrow(ia,4,1,1,2);
%define a current arrow from node 4 to node 1, numbered current 1
%%%ia = currentarrow(ia,1,2,2,2);
%another current arrow, numbered current 2
ia=cell(0);

R = 1; % 1 ohm resistor just for nice scaling for now.
im = 1/R*[1 1];
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.


%%%%%%%%%SET UP 
vm=aniset(vm);
rate = 40;
%%%%%%%%%%%%%%%%
view(50,20);
disp('here''s the circuit; hit any key to show dc voltages')
pause
canimate(t,vm,vm,im,ca,ia,rate);
