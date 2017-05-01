function ia = currentarrow(ia,n1,n2,cn,x,scale)
%ia = currentarrow(ia,n1,n2,cn)
%Adds a current arrow to the circuit animation current-arrow cell array ia.
%The current number cn specifies which column in the current matrix is used
%to specify the current value.
%The arrow points from n1 to n2, when the current value in column cn
%of the current matrix is positive.
%
%ia = currentarrow(ia,n1,n2,cn,x,scale)
%setting scale=1 allows choosing to scale arrow area with current rather than the
%default of scaling length.

%scale = 1 means scale arrow area; scale = 0 scales length
if nargin<6
    scale = 0;
end

offset=0.2;

global CANI_XES CANI_YS;  xes = CANI_XES; ys = CANI_YS;


%Arrow

x0 = [ 0 0 -0.1 0 0.1];
y0 = [0.4 -0.4 -0.3 -0.4 -0.3];
z0 = zeros(size(x0));

x=[xes(n2),xes(n1)];
y=[ys(n2),ys(n1)];

[xplot,yplot] = move(x,y,x0+offset,y0);
   
h = plot3(xplot,yplot,z0,'color',[0 0.8 0],'linewidth',2);
hold on

zvm = zeros(length(xes),length(z0));
zvm(n1,:)= ([x0]+0.5)/0.7;
zvm(n2,:)=-([x0]-0.35)/0.7;


if length(ia)>0,
   ia = cat(2,ia,{h; [n1 n2]; zvm;cn ;x0;x;y0;y;scale});
else
   ia = {h; [n1 n2]; zvm;cn ;x0;x;y0;y;scale};
end

% iac contains
% {graphics handle; [n1, n2];zv matrix; current number ;Arrx;xpos;Arry;ypos}
% ivec is a row of each numbered current.
