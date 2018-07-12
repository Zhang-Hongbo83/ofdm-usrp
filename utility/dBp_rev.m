function wValue = dBp_rev(SNR_dB)
% Description:
%     dBp_rev change dB to linear W
% 
% EXAMPLE:
%     wValue = dBp_rev(sigIn)
%     
% INPUT:
%     SNR_dB       - Input SNR in unit of dB
%     
% OUTPUT:
%     wValue      - Output power W value of input signal
%     
% Modifications:
% Version    Date        Author        Log.
% V1.0       20170702    H.B. Zhang    Create this script
% 
% Ref:
%     

wValue = 10^(SNR_dB/10);

end