function [ sam ] = SAM1( M,F )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%SAM  

%SAM 
numerator = (sum(bsxfun(@times,M,F),3)); 
denominator = bsxfun(@times,sqrt(sum((M.^2),3)),sqrt(sum((F.^2),3))); 
sam= ((bsxfun(@rdivide,numerator,denominator))); 
nanElem = isnan(sam);   
sam(nanElem) = 0; 
sam(sam>1)=1; 
sam(sam<0)=0; 
sam=acos(sam); 
sam = mean(sam(:)); 

end

