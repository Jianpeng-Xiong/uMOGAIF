function Operator = Roulette( OpProb )
%ROULETTE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Fitness=OpProb;
index=TournamentSelection(2,1,Fitness);
if index==1
    Operator=1; 
else
    Operator=2;
end
    
end

