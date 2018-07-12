function [txSymsrc,sigParms] = genSymSrc(sigParms)
% Description:
%     Generate Transmitter symbols signal
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
% Modifications:
% Version    Date        Author        Log.
% V1.0       20161001    H.B. Zhang    Create this script

% get parameters from sigParms
bits_len           = sigParms.bits_len;
prbs_mode          = sigParms.prbs_mode;
modFormat          = sigParms.modFormat;

% generate PRBS and modulated symbols
bitPerSymbol       = format2nBpB(modFormat);
syms_len           = floor(bits_len/bitPerSymbol);

bits               = gen_bits(prbs_mode,bits_len);
syms               = qamModu(bits,modFormat);

% save parameters and get output signal
sigParms.bitPerSymbol = bitPerSymbol;
sigParms.syms_len     = syms_len;

txSymsrc              = syms;
end