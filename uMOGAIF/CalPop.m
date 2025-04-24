function [Score,Greatpop] = CalPop( Pop,Archive )
%CALPOP 
Domain=zeros(1,length(Pop));
Greatpop=[];
for i=1:length(Pop)
    less=0;more=0;equal=0;
        for j=1:length(Archive)
            r=Domain_compare(Pop(i),Archive(j));
            %r=FuzzyDomain(Pop(i),Archive(j));
              if r==1 
                  less=less+1;
              elseif r==-1
                  equal=equal+1;
              else
                  more=more+1; 
              end
        end
     if less>more  
         Domain(i)=Domain(i)+1;
         Greatpop=[Greatpop,Pop(i)];

     end

end
Score=sum(Domain);
end


