function [sumD]=SID(MS,PANMS)
MS=double(MS);
PANMS=double(PANMS);
[n,m,d]=size(PANMS);
MS=MS(:,:,1:d);
MS=MS-min(min(min(MS)))+0.00001;
MS=MS/max(max(max(MS)));
PANMS=PANMS-min(min(min(PANMS)))+0.00001;
PANMS=PANMS/max(max(max(PANMS)));

for i=1:d
    p(:,:,i)=MS(:,:,i)./sum(MS,3);
    q(:,:,i)=PANMS(:,:,i)./sum(PANMS,3);
end


S=zeros(n,m);
N=zeros(n,m);

for i=1:d
    S=(p(:,:,i).*log(p(:,:,i)./q(:,:,i)))+ S;
    N=(q(:,:,i).*log(q(:,:,i)./p(:,:,i)))+ N;
end

D=(N)+(S);
sumD=sum(sum(D))/(n*m);


    