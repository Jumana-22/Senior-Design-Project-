
clear all
close all
clc

global Best_CM;
global Best_accurancy;

global Best_feature;
Best_accurancy=-1;

%% The used classifier and dataset can be modified in the functions (i) classify.m (ii)classifyS2.m
%% However the dimensions of the dataset are to be specified in this script on line 18 as n.

for W=1:1 % number of evaluations
clearvars -except Result W TRK Strack track
close all   
fprintf('\n\n\nEvaluation number %s\n',num2str(W))

fprintf('Executing Stage 1\n')
eps_a=1;                               % encouragement factor
Ch=3;                                   % number of children
n=53;                                 % SS dimensions
B=9;                                    % Number of B best particles to keep in swarm
iter=100;  %50

X=ones(1,n);

prob= 0.5*ones(1,n,4);                    %Initialize probabilities

%%
for i=1:iter

Evai=classify(X);
[X,prob]=produce_classify(X,Ch,eps_a,n,prob,[]);
[r,~]=size(X);

 X(any(X,2)==0,end)=1;

Eval=classify(X);
BB = unique(X,'rows');
[rw,~]=size(BB);
if rw==1
    rng('shuffle')
    X(2:end,:)=randi([0 1],r-1,n); 
    
    X(any(X,2)==0,end)=1;
end

    if r>B

    [T,TT]=sort(Eval,'descend');        % Keep the best B particles
    X=X(TT(1:B),:);
    prob=prob(TT(1:B),:,:);
    T=T(1:B);
    EvR(i,:)=T;


    end
    
    probrec(i,:)= prob(1,:,1);
    probrec1(i,:)= prob(1,:,3);
    Xrec(i,:)=X(1,:);
    Erec(i)=max(Eval);
    
end
F=find(T==max(T));
SuM=sum(X(F,:),2);
F1=find(min(SuM));
F=F(F1);
BPF=X(F(1),:);
BVF=max(Eval);

features=find(BPF==1);
total=sum(BPF);
Accuracy=BVF;


track(1)=total;
track(2)=Accuracy;

Trk(1:2,1:2)=0;
Trk(1:2,end+1)=[total,Accuracy];

e=2;
stages=1;

% End of the first stage

while ~isequal(Trk(1:2,end),Trk(1:2,end-1),Trk(1:2,end-2))
% for e=3:2:stages*2

clearvars -except Result W track features stages Trk Strack e TRK eps_a

%% Stage 2 Part A

SFG=features;
% NSG=find(BPF==0);


fprintf('Executing Stage %d\n',e)
e=e+1;

eps_a=eps_a*0.96;                               % encouragement factor
Ch=3;                                   % number of children
n=length(SFG);                                   % SS dimensions
B=9;                                    % Number of B best particles to keep in swarm
iter=30;
               % Initialize random population
X=ones(1,n);
% X=randi([0 1],1,n);

prob= 0.5*ones(1,n,4);                    %Initialize probabilities

%%
for i=1:iter

% Evai=classifyS2(X,SFG);
[X,prob]=produce_classify(X,Ch,eps_a,n,prob,SFG);
[r,~]=size(X);

if r<=B

Eval=classifyS2(X,SFG);

BB = unique(X,'rows');
[rw,~]=size(BB);
if rw==1
    rng('shuffle')
    X(2:end,:)=randi([0 1],r-1,n);  
    
    X(any(X,2)==0,end)=1;
end
end


    if r>B
    
        X=unique(X,'rows');
        [l,~]=size(X);
    
            if l<Ch*B
                rng('shuffle')
                X(l+1:Ch*B,:)= randi([0 1],(Ch*B)-l,n);
                
                X(any(X,2)==0,end)=1;
            end
            
            Eval=classifyS2(X,SFG);
    
    
    [T,TT]=sort(Eval,'descend');        % Keep the best B particles
    X=X(TT(1:B),:);
    prob=prob(TT(1:B),:,:);
    T=T(1:B);
    EvR(i,:)=T;
    

    end
    
%     probrec2(i,:)= prob(1,:,1);
%     probrec3(i,:)= prob(1,:,3);
%     Xrec1(i,:)=X(1,:);
%     Erec1(i)=max(Eval);
    
end
F=find(T==max(T));
SuM=sum(X(F,:),2);
F1=find(SuM==min(SuM));
F=F(F1);
BPF1=X(F(1),:);
BVF1=max(Eval);


features=features(find(BPF1==1))
total1=sum(BPF1);
Accuracy1=BVF1;


Trk(1:2,end+1)=[total1,Accuracy1];

track(end+1)=total1;
track(end+1)=Accuracy1;
stages=stages+1;
end

if isequal(Trk(1:2,end),Trk(1:2,end-1),Trk(1:2,end-2))
% for e=3:2:stages*2
if stages<10
    for h=1:3
clearvars -except Result W track features stages Trk Strack e TRK eps_a

%% Stage 2 Part A

SFG=features;
% NSG=find(BPF==0);


fprintf('Executing Stage %d\n',e)
e=e+1;

eps_a=eps_a*0.96;                              % encouragement factor
Ch=3;                                   % number of children
n=length(SFG);                                   % SS dimensions
B=9;                                    % Number of B best particles to keep in swarm
iter=30;
               % Initialize random population
% X=ones(1,n);
X=randi([0 1],1,n);

prob= 0.5*ones(1,n,4);                    %Initialize probabilities

%%
for i=1:iter

% Evai=classifyS2(X,SFG);
[X,prob]=produce_classify(X,Ch,eps_a,n,prob,SFG);
[r,~]=size(X);

if r<=B

Eval=classifyS2(X,SFG);

BB = unique(X,'rows');
[rw,~]=size(BB);
if rw==1
    rng('shuffle')
    X(2:end,:)=randi([0 1],r-1,n);  
    
    X(any(X,2)==0,end)=1;
end
end


    if r>B
    
        X=unique(X,'rows');
        [l,~]=size(X);
    
            if l<Ch*B
                rng('shuffle')
                X(l+1:Ch*B,:)= randi([0 1],(Ch*B)-l,n);
                
                X(any(X,2)==0,end)=1;
            end
            
            Eval=classifyS2(X,SFG);
    
    
    [T,TT]=sort(Eval,'descend');        % Keep the best B particles
    X=X(TT(1:B),:);
    prob=prob(TT(1:B),:,:);
    T=T(1:B);
    EvR(i,:)=T;
    

    end
    
%     probrec2(i,:)= prob(1,:,1);
%     probrec3(i,:)= prob(1,:,3);
%     Xrec1(i,:)=X(1,:);
%     Erec1(i)=max(Eval);
    
end
F=find(T==max(T));
SuM=sum(X(F,:),2);
F1=find(SuM==min(SuM));
F=F(F1);
BPF1=X(F(1),:);
BVF1=max(Eval);


features=features(find(BPF1==1));
total1=sum(BPF1);
Accuracy1=BVF1;


Trk(1:2,end+1)=[total1,Accuracy1];

track(end+1)=total1;
track(end+1)=Accuracy1;
stages=stages+1;
end



end
end

Strack(W)=stages;
TRK(W,:)=string(num2str(track));
Result(1,W)=total1;
Result(2,W)=Accuracy1;
track=[];
end



fileID = fopen('results_test_new_idea_new_epsilon.txt','w');
fprintf(fileID,'%6s %6s\n','BAccuracy','totalF');
fprintf(fileID,'%6.4f %6.4f\n',Result);
fprintf(fileID,'\n%6s','mean');
fprintf(fileID,'\n\n%6.4f %6.4f\n',mean(Result,2));
fprintf(fileID,'\n%6s','track');
% fprintf(fileID,'\n\n%6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f %6.4f\n',track');
fprintf(fileID,'\n\n%s',TRK);
fprintf(fileID,'\n\n%s','Stages');
fprintf(fileID,'\n%d',Strack);
fprintf(fileID,'\n\n%s','Average Stages');
fprintf(fileID,'\n%6.4f',mean(Strack));

fclose(fileID);
