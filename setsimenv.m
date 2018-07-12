function setsimenv
% Description:
%     SETSIMENV Set simulation envirement.
% 
% EXAMPLE:
%     setsimenv
%     
% INPUT:
%     
%     
% OUTPUT:
%     
%  
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
% 
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180626    H.B. Zhang    Create this script
% Ref:
%     

clear;
close all;
clc;

% Set release date
verRelDate    = '2018-06-26';
RelDateNum    = datenum(verRelDate);

% Get current path
currentPath   = fileparts(mfilename('fullpath'));
changeFlag    = 0;

% Add path and Check Folder file(s)
changeFlag    = addPath_checkFileChangeInFolder(currentPath,RelDateNum,changeFlag,0);

% Select subFolder for adding to simulation path
select_subFolder = {
    'analysis';
    'config';
    'database';
    'dsp';
    'hwDevice';
    'input';
    'lib';
    'logs';
    'math';
    'offline';
    'output';
    'results';
    'scripts';
    'tools';
    'utility'
    };

num_sub      = length(select_subFolder);

for isub = 1:num_sub
    subfolderName = fullfile(currentPath,select_subFolder{isub});
    changeFlag    = addPath_checkFileChangeInFolder(subfolderName,RelDateNum,changeFlag,1);
end

workRoot = currentPath;
save(fullfile(workRoot,'database','workRoot'),'workRoot');

open runMain.m
end


%% ==================== SUB FUNCTION(S) =========================
function changeFlag = addPath_checkFileChangeInFolder(folderName,RelDateNum,changeFlag,subFolderFlag)

addpath(folderName);
fileList = dir(folderName);

for fileNdx = 3:length(fileList)
    if fileList(fileNdx).isdir
        if (subFolderFlag == 1)
            changeFlag = addPath_checkFileChangeInFolder(fullfile(folderName,fileList(fileNdx).name),...
                RelDateNum,changeFlag,subFolderFlag);
        end
    else
        if floor(fileList(fileNdx).datenum) > RelDateNum
           fprintf('%-30s%s \n',fileList(fileNdx).date,fullfile(folderName,fileList(fileNdx).name)); 
           changeFlag = 1;
        end
    end
end
end