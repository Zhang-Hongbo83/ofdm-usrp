function [ x ] = IDHartleyT( X )  
%DHartleyT Summary of this function goes here  
%   Detailed explanation goes here  
%   x is the input single  
%   X is the discrete Hartley transform of x  
% N = length(X);  
% [x_rows,x_columns] = size(X);  
% if x_rows<x_columns  
%     X = X';%x should be a column vector  
% end  

N = size(X,1);
[k,n] = meshgrid(0:N-1);  
HN = sqrt(1/N)*(cos(2*pi/N*n.*k)+sin(2*pi/N*n.*k));  
x = HN*X;  
end 