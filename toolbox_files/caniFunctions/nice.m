function nx=nice(x)
%pick a 'nice round number' near and above x
absx = abs(x);
order = ceil(log10(absx));
scaled = absx./10.^order;
options = [1 0.5 0.2 0.1];
diff = options - scaled;
pdiff = diff + 10000*(diff < 0);
[junk,which] = min(pdiff);
n = options(which);
nx = n*10^order;
