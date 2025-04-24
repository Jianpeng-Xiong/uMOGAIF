function Candidates = KNN(Candidates, BeforeSize, AfterSize)

if  BeforeSize==0 || AfterSize<0
    Candidates=Candidates;
else   
    Next = true(1, BeforeSize);  
    Del  = Truncation(Candidates.objs, BeforeSize - AfterSize);
    Temp = find(Next);
    Next(Temp(Del)) = false;
        
    % Population for next generation
    Candidates = Candidates( Next );
end   
end

function Del = Truncation(PopObj,K)
    % Truncation
    Distance = pdist2(PopObj,PopObj);
    Distance(logical(eye(length(Distance)))) = inf;
    Del = false(1,size(PopObj,1));
    while sum(Del) < K
        Remain   = find(~Del);
        Temp     = sort(Distance(Remain,Remain),2);
        [~,Rank] = sortrows(Temp);
        Del(Remain(Rank(1))) = true;
    end
end