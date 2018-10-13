function sol=RMSE1(M,F)
M=double(M);
F=double(F);
[n,m,d]=size(F);
D=(M(:,:,1:d)-F).^2;
sol=sqrt(sum(sum(sum(D)))/(n*m*d));
