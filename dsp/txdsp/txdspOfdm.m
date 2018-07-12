function [vR,vP] = txdspOfdm(vP)
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
% V1.1       20180711    H.B. Zhang    Add DHT coding
% Ref:
%

% check system running mode
if (vP.sysMode == 3) % 1->simulation mode;2->offline txdsp;3->offline rxdsp
    vR = [];
    return;
end

% set output folder
load workRoot;
outputPath             = fullfile(workRoot,'output\');

% get parameters
glb                    = vP.glb;
modFormat              = glb.modFormat;
fBaud                  = glb.fBaud;
SPS                    = 1;        % samples for symbol for ZOH
Nbit                   = glb.Nbit;
Nsceff                 = glb.Nsceff;
Nf                     = glb.Nf;
Nfft                   = glb.Nfft;
CP                     = glb.CP;
Nb                     = glb.Nb;
isDHTON                = glb.isDHTON;

% generate bits and symbols
sigParms               = genQAMSrc(fBaud,SPS,Nbit,modFormat);
txSymbol               = reshape(sigParms.txSymSrc,Nsceff,Nf);  

% DHT coding
if (isDHTON == 1)
    txDHTCoding        = DHartleyT(txSymbol);
else
    txDHTCoding        = txSymbol;
end

txSigFDTmp             = zeros(Nfft,Nf);
txSigFDTmp(1:Nsceff,:) = txDHTCoding;
txSigFD                = circshift(txSigFDTmp,[-floor(Nsceff/2),0]);

% FFT for OFDM generate
txSigTDArray           = ifft(txSigFD,Nfft,1);

% Add cyclic prefix and generate transmitted time domian OFDM signal
txSigTDCP              = [txSigTDArray(Nfft*(1-CP)+1:end,:); txSigTDArray];
txSigTD                = txSigTDCP(:);

% PAPR Reduction
% paprReduce


% Add sync header
tx_re                  = real(txSigTD);
tx_im                  = imag(txSigTD);
% header location needs to follow below parameters
syncPRBS               = load('PRBS7.txt');
synchead               = kron(syncPRBS,ones(Nb,1));
synchead               = [synchead; synchead];

real_tx_signal         = [synchead*max(abs(tx_re))/2; tx_re];
imag_tx_signal         = [synchead*max(abs(tx_im))/2; tx_im];
txSig                  = complex(real_tx_signal, imag_tx_signal);

% collect parameters and output
vR.sigParms            = sigParms;
vR.txSymbol            = txSymbol;
vR.txSigTD             = txSigTD;
vR.txSig               = txSig;
vR.synchead            = synchead;

% save offline data
if (vP.sysMode == 2) % offline txdsp
    % save txt file
    save(fullfile(outputPath,'real_tx_signal.txt'),'real_tx_signal','-ascii');
    save(fullfile(outputPath,'imag_tx_signal.txt'),'imag_tx_signal','-ascii');
    % save mat file
    oflTxData.vR       = vR;
    oflTxData.vP       = vP;
    save(fullfile(outputPath,strcat('oflTxData_DHT',num2str(isDHTON),'.mat')),'oflTxData');
    fprintf('%s:\n','- offline txdsp data is saved in');
    fprintf('%s.\n',outputPath);
end

end