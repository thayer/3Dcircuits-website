function cavimate(t,vm,cvm,im,ca,ia,rate,switchm,filename);

%Part of 3D circuit animation tool kit.
%Copyright 2001, Charles R. Sullivan, charles.r.sullivan@dartmouth.edu
%Version 1.1, Dec., 2001 

%t  vector of times of frames in animation.
% vm	matrix of nodes voltages at each time, scaled to -1 to 1 (or 0 to 1) range
% cvm   same thing for colors; listed separately in case you want to scale it differntly
% im	matrix of currents vs. time and vs. number of current arrow defined.
% ca	circuit cell array--struture with graphics objects.
% ia	current arrow cell array structure
% rate	rate = nominal frames per second.
% switchm	matrix of logical elements indicating swtiches on or off status.
% filename

if nargin<8, switchm = ones(length(t),1); end
if length(switchm)<length(t), switchm = ones(length(t),1);, end

%
%
%F = getframe(gcf);
%image(F.cdata)
%colormap(F.colormap)
%
%

aviobj=avifile(filename,'fps',rate,'compression','none');
title('')
%Loop through frames
for ti=1:length(t)

	%Loop through circuit graphics objects, update each
	[junk,nc]=size(ca);
   for i = 1:nc
       
       %for debugging
      x = ca(:,i);
      x = vm(ti,:);
      x = cvm(ti,:);
            x = switchm(ti,:);
            %end for debugging
      
 
   		updatec(ca(:,i),vm(ti,:),cvm(ti,:),switchm(ti,:))
	end
	
	%Loop through current arrow graphics objects, update each
	[junk,nc]=size(ia);
   for i = 1:nc
      updatei(ia(:,i),vm(ti,:),im(ti,:))
   end
   pause(1/rate)
   frame =getframe(gcf);
   aviobj = addframe(aviobj,frame);
end
aviobj = close(aviobj);