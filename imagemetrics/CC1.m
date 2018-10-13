function CC = CC1( M,F )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n,d]=size(M);
for i=1:d
    C(i)=corr2(M(:,:,i),F(:,:,i));
end
CC=mean(C);

end

