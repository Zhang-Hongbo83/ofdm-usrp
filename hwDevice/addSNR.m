function outSig = addSNR(inSig,SNR_dB)
% Description:
%     Add SNR to input time domain signal
% 
% EXAMPLE:
%     outSig = addSNR(inSig,SNR_dB)
%     
% INPUT:
%     inSig        - Input signal
%     SNR_dB       - SNR in unit of dB
%     
% OUTPUT:
%     outSig       - output signal with SNR
%     
% Modifications:
% Version    Date        Author        Log.
% V1.0       20170702    H.B. Zhang    Create this script
% 
% Ref:
%     

sigLen                  = length(inSig);
signal_rms              = rms(inSig);

SNR_lin                 = dBp_rev(SNR_dB);
noise_rms               = signal_rms/sqrt(SNR_lin);

rng('default');
noise                   = noise_rms*randn(sigLen,1);

outSig                  = inSig(:) + noise;
end