function [vP] = checkSysMode(vP)
% Description:
%     Check the system running mode: simulation or offline
%
% EXAMPLE:
%     [sysMode,oflTxON,oflRxON] = checkSysMode(sysModeStr,oflTxON,oflRxON)
%
% INPUT:
%     vP.sysModeStr   - system running mode: simulation/offline
%     vP.oflTxON      - controller of offline txdsp
%     vP.oflRxON      - controller of offline rxdsp
%
% OUTPUT:
%     vP.sysMode      - running mode
%     vP.oflTxON      - controller of offline txdsp
%     vP.oflRxON      - controller of offline rxdsp
%
% Parameter description: running mode
%     sysMode            - 0: system error, stop running program
%                        - 1: simulation mode
%                        - 2: offline mode: txdsp
%                        - 3: offline mode: rxdsp
%
%  Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180711    H.B. Zhang    Create this script
%
% Ref:
%
% ------------------------------------------------------------

% get parameters
sysModeStr             = vP.sysModeStr;
oflTxON                = vP.oflTxON;
oflRxON                = vP.oflRxON;

% check simulation/offline mode
if strcmpi(sysModeStr, 'Simulation')  % simulation mode 1
    sysMode            = 1;
elseif strcmpi(sysModeStr, 'Offline') % offline mode: 2->tx; 3->rx; 0->error
    if (oflTxON==1) && (oflRxON==1)
        fprintf('%s\n','- oflTx and oflRx cannot work on the same time.');
        fprintf('%s\n','- please check parameters of oflTxON and oflRxON.');
        sysMode        = 0;
    elseif (oflTxON==1)
        sysMode        = 2;
        fprintf('%s\n','- offline txdsp is active.');
    elseif (oflRxON==1)
        sysMode        = 3;
        fprintf('%s\n','- offline rxdsp is active.');
    else
        sysMode        = 0;
    end
else
    fprintf('%s\n','- System running mode wrong, choose ''Simulation'' or ''Offline''.');
    sysMode            = 0;
end

vP.sysMode             = sysMode;
end