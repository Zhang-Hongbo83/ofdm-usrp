% Description:
%     Loading offline experimental data
%
% EXAMPLE:
%     loadOflData
%
% INPUT:
%     none             - 
%
% OUTPUT:
%     none             - 
%
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180712    H.B. Zhang    Create this script
% Ref:
%

% parameters definition
fileType               = '.mat';   % file type
fileIdx                = 2;

% offline data root path
folderRoot             = 'D:\temp\dataUSRPofdm\';

% experimental date
expDate                = '20180711';

% offline data folder path
folderPath             = fullfile(folderRoot,expDate);

% get file list
[fileList,fileListNum] = getFileList(folderPath,fileType);

% check file exist
if (fileIdx > fileListNum)
    error('ERROR (loadOflData.m): File index out of range!');
end

%% load data for offline processing
oflDataFile            = fileList{fileIdx};
fprintf('%s\n', '- loading USRP offline data begin:');
fprintf('%s: %s\n', '- file name', oflDataFile);

load(oflDataFile);
fprintf('%s\n', '- loading USRP offline data completed.');

vP                     = oflRxData.vP;
vR                     = oflRxData.vR;
fprintf('%s\n', '- re-loading offline parameters completed: re-write vP and vR.');