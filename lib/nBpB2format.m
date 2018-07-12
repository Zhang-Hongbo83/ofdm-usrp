function modFormat = nBpB2format(nBPB)
% Description:
%    translate nBPB to modulation format
%
% EXAMPLE:
%
%
% INPUT:
%     nBPB         - Bits num per Symbol
%
% OUTPUT:
%     modFormat    - Modulation format
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20170629    H.B. Zhang    Create this script
% Ref:
%

if iscell(nBPB)
    numBpB = length(nBPB);
else
    numBpB = 1;
end
modFormat  = cell(numBpB,1);

for i = 1:numBpB
    if iscell(nBPB)
        iBpB = nBPB{i};
    else
        iBpB = nBPB;
    end
    
    switch iBpB
        case 0
            modFormat{i} = [];
        case 1
            modFormat{i} = 'DBPSK';
        case 2
            modFormat{i} = 'DQPSK';
        case 4
            modFormat{i} = '16QAM';
        case 5
            modFormat{i} = '32QAM';
        case 6
            modFormat{i} = '64QAM';
        case 7
            modFormat{i} = '128QAM';
        case 8
            modFormat{i} = '256QAM';
        otherwise
            error('Un-supported modulation format');
    end
end

end