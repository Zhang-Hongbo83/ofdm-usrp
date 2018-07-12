%% processing ideal tx signal
lenTxSig               = length(txSig);
Nf                     = (lenTxSig - lenSync)/smplPerOFDM;

% drop sync
txSigTmp               = txSig(lenSync+1:end);
txSigMat               = reshape(txSigTmp,[],Nf);
% drop CP
txSigNoCP              = txSigMat(GI+1:end,:);

% OFDM demodulate
txSymbolTmp            = fft(txSigNoCP,[],1);
txSymbolTmp2           = circshift(txSymbolTmp,[floor(Nsceff/2),0]);
txSymbolTmp3           = txSymbolTmp2(1:Nsceff,:);

% DHT decoding
if (isDHTON == 1)
    txSymbol           = IDHartleyT(txSymbolTmp3);
else
    txSymbol           = txSymbolTmp3;
end

% drop 1st subcarrier
txSymbolEff            = txSymbol;
txSymbolEff(Nsceff/2+1,:) = [];

% figure(101);
% plot(txSymbolEff,'.');
fprintf('%s\n', '- Tx signal have been pre-processed.')