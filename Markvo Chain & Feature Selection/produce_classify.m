%% inputs 
% X=agent, Ch=number of children, eps= amount of encouragement, n=number of dimensions, prob=probabilities
%% returns 
%temp1= newly produced children, P1= probabilities associated with new children

function [temp1,P1]=produce_classify(X,Ch,eps_a,n,prob,SFG)
P1=[];
temp1=[];
[r,~]=size(X);
    for k=1:r 	
            
         temp=repmat(X(k,:),Ch,1);
         Tpro=prob(k,:,:); % actual probability associated with parent agent
         rng('shuffle')
         R=rand(Ch,n); % generate random values for evaluation of each child
         
         for h=1:n
           if  X(k,h) == 0 
         S(:,h)= R(:,h) < Tpro(:,h,1);                    % find locations where prob of parent is greater than child
           else                                             % based on agent position as 0 or 1.
         S(:,h)= R(:,h) < Tpro(:,h,3); 
           end
         end
        

%         S = R < Tpro(:,:,1);
%          S=double(S);
         
         
              temp(S==1)=not(temp(S==1));
           
     %% Call Classifier
        a=X(k,:);  % removing all zeros condition
        a(~any(a,2),end)=1;
        X(k,:)=a;
        
          temp(~any(temp,2),end)=1; % removing all zeros condition
        if isempty(SFG)
                EvaO=classify(X(k,:));                      % Compute evaluation for parent
        
                EvaN=classify(temp);                      % Compute evaluation for children
                
        else
            EvaO=classifyS2(X(k,:),SFG);                      % Compute evaluation for parent
        
                EvaN=classifyS2(temp,SFG);                      % Compute evaluation for children
        end
        
    
%                 eps=0.3./(100-(max(abs(EvaO-EvaN))^2)^0.5+1);
%                 eps=0.3./(100-((abs(EvaO-EvaN)).^2).^0.5+1)
                eps=0.1./(100-((abs(EvaO-EvaN)).^2).^0.5+1);
                eps=min(max(0.001,eps),0.3); % setting eps between a certain range here 0.001 and 0.3
                eps=eps*eps_a; % controling the magnitude of eps, decrease with increasing stages.
            
                TE=EvaN>=EvaO;   % find improved children
                TE=TE';
          
%             Same=(X(k,:)==temp); 			% Is there any change in bits?
            
            P=repmat(Tpro,Ch,1);            % prepare to update probabilities P contains previous prob
            


            P=probabilities(P,TE,X,temp,eps);
            
            P(P<0.001)=rand;
            P(P>0.99)=rand;
            
            XX=repmat(X(k,:),Ch,1);             % update only successful particles
            XX(TE==1,:)=temp(TE==1,:);
            
%               XX=temp;      % update either bad or good
              
%             P(TE==0,:,:)=repmat(Tpro,length(find(TE==0)),1); % update only successful particles probability
            P1=[P1;P];
            temp1=[temp1;XX];
     end
end