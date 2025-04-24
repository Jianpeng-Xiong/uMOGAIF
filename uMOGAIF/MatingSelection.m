function [ParentC,ParentM] = MatingSelection(CA,DA,N,Scorepercent,Choicemax)
% The mating selection 

    PopObjCA = CA.objs;
    PopObjDA = DA.objs;
    p=rand(1,N);
    First_index = find(p < Scorepercent); 
    
    Second_index = setdiff(1:N,First_index); 
    CAParent1 = randi(length(CA),1,ceil(N/2));
    CAParent2 = randi(length(CA),1,ceil(N/2));
    Dominate  = any(CA(CAParent1).objs<CA(CAParent2).objs,2) - any(CA(CAParent1).objs>CA(CAParent2).objs,2); 
    ParentC   = [CA([CAParent1(Dominate==1),CAParent2(Dominate~=1)]),...
                 DA(randperm(length(DA),N/2))];


    ParentM1  = CA(randperm(length(CA),length(First_index)));


    DAlength=length(DA);
    Secondlength=length(Second_index);
    if Scorepercent>1/2*Choicemax
        [FrontNo,~] = NDSort(PopObjDA,length(DA));
        CrowdDis = CrowdingDistance(PopObjDA,FrontNo);
        [~,index]=sort(CrowdDis,'descend');
        if DAlength>=N 
            ParentM2=DA(index(Second_index));
        else
            ParentM2=DA;
        end
    else
       if DAlength>= N
           ParentM2=DA(randperm(length(DA),length(Second_index)));
       else
           ParentM2=DA;
       end

    end

ParentM=[ParentM1 ParentM2];

end