function fileDateNum = getFileDateNum(fileName)
% Description:
%     Get datanum of fileName
%
% EXAMPLE:
%     fileDateNum = getFileDateNum(fileName);
%
% INPUT:
%     fileName         - input file name
%
% OUTPUT:
%     fileDataNum      - output file datenum
%
%  Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180713    H.B. Zhang    Create this script
%
% Ref:
%

fileInfo               = dir(fileName);
fileDateNum            = int64(fileInfo.datenum);

end