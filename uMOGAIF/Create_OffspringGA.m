function Offspring = Create_OffspringGA(parent_population,N)
%% Non-dominated sorting
            [FrontNo,~] = NDSort(parent_population.objs,N);
             %% Calculate the crowding distance of each solution
            CrowdDis = CrowdingDistance(parent_population.objs,FrontNo);
            MatingPool = TournamentSelection(2,N/2,FrontNo,-CrowdDis);
            %% Create Offspring by using Revised DE
            Offspring  = GAhalf(parent_population(MatingPool));
end