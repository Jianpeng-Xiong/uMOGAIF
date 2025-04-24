function [GR,Fitness] = CalFitness(PopObj)
% Calculate the fitness of each solution
    N = size(PopObj,1);
    [N,M] = size(PopObj);

    PopObjs=PopObj;

    div=4*M;
    fmax = max(PopObjs,[],1);
    fmin = min(PopObjs,[],1);
    lb   = fmin-(fmax-fmin)/2/div;
    ub   = fmax+(fmax-fmin)/2/div;
    d    = (ub-lb)/div;
    lbMatrix  = repmat(lb,N,1);          
    dMatrix    = repmat(d,N,1);           
    GLoc = floor((PopObjs-lbMatrix)./dMatrix);  
    GLoc(isnan(GLoc)) = 0;
    meadian=mean(GLoc);
    GR=sum(floor(GLoc-ones(N,M).*meadian),2);

    Count=tabulate(GR);
    Counts=sortrows(Count,size(Count,2),'descend');

    %% Detect the dominance relation between each two solutions
    Dominate = false(N);
    for i = 1 : N-1
        for j = i+1 : N
            k = any(PopObj(i,:)<PopObj(j,:)) - any(PopObj(i,:)>PopObj(j,:));
            if k == 1
                Dominate(i,j) = true;
            elseif k == -1
                Dominate(j,i) = true;
            end
        end
    end
    
    %% Calculate S(i)
    S = sum(Dominate,2);
    
    %% Calculate R(i)
    R = zeros(1,N);
    for i = 1 : N
        R(i) = sum(S(Dominate(:,i)));
    end
    
    G=zeros(1,N);
    for i =1:N
        for j=1:length(Counts(:,1))
            if GR(i)==Counts(j,1)
                G(i)=Counts(j,3)*1/100;
                break;
            end
            
        end
    end
    %% Calculate the fitnesses
    Fitness = R + G;
end