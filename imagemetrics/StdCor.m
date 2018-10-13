function [ stdxy,stdx,stdy ] = StdCor( A,B )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(A);
MA=mean(mean(A));
MB=mean(mean(B));
sumxy=0;
sumx=0;
sumy=0;
for i=1:m
    for j=1:n
        sumxy=sumxy+((A(i,j)-MA)*(B(i,j)-MB));
        sumx=sumx+((A(i,j)-MA).^2);
        sumy=sumy+((B(i,j)-MB).^2);
    end
end
stdxy=sumxy/(m*n-1);
stdx2=sumx/(m*n-1);
stdy2=sumy/(m*n-1);
stdx=stdx2.^(1/2);
stdy=stdy2.^(1/2);
end

