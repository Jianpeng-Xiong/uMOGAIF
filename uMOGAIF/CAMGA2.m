function Archive= CAMGA2(Population,Archive,N)
% The environmental selection of AMGA2
    if length(Population)+length(Archive)<=N
        Archive=[Archive,Population];        
    else
        Population=[Archive,Population];
        %% Non-dominated sorting
        [FrontNo,MaxFNo] = NDSort(Population.objs,N);
        Next = FrontNo < MaxFNo;

        %% Calculate the crowding distance of each solution
        CrowdDis = CrowdingDistance(Population.objs,FrontNo);

        %% Select the solutions in the last front based on their crowding distances
        Last     = find(FrontNo==MaxFNo);
        [~,Rank] = sort(CrowdDis(Last),'descend');
        Next(Last(Rank(1:N-sum(Next)))) = true;
        Archive=  Population(Next); 
    end
end