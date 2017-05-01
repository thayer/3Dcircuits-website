function updatec(cac,vvec,cvvec,switchm)
%keyboard

% cac contains
%{graphics handle; [n1, n2]; zv matrix; colselect; aux data}
% vvector is a row of voltage at each node.

h = cac{1};
nodes = cac{2};
zvm = cac{3};
aux = cac{5};
colselect = cac{4};

if colselect ~= 0
   colorvalue=cvvec(colselect);
   color = sqrt(abs(colorvalue))*([0 1 0]*(colorvalue < 0) + [1 0 0]);
   set(h,'color',color)
end

%If there is something that needs to switch....
if any(aux)
   xvalues = aux(2,:)*(1-switchm(aux(1,1)))+aux(3,:)*switchm(aux(1,1));
   yvalues = aux(4,:)*(1-switchm(aux(1,1)))+aux(5,:)*switchm(aux(1,1));
   set(h,'xdata',xvalues,'ydata',yvalues)
   if length(aux) > 5
      zvm1 = aux(6,:)*(1-switchm(aux(1,1))) + aux(7,:)*switchm(aux(1,1));
      zvm2 = aux(8,:)*(1-switchm(aux(1,1))) + aux(9,:)*switchm(aux(1,1));
      zvm(nodes(1),:) = zvm1;
      zvm(nodes(2),:) = zvm2;
	end
end

%debug stuff
%a = size(vvec);
%b = size(zvm);
%if b(1) == 9, keyboard, end
 %end debug stuff
  
zvalues = vvec*zvm;
set(h,'zdata',zvalues)

