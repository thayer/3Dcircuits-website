function ca = addwire(ca,n1,n2)

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;


x=[xes(n1),xes(n2)];
y=[ys(n1),ys(n2)];
z=zeros(size(x));

h = plot3(x,y,z,'k','linewidth',2);
hold on

zvm = zeros(length(xes),length(z));
zvm(n1,1)=1;
zvm(n2,2)=1;
colselect=n1;

aux = zeros(0); %placeholder for future features, e.g. switches and exploding wires.
if length(ca)>0,
   ca = cat(2,ca,{h; [n1 n2]; zvm; colselect; aux});
else
   ca = {h; [n1 n2]; zvm; colselect; aux};
end
