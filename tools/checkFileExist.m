function tf = checkFileExist(fileName)
% Description:
%     Check if the specified file exist or not
% 
% EXAMPLE:
%     
%     
% INPUT:
%     fileName     - Input fileName
%     
% OUTPUT:
%     tf           - True of False
% 
%  Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180626    H.B. Zhang    Create this script
% 
% Ref:
%     

if exist(fileName,'file')
    tf = true;
else
    tf = false;
end

end