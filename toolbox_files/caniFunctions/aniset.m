function vm=aniiset(vm,mmag)
% Set up for circuit animation,
%mmag is optional maximum voltage on scale
set(gca,'FontSize',12)

if nargin<2,
%Scale voltages for max of one
mmag = max(max(abs(vm)));
mmag = nice(mmag);  %picks scale of 1, 2, 5, times 10^something
end

vm = vm/mmag;
zmax = 1;

if min(min(vm))<-0.15,
     zmin=-1;
	 coords=axis;
	coords(5)=zmin;
	coords(6)=zmax;
	axis(coords);
	axis equal;
	set(gca,'ZTick',[-1 -.5 0 .5 1],'ZTicklabel',[-1 -.5 0 .5 1]*mmag)
else
	zmin=0;
	coords=axis;
	coords(5)=zmin;
	coords(6)=zmax;
	axis(coords);
	axis equal;
	set(gca,'ZTick',[0 .25 .5 .75 1],'ZTicklabel',[0 .25 .5 .75 1]*mmag)
	
end


set(gca,'XTick',[],'YTick',[])

verstring = version;
ver = str2num(verstring(1:3));
if ver> 5.2, set(gcf,'DoubleBuffer','on'), end
zlabel('voltage')

d=uicontrol(gcf,'Style','text','Units','normalized','Position',[0 0 1 0.07], ...
'FontWeight', 'bold', 'FontSize',12, ...
'String','Dartmouth Engineering',...
'BackgroundColor',[0.8,0.8,0.8],'ForegroundColor',[0,0.3,0]);
set(d,'Units','pixels');
