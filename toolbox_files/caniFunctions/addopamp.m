function ca = addopamp(ca,n1,n2,n3)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;

%ca = addopamp(ca,n1,n2,n3)
%Adds an op-amp to the struture ca for circuit animations.
%n1 is the + input, n2 is the (-) input and n3 is the output.
%n3 must be positioned vertially aligned with the (-) input, and
%horizontally one space over.

%Base location on n1, n3.  Better have chosen n3 in the right place.

%b is half body width
b = 0.3;
%t is terminal distance from center
t = 0.15;

%Draw body:
x1 = [0.2 0.8 0.2 0.2];
y1 = [-b 0 b -b];
z1 = zeros(size(x1));

x=[xes(n1), xes(n2)];
y=[ys(n1),ys(n2)];

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'color',[.75,.35,.75],'linewidth',2);
hold on

zvm = zeros(length(xes),length(z1));
c1 = (0.5+b/2/t);
c2 = (0.5-b/2/t);
zvm(n1,:)=[c1 0 c2 c1];
zvm(n2,:)=[c2 0 c1 c2];
zvm(n3,:)=[0 1 0 0];
colselect=0;

aux = zeros(0); %placeholder for future features, e.g. switches and exploding wires.
if length(ca)>0,
   ca = cat(2,ca,{h; [n1 n2 n3]; zvm; colselect; aux});
else
   ca = {h; [n1 n2 n3]; zvm; colselect; aux};
end

%%%%%%%%%%Done body
%%%%%%%%%%wire1

x1 = [0 0 0.2];
y1 = [-0.5 -t -t];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n1,:)=1;
colselect=n1;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%%wire2 
x1 = [0 0 0.2];
y1 = [0.5 t t];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%wire3 (output)
x1 = [0.8 1.0 1.0];
y1 = [0 0 0.5];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n3,:)=1;
colselect=n3;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%%%%%%%%%Plus sign

x1 = [0.3 0.4 0.35 0.35 0.35];
y1 = [-t -t -t -t-0.05 -t+0.05];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n1,:)=1;
colselect=n1;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});

%minus sign
x1 = [0.3 0.4 ];
y1 = [t t];
z1 = zeros(size(x1));

[x1,y1] = move(x,y,x1,y1);
   
h = plot3(x1,y1,z1,'k','linewidth',2);

zvm = zeros(length(xes),length(z1));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
