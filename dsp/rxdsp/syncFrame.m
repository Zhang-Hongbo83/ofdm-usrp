function [frmIdx,tau] = syncFrame(inSig,syncSeq)
% Description:
%     Find the framer and drop sync head sequence
%
% Input:
%     - syncSeq         : sync sequence
%     - inSig           : input signal with synchead
%
% Output:
%     - tau             : frame starter index
%     - frmIdx          : frame starter index without synchead
%
% Modifications:
% Version    Date        Author(s)     Mark
% V1.0       20180607    H.B. Zhang    Create this script


% normalized
inSig                  = inSig/rms(inSig);
syncSeq                = syncSeq/rms(syncSeq);

[xcorTmp,lag]          = xcorr(inSig,syncSeq);
[~ ,idx]               = max(abs(xcorTmp));
tau                    = lag(idx);

frmIdx                 = length(syncSeq) + tau+1;

% % plot for debug
% figure(101);clf;
% plot(lag,abs(xcorTmp));
% figure(102);clf;
% plot(inSig)

end