function [ X ] = DHartleyT( x )  
%DHartleyT Summary of this function goes here  
%   Detailed explanation goes here  
%   x is the input single  
%   X is the discrete Hartley transform of x  
% N = length(x);  
% [x_rows,x_columns] = size(x);  
% if x_rows<x_columns  
%     x = x';%x should be a column vector  
% end  

N = size(x,1);
[k,n] = meshgrid(0:N-1);  
HN = sqrt(1/N)*(cos(2*pi/N*n.*k)+sin(2*pi/N*n.*k));  
X = HN*x;  
end 