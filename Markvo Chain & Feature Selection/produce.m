function [temp1,P1]=produce(X,Ch,seq,OF,eps,n,prob,SS)
P1=[];
temp1=[];
[r,~]=size(X);
    for k=1:r
            R=rand(1,n,Ch); 
         temp=repmat(X(k,:),Ch,1);
         Tpro=prob(k,:);
         S= R < Tpro;                       % find locations where prob is greater than rand
      
         S=double(reshape(S,n,Ch))';
         
         temp(S==1)=not(temp(S==1));
         
      
            [~, idx] = ismember(X(k,:), seq, 'rows');
            [~, idx1] = ismember(temp, seq, 'rows');
            
            idx(idx==0)=SS+1;                % if particle not found in repository of predefined evaluations
            idx1(idx1==0)=SS+1;            
               
                EvaO=OF(idx);                       % Compute evaluation for old position
        
                EvaN=OF(idx1);                      % Compute evaluation for new position
         
            TE=EvaN>EvaO;
          
            Same=(X(k,:)==temp);
            
            P=repmat(Tpro,Ch,1);
            

           P(TE==1&Same==1)=P(TE==1&Same==1) + eps; % encourage particles who have improved
            P(TE==1&Same==0)=P(TE==1&Same==0) - eps; % encourage particles who have improved
%           
            P(TE==0&Same==1)=P(TE==0&Same==1) - eps; % discourage particles who have worsen
            P(TE==0&Same==0)=P(TE==0&Same==0) + eps; % discourage particles who have worsen
            
            P(P<0.001)=0;
            P(P>0.99)=1;
            
            XX=repmat(X(k,:),Ch,1);             % update only successful particles
            XX(TE==1,:)=temp(TE==1,:);
            
%               XX=temp;      % update either bad or good
              
              
            P1=[P1;P];
            temp1=[temp1;XX];
     end
end