function [vR,vP] = wireLessChanModel(vR,vP)
% Description:
%     Wireless channel model£º
%     Currently, ONLY SNR is available
%
% EXAMPLE:
%     [eRxSig,vP] = wireLessChanModel(eTxSig,vR,vP)
%
% INPUT:
%     vR.eTxSig    - input TxDSP electrical signal
%     vR           - results collection
%     vP           - global parameters
%
% OUTPUT:
%     eRxSig       - output electrical signal after detection
%     vR           - results collection
%     vP           - collect outputs parameters
%
%  Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180704    H.B. Zhang    Create this script
%
% Ref:
%

% check system running mode
if (vP.sysMode ~= 1) % 1->simulation mode;2->offline txdsp;3->offline rxdsp
    return;
end

fprintf('- Wireless channel running ...\n');

%% Parameters
glb                    = vP.glb;
SNR                    = glb.SNR;
eTxSig                 = vR.txSig;
eTxSig                 = eTxSig(:);


%% channel model
% % Pulse shaping filter and upsampling
% txSigUp                = reSample(eTxSig,fBaud,fs);

% upsampling by ZOH, LPF is necessary, DAC and other devices

% bwFilter


% insert modulation code here


% insert add SNR coder here
rxSig                  = addSNR(eTxSig,SNR);

% insert processing and detection code here



%% simulate USRP cyclic transmit signal
rxSig                  = repmat(rxSig,5,1); % simulate USRP
rxSig                  = circshift(rxSig, [-1000,0]);

%% collect output data and parameters
vR.rxSig               = rxSig;

fprintf('- Wireless channel completed!\n');
end