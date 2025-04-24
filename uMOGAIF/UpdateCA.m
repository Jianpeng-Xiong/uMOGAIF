function [CA,GR] = UpdateCA(CA,New,MaxSize)
% Update CA
    
[CA]=ESPEA2([CA,New],MaxSize);


end

