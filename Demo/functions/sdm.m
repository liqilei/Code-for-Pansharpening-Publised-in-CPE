function [ MSH] = sdm(M,P,alpha,MSH,gamma )
[m,n,d]=size(M);

for i=1:d
    for j=1:m
        for k=1:n
            factor(j,k,i)=2*alpha(i)*(((alpha(1)*M(j,k,1)+alpha(2)*M(j,k,2)+alpha(3)...
            *M(j,k,3)+alpha(4)*M(j,k,4))-P(j,k)+(alpha(1)*MSH(j,k,1)+alpha(2)*MSH(j,k,2)+alpha(3)*MSH(j,k,3)...
            +alpha(4)*MSH(j,k,4))));%最小化细节函数
        end
    end
end

iter=2;
solution=1;
while iter<1000
    
    for i=1:d
        for j=1:m
            for k=1:n
                NewMSH(j,k,i)=MSH(j,k,i)-gamma*factor(j,k,i);%梯度下降函数，迭代求最终细节
            end
        end
    end
    
    
    for i=1:d
      for j=1:m
        for k=1:n
            factor(j,k,i)=2*alpha(i)*sum(sum(sum((((alpha(1)*M(j,k,1)+alpha(2)*M(j,k,2)+alpha(3)...
            *M(j,k,3)+alpha(4)*M(j,k,4))-P(j,k)+(alpha(1)*NewMSH(j,k,1)+alpha(2)*NewMSH(j,k,2)+alpha(3)*NewMSH(j,k,3)...
            +alpha(4)*NewMSH(j,k,4)))))));
        end
      end
    end
    
    En(iter-1)=sum(sum(sum(abs((alpha(1)*M(:,:,1)+alpha(2)*M(:,:,2)+alpha(3)*M(:,:,3)+alpha(4)*M(:,:,4))-P+...
    (alpha(1)*NewMSH(:,:,1)+alpha(2)*NewMSH(:,:,2)+alpha(3)*NewMSH(:,:,3)...
    +alpha(4)*NewMSH(:,:,4))))));%将获得的细节图像带入公式13求得IHS空间的高分辨率多光谱图像的高频部分
    
    MSH=NewMSH;%估计出的最终细节图像
    if En(iter-1)<solution
        break;
    else
        iter=iter+1;
    end
end
    
    

 end

