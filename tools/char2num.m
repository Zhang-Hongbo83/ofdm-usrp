function intNum = char2num(charString)
% Description:
%     Conver char array to integration number
%
% EXAMPLE:
%     intNum = char2num(charString)
%
% INPUT:
%     charString       - input char array
%
% OUTPUT:
%     intNum           - output int number
%
%  Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180713    H.B. Zhang    Create this script
%
% Ref:
%

charNum                = double(charString);
charNumStr             = string(charNum);
intNum                 = str2double(cell2mat(charNumStr)); 
end