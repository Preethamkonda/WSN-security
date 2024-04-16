xm=100;
ym=100;
sink.x=0*xm;
sink.y=0*ym;
node_number=100;
datanum=2000;
Eo=0.5;
%Eelec=Etx=Erx
ETX=50*10^(-9);
ERX=50*10^(-9);
%Transmit Amplifier types
Efs=10*10^(-12);
Emp=0.0013*10^(-12);
%Data Aggregation Energy
EDA=5*10^(-9);
%Data Aggregation
DA=0.6;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datanum1=DA*datanum;%%%%%%%%%%%%%%%%%%
rmax=2000;
do=sqrt(Efs/Emp);
E1=0.75;
for i=1:1:node_number%nodes area wise distribution
    if(i<26)
        S3(i).xd=rand*50;
        S3(i).yd=rand*50;
        %         plot(S3(i).xd,S3(i).yd,'go')
        xlabel('x-axes(m)','FontSize',8);
        ylabel('y-axes(m)','FontSize',8);
        hold on
        S3(i).E=Eo;
        S3(i).Q=0;
    end
    if(i>25 && i<51)
        S3(i).xd=rand*50;
        S3(i).yd=50+rand*50;
        %         plot(S3(i).xd,S3(i).yd,'m*')
        hold on
        S3(i).E=Eo;
        S3(i).Q=0;
    end
    if(i>50 && i<76)
        S3(i).xd=50+rand*50;
        S3(i).yd=50+rand*50;
        %         plot(S3(i).xd,S3(i).yd,'r.')
        hold on
        S3(i).E=Eo;
        S3(i).Q=0;
    end
    if(i>75)
        S3(i).xd=50+rand*50;
        S3(i).yd=rand*50;
        hold on
        %         plot(S3(i).xd,S3(i).yd,'b+')
        S3(i).E=Eo;
        S3(i).Q=0;
    end%%%%%%%
end
flag_first_dead1=0;
flag_first_dead2=0;
flag_first_dead3=0;
flag_first_dead4=0;
flag_all_dead1=0;
flag_all_dead2=0;
flag_all_dead3=0;
flag_all_dead4=0;
dead1=0;
dead2=0;
dead3=0;
dead4=0;
first_dead1=0;
first_dead2=0;
first_dead3=0;
first_dead4=0;
all_dead1=0;
allive1=25;
allive2=25;
allive3=25;
allive4=25;
% % % counter for bit transmitted to Bases Station
packets_TO_BS1=0;
temp_L_node1=0;
temp_L_node2=0;
temp_L_node3=0;
temp_L_node4=0;
% figure(1);
x=0;
ym=50;% % this variable controle the speed of sink%%%%%%%%%%%%%%%%%%%%%
for i=1:node_number
    S3(i).parent=0;
    S3(i).children=zeros(1,100);
end
RENERGY1=zeros(1,rmax+1);
ENERGY1=zeros(1,rmax+1);
for r3=0:rmax     %
    for i=1:node_number
        S3(i).parent=0;
        S3(i).children=zeros(1,100);
    end
    for i=1:node_number
        RENERGY1(r3+1) =RENERGY1(r3+1)+S3(i).E;
        ENERGY1(r3+1)=100-RENERGY1(r3+1);
    end
    A1=zeros(25,25);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    B1=zeros(50,50);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    C1=zeros(75,75);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    D1=zeros(100,100);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dead1=0;
    dead2=0;
    dead3=0;
    dead4=0;
    for i=1:1:25%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(i).E<=0)
            dead1=dead1+1;
            if (dead1==1)
                if(flag_first_dead1==0)
                    first_dead1=r3+1;
                    flag_first_dead1=1;
                end
            end
            if(dead1==25)
                if(flag_all_dead1==0)
                    all_dead1=r3+1;
                    flag_all_dead1=1;
                end
            end
        end
    end
    for i=26:1:50%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(i).E<=0)
            dead2=dead2+1;
            if (dead2==1)
                if(flag_first_dead2==0)
                    first_dead2=r3+1;
                    flag_first_dead2=1;
                end
            end
            if(dead2==25)
                if(flag_all_dead2==0)
                    all_dead2=r3+1;
                    flag_all_dead2=1;
                end
            end
        end
    end
    for i=51:1:75%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(i).E<=0)
            dead3=dead3+1;
            if (dead3==1)
                if(flag_first_dead3==0)
                    first_dead3=r3+1;
                    flag_first_dead3=1;
                end
            end
            if(dead3==25)
                if(flag_all_dead3==0)
                    all_dead3=r3+1;
                    flag_all_dead3=1;
                end
            end
        end
    end
    for i=76:1:100%flags for the calculation of first ,teenth, half and all nodes ..
        if (S3(i).E<=0)
            dead4=dead4+1;
            if (dead4==1)
                if(flag_first_dead4==0)
                    first_dead4=r3+1;
                    flag_first_dead4=1;
                end
            end
            if(dead4==25)
                if(flag_all_dead4==0)
                    all_dead4=r3+1;
                    flag_all_dead4=1;
                end
            end
        end
    end
    STATISTICS3(r3+1).ALLIVE1=allive1-dead1;
    STATISTICS3(r3+1).Et1=0;%total energy of nodes in a round
    STATISTICS3(r3+1).ALLIVE2=allive2-dead2;
    STATISTICS3(r3+1).Et2=0;%total energy of nodes in a round
    STATISTICS3(r3+1).ALLIVE3=allive3-dead3;
    STATISTICS3(r3+1).Et3=0;%total energy of nodes in a round
    STATISTICS3(r3+1).ALLIVE4=allive4-dead4;
    STATISTICS3(r3+1).Et4=0;%total energy of nodes in a round
    STATISTICS3(r3+1).DEAD5=dead1+dead2+dead3+dead4;
    STATISTICS3(r3+1).ALLIVE5=(STATISTICS3(r3+1).ALLIVE1+STATISTICS3(r3+1).ALLIVE2+STATISTICS3(r3+1).ALLIVE3+STATISTICS3(r3+1).ALLIVE4);
    for i=1:1:25
        if (S3(i).E>0)
            STATISTICS3(r3+1).Et1=STATISTICS3(r3+1).Et1 + S3(i).E;
        end
    end
    if (STATISTICS3(r3+1).ALLIVE1>0)
        STATISTICS3(r3+1).Eavg1=STATISTICS3(r3+1).Et1/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg1=0;
    end
    for i=26:1:50
        if (S3(i).E>0)
            STATISTICS3(r3+1).Et2=STATISTICS3(r3+1).Et2 + S3(i).E;
        end
    end
    if (STATISTICS3(r3+1).ALLIVE2>0)
        STATISTICS3(r3+1).Eavg2=STATISTICS3(r3+1).Et2/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg2=0;
    end
    for i=51:1:75
        if (S3(i).E>0)
            STATISTICS3(r3+1).Et3=STATISTICS3(r3+1).Et3 + S3(i).E;
        end
    end
    if (STATISTICS3(r3+1).ALLIVE3>0)
        STATISTICS3(r3+1).Eavg3=STATISTICS3(r3+1).Et3/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg3=0;
    end
    for i=76:1:100
        if (S3(i).E>0)
            STATISTICS3(r3+1).Et4=STATISTICS3(r3+1).Et4 + S3(i).E;
        end
    end
    if (STATISTICS3(r3+1).ALLIVE4>0)
        STATISTICS3(r3+1).Eavg4=STATISTICS3(r3+1).Et4/(25*Eo);
    else
        STATISTICS3(r3+1).Eavg4=0;
    end
    STATISTICS3(r3+1).Eavg5=(STATISTICS3(r3+1).Eavg1+STATISTICS3(r3+1).Eavg2+STATISTICS3(r3+1).Eavg3+STATISTICS3(r3+1).Eavg4)/4;
    A=zeros(1,STATISTICS3(r3+1).ALLIVE1);
    for i=1:1:25
        if S3(i).E>0
            A(1)=i;
            break;
        end
    end
    for i=2:STATISTICS3(r3+1).ALLIVE1
        for j=(A(i-1)+1):25,
            if S3(j).E>0
                A(i)=j;
                break;
            end
        end
    end
    B=zeros(1,STATISTICS3(r3+1).ALLIVE2);
    for i=26:1:50
        if S3(i).E>0
            B(1)=i;
            break;
        end
    end
    for i=2:(STATISTICS3(r3+1).ALLIVE2)
        for j=(B(i-1)+1):50,
            if S3(j).E>0
                B(i)=j;
                break;
            end
        end
    end
    C=zeros(1,STATISTICS3(r3+1).ALLIVE3);
    for i=51:1:75
        if S3(i).E>0
            C(1)=i;
            break;
        end
    end
    
    for i=2:(STATISTICS3(r3+1).ALLIVE3)
        for j=(C(i-1)+1):75,
            if S3(j).E>0
                C(i)=j;
                break;
            end
        end
    end
    D=zeros(1,STATISTICS3(r3+1).ALLIVE4);
    for i=76:1:100
        if S3(i).E>0
            D(1)=i;
            break;
        end
    end
    
    for i=2:(STATISTICS3(r3+1).ALLIVE4)
        for j=(D(i-1)+1):100,
            if S3(j).E>0
                D(i)=j;
                break;
            end
        end
    end
    hold off;
    %     figure(1);%%%%%%%%%%%%%%%%%movement of sink for region 1 chain formation%%%%%%%%%%
    x=x+33;
    sink.x=x;
    sink.y=25;
    %     plot(sink.x,sink.y,'ko')
    hold on;
    distance1=zeros(1,STATISTICS3(r3+1).ALLIVE1);
    max_distance1=0;
    max_node1=0;
    distance2=zeros(1,STATISTICS3(r3+1).ALLIVE2);
    max_distance2=0;
    max_node2=0;
    distance3=zeros(1,STATISTICS3(r3+1).ALLIVE3);
    max_distance3=0;
    max_node3=0;
    distance4=zeros(1,STATISTICS3(r3+1).ALLIVE4);
    max_distance4=0;
    max_node4=0;
    for i=1:STATISTICS3(r3+1).ALLIVE1%%%calculating sink distance from all nodes and finding farthest node
        S3(A(i)).distance1=sqrt((S3(A(i)).xd - sink.x)^2+(S3(A(i)).yd - sink.y)^2);
        if max_distance1<S3(A(i)).distance1
            max_distance1=S3(A(i)).distance1;%%%%
            max_node1=(A(i));
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE2%%%calculating sink distance from all nodes and finding farthest node
        S3(B(i)).distance2=sqrt((S3(B(i)).xd - sink.x)^2+(S3(B(i)).yd - sink.y)^2);
        if max_distance2<S3(B(i)).distance2
            max_distance2=S3(B(i)).distance2;%%%%
            max_node2=(B(i));
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE3%%%calculating sink distance from all nodes and finding farthest node
        S3(C(i)).distance3=sqrt((S3(C(i)).xd - sink.x)^2+(S3(C(i)).yd - sink.y)^2);
        if max_distance3<S3(C(i)).distance3
            max_distance3=S3(C(i)).distance3;%%%%
            max_node3=(C(i));
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE4%%%calculating sink distance from all nodes and finding farthest node
        S3(D(i)).distance4=sqrt((S3(D(i)).xd - sink.x)^2+(S3(D(i)).yd - sink.y)^2);
        if max_distance4<S3(D(i)).distance4
            max_distance4=S3(D(i)).distance4;%%%%
            max_node4=(D(i));
        end
    end
    %         % chain of nodes 1
    connect_distance1=zeros(1,STATISTICS3(r3+1).ALLIVE1);%
    connect_node1=zeros(1,STATISTICS3(r3+1).ALLIVE1);%
    connect_node1(1)=max_node1;
    connect_distance1(1)=0;
    for i=2:STATISTICS3(r3+1).ALLIVE1%%%%chain formation between the alive nodes in each round
        temp_node1=0;
        temp_min_distance1=inf;
        for j=1:STATISTICS3(r3+1).ALLIVE1
            b1=0;
            for k=1:(i-1)
                if A(j)==connect_node1(k)
                    b1=1;
                    break
                end
            end
            if b1==0%%finding the nearest node for any node not connected in chain
                distance1=sqrt((S3(connect_node1(i-1)).xd - S3(A(j)).xd)^2 + (S3(connect_node1(i-1)).yd - S3(A(j)).yd)^2);
                if temp_min_distance1>distance1
                    temp_min_distance1=distance1;
                    temp_node1=A(j);
                end
            end
        end
        connect_distance1(i)=temp_min_distance1;
        connect_node1(i)=temp_node1;
        A1(connect_node1(i),connect_node1(i-1))=1;%if calculated minimum distance is less than threshold
        A1(connect_node1(i-1),connect_node1(i))=1;
        %             plot([S3(connect_node1(i-1)).xd S3(connect_node1(i)).xd],[S3(connect_node1(i-1)).yd S3(connect_node1(i)).yd],'-o');
        hold on;
    end
    %         %energy calculation for nodes 1
    Q_max=0;
    L_node1(r3+1)=temp_L_node1;%temorary leader node
    for i=1:STATISTICS3(r3+1).ALLIVE1%%chain leader selection
        distance_to_bs1(A(i))=sqrt((S3(A(i)).xd-sink.x)^2+(S3(A(i)).yd-sink.y)^2);%%
        S3(A(i)).Q=S3(A(i)).E/distance_to_bs1(A(i));%%ratio between the energy and distance of each node to BS
        if  Q_max<S3(A(i)).Q
            Q_max=S3(A(i)).Q;
            L_node1(r3+1)=A(i);%finding most optimal leader with highest weight
        end
    end
    temp_L_node1=L_node1(r3+1);
    k1=zeros(1,25);                  %
    k1(1)=temp_L_node1;    %  placing the leader in each round at the start of chain array
    f1=zeros(1,(25+1));              %
    for j0=1:25
        if A1(k1(1),j0)==1                  %
            f1(2)=f1(2)+1;                  %
            k1(f1(2)+1)=j0;                 %
            S3(k1(1)).children(f1(2))=j0;
        end
    end
    for j1=2:(25+1)               %
        if f1(j1)~=0                       %
            for t1=1:f1(j1)
                t=sum(f1(1:(j1-1)))+t1+1;    %
                S3(k1(t)).parent=k1(j1-1);    %
                for j2=1:25
                    if  A1(k1(t),j2)==1           %
                        if  S3(k1(t)).parent~=j2   %
                            f1(t+1)=f1(t+1)+1;          %f1(t+1)
                            k1(sum(f1(1:t))+1+f1(t+1))=j2;    %sum(f1(1:t))
                            S3(k1(t)).children(f1(t+1))=j2;
                        end
                    end
                end
            end
        end
    end
    distance_send1=zeros(1,100);
    distance_send2=zeros(1,100);
    child_count1=zeros(1,100);%%counter for child nodes of all nodes
    for i=1:25
        if S3(i).E>0%%%%%selection of secondary leader node in region 1%%%%%%%
            if S3(i).parent~=0
                distance_send1(i)=sqrt((S3(i).xd-S3(S3(i).parent).xd)^2+(S3(i).yd-S3(S3(i).parent).yd)^2);
                distance_send2(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);
                if distance_send1(i)>distance_send2(i)
                    distance_send1(i)=distance_send2(i);
                    S3(i).parent=0;
                    if f1(k1>(i-1)&k1<(i+1))==1,
                        f1(k1>(i-1)&k1<(i+1))=0;
                    else
                        f1(k1>(i-1)&k1<(i+1))=1;
                    end
                end
            else
                distance_send1(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for i=1:25
        if S3(i).E>0
            child_count1(i)=f1(find(k1>(i-1)&k1<(i+1))+1);
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE1%%energy calculation on the basis of child nodes of each node
        if child_count1(A(i))==0                     %if only 1 child node
            if  distance_send1(A(i))>do
                S3(A(i)).E=S3(A(i)).E-(ETX*datanum+datanum*Emp*((distance_send1(A(i)))^4));
            else
                S3(A(i)).E=S3(A(i)).E-(ETX*datanum+datanum*Efs*((distance_send1(A(i)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(A(i))>do
                S3(A(i)).E=S3(A(i)).E-((child_count1(A(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(A(i)))^4)));
            else
                S3(A(i)).E=S3(A(i)).E-((child_count1(A(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(A(i)))^2)));
            end
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE1%any node having child consumes ERX equal to childs
        S3(A(i)).E=S3(A(i)).E-(child_count1(A(i))*ERX*datanum);
    end
    if (x==66)%%%movement of sink for the chain formation in region 2%%%%
        x=0;
    end
    if (x==33)
        ym=75;
    end
    sink.x=x;
    sink.y=ym;
    %     figure(1);
    %     plot(sink.x,sink.y,'go')
    hold on;
    %     %     for nodes 26.....
    connect_distance2=zeros(1,STATISTICS3(r3+1).ALLIVE2);%
    connect_node2=zeros(1,STATISTICS3(r3+1).ALLIVE2);%
    connect_node2(1)=max_node2;
    connect_distance2(1)=0;
    for i=2:STATISTICS3(r3+1).ALLIVE2%%%%chain formation between the alive nodes in each round
        temp_node2=0;
        temp_min_distance2=inf;
        for j=1:STATISTICS3(r3+1).ALLIVE2
            b2=0;
            for k=1:(i-1)
                if B(j)==connect_node2(k)
                    b2=1;
                    break
                end
            end
            if b2==0%%finding the nearest node for any node not connected in chain
                distance2=sqrt((S3(connect_node2(i-1)).xd - S3(B(j)).xd)^2 + (S3(connect_node2(i-1)).yd - S3(B(j)).yd)^2);
                if temp_min_distance2>distance2
                    temp_min_distance2=distance2;
                    temp_node2=B(j);
                end
            end
        end
        connect_distance2(i)=temp_min_distance2;
        connect_node2(i)=temp_node2;
        B1(connect_node2(i),connect_node2(i-1))=1;%if calculated minimum distance is less than threshold
        B1(connect_node2(i-1),connect_node2(i))=1;
        %         plot([S3(connect_node2(i-1)).xd S3(connect_node2(i)).xd],[S3(connect_node2(i-1)).yd S3(connect_node2(i)).yd],'-+');
        hold on;
    end
    %     %     %energy calculation for nodes in region 2
    Q_max1=0;
    L_node2(r3+1)=temp_L_node2;%temorary leader node
    for i=1:STATISTICS3(r3+1).ALLIVE2%%chain leader selection
        distance_to_bs2(B(i))=sqrt((S3(B(i)).xd-sink.x)^2+(S3(B(i)).yd-sink.y)^2);%%
        S3(B(i)).Q=S3(B(i)).E/distance_to_bs2(B(i));%%ratio between the energy and distance of each node to BS
        if  Q_max1<S3(B(i)).Q
            Q_max1=S3(B(i)).Q;
            L_node2(r3+1)=B(i);%finding most optimal leader with highest weight
        end
    end
    temp_L_node2=L_node2(r3+1);
    k2=zeros(1,25);                  %
    k2(1)=temp_L_node2;    %  placing the leader in each round at the start of chain array
    f2=zeros(1,(25+1));              %
    for j0=26:1:50
        if B1(k2(1),j0)==1                  %
            f2(2)=f2(2)+1;                  %
            k2(f2(2)+1)=j0;                 %
            S3(k2(1)).children(f2(2))=j0;
        end
    end
    for j1=2:(25+1)               %
        if f2(j1)~=0                       %
            for t1=1:f2(j1)
                t=sum(f2(1:(j1-1)))+t1+1;    %
                S3(k2(t)).parent=k2(j1-1);    %
                for j2=26:50
                    if  B1(k2(t),j2)==1           %
                        if  S3(k2(t)).parent~=j2   %
                            f2(t+1)=f2(t+1)+1;          %f2(t+1)
                            k2(sum(f2(1:t))+1+f2(t+1))=j2;    %sum(f2(1:t))
                            S3(k2(t)).children(f2(t+1))=j2;
                        end
                    end
                end
            end
        end
    end
    hold on
    for i=26:1:50
        if S3(i).E>0%%%%%secondary leader selection in region 2
            if S3(i).parent~=0
                distance_send1(i)=sqrt((S3(i).xd-S3(S3(i).parent).xd)^2+(S3(i).yd-S3(S3(i).parent).yd)^2);
                distance_send2(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);
                if distance_send1(i)>distance_send2(i),
                    distance_send1(i)=distance_send2(i);
                    S3(i).parent=0;
                    if f2(k2>(i-1)&k2<(i+1))==1,
                        f2(k2>(i-1)&k2<(i+1))=0;
                    else
                        f2(k2>(i-1)&k2<(i+1))=1;
                    end
                end
            else
                distance_send1(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for i=26:1:50
        if S3(i).E>0
            child_count1(i)=f2(find(k2>(i-1)&k2<(i+1))+1);
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE2%%energy calculation on the basis of child nodes of each node
        if child_count1(B(i))==0                     %if only 1 child node
            if  distance_send1(B(i))>do
                S3(B(i)).E=S3(B(i)).E-(ETX*datanum+datanum*Emp*((distance_send1(B(i)))^4));
            else
                S3(B(i)).E=S3(B(i)).E-(ETX*datanum+datanum*Efs*((distance_send1(B(i)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(B(i))>do
                S3(B(i)).E=S3(B(i)).E-((child_count1(B(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(B(i)))^4)));
            else
                S3(B(i)).E=S3(B(i)).E-((child_count1(B(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(B(i)))^2)));
            end
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE2%any node having child consumes ERX equal to childs
        S3(B(i)).E=S3(B(i)).E-(child_count1(B(i))*ERX*datanum);
    end
    x=x+33;%%%%movement of sink in region 3 for chain formation
    hold on
    %     figure(1)
    sink.x=x;
    %     plot(sink.x,sink.y,'ro');
    hold on
    %     %    chain formation for nodes 51.....
    connect_distance3=zeros(1,STATISTICS3(r3+1).ALLIVE3);%
    connect_node3=zeros(1,STATISTICS3(r3+1).ALLIVE3);%
    connect_node3(1)=max_node3;
    connect_distance3(1)=0;
    for i=2:STATISTICS3(r3+1).ALLIVE3%%%%chain formation between the alive nodes in each round
        temp_node3=0;
        temp_min_distance3=inf;
        for j=1:STATISTICS3(r3+1).ALLIVE3
            b3=0;
            for k=1:(i-1)
                if C(j)==connect_node3(k)
                    b3=1;
                    break
                end
            end
            if b3==0%%finding the nearest node for any node not connected in chain
                distance3=sqrt((S3(connect_node3(i-1)).xd - S3(C(j)).xd)^2 + (S3(connect_node3(i-1)).yd - S3(C(j)).yd)^2);
                if temp_min_distance3>distance3
                    temp_min_distance3=distance3;
                    temp_node3=C(j);
                end
            end
        end
        connect_distance3(i)=temp_min_distance3;
        connect_node3(i)=temp_node3;
        C1(connect_node3(i),connect_node3(i-1))=1;%if calculated minimum distance is less than threshold
        C1(connect_node3(i-1),connect_node3(i))=1;
        %         plot([S3(connect_node3(i-1)).xd S3(connect_node3(i)).xd],[S3(connect_node3(i-1)).yd S3(connect_node3(i)).yd],'-o');
        hold on;
    end
    % % % % % % energy calculation for nodes in region 3
    Q_max2=0;
    L_node3(r3+1)=temp_L_node3;%temorary leader node
    for i=1:STATISTICS3(r3+1).ALLIVE3%%chain leader selection
        distance_to_bs1(C(i))=sqrt((S3(C(i)).xd-sink.x)^2+(S3(C(i)).yd-sink.y)^2);%%
        S3(C(i)).Q=S3(C(i)).E/distance_to_bs1(C(i));%%ratio between the energy and distance of each node to BS
        if  Q_max2<S3(C(i)).Q
            Q_max2=S3(C(i)).Q;
            L_node3(r3+1)=C(i);%finding most optimal leader with highest weight
        end
    end
    temp_L_node3=L_node3(r3+1);
    k3=zeros(1,25);                  %
    k3(1)=temp_L_node3;    %  placing the leader in each round at the start of chain array
    f3=zeros(1,(25+1));              %
    for j0=51:75
        if C1(k3(1),j0)==1                  %
            f3(2)=f3(2)+1;                  %
            k3(f3(2)+1)=j0;                 %
            S3(k3(1)).children(f3(2))=j0;
        end
    end
    for j1=2:(25+1)               %
        if f3(j1)~=0                       %
            for t1=1:f3(j1)
                t=sum(f3(1:(j1-1)))+t1+1;    %
                S3(k3(t)).parent=k3(j1-1);    %
                for j2=51:75
                    if  C1(k3(t),j2)==1           %
                        if  S3(k3(t)).parent~=j2   %
                            f3(t+1)=f3(t+1)+1;          %f3(t+1)
                            k3(sum(f3(1:t))+1+f3(t+1))=j2;    %sum(f3(1:t))
                            S3(k3(t)).children(f3(t+1))=j2;
                        end
                    end
                end
            end
        end
    end
    for i=51:75
        if S3(i).E>0
            if S3(i).parent~=0%%%%%secondary leader selection in region 3
                distance_send1(i)=sqrt((S3(i).xd-S3(S3(i).parent).xd)^2+(S3(i).yd-S3(S3(i).parent).yd)^2);
                distance_send2(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);
                if distance_send1(i)>distance_send2(i),
                    distance_send1(i)=distance_send2(i);
                    S3(i).parent=0;
                    if f3(k3>(i-1)&k3<(i+1))==1,
                        f3(k3>(i-1)&k3<(i+1))=0;
                    else
                        f3(k3>(i-1)&k3<(i+1))=1;
                    end
                end
            else
                distance_send1(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for i=51:75
        if S3(i).E>0
            child_count1(i)=f3(find(k3>(i-1)&k3<(i+1))+1);
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE3%%energy calculation on the basis of child nodes of each node
        if child_count1(C(i))==0                     %if only 1 child node
            if  distance_send1(C(i))>do
                S3(C(i)).E=S3(C(i)).E-(ETX*datanum+datanum*Emp*((distance_send1(C(i)))^4));
            else
                S3(C(i)).E=S3(C(i)).E-(ETX*datanum+datanum*Efs*((distance_send1(C(i)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(C(i))>do
                S3(C(i)).E=S3(C(i)).E-((child_count1(C(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(C(i)))^4)));
            else
                S3(C(i)).E=S3(C(i)).E-((child_count1(C(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(C(i)))^2)));
            end
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE3%any node having child consumes ERX equal to childs
        S3(C(i)).E=S3(C(i)).E-(child_count1(C(i))*ERX*datanum);
    end
    if x==66,%%%%%%%movement of sink for the chain formation in region 4
        ym=25;
    end
    hold on
    % figure(1)
    sink.x=x;
    sink.y=ym;
    % plot(sink.x,sink.y,'ro');
    hold on
    %     %   chain formation  for nodes  76....
    connect_distance4=zeros(1,STATISTICS3(r3+1).ALLIVE4);%
    connect_node4=zeros(1,STATISTICS3(r3+1).ALLIVE4);%
    connect_node4(1)=max_node4;
    connect_distance4(1)=0;
    for i=2:STATISTICS3(r3+1).ALLIVE4%%%%chain formation between the alive nodes in each round
        temp_node4=0;
        temp_min_distance4=inf;
        for j=1:STATISTICS3(r3+1).ALLIVE4
            b4=0;
            for k=1:(i-1)
                if D(j)==connect_node4(k)
                    b4=1;
                    break
                end
            end
            if b4==0%%finding the nearest node for any node not connected in chain
                distance4=sqrt((S3(connect_node4(i-1)).xd - S3(D(j)).xd)^2 + (S3(connect_node4(i-1)).yd - S3(D(j)).yd)^2);
                if temp_min_distance4>distance4
                    temp_min_distance4=distance4;
                    temp_node4=D(j);
                end
            end
        end
        
        connect_distance4(i)=temp_min_distance4;
        connect_node4(i)=temp_node4;
        D1(connect_node4(i),connect_node4(i-1))=1;%if calculated minimum distance is less than threshold
        D1(connect_node4(i-1),connect_node4(i))=1;
        %         plot([S3(connect_node4(i-1)).xd S3(connect_node4(i)).xd],[S3(connect_node4(i-1)).yd S3(connect_node4(i)).yd],'-o');
        hold on;
    end
    %energy calculation for nodes 4
    Q_max3=0;
    L_node4(r3+1)=temp_L_node4;%temorary leader node
    for i=1:STATISTICS3(r3+1).ALLIVE4%%chain leader selection
        distance_to_bs1(D(i))=sqrt((S3(D(i)).xd-sink.x)^2+(S3(D(i)).yd-sink.y)^2);%%
        S3(D(i)).Q=S3(D(i)).E/distance_to_bs1(D(i));%%ratio between the energy and distance of each node to BS
        if  Q_max3<S3(D(i)).Q
            Q_max3=S3(D(i)).Q;
            L_node4(r3+1)=D(i);%finding most optimal leader with highest weight
        end
    end
    temp_L_node4=L_node4(r3+1);
    k4=zeros(1,25);                  %
    k4(1)=temp_L_node4;    %  placing the leader in each round at the start of chain array
    f4=zeros(1,(25+1));              %
    for j0=76:100
        if D1(k4(1),j0)==1                  %
            f4(2)=f4(2)+1;                  %
            k4(f4(2)+1)=j0;                 %
            S3(k4(1)).children(f4(2))=j0;
        end
    end
    for j1=2:(25+1)               %
        if f4(j1)~=0                       %
            for t1=1:f4(j1)
                t=sum(f4(1:(j1-1)))+t1+1;    %
                S3(k4(t)).parent=k4(j1-1);    %
                for j2=76:100
                    if  D1(k4(t),j2)==1           %
                        if  S3(k4(t)).parent~=j2   %
                            f4(t+1)=f4(t+1)+1;          %f4(t+1)
                            k4(sum(f4(1:t))+1+f4(t+1))=j2;    %sum(f4(1:t))
                            S3(k4(t)).children(f4(t+1))=j2;
                        end
                    end
                end
            end
        end
    end
    for i=76:100
        if S3(i).E>0
            if S3(i).parent~=0
                distance_send1(i)=sqrt((S3(i).xd-S3(S3(i).parent).xd)^2+(S3(i).yd-S3(S3(i).parent).yd)^2);
                distance_send2(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);
                if distance_send1(i)>distance_send2(i),
                    distance_send1(i)=distance_send2(i);
                    S3(i).parent=0;
                    if f4(k4>(i-1)&k4<(i+1))==1,
                        f4(k4>(i-1)&k4<(i+1))=0;
                    else
                        f4(k4>(i-1)&k4<(i+1))=1;
                    end
                end
            else
                distance_send1(i)=sqrt((S3(i).xd-sink.x)^2+(S3(i).yd-sink.y)^2);%%finding distance between leader and sink
            end
        end
    end
    for i=76:100
        if S3(i).E>0
            child_count1(i)=f4(find(k4>(i-1)&k4<(i+1))+1);
        end
    end
    for i=1:STATISTICS3(r3+1).ALLIVE4%%energy calculation on the basis of child nodes of each node
        if child_count1(D(i))==0                     %if only 1 child node
            if  distance_send1(D(i))>do
                S3(D(i)).E=S3(D(i)).E-(ETX*datanum+datanum*Emp*((distance_send1(D(i)))^4));
            else
                S3(D(i)).E=S3(D(i)).E-(ETX*datanum+datanum*Efs*((distance_send1(D(i)))^2));
            end
        else                                          %if more than 1 child nodes
            if  distance_send1(D(i))>do
                S3(D(i)).E=S3(D(i)).E-((child_count1(D(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Emp*((distance_send1(D(i)))^4)));
            else
                S3(D(i)).E=S3(D(i)).E-((child_count1(D(i))*(ETX+EDA)*(datanum*DA))+(ETX*datanum+datanum*Efs*((distance_send1(D(i)))^2)));
            end
        end
    end
    for i=1 :STATISTICS3(r3+1).ALLIVE4%any node having child consumes ERX equal to childs
        S3(D(i)).E=S3(D(i)).E-(child_count1(D(i))*ERX*datanum);
    end
    if (x==66)
        x=0;
    end
end
