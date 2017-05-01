function canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);

%canimate(t,vm,cvm,im,ca,ia,rate)
%Runs circuit animation.
%t  vector of times of frames in animation.
% vm	matrix of nodes voltages at each time, scaled to -1 to 1 (or 0 to 1) range
% cvm   same thing for colors; listed separately in case you want to scale it differntly
% im	matrix of currents vs. time and vs. number of current arrow defined.
% ca	circuit cell array--struture with graphics objects.
% ia	current arrow cell array structure
% rate	rate = nominal frames per second.
%
%Additional optional arguments
%canimate(t,vm,cvm,im,ca,ia,rate,switchm,skippause);
% switchm	matrix of logical elements indicating on or off status of switches.
% skippause  set to one to skip the pause before the animation proceeds.  Used mostly for loops.
%
%See http://engineering.dartmouth.edu/3Dcircuits for detailed instructions.
%
%Part of 3D circuit animation tool kit.
%Copyright 2001, Charles R. Sullivan, charles.r.sullivan@dartmouth.edu
%Version 1.1, Dec., 2001 
%No change in this function for version 1.2.

if nargin<9, skippause = 0; end
if nargin<8, switchm = ones(length(t),1); end
if length(switchm)<length(t), switchm = ones(length(t),1);, end

%Loop through frames
for ti=1:length(t)

	%Loop through circuit graphics objects, update each
	[junk,nc]=size(ca);
   for i = 1:nc
       
       %for debugging
      x = ca(:,i);
      x = size(vm(ti,:));
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
   if (ti==1)& (skippause~=1)
      title('Hit any key (in command window) to run','Fontsize',12)
      %waitforbuttonpress
      %ginput(1);
      pause
      %title('')
	  title('Click and hold on titlebar to pause; control-C in command window to stop','Fontsize',12)
  end
  if (ti==2)& (skippause>1)
      title('t = 0+; Hit any key to continue','Fontsize',12)
      %waitforbuttonpress
      %ginput(1);
      pause
      %title('')
	  title('Click and hold on titlebar to pause; control-C in command window to stop','Fontsize',12)
   end
end
title('')
