function DA = UpdateDA(DA,New,MaxSize,Scorepercent,Greatpop)
% Update DA

if Scorepercent<0.5
   DA=CA(DA,New,MaxSize);
else
    Pop=[DA,New];
    PopObj=Pop.objs;
    N=MaxSize-length(Greatpop);
    [FrontNo,~] = NDSort([DA,New],length(DA));
    CrowdDis = CrowdingDistance(PopObj,FrontNo);
    [~,index]=sort(CrowdDis,'descend');
    Part2=Pop(index(1:N));
    DA=[Greatpop,Part2];
end
    
end

