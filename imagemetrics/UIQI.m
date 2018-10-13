function [ uiqi ] = UIQI( M,F )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n,d] = size(M);
for i=1:d
    [stdxy,stdx,stdy]=StdCor(M(:,:,i),F(:,:,i));
    Mx=mean(mean(M(:,:,i)));
    My=mean(mean(F(:,:,i)));
    Q1(i)=stdxy/(stdx*stdy);
    Q2(i)=2*Mx*My/((Mx^2)+(My^2));
    Q3(i)=2*stdx*stdy/((stdx^2)+(stdy^2));
    Q(i)=Q1(i)*Q2(i)*Q3(i);
end
uiqi=mean(Q);

