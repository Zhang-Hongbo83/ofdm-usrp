% Description:
%     Save results of OFDM transmission system
%
% EXAMPLE:
%     saveResults
%
% Parameter description
%     sysMode            - 0: system error, stop running program
%                        - 1: simulation mode
%                        - 2: offline mode: txdsp
%                        - 3: offline mode: rxdsp
%
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180712    H.B. Zhang    Create this script
% Ref:
%

load workRoot.mat;
logFilePath            = fullfile(workRoot,'logs',logFileName);
resultFilePath         = fullfile(workRoot,'results',resultFileName);

%% print simulation results into result file
if checkFileExist(resultFilePath)
    fid                    = fopen(resultFilePath,'a+');
else
    fid                    = fopen(resultFilePath,'w+');
    % print file header
    fprintf(fid,'%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%-4s\t%s\t%s\t%-4s\t%-4s\n', ...
    'modFormat','fDAC','fBaud','bitrate','Nsceff','Nb',...
    'Nfft','Nf','CP','isEqualization','isDHTON','QdB','ber');
end

% print result data
fprintf(fid,'%-9s\t%.2f\t%.2f\t%.2f\t%-6d\t%d\t%-4d\t%d\t%.2f\t%-14d\t%-7d\t%.2f\t%.2e\n', ...
    glb.modFormat,glb.fDAC,glb.fBaud,glb.bitrate,glb.Nsceff,glb.Nb,...
    glb.Nfft,glb.Nf,glb.CP,glb.isEqualization,glb.isDHTON,QdB,ber);
fclose(fid);

%% save logs
