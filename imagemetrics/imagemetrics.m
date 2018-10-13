function [ sol ] = imagemetrics( M,LM,P,F )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%相关系数
M=double(M);
P=double(P);
F=double(F);

[m, n, d]=size(M);
sol(1)=CC1(M,F);
%ERGAS
sol(4)=ERGAS1(M,F);
%QA
sol(2)=UIQI(M,F);
%SAM
sol(5)=SAM1(M,F);
%RASE
sol(6)=RASE1(M,F);
%RMSE
sol(7)=RMSE1(M,F);

[D_lambda,D_s,QNRValue]=QNR1(LM,P,F);
sol(8)=D_s;

sol(9)=D_lambda;

sol(3)=QNRValue;
%SID
sol(10)=SID(M,F);
%Spatial
% sp=spatial(F, P);
% if d==3
%     sol(11)=sum(sp)/3;
% else 
%     sol(11)=sum(sp)/4;
% end

% sol(9)=SCC(F,P);


end

