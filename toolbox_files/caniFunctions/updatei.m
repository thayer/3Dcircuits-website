function updatei(iac,vvec,ivec)
% iac contains
% {graphics handle; [n1, n2];zv matrix; current number ;Arrx;xpos;Arry;ypos;scaling}
% ivec is a row of each numbered current.
% scaling = 0 means just change length; scaling = 1 means change area.
offset=0.2; %distance from branch

h = iac{1};
nodes = iac{2};
n1=nodes(1);
n2= nodes(2);

zvm = iac{3};

iselect = iac{4};
ivalue=ivec(iselect);
scaling=iac{9};
if scaling,
	scale = sign(ivalue)*sqrt(abs(ivalue));
	width = 5*abs(scale)+eps;
else
	scale = ivalue;
	width = 2;
end
hypfact = 1/sqrt(1+(vvec(n1)-vvec(n2))^2);
%factor so length doesn't stretch vertically;

Arrx = iac{5};
Arrxs = Arrx*scale;
xpos = iac{6};
Arry = iac{7};
Arrys=Arry*scale*hypfact;
ypos = iac{8};
[xplot,yplot] = move(xpos,ypos,Arrxs+0.2,Arrys);

zvm(n1,:)= ([Arrys]+0.35)/0.7;
zvm(n2,:)=-([Arrys]-0.35)/0.7;

zvalues = vvec*zvm;


set(h,'zdata',zvalues,'xdata',xplot,'ydata',yplot,'linewidth',width);
%keyboard
  
