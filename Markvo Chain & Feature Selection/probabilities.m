function UP=probabilities(P,TE,X,temp,eps)
UP=P;
[r,c]=size(temp);
for i=1:r
    for j=1:c
       if X(1,j)==1 && temp (i,j) == 1 && TE (i)==1
           UP(i,j,1)= P(i,j,1) + eps(i);
           UP(i,j,2)= 1- P(i,j,1) - eps(i);
       elseif X(1,j)==1 && temp (i,j) == 1 && TE (i)==0
           UP(i,j,1)= P(i,j,1) - eps(i);
           UP(i,j,2)= 1- P(i,j,1) + eps(i);
       elseif X(1,j)==0 && temp (i,j) == 0 && TE (i)==1
           UP(i,j,3)= P(i,j,3) - eps(i);
           UP(i,j,4)= 1- P(i,j,3) + eps(i);
       elseif X(1,j)==0 && temp (i,j) == 0 && TE (i)==0
           UP(i,j,3)= P(i,j,3) + eps(i);
           UP(i,j,4)= 1- P(i,j,3) - eps(i);
           
       elseif X(1,j)==1 && temp (i,j) == 0 && TE (i)==1
           UP(i,j,1)= P(i,j,1) + eps(i);
           UP(i,j,2)= 1- P(i,j,1) - eps(i);
           
       elseif X(1,j)==1 && temp (i,j) == 0 && TE (i)==0
           UP(i,j,1)= P(i,j,1) - eps(i);
           UP(i,j,2)= 1- P(i,j,1) + eps(i);
       
       elseif X(1,j)==0 && temp (i,j) == 1 && TE (i)==1
           UP(i,j,3)= P(i,j,3) - eps(i);
           UP(i,j,4)= 1- P(i,j,3) + eps(i);
           
       elseif X(1,j)==0 && temp (i,j) == 1 && TE (i)==0
           UP(i,j,3)= P(i,j,3) + eps(i);
           UP(i,j,4)= 1- P(i,j,3) - eps(i);
       end
    end
end