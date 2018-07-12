function [outSig,estPhase] = phaseNoiseComp_QPSK(inSig)
% Description:
%     Phase Noise compensation for QPSK-pi/2 signal using 4-power method
% 
% EXAMPLE:
%     [outSig,estPhase] = phaseNoiseComp_QPSK(inSig)
%     
% INPUT:
%     inSig                   - Input signal with PN
%     
% OUTPUT:
%     outSig                  - Output PN compensated signal
%     estPhase                - estimated phase noise
%     
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180414    H.B. Zhang    Create this script
% 
% Ref:
%     

PWR                    = 4;
pwrValue               = inSig.^PWR;
phaseValue             = angle(pwrValue);
estPhase               = mean(phaseValue(:))/PWR;

outSig                 = inSig*exp(1j*(-estPhase));
end