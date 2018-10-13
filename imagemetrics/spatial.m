function ccs=spatial(F,P)
d=size(F, 3);
F=double(F);
P=double(P);
mask=[-1,-1,-1;-1,8,-1;-1,-1,-1];
HP=conv2(P, mask,'same');
for i=1:d
    HF(:,:,i)=conv2(F(:,:,i), mask, 'same');
    A=corrcoef(HP, HF(:,:,i));
    ccs(i)=A(1,2);
end
if d==3
    ccs(4)=0;
end



