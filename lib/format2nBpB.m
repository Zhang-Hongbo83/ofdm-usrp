function nBPB = format2nBpB(modFormat)
% Description:
%     MFUNTMPL General MATLAB M-Function Template
%
% EXAMPLE:
%
%
% INPUT:
%     modFormat    - Modulation format
%
% OUTPUT:
%     nBPB         - Bits num per Symbol
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20151024    H.B. Zhang    Create this script
% V1.1       20160824    H.B. Zhang    Add NRZ format
% V1.2       20170629    H.B. Zhang    Add DBPSK/DQPSK/128QAM/256QAM,
%                                      support format array
% V1.1       20171123    H.B. Zhang    Add EDB/ODB format
% Ref:
%

modFormat = upper(modFormat);

if iscell(modFormat)
    numFormat = length(modFormat);
else
    numFormat = 1;
end
nBPB      = zeros(numFormat,1);

for iFormat=1:numFormat
    if iscell(modFormat)
        iModFormat = modFormat{iFormat};
    else
        iModFormat = modFormat;
    end
    
    switch iModFormat
        case {'BPSK','NRZ','DBPSK','EDB','ODB'}
            nBPB(iFormat) = 1;
        case {'QPSK','4QAM','PAM4','DQPSK'}
            nBPB(iFormat) = 2;
        case {'8QAM','PAM8'}
            nBPB(iFormat) = 3;
        case '16QAM'
            nBPB(iFormat) = 4;
        case '32QAM'
            nBPB(iFormat) = 5;
        case '64QAM'
            nBPB(iFormat) = 6;
        case '128QAM'
            nBPB(iFormat) = 7;
        case '256QAM'
            nBPB(iFormat) = 8;
        otherwise
            error('Un-supported modulation format');
    end
end

end