function ca = addV(ca,n1,n2)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;


% do three plates
%wire1 & plate 1

x1 = [0 0 -0.05 0.05]*2;
y1 = [-0.5 -0.325 -0.325 -0.325];
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

%%%%%%%%%%Now wire2, top plate

x1 = [0 0 -0.1 0.1]*2;
y1 = [0.5 0.325 0.325 0.325];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);
hold on

zvm = zeros(length(xes),length(z1));

zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%Done wire2

%%%%%%%%%%Now mid plates 1
x3 = [-0.1 0.1 0 0 -0.05 0.05]*2;
y3 = [-0.3 -0.3 -0.3 -0.2 -0.2 -0.2]+.025;
z3 = zeros(size(x3));

[x3,y3] = move(x,y,x3,y3);
   
h = plot3(x3,y3,z3,'color',[.75 .35 .75],'linewidth',2);

zvm = zeros(length(xes),length(z3));
zvm(n2,:)= ones(size(z3))/5;
zvm(n1,:)=zvm(n2,:)*4;
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%Now mid plates 2
x3 = [-0.1 0.1 0 0 -0.05 0.05]*2;
y3 = [-0.15 -0.15 -0.15 -0.05 -0.05 -0.05]+.025;
z3 = zeros(size(x3));

[x3,y3] = move(x,y,x3,y3);
   
h = plot3(x3,y3,z3,'color',[.75 .35 .75],'linewidth',2);

zvm = zeros(length(xes),length(z3));
zvm(n1,:)= ones(size(z3))*3/5;
zvm(n2,:)=ones(size(z3))*2/5;
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%Now mid plates 3
x3 = [-0.1 0.1 0 0 -0.05 0.05]*2;
y3 = [0.05 0.05 0.05 0.15 0.15 0.15]-.025;
z3 = zeros(size(x3));

[x3,y3] = move(x,y,x3,y3);
   
h = plot3(x3,y3,z3,'color',[.75 .35 .75],'linewidth',2);

zvm = zeros(length(xes),length(z3));
zvm(n1,:)= ones(size(z3))*2/5;
zvm(n2,:)=ones(size(z3))*3/5;
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%Now mid plates 4
x3 = [-0.1 0.1 0 0 -0.05 0.05]*2;
y3 = [0.2 0.2 0.2 0.3 0.3 0.3]-.025;
z3 = zeros(size(x3));

[x3,y3] = move(x,y,x3,y3);
   
h = plot3(x3,y3,z3,'color',[.75 .35 .75],'linewidth',2);

zvm = zeros(length(xes),length(z3));
zvm(n1,:)= ones(size(z3))/5;
zvm(n2,:)=zvm(n1,:)*4;
colselect=0;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
