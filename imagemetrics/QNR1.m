function [D_lambda,D_s,Q] = QNR1(M,P,F)
% The matlab implementation of the QNR metric which does not require a
% reference multi-spectral image for evaluation.

% M is the low-resolution multi-spectral image.
% P is the high-resolution panchormatic image.
% F is the pansharpened image.
% References:
% [1] IEEE Transactions on Geoscience and Remote Sensing, 2009, M.M. Khan et 
% al., Pansharpening Quality Assessment Using the Modulation Transfer 
% Functions of Instruments
% [2] Photogrammetric Engineering & Remote Sensing, 2008, L. Alparone et al., 
% Multispectral and Panchromatic Data Fusion Assessment Without Reference

% The code is edited by Xudong Kang and avaible on
% http://xudongkang.weebly.com
% Data Normalization
%%%% Estimating the Spectral Quality D_lambda
w1=20;
w2=80;
N = size(M,3); %calculate the number of bands
D_lambda = 0;  %Initialization
for i=1:N
    for j=1:N
        if j~=i
            [Q_M unused] = img_qi(M(:,:,i),M(:,:,j),w1);
            [Q_F unused] = img_qi(F(:,:,i),F(:,:,j),w2);
            if Q_F>1
                Q_F=1;
            else
            end
            D_lambda = D_lambda+abs(Q_M-Q_F);
        else
        end
    end
end
D_lambda=D_lambda./(N*(N-1)); %Normalization

%%%% Estimating the Spatial Quality D_s
p = imresize(P,0.25,'bicubic'); % estimate the low-resolution panchormatic image
D_s = 0; %Initialization
for i=1:N
    [Q_p unused] = img_qi(M(:,:,i),p,w1);
    [Q_P unused] = img_qi(F(:,:,i),P,w2);
    D_s=D_s+abs(Q_p-Q_P);
end
D_s=D_s./N; %Normalization
Q =(1-D_lambda)*(1-D_s);
end

