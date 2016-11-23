%Height.m
% ayalyze the proper height of 2D laser.
% Zhen Song Jan 11, 2002

%all measured in inch. 1inch=25.4mm

% Cars and vans
% bumper bottom, bumper top, car top
hCarFront=[
 10, 17, 36;
 12, 23, 37;
 13.5,20.5,37;
 12, 21,  35;
 15, 20,  38;
 15, 20,  35;
 14, 20,  35;
 9.5,20,  34;
 10, 20,  35;
 10, 20,  34;
 11, 22,  42; %van
 12, 21,  41  %van
];
%same as above
hCarBack=[ 
    15, 23, 38;
    15, 24, 37;
    17.5,26,39;
    15, 23, 38;
    15, 21, 38;
    16, 21, 40;
    15, 25, 44;
    14, 25, 42;
    13, 24, 38;
    16, 23, 41;
    16, 22, 45; %van
    14, 22, 46  %van
];
%include trucks, jeeps
hOtherFront=[
    20, 26, 47;
    22, 26, 42; %jeep
    21, 30, 52;

    21, 30, 49;
    21, 27, 48;
    19, 35, 52;

    15, 20, 45];
hOtherBack=[
    19, 23, 49;
    19, 27, 45; %jeep
    24, 27, 53;

    22, 26, 48;
    22, 30, 52;
    25, 30, 54;

    17, 25, 44];
    
 figure; 
 hold on;
 %car
 [CarNum,n]=size(hCarFront);
 [OtherNum,n]=size(hOtherFront);
 for cnt=1:CarNum
     plot([cnt,cnt], [hCarFront(cnt,1),hCarFront(cnt,3)]);
     plot([cnt-0.2,cnt+0.2],[hCarFront(cnt,1),hCarFront(cnt,1)]);
     plot([cnt-0.2,cnt+0.2],[hCarFront(cnt,2),hCarFront(cnt,2)]);
     plot([cnt-0.2,cnt+0.2],[hCarFront(cnt,3),hCarFront(cnt,3)]);
 end
 
 CurCnt=cnt;
 for cnt=1:CarNum
     cntx=cnt+CurCnt;
     plot([cntx,cntx], [hCarBack(cnt,1),hCarBack(cnt,3)],':' );
     plot([cntx-0.2,cntx+0.2],[hCarBack(cnt,1),hCarBack(cnt,1)],':');
     plot([cntx-0.2,cntx+0.2],[hCarBack(cnt,2),hCarBack(cnt,2)],':');
     plot([cntx-0.2,cntx+0.2],[hCarBack(cnt,3),hCarBack(cnt,3)],':');
 end 
 CurCnt=cntx;
 for cnt=1:OtherNum
     cntx=cnt+CurCnt;
     plot([cntx,cntx], [hOtherFront(cnt,1),hOtherFront(cnt,3)],'r');
     plot([cntx-0.2,cntx+0.2],[hOtherFront(cnt,1),hOtherFront(cnt,1)],'r');
     plot([cntx-0.2,cntx+0.2],[hOtherFront(cnt,2),hOtherFront(cnt,2)],'r');
     plot([cntx-0.2,cntx+0.2],[hOtherFront(cnt,3),hOtherFront(cnt,3)],'r');
 end 
 CurCnt=cntx;
 for cnt=1:OtherNum
     cntx=cnt+CurCnt;
     plot([cntx,cntx], [hOtherBack(cnt,1),hOtherBack(cnt,3)],'r:');
     plot([cntx-0.2,cntx+0.2],[hOtherBack(cnt,1),hOtherBack(cnt,1)],'r:');
     plot([cntx-0.2,cntx+0.2],[hOtherBack(cnt,2),hOtherBack(cnt,2)],'r:');
     plot([cntx-0.2,cntx+0.2],[hOtherBack(cnt,3),hOtherBack(cnt,3)],'r:');
 end 
title('Height of Vehicles');
text(1,53,'From top to bottom each short bar respents: bottom of windows, top of bumpers, and bottom of bumpers respectively');
text(1,48,'Blue:Cars and Vans Red:Trucks and Jeeps Solid:Front Dash:Backward');
grid on;
 

alpha=[0:0.5:45]; 
xangle=alpha;
alpha=alpha/180*pi; %in radius
LHeight=350; %estimated lamp post height

%Vehicle dimension, measured in inch. 
VDim=[
    53, 151, 60;
    54, 176, 64;
    55, 182, 66;
    56, 124, 60;    
    67, 192, 77; %van
    64, 189, 75; %van
    69, 223, 81; %truck 
    60, 182, 61; %truck
    62, 165, 68; %jeep
    78, 160, 70; %jeep
    67, 185, 68];%jeep
RoadWidth=192;
T4Length=82;

figure;
grid on;
hold on;
LaserHeight=25;
D2=LaserHeight*tan(alpha);
h2=plot(xangle,D2,'r:');

EstDist=20; % Vehicles might be 20in away from the lamp post.
[Vnum,n]=size(VDim);
for vnum=1:Vnum
    AlpLen=length(alpha);

%vnum=1;
    D1=[];
    for alpnum=1:AlpLen
        MaxAng=atan((LHeight-VDim(vnum,1))/(VDim(vnum,2)+EstDist));

        if MaxAng<alpha(alpnum)+pi/4 %then d1 is limited by the vehicle's height
            d1=(VDim(vnum,2)+EstDist)*(VDim(vnum,1)-LaserHeight)/(LHeight-VDim(vnum,1));
        else %d1 is limited by alpha
            d1=(VDim(vnum,1)-LaserHeight)/tan(alpha(alpnum)+pi/4);
        end
        D1=[D1, d1];
    end
    if vnum<=4  % car
        h1=plot(xangle,D1);
    end
    if vnum==5 | vnum==6 %van
        h1=plot(xangle,D1,':');
    end
    if vnum==7 | vnum==8 %truck
        h1=plot(xangle,D1,'-.');
    end
    if vnum>8 %jeep
        h1==plot(xangle,D1,'--');
    end
end
title('Minimum Detectable Distance W.R.T Static Tile Angle');
legend([h1,h2],'D1','D2');
xlabel('Static Tile Angle (Degree)');
ylabel('Distance (Inch)');
str1=sprintf('Lamp Port Height=%g in, The Distanced ',LHeight);
str2=sprintf('From a Vehicle to the Lamp Pole=%g in', EstDist);
text(30,50,str1);
text(30,45,str2);
text(30,40,'- car,: van,-. truck,-- jeep');