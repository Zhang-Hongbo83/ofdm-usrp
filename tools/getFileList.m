function [fileList,fileListNum] = getFileList(folder,fileType)
% Description:
%     Get file list of folder in specified filtType
%
% EXAMPLE:
%     [fileList,fileListNum] = getFileList(folder,fileType)
%
% INPUT:
%     folder           - specified directory 
%     fileType         - specified file type, such as: .mat, .txt, ...
%
% OUTPUT:
%     fileList         - fileList cell
%     fileListNum      - effective file number
%
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180712    H.B. Zhang    Create this script
% Ref:
%

% get file list details
fileListTmp            = dir(fullfile(folder,strcat('*',fileType)));

% collect FILEs only, exclude folders end with string of fileType
fileListTmpNum         = length(fileListTmp);
fileList               = cell(fileListTmpNum,1);
fileListNum            = 0;
for iFile = 1:fileListTmpNum
    fileTmp            = fileListTmp(iFile);
    if (fileTmp.isdir == 0)
        fileListNum    = fileListNum + 1;
        fileList{fileListNum} = fullfile(fileTmp.folder, fileTmp.name);
    else
        % do nothing
    end
end

% drop null cell, this usually caused by xxxmat folder
fileList(fileListNum+1:end) = [];

end