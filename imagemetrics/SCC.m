function SCC = SCC(F,P )
[m,n,d]=size(F);
for i=1:d
    A=F(:,:,i);
    SC(i)=corr2(A,P);
end
SCC=mean(SC);
end

