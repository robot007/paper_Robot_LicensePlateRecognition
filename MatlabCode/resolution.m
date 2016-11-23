%resolution

rMin=0.50; %meters
rMax=10.00; %meters
r0=rMin*2;
DelLaser=0.015;
rInt=3; %range of interest
DelrLog=1/rInt * DelLaser;
k=ceil(log(rMax/r0)/DelrLog)

x=linspace(rMin, rMax);
floor( log(x/r0)/DelrLog )
ymin=floor( log(x/r0)/DelrLog ) *DelrLog;
ymax=ceil( log(x/r0)/DelrLog ) *DelrLog;
ymax-ymin

xmin=r0 *exp(ymin);
xmax=r0 *exp(ymax);
xdel=abs(xmax-xmin);
plot(x,xdel);

figure;
n=linspace(0,k);
DelK=log(rMax/r0)/k;
ndel=rMin*(exp(n*DelK)-exp( (n-1)*DelK));
plot(n,ndel,'r');

r=linspace(0.1,1000);
r0=10;
y=log(r0./r);
%y=log(r/r0);
plot(r,y);

disp('reverse: rlog = log(r/r0)')
rInt0=2; rInt1=4;
rMin=2;
rMax=10;
DelLaser=0.015;
DelReq=0.1;
DelRlog=DelReq/rInt1;
k=ceil((log(rMax)-log(rMin))/DelRlog)

r0=rInt0;

%k=abs( log(r0/rMax) - log(r0/rMin) )/