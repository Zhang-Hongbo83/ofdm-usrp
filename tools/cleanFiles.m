% Parameter description
%     Clean output and temporal files for release
%
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180712    H.B. Zhang    Create this script
% Ref:
%

fprintf('%s\n','- Clean output and temporal files for release');

% load work place root path
load workRoot.mat;

% defined folders to be clean
cleanFolderList = {
    'database';
    'logs';
    'input';
    'output';
    'results'
    };

for iFile = 1:length(cleanFolderList)
    cleanFolderTmp = fullfile(workRoot,cleanFolderList{iFile});
    delete(strcat(cleanFolderTmp,'\*.mat'));
    delete(strcat(cleanFolderTmp,'\*.txt'));
    
    fprintf('%s: %s\n','- clean folder',cleanFolderTmp);
end
fprintf('%s\n','- clean folder completed.');

clear iFile cleanFolderTmp;