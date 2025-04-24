function  uMOGAIF(Global)
% <algorithm> <M>
    %% Parameter setting --the number of parent_Population 
    N = 4*Global.M;
    Arch_N=20;
    %% Setting the basic variables
    windowsize=10;
    window=1;
    OpProb=[0 0 0];
    Trend=zeros(windowsize+1,3);
    Scorepercent=0;  
     Choicemax =0;
    GR=randperm(20,20);
    GR=GR';
    %% Generate initial population
    init_Population = Global.Initialization(N); 
    %% Generate the archive
    CA = init_Population;
    DA = init_Population;
    Archive=[CA,DA];
     %% Optimization
    while Global.NotTermination(Archive)
        [ParentC,ParentM] = MatingSelection(CA,DA,N,Scorepercent,Choicemax);
        %% Reproduction
        last=window;
        %Trend(1,:)=OpProb;
        Operator=Roulette(OpProb);
            if Operator==1
              Offspring= GAhalf([ParentC,ParentM]);
            elseif Operator==2
                Offspring= Revised_DE(ParentC,ParentM(randperm(length(ParentM),N)),...
               ParentM(randperm(length(ParentM),N)),ParentM(randperm(length(ParentM),N)),{0.5,0.1,1,20});                
            elseif Operator==3
                Offspring= GA([ParentC,ParentM]);
                
            end
        [Score,Greatpop] = CalPop(Offspring,Archive);
        Scorepercent=Score/length(Offspring);
        window=window+1;
        Trend(window,Operator)=Scorepercent;
        if Scorepercent>Choicemax*0.5    
            if Operator==1
                OpProb(1)=OpProb(1)+1/windowsize;
            elseif Operator==2
                OpProb(2)=OpProb(2)+1/windowsize;
            elseif Operator==3
                OpProb(3)=OpProb(3)+1/windowsize;
            end
        else
            Op=randi([1,3]);
            OpProb(Op)=OpProb(Op)+1/windowsize;
        end

        
        %% Compensatory archives
            CA=UpdateDA(DA,Offspring,Arch_N,Scorepercent,Greatpop);
            %% Basic archives
            [DA]=UpdateCA(CA,DA,Arch_N);    
        %% Trunction
            Archive=DA;
        %% Re OpProb
            if window==windowsize+1               
                [OpProb,Choicemax]=membership(Trend,windowsize);
                Trend=zeros(windowsize+1,3);
                window=1;
            end  
    end

end

function [Centroid,Choicemax]=membership(Trend,N)
xchoice1=Trend(:,1);
ave1=sum(xchoice1)/N;

xchoice2=Trend(:,2);
ave2=sum(xchoice2)/N;

xchoice3=Trend(:,3);
ave3=sum(xchoice3)/N;

Choicemax=max(max(Trend));
y1=gbellmf(xchoice1,[0.2 Choicemax/2 ave1]);
y2=gbellmf(xchoice2,[0.2 Choicemax/2 ave2]);
y3=gbellmf(xchoice3,[0.2 Choicemax/2 ave3]);
xCentroid1 = defuzz(xchoice1,y1,'centroid');
xCentroid2 = defuzz(xchoice2,y2,'centroid');
xCentroid3 = defuzz(xchoice3,y3,'centroid');
Centroid=[xCentroid1,xCentroid2,xCentroid3];
end

