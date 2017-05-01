function ca = addC(ca,n1,n2)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;


%plate1 and wire1

x1 = [0 0 -0.1 0.1];
y1 = [-0.5 -0.05 -0.05 -0.05];
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

%%%%%%%%%%Done plate1 and wire1
%%%%%%%%%%plate2 and wire2

x2 = [0 0 -0.1 0.1];
y2 = [0.5 0.05 0.05 0.05];
z2 = zeros(size(x2));

[x2,y2] = move(x,y,x2,y2);
   
h = plot3(x2,y2,z2,'k','linewidth',2);

zvm = zeros(length(xes),length(z2));
zvm(n2,:)=1;
colselect=n2;

ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
