%Circuit animation of capacitor connected to 120 V rms line.

%Copyright 2002, Charles R. Sullivan
%Version 1.1, Jan., 2002

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
makegrid(3,3)



%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

%%%%%%%%Add components
ca = addV(ca,1,4);
ca = addwire(ca,4,5);
ca = addwire(ca,1,2);
ca = addC(ca,5,2);

ia = currentarrow(ia,4,5,1,0);
%Capacitor current, shown in "top" wire to cap.  Numbered current 1
ia = currentarrow(ia,2,1,1,0);
%cap current, shown in "bottom" wire to cap.  

% calculate voltage(time)
nframes=200;
t = linspace(0,1/60,nframes);
t = t'; % make it a column vector
vin=170*sin(2*pi*60*t);  %calculate voltage

%Voltage matrix--each row is a time snapshot of voltage at each node.
%Each column is a time history of the correspondng node.
z = zeros(nframes,1);
vm = [z z z vin vin z z z z];


icap=cos(2*pi*60*t); % Scale so maximum current is one. 
im = [icap];
%im is the current matrix; same format as voltage matrix, but with 
%columns only for currents the user has numbered.

rate = 20; %nominal frames per second.

%%%%%%%%%SET UP 
vm_scaled=aniset(vm);  %Set up scaling on the graph, etc.  
cvm=vm_scaled;  %A separate matrix, cvm, is used to specify the voltages
                    %used to display voltages; this allows different scaling of the two
                    %if desired.

view([ 35, 30]);  % azimuth and elevation

%%%%%%%%%%%%%RUN
skippause = 0;  %Choose whether to display frame zero until user hits a key.
canimate(t,vm_scaled,cvm,im,ca,ia,rate,cvm,skippause);
% Since this is a periodic waveform, we'll repeat the animation until the user terminates it
% or twenty cycles have been completed.
skippause = 1;
for i=1:20;
canimate(t,vm_scaled,cvm,im,ca,ia,rate,cvm,skippause);
end
