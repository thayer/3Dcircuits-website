function ca = addR(ca,n1,n2)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;


%wire1

x1 = [0 0];
y1 = [-0.5 -0.35];
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

%%%%%%%%%%Now wire2

x2 = [0 0];
y2 = [0.5 0.35];
z2 = zeros(size(x2));

[x2,y2] = move(x,y,x2,y2);
   
h = plot3(x2,y2,z2,'k','linewidth',2);

zvm = zeros(length(xes),length(z2));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%Done wire2

%%%%%%%%%%Now Box!
x3 = [-1 1 1 -1 -1]*0.1;
y3 = [-0.35 -0.35 0.35 0.35 -0.35];
z3 = zeros(size(x3));

[x3,y3] = move(x,y,x3,y3);
   
h = plot3(x3,y3,z3,'color',[.75,.35,.75],'linewidth',2);

zvm = zeros(length(xes),length(z3));
zvm(n2,:)= [0 0 1 1 0];
zvm(n1,:)=[1 1 0 0 1];
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%Now Arrow!
x3 = [ 0 0 -0.8 0 0.8]*0.1;
y3 = [-0.25 0.25 0.15 0.25 0.15];
z3 = zeros(size(x3));

[x3,y3] = move(x,y,x3,y3);
   
h = plot3(x3,y3,z3,'color',[.75 .35 .75],'linewidth',2);

zvm = zeros(length(xes),length(z3));
zvm(n2,:)= ([-0.25 0.25 0.15 0.25 0.15]+0.35)/0.7;
zvm(n1,:)=-([-0.25 0.25 0.15 0.25 0.15]-0.35)/0.7;
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
