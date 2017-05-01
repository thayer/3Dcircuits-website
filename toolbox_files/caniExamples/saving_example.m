function saving_example(save)

%Circuit animation of capacitor connected to 120 V rms line.
%Circuit Animation toolbox v.1.2 May 2002.  Charles R. Sullivan

%%%%%%%%Set up and clear figure%%%%%%%%%%%
aninit

% Components may be placed between any of the numbered nodes
% in this pre-defined grid.  Wires must also be placed
% between numbered nodes to complete the circuit.
% 7 8 9
% 4 5 6
% 1 2 3
%'makegrid) sets up a grid as shown above
makegrid(3,3);

%%%%%%%%Add components
ca = addV(ca,1,4);
ca = addwire(ca,4,5);
ca = addwire(ca,1,2);
ca = addC(ca,5,2);

%%%%%%%%%Add current arrows
ia = currentarrow(ia,4,5,1);
%Capacitor current, shown in "top" wire to cap.  Numbered current 1
ia = currentarrow(ia,2,1,1);
%cap current, shown in "bottom" wire to cap.  Numbered current 1 again, because it is the same.  

% calculate voltage as a function of time
nframes=200;
t = linspace(0,1/60,nframes);
t = t'; % make it a column vector
vin=170*sin(2*pi*60*t);  %calculate voltage

%Voltage matrix--each row is a time snapshot of voltage at each node.
%Each column is a time history of the correspondng node.
z = zeros(nframes,1);
vm = [z z z vin vin z z z z];

icap=cos(2*pi*60*t); %Calculate current; derivative of voltage. 
im = [icap];
%im is the current matrix; same format as voltage matrix, but with 
%columns only for currents the user has numbered.

rate = 20; %nominal frames per second.

%%%%%%%%%SET UP 
vm_scaled=aniset(vm*2);  %Set up scaling on the graph, etc.  
cvm=vm_scaled;  %A separate matrix, cvm, is used to specify the voltages
                    %used to display voltages; this allows different scaling of the two
                    %if desired.
  vm_scaled=vm_scaled/2;

%%%%%%%%%%%%%RUN
if nargin<1, save = 0; end   % Sets it up to not save anything if save has not been specified.
if save
    saveanimation(t,vm_scaled,cvm,im,ca,ia,rate);
else
   canimate(t,vm_scaled,cvm,im,ca,ia,rate);
end


