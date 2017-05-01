%Circuit Animation Toolbox
%
%The functions in this toolbox are used to create 3D animations of electrical circuits.
%More information is available at engineering.dartmouth.edu/3Dcircuits.
%Thes functions are called by a function that creates and runs an animation of a particular circuit.
%A library of circuits is in the "caniCircuits" folder.
%Example files to follow to create your own animation are in the "caniExamples" folder.
%
%Functions:
%
%Building a circuit:
%
% makegrid         -Set up a grid of circuit nodes of a specified size.
% showgrid         -Diplays the grid that would be set up by makegrid for the same arguments, FYI
% aninit                -Initialize figure window, variables for animation.
% add _               -add specified element to structure and draw.  Type 'help caniElements' for a list.
% currentarrow   -adds a current arrow
% aniset               -after building a circuit and defining voltages, run this final setup and scaling utility.
%
% Running an animation
%
% canimate              -animates a circuit.
% saveanimation    -version of canimate for saving a 'movie' (avi file) of the animation.
%
% Functions used by other functions (not normally by user)
%
% move          -move drawn object; used by some add functions
% updatec     -update one circuit object.
% updatei      -update one current arrow object.
% cavimate   -called by saveanimation to actually do the work of running and saving the animation.
% nice            -used in setting up axis scaling--picks a "nice round number" near and above input argument.
 
