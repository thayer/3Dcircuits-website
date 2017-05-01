function saveanimation(t,vm,cvm,im,ca,ia,rate,switchm,junk,morejunk,mmorejunk);

%promptsfor file to same animation in and then runs cavimate which runs animation and saves to specified file
%Part of Circuit Animation Toolbox v.1.2.

%C. Sullivan, June 2002.
maxframes=100;  %Max number of frames to put in one file.  Increase it if you can handle larger files.


if nargin<8, switchm = ones(length(t),1); end
if length(switchm)<length(t), switchm = ones(length(t),1);, end
len = length(t);
n = ceil(len/maxframes);
for i = 1:n
[filename,pname]=uiputfile('*.avi', 'Choose file to save animation in (AVI format)');
    olddir = cd;
    cd(pname);
    f1 = (i-1)*100+1;
    ff = min(i*100,len);
    cavimate(t(f1:ff),vm(f1:ff,:),cvm(f1:ff,:),im(f1:ff,:),ca,ia,rate,switchm(f1:ff,:),filename);
    cd(olddir);
end
