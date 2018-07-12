function [vR,vP] = rxdspOfdm(vR,vP)
% Description:
%     OFDM Transmitter
%
% EXAMPLE:
%     [vR,vP] = txdspOfdm(vP)
%
% INPUT:
%     vP               - system parameters
%
% OUTPUT:
%     vR               - saved generated signal: txSymbol/txBit
%
%  Copyright, 2018 (C), H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180627    H.B. Zhang    Create this script
% Ref:
%

% system running mode saved temporal
sysMode                = vP.sysMode;

% check system running mode
if (sysMode == 2) % 1->simulation mode;2->offline txdsp;3->offline rxdsp
    vR = [];
    return;
end

% NOTE: offline rxdsp do not supported now
if (sysMode == 3)
    loadOflData;
    vP.sysMode         = sysMode;
end

% get parameters and values
glb                    = vP.glb;
Nsceff                 = glb.Nsceff;
Nfft                   = glb.Nfft;
Nb                     = glb.Nb;
CP                     = glb.CP;
isEqualization         = glb.isEqualization;
modFormat              = glb.modFormat;
isDHTON                = glb.isDHTON;

% load syncheader PRBS
syncPRBS               = vR.synchead;
lenPRBS                = length(syncPRBS);

% get signal
txSig                  = vR.txSig(:);  % including syncheader
rxSig                  = vR.rxSig(:);

% average mean square value of tx signal
rmsTxRe                = rms(real(txSig));
rmsTxIm                = rms(imag(txSig));

% calc parametrs
lenSync                = lenPRBS;
lenTx                  = length(txSig);
lenRx                  = length(rxSig);
GI                     = CP*Nfft;
smplPerOFDM            = GI + Nfft;

% syncFrame
getEffRxSig;

% plot figures
ofdmDemodTx;  % for debugging code and ber calculation
ofdmDemodRx;

% returen data
vR.txSymbolEff         = txSymbolEff;
vR.rxSymbolRec         = rxSymbolRec;
vR.segRxEff            = segRxEff;

end