% Description
%     Refresh or re-generate case_list.m 
%
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180713    H.B. Zhang    Create this script
% Ref:
%

% set folder path
load workRoot.mat
caseListPath           = fullfile(workRoot,'config');

% flag: if generate case_list.m or not
isGenCaseList          = 0;    % 0->NO/1->Yes
caseListFilePre        = 'case_list';
mFileSuffix            = '.m';
xlsFileSuffix          = '.xlsx';

% file names and file paths
mFileName              = strcat(caseListFilePre,mFileSuffix);
xlsFileName            = strcat(caseListFilePre,xlsFileSuffix);
mFilePath              = fullfile(caseListPath,mFileName);
xlsFilePath            = fullfile(caseListPath,xlsFileName);

if checkFileExist(mFilePath) % exist case_list.m
    % get file modified date and time number
    case_list;
    caseListVerXls     = getFileDateNum(xlsFilePath);
    if isequal(caseListVer,caseListVerXls)
        % do nothing
        fprintf('%s%s\n','- no modification is detected in file: ',xlsFileName);
    else
        isGenCaseList  = 1;    % need to re-generate case_list file
        fprintf('%s%s\n','- modification is detected in file: ',xlsFileName);
        fprintf('%s%s\n','- please wait to re-generate case list file: ',mFileName);
    end
else
    isGenCaseList  = 1;        % need to generate case_list file
    fprintf('%s%s\n','- no case list file is found in ./config/: ',mFileName);
    fprintf('%s%s\n','- please wait to generate case list file: ',mFileName);
end

if (isGenCaseList == 1)        % generate case_list file
    genOK = genCaseList(xlsFilePath);
    if (genOK == 0)
        fprintf('%s\n','- Gen case_list.m file failed, simulation will be stopped.');
        return;
    end
end

% run case_list to generate struct variable caseList
eval(['run ',mFilePath]);