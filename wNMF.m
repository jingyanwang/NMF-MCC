function [Output]=wNMF(Input, Options)
% [Output]=wNMF(Input, Options)
% Non-Negative Matrix Factorization based on Maximum Correntropy Criterion (NMF-MCC) 
% 
% load wNMF_Input; 
% [Output]=wNMF(Input, Options); 
% WeightImage=reshape(-Output.rho,32,32);
% figure;
% imagesc(WeightImage);
% title('-rho')


X=Input.X;

H0=Input.H0;
W0=Input.W0;

K=Options.K;
T=Options.T;

%%%%%%%%%%%%%%%%%%

[D N]=size(X);

if strcmp(Options.Method,'NMF-MCC')

rho=-ones(D,1);
               
H=H0;
W=W0;

% H=rand(D,K);
% W=rand(K,N);

for t=1:T
    temp1=sum(X-H*W,2);   
    sigma = mean(temp1);
    temp1 = temp1/sigma;
    rho = normpdf(temp1,zeros(D,1),1);
    rho=-D*rho/sum(rho);

    temp3=diag(-rho);
    
    H=H.* (temp3*X*W')./(temp3*H*W*W');    
    W=W.*(H'*temp3*X)./(H'*temp3*H*W);  
end

%%%%%%%%%%%%%%%%%%

Output.H=H;
Output.W=W;
Output.rho=rho;
end

end