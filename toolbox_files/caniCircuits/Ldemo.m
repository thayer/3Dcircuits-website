%Animation of basic inductor operation using circuit animation toolbox, version 1.2
% %Copyright 2001-2002, Charles R. Sullivan

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
   

ca = addL(ca,5,2);
ca = addwire(ca,5,4);
ca = addV(ca,1,4);
ca = addwire(ca,1,2);


ia = currentarrow(ia,5,2,1,2);
%define a current arrow from node 5 to node 2, numbered current 1


% calculate voltage(time)
%t = 0:1:140;
%t = t'; % make column, consistent with ode45 output
pulse=[0:.1:0.9 ones(1,80) 0.9:-0.1:0];
doublepulse =[0:1/19:18/19 ones(1,160) 18/19:-1/19:0];
pause =zeros(1,60);
v1 = [0 pulse pause -doublepulse pause pulse]';
t=1:length(v1);
vm = v1*[0 0 0 1 1 0 0 0 0];
%keyboard
% ones indicate nodes that get that voltage as a function of time.  
% in general create matrix with trajectories of all node voltages.

im = cumsum(v1)/sum(pulse);
%create a current matrix; sort of like voltage matrix but with 
%columns only for branches for which current arrows were defined.


rate = 40;

%%%%%%%%%SET UP 
vm = aniset(vm);

%%%%%%%%%%%%%RUN
canimate(t,vm*0.5,vm,im,ca,ia,rate);
figure(2)
subplot(2,1,1)
plot(t,v1,'linewidth',2)
ylabel('voltage')
axis([0 max(t) -1.1 1.1])
subplot(2,1,2)
plot(t,im,'color',[0 0.75 0],'linewidth',2)
axis([0 max(t) -1.1 1.1])
ylabel('current')
%hold off
%legend('Voltage','Current')
xlabel('time')
