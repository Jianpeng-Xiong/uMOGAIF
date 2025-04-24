function r=Domain_compare(A,B)
%DOMAIN_COMPARE 

M=length(A.obj);
more=0;less=0;

 for i=1:M
     if A.obj(:,i)<=B.obj(:,i)
        less=less+1;        
     else 
        more=more+1;
     end
 end

 if(more==0)
     r=1; 
 elseif(less==0)
     r=0;
 else
     r=-1;
 end

 end





