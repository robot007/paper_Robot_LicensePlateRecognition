function SpieFig
disp('1. Demo LPR accuracy rate curves');
disp('2. Laser height study ');
disp('3. Speed diagram');
disp('4. LPR accuracy rate testing');
Opt=input('Option : ','s');
switch Opt
    case '1'
        figure(1);
        
        subplot(2,1,1);
        x=linspace(-30,30);
        y1=exp(-0.05*abs(x));
        y2=exp(-0.1*abs(x));
        y3=exp(-0.07*abs(x));
        plot(x,y1);
        hold on;
        plot(x,y2,':');
        plot(x,y3,'-.');
        legend('Plate 1','Plate 2','Plate 3');
        xlabel('Inspection Angle');
        ylabel('Accuracy Rate');
        title('LPR inspection rate wrt. its insepction angle (demo)');
        
        subplot(2,1,2);
        x=linspace(1,5);
        y1=exp(-0.01*abs(x-4));
        y2=exp(-(0.05*abs(x-4)));
        y3=exp(-(0.02*abs(x-4)));
        plot(x,y1);
        hold on;
        plot(x,y2,':');
        plot(x,y3,'-.');
        legend('Plate 1','Plate 2','Plate 3');
        xlabel('Inspection Angle');
        ylabel('Accuracy Rate');
        title('LPR inspection rate wrt. its insepction distance (demo)');
        
        print -deps2c img/DemoLPRAccuracy.eps
        print -djpeg img/DemoLPRAccuracy.jpg        
        unix('epstopdf img/DemoLPRAccuracy.eps');
    case '2'
        
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
            h1=plot([cnt,cnt], [hCarFront(cnt,1),hCarFront(cnt,3)]);
            plot([cnt-0.2,cnt+0.2],[hCarFront(cnt,1),hCarFront(cnt,1)]);
            plot([cnt-0.2,cnt+0.2],[hCarFront(cnt,2),hCarFront(cnt,2)]);
            plot([cnt-0.2,cnt+0.2],[hCarFront(cnt,3),hCarFront(cnt,3)]);
        end
        
        CurCnt=cnt;
        for cnt=1:CarNum
            cntx=cnt+CurCnt;
            h2=plot([cntx,cntx], [hCarBack(cnt,1),hCarBack(cnt,3)],':' );
            plot([cntx-0.2,cntx+0.2],[hCarBack(cnt,1),hCarBack(cnt,1)],':');
            plot([cntx-0.2,cntx+0.2],[hCarBack(cnt,2),hCarBack(cnt,2)],':');
            plot([cntx-0.2,cntx+0.2],[hCarBack(cnt,3),hCarBack(cnt,3)],':');
        end 
        CurCnt=cntx;
        for cnt=1:OtherNum
            cntx=cnt+CurCnt;
            h3=plot([cntx,cntx], [hOtherFront(cnt,1),hOtherFront(cnt,3)],'r');
            plot([cntx-0.2,cntx+0.2],[hOtherFront(cnt,1),hOtherFront(cnt,1)],'r');
            plot([cntx-0.2,cntx+0.2],[hOtherFront(cnt,2),hOtherFront(cnt,2)],'r');
            plot([cntx-0.2,cntx+0.2],[hOtherFront(cnt,3),hOtherFront(cnt,3)],'r');
        end 
        CurCnt=cntx;
        for cnt=1:OtherNum
            cntx=cnt+CurCnt;
            h4=plot([cntx,cntx], [hOtherBack(cnt,1),hOtherBack(cnt,3)],'r:');
            plot([cntx-0.2,cntx+0.2],[hOtherBack(cnt,1),hOtherBack(cnt,1)],'r:');
            plot([cntx-0.2,cntx+0.2],[hOtherBack(cnt,2),hOtherBack(cnt,2)],'r:');
            plot([cntx-0.2,cntx+0.2],[hOtherBack(cnt,3),hOtherBack(cnt,3)],'r:');
        end 
        title('Height of vehicles');
        legend([h1,h2,h3,h4],'Front of cars and vans','Rear of cars and vans','Front of jeeps and trucks', 'Rear of jeeps and trucks');
        ylabel('Inch');
        axis([0 40 0 55]);
        text(1,7,'From up to down, each of the short bars respents, bottom of windows, top of bumpers, ');
        text(1,4,'bottom of bumpers, respectively.');
        %        text(1,48,'Blue:Cars and Vans Red:Trucks and Jeeps Solid:Front Dash:Backward');
        %        grid on;
        
        print -deps2c img/VehicleHeight.eps
        print -djpeg img/VehicleHeight.jpg
        unix('epstopdf img/VehicleHeight.eps');
    case '3'
        close all;
        clear all;
        figure(1);
        T=0:0.1:15;
        A=0.2;
        Vmax=0.75;
        Vmin=0.1;
        Len=length(T);
        V1=[Vmax*ones(1,10), Vmax-0.2*[0:0.1:3.75], zeros(1,50), 0.2*[0:0.1:3.75]];
        V1=[V1, Vmax*ones(1,Len-length(V1))];
        V2=[Vmax*ones(1,10), Vmax-0.2*[0:0.1:3.25], Vmin+0.2*[0:0.1:3.25]];
        V2=[V2, Vmax*ones(1,Len-length(V2))];
        subplot(2,1,1);
        plot(T,V1);
        title('Found bumper');
        xlabel('Time (s)'); ylabel('Velocity (m/s)');
        %        arrow([4.75,1],[4.75,0]);
        %        text(5,0.5,'Check bumper');
        subplot(2,1,2);
        plot(T,V2);
        xlabel('Time (s)'); ylabel('Velocity (m/s)');
        title('Have not found bumper');
        print -deps2c img/FoundBumper.eps
        print -djpeg img/FoundBumper.jpg
        unix('epstopdf img/FoundBumper.eps');
    case '4'
        close all;
        clear all;
        figure(4);
        AxisR=[-2 2 -2 10];
        Car=[-1 -1 1 1; 8 3 3 8];
        GrayC=[0.8 0.8 0.8];
        patch(Car(1,:), Car(2,:), GrayC);
        axis(AxisR); hold on; axis equal;
        h1=text(mean(Car(1,:))-1,mean(Car(2,:)),'Car');
        set(h1,'FontSize',15,'Color',[0 0 0]);
        Stall=[-1.4 -1.4 1.4 1.4; 3 9 9 3];
        h2=line(Stall(1,:),Stall(2,:));
        set(h2,'Color',[0 0 1]);
        Tmp=-1.5:0.5:1.5;
        Len=length(Tmp);
        HLn=[Tmp;zeros(1,Len)];
        %        BackLn=MidLn-[zeros(1,Len); ones(1,Len)*0.5];
        %        FrontLn=MidLn+[zeros(1,Len); ones(1,Len)*0.5];        
        Tmp=-1:0.5:2;
        Tmp=[Tmp(1:2), Tmp(4:end)];
        LenV=length(Tmp);
        VLn=[zeros(1,LenV); Tmp];
        plot(HLn(1,:), HLn(2,:),'o');
        plot(VLn(1,:), VLn(2,:),'o');
        HStr=cell(1,Len);
        VStr=cell(1,LenV);
        VecP=9.8;
        text(4,VecP,'Positions');
        for cnt=1:Len
            HStr{cnt}=sprintf('H%d',cnt);
            h=text(HLn(1,cnt),HLn(2,cnt),HStr{cnt});
            set(h,'FontWeight','Bold','FontSize',11);
            VecP=VecP-0.3;
            str=sprintf('H%d:(%1.1f,%1.1f)',cnt,HLn(1,cnt),HLn(2,cnt));
            text(4,VecP,str);
        end
        for cnt=1:LenV
            VStr{cnt}=sprintf('V%d',cnt);
            h=text(VLn(1,cnt),VLn(2,cnt),VStr{cnt});            
            set(h,'FontWeight','Bold','FontSize',11);            
            if cnt<3
                VecP=VecP-0.3;
                str=sprintf('V%d:(%1.1f,%1.1f)',cnt,VLn(1,cnt),VLn(2,cnt));
                text(4,VecP,str);
            else
                if cnt>3
                    VecP=VecP-0.3;
                    str=sprintf('V%d:(%1.1f,%1.1f)',cnt-1,VLn(1,cnt-1),VLn(2,cnt-1));
                    text(4,VecP,str);
                end
            end
        end
 
        %0: did not recognized; 1, partially recognized; 2, fully
        %recognized. Each position has 10 trials with total 20 scores. 
        % actual score/ total score = accuracy rate
        LPRAcuMat=[0, 0, 1, 1, 1, 3/20, 0; ...
                0, 0.5, 19/20, 1, 1, 1, 0;...
                0/20, 0, 11/20, 1, 1, 1, 0;...
                0, 0, 2/20, 1, 1, 0, 0;...
                0, 0, 0, (2*6+3)/20, 1, 0, 0;...
                0, 0, 0, 9/20, 0, 0, 0]
        YShift=3;
        TestX=[-1.5:0.5:1.5];
        TestY=[-1:0.5:1.5]-YShift;
        figure(5);
        subplot(1,2,1);
        colormap('gray');
        [cs,h]=contourf(TestX,TestY,LPRAcuMat);
%        clabel(cs,h);
        colorbar;

        AxisR=[-2 2 -2-YShift 10-YShift];
        Car=[-1 -1 1 1; 7 3 3 7]-[0;YShift]*ones(1,4);
        GrayC=[0.8 0.8 0.8];
        patch(Car(1,:), Car(2,:), GrayC);
        axis(AxisR); hold on; axis equal;
        h1=text(mean(Car(1,:))-0.5,mean(Car(2,:)),'Car');
        set(h1,'FontSize',15,'Color',[0 0 0]);
        Stall=[-1.4 -1.4 1.4 1.4; 3 9 9 3]-[0;YShift]*ones(1,4);
        h2=line(Stall(1,:),Stall(2,:));
        set(h2,'Color',[0 0 1]);
        xlabel('Distance (m)');
        ylabel('Distance (m)');        
        subplot(1,2,2);
        [cs,h]=contourf(TestX,TestY,LPRAcuMat);
        hold on; colorbar; axis equal
        for cnt1=1:length(TestX)
            for cnt2=1:length(TestY)
                h1=plot(TestX(cnt1),TestY(cnt2),'^');
                set(h1,'MarkerEdgeColor',[1 1 1],'MarkerFaceColor',[0 0 0],'LineWidth',2,'MarkerSize',6);
            end
        end
        xlabel('Distance (m)');
        ylabel('Distance (m)');
        print -deps2 img/LPRAccuracy.eps
        unix('epstopdf img/LPRAccuracy.eps');
%        set(h1,'MarkerEdgeColor',[1 1 1],'MarkerFaceColor',[0 0 0],'LineWidth',2,'MarkerSize',6,'Marker','^')
%        HARate=rand(3,Len);
%        VARate=rand(3,LenV);
        
%         
%         print -deps2c img/LPRTestPos.eps
%         print -djpeg90  -r300 img/LPRTestPos.jpg;        
        
%         figure(1);
%         subplot(2,1,1);
%         HVec=HLn-[0;3]*ones(1,Len);
%         [PolHVecTh,PolHVecR]=cart2pol(HVec(1,:),HVec(2,:));
%         PolHVecAng=rad2deg(abs(PolHVecTh))-90;
%         
%         h1=plot(PolHVecAng,HARate(1,:),'*-.');
%         hold on;
%         h2=plot(PolHVecAng,HARate(2,:),'d-.');
%         h3=plot(PolHVecAng,HARate(3,:),'<-.');
%         legend([h1,h2,h3],'Plate 1','Plate 2','Plate 3');
%         xlabel('Inspection Angle');
%         ylabel('Accuracy Rate');
%         title('LPR inspection rate wrt. its angle');
%         
%         subplot(2,1,2);
%         
%         VARateAll=[VARate(:,1:2),HARate(:,4),VARate(:,3:end)];
%         AllVLn=[VLn(:,1:2),HLn(:,4),VLn(:,3:end)];
%         DisV=AllVLn-[0;3]*ones(1,Len);
%         DisV=abs(DisV(2,:));
%         
%         h1=plot(DisV,VARateAll(1,:),'*-.');
%         hold on;
%         h2=plot(DisV,VARateAll(2,:),'d-.');
%         h3=plot(DisV,VARateAll(3,:),'<-.');        
%         legend([h1,h2,h3],'Plate 1','Plate 2','Plate 3');
%         xlabel('Inspection Distance');
%         ylabel('Accuracy Rate');
%         title('LPR inspection rate wrt. its distance');
%         
%         print -deps2c img/LPRAccuracy.eps;
%         print -djpeg90  -r300 img/LPRAccuracy.jpg;        
        
        
        
end
