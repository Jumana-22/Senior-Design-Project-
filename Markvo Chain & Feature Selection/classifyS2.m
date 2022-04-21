function E=classifyS2(F,G)
global Best_CM;
global Best_accurancy;

global Best_feature;
warning('off','all')
[r,~]=size(F);
% load ionosphere
load samples955.mat
Y=cellstr(Y);
Y(19:end)=Y(19); % puting all classes other than A  as class B. making it class A Vs rest
% load testknn.mat
% X=[W,X];

% load 'warpAR10P.mat'

% T = readtable('11Tumors.csv');
% X=table2array(T(:,2:end-1));
% Y=table2array(T(:,end));
X=X(:,G);


for i=1:r
a=find(F(i,:)==1);



rng('default')
indices = crossvalind('Kfold',Y,10);

for p=1:10




    testdat = (indices == p); 
    traindat = ~testdat;

train = X(traindat,:);
test = X(testdat,:);


Xtrain=train(:,a);
Xtest=test(:,a);


BMdl=fitcknn(Xtrain,Y(traindat)); % KNN
% BMdl=fitcensemble(Xtrain,Y(traindat),'NumLearningCycles',250); % Random Forest
class= predict(BMdl,Xtest);

BM(testdat,1)=class;
end


cp = classperf(Y,BM);

% BAcc=sum((cp.SampleDistributionByClass-cp.ErrorDistributionByClass)./cp.SampleDistributionByClass)/length(cp.SampleDistributionByClass);
BAcc=min(cp.Sensitivity,cp.Specificity);

if Best_accurancy<=BAcc & BAcc>=0.6
    
    Best_CM=cp.CountingMatrix
    Best_feature=a
    Best_accurancy=BAcc
end

E(i)=BAcc;
end

end

