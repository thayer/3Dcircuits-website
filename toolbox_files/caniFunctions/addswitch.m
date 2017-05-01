function ca = addswitch(ca,n1,n2,swn)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;

%ca = addswtich(ca,n1,n2,swn)
%Adds a switch to the struture ca for circuit animations.
%n1 and n2 are the two node numbers it is connected to.
%swn is the number of the column in the switch matrix that specifies 
%         the switching behavior.

%ls = length of switch/2
ls = 0.2;
%ws = width of switch
ws = 0.25;
%wire1

x1 = [0 0];
y1 = [-0.5 -ls];
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
y1 = [0.5 ls];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%wire2 terminal

x1 = [0];
y1 = [ls];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'bo','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
%%%%%%%%%wire 1 terminal

x1 = [0];
y1 = [-ls];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'bo','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n1,:)=1;
colselect=n1;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%%%%%%%%%%%%%%%%%% switchleg
x1 = [ 0 -ws];
y1 = [-ls -ls+sqrt(4*ls^2-ws^2)];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'b-','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n1,:)=1;
colselect=0;
aux(1,1) = swn;
aux(1,2) = 0;
aux(2,:) = x1;  %x1 with switch off
aux(3,:) = [x1(1) x1(1)]; % x1 with swtich on
aux(4,:) = y1;
aux(5,:) = [y1(1), y1(1) + sign(y1(2)-y1(1))*2*ls ];
ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
