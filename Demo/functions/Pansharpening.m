function HMS = Pansharpening( MS,Pan,lambda,gamma )

MS=double(MS);
Pan=double(Pan);
original_MS=MS;
original_Pan=Pan;
[m,n,d]=size(MS);

if(~exist('lambda', 'var')),
    lambda = 0.8;
end
if(~exist('gamma', 'var')),
    gamma = 0.1;
end
%%
% Pretreatment 
for i=1:d
    MS_max(i)=max(max(MS(:,:,i)));
    normal_MS(:,:,i)=MS(:,:,i)/MS_max(i);
end
Pan_max=max(max(Pan));
normal_Pan=Pan/Pan_max;
%%
%  Estimating the Primitive Detail Map
% for i=1:d
%     MS_low(:,:,i)=wlsFilter(normal_MS(:,:,i),lambda,0.8);
% end
% Pan_low=wlsFilter(normal_Pan,lambda,0.8);
r = 2; % try r=2, 4, or 8
eps = 0.1; % try eps=0.1^2, 0.2^2, 0.4^2
for i = 1 : d
    MS_low(:, :, i) = guidedFilter(normal_MS(:, :, i), normal_MS(:, :, i), r, eps);
end
Pan_low = guidedFilter(normal_Pan, normal_Pan, r, eps);

for i=1:d
    MS_high(:,:,i)=normal_MS(:,:,i)-MS_low(:,:,i);
end
Pan_high = normal_Pan-Pan_low;

temp = zeros(m*n,d);
for k = 1:d
    temp(:,k) = reshape(squeeze(MS_high(:,:,k)),[m*n,1]);
end

alpha = regress(Pan_high(:),temp);

I_high=(alpha(1)*MS_high(:,:,1)+alpha(2)*MS_high(:,:,2)+alpha(3)*MS_high(:,:,3)+alpha(4)*MS_high(:,:,4));
for i=1:d
    primitive_D(:,:,i)=(Pan_high-I_high);
end
%
for i = 1 : 4
    extra(:,:,i) = guidedFilter(Pan_high, MS_high(:,:,i), r, eps);
    add(:,:,i) = MS_high(:,:,i) - extra(:,:,i) ;
    primitive_D(:,:,i)  = primitive_D(:,:,i) + add(:,:,i);
end
for i = 1 : 4
    extra(:,:,i) = guidedFilter(Pan_high, add(:,:,i), r, eps);
    add(:,:,i) = MS_high(:,:,i) - extra(:,:,i) ;
    primitive_D(:,:,i)  = primitive_D(:,:,i) + add(:,:,i);
end
% Refining the Primitive Detail Map
final_D=sdm(MS_high,Pan_high,alpha,primitive_D,gamma);
r = 8;
eps = 10^-2;
s = 4;

% extra = fastguidedfilter(Pan_high, MS_high(:,:,i), r, eps, s);
%
% Obtain the HMS image
for i=1:d
    HMS(:,:,i)=original_MS(:,:,i)+final_D(:,:,i)*MS_max(i);

end

end

