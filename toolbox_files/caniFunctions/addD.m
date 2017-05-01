function ca = addD(ca,n1,n2,swn)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;

%ca = addD(ca,n1,n2,swn)
%Adds a diode to the struture ca for circuit animations.
%n1 is the anode, n2 is the cathode.
%swn is the number of the column in the switch matrix that specifies 
%         the switching behavior of the diode.


%ld = length of diode/2
ld = 0.1;
%ws = width of diode/2
wd = 0.15;
%wire1
x1 = [0 0];
y1 = [-0.5 -ld];
z1 = zeros(size(x1));

x=[xes(n1),xes(n2)];
y=[ys(n1),ys(n2)];

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);
hold on

zvm = zeros(length(xes),length(z1));
zvm(n1,:)=1;
colselect=n1;

aux = zeros(0); %placeholder for future features, e.g. switches and exploding wires.
if length(ca)>0,
   ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
else
   ca = {h; [n1 n2]; zvm; colselect; aux};
end

%%%%%%%%%%Done wire1
%%%%%%%%%%wire2

x1 = [0 0];
y1 = [0.5 ld];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%cathode (wire 2)

x1 = [-wd wd];
y1 = [ld ld];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'b-','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n2,:)=1;
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
%%%%%%%%%%%%%%%%%%%%%%%%%%% triangle
x1 = [ 0 -wd +wd 0];
y1 = [ld -ld -ld ld];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'b-','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvmon1=[0 1 1 0];
zvmon2=[1 0 0 1];
zvmoff1=[1 1 1 1];
zvmoff2=[0 0 0 0];
colselect=0;
aux(1,1) = swn;
aux(1,2:4) = [0 0 0 ];  %This is just a placeholder.
aux(2,:) = x1;  %x1 with switch off
aux(3,:) = x1; % x1 with swtich on
aux(4,:) = y1; %y1 with switch off
aux(5,:) = y1; %y1 with switch on
aux(6,:) = zvmoff1; % zvm with switch off, n1 part
aux(7,:) = zvmon1; %zvm with swtich on.
aux(8,:) = zvmoff2; % zvm with switch off, n2 part
aux(9,:) = zvmon2; %zvm with swtich on.
ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
