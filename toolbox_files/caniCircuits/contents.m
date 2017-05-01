%Circuit Animation Toolbox
%
%This toolbox is used to create 3D animations of electrical circuits.
%More information is available at http://engineering.dartmouth.edu/3Dcircuits
%
%This folder contains ready-to-run animations.
%Many examples are on the web at the above URL as gif animations.   There are more
%available here, and the versions here allow more flexibility--changing parameters and viewing angles.
%
%Passive Linear Circuits
%Ldemo                 -Response of an inductor to applied voltage
%RCI                       -An RC circuit driven by a current source.  Exponential response.
%RLC                      -Response of a parallel RLC circuit to initial conditions.
%ACCap                 -Capacitor behavior with an AC sinusoid applied.
%
%Op Amp and Comparator Circuits
%opamp                 -Simple ideal open-loop op-amp behavior.
%invamp                 -Inverting amplifier, with variable op-amp gain as well as circuit gain.
%iinamp                  -Transconductance amp with extra resistor on input for no good reason.
%compnoise          -Comparator with a noisy input.
%plusfb                   -Schmitt trigger circuit with clean input signal
%schmittnoise       -Schmitt trigger circuit with noisy input.  Compare to compnoise.m
%acamp                  -A bad design for an ac-coupled amplifier.
%
%Rectifier circuits
%Diodedemo         -Half-wave rectifier with no filter.
%bridger                  -Full-wave rectifier with no filter, input ground referenced.
%bridgegr                -Full-wave rectifier with no filter, output ground referenced.
%rectc                       -Half-wave rectifier with capacitor on output.
%
%Switching power circuits
%buckani                -Buck converter
%boostani              -Boost converter
%discbuckani        -Discountinuous-mode buck converter.
%
%DC Pictures (not animated)
%forthevenin           -A dc circuit with a few resistors and a current source
%thevenin               -Part of the circuit in 'forthevenin' replaced with a thevenin equivalent
%firstdcexample    -A dc circuit including series and parallel branches, good for KVL discussion
%
%To get started making your own animations, check the instructions
%on the web site given above, and see the example files in the 'caniExamples'  folder.