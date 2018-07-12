function sigParms = genQAMSrc(fBaud,SPS,bits_len,modFormat)
% Description:
%     generate QPSM or M-QAM signal. Default output QPSK signal
%
% EXAMPLE:
%     sigParms = genPAMSrc(fBaud,SPS,bits_len,modFormat)
%
% INPUT:
%     bits_len     - Bit stream length of input signal
%     modFormat    - modulation format: QPSK,4/16/32/64/128/256QAM
%
% OUTPUT:
%     sigParms     - output generated signal information
%
%  Copyright, 2017, H.B. Zhang, <hongbo.zhang83@gmail.com>
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20171123    H.B. Zhang    Create this script

% check input
if (nargin <= 0)
    fBaud           = 56e9;                % Baud Rate
    SPS             = 2;                   % xSPS oversample
    bits_len        = 2^12;
    modFormat       = 'QPSK';
elseif (nargin <= 1)
    SPS             = 2;                   % xSPS oversample
    bits_len        = 2^12;
    modFormat       = 'QPSK';
elseif (nargin <= 2)
    bits_len        = 2^12;
    modFormat       = 'QPSK';
elseif (nargin <= 3)
    modFormat       = 'QPSK';
elseif (nargin == 4)
    % do nothing
else
    error('Error(genQAMSrc.m): check the inputs!');
end

%% Configuration
% set signal parameters
prbs_mode           = 'rand';
sigParms.bits_len   = bits_len;
sigParms.prbs_mode  = prbs_mode;
sigParms.modFormat  = modFormat;

% set system parameters
smplRate            = fBaud*SPS;           % signal sample rate
sigParms.fBaud      = fBaud;
sigParms.SPS        = SPS;
sigParms.smplRate   = smplRate;

%% TxDSP
% generate symbols
[txSymSrc,sigParms] = genSymSrc(sigParms);
sigParms.txSymSrc   = txSymSrc;

% oversample
osMode                 = 1;
switch osMode
    case 1    % ZOH
        txSig = reshape(ones(SPS,1)*txSymSrc(:).',length(txSymSrc)*SPS,1);
    case 2    % ZeroInsertion
        txSig = reshape([txSymSrc(:).';zeros(SPS-1,length(txSymSrc))],length(txSymSrc)*SPS,1)*SPS;
    case 3    % brickwall, frequency domain
        txSig = reSample(txSymSrc,fBaud,smplRate);
    otherwise
        error('Error(genPAMSrc.m):do not support oversample mode!');
end

sigParms.txSig      = txSig;

% devices bandwith effect by bessel filter
fltFlag             = 0;
if (fltFlag == 1)
    order           = 5;
    BW              = 0.75*fBaud;
    [txSig, ~]      = filter_bessel(txSig,smplRate,BW,order);
end
    
% plot signal eye-diagram: 4 eyes
pltFlag             = 0;
if (pltFlag == 1)
    segNum              = 100;
    eyeNum              = 4;
    eyediagram(real(txSig(1:segNum*eyeNum*SPS)),eyeNum*SPS,eyeNum*1/smplRate);
else
    % do nothing
end
end