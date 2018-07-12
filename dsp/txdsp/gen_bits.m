function bits = gen_bits(prbs_mode,prbs_len,prbs_order,PNgenNum,stateIn)
% Description:
%     Generate bit signal
% 
% EXAMPLE:
%     bits = gen_bits(prbs_mode,prbs_len)
%     
% INPUT:
%     prbs_mode          - PRBS mode: rand or prbs
%     prbs_len           - length of PRBS stream
%     prbs_order         - PN order for PRBS mode
%     PNgenNum           - PN generator number for PBS mode, default to 1
%     stateIn            - input state
%     
% OUTPUT:
%     bits               - generated bits stream
%     
% Modifications:
% Version    Date        Author        Log.
% V1.0       20161001    H.B. Zhang    Create this script
% V1.1       20180413    H.B. Zhang    Add genPRBS m_sequence


% check inputs
if (nargin < 2)
    error('Please type ''help gen_bits'' for help and check its inputs.');
elseif (nargin < 3)
    prbs_order = 18;
    PNgenNum   = 1;
    stateIn    = randi([0,1],1,prbs_order);
elseif (nargin < 4)
    PNgenNum   = 1;
    stateIn    = randi([0,1],1,prbs_order);
elseif (nargin < 5)
    stateIn    = randi([0,1],1,prbs_order);
elseif (nargin > 5)
    error('TOO MANY inputs, please type ''help gen_bits'' for help and check its inputs.');
end

% generate prbs/nrz signal
switch lower(prbs_mode)
    case 'prbs'
        bits = genPRBS(prbs_order, prbs_len, PNgenNum,stateIn);
    case 'rand'
        bits = randi([0,1],prbs_len,1);
    otherwise
        error('Error(gen_bits.m): Un-supported PRBS mode!');
end

end