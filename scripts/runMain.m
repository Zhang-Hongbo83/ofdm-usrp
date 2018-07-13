% Description:
%     OFDM transmission system for simulation and USRP-based experiment
%
% EXAMPLE:
%     runMain
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
% V1.0       20180626    H.B. Zhang    Create this script
% V1.1       20180711    H.B. Zhang    Add DHT precoding and offline code
% V1.1       20180712    H.B. Zhang    Ver B001 release
% V1.2       20180713    H.B. Zhang    Auto detect xlsx modification, add
%                                      caseNum to result file, add rng seed
% Ref:
%

%% clear simulation envirements
clear;
close all;
clc;

%% Simulation/Offline mode
vP.sysModeStr          = 'Simulation';  % {'Simulation','Offline'}
vP.oflTxON             = 0;  % 0->OFF/1-ON, generate USRP Transmitter offline data
vP.oflRxON             = 1;  % 0->OFF/1-ON, running offline script to process offline data

%% gen case_list.m and select simulation case number
tBegin                      = clock;
caseNum                     = 1;
refreshCaseList;

%% set version information
verInfo.projName       = 'OFDM-USRP';
verInfo.date           = '2018-07-13';
verInfo.verNo          = 'B001T001';
verInfo.author         = 'Hongbo Zhang';
verInfo.email          = 'hongbo.zhang83@gmail.com';
vP.verInfo             = verInfo;
seedOrig               = char2num(verInfo.verNo);
seed                   = mod(seedOrig,2^32);
rng('default');
rng(seed);

%% insert control flag code here


%% system settings: vP -> save parameters; vR -> save results
sysSettings;
diary on;
% check system running mode: 0->error; 1->simulation; 2->offline
if (vP.sysMode == 0)
    fprintf('- System running mode checking failed.\n');
    return;
end

%% Print system information
print_sim_info;

%% TxDSP
[vR,vP]                = txdspOfdm(vP);

% Channel: ISI, frequency fading, AWGN, multi-path interferences
[vR,vP]                = wireLessChanModel(vR,vP);

% RxDSP
[vR,vP]                = rxdspOfdm(vR,vP);

%% Calc BER
calcBER;

%% End DSP processing
tEnd                   = clock;
fprintf('%33s%.2f seconds\n','     Simulation Time: ', etime(tEnd,tBegin));

%% Analysis
% plotSpectrum(vR.txSigTD,2^12,fDAC*vP.glb.dataUnit);

%% Save logs and simulation/offline results
saveResults;
diary off;