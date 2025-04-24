function Operator = Roulette( OpProb )
%ROULETTE 此处显示有关此函数的摘要
%   此处显示详细说明
Fitness=OpProb;
index=TournamentSelection(2,1,Fitness);
if index==1
    Operator=1; 
else
    Operator=2;
end
    
end

