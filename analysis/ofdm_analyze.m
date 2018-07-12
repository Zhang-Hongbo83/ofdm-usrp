% plot tx signal
lenTxSig               = length(tx_sig);
Nf                     = (lenTxSig - lenSync)/smplPerOFDM;

% drop sync
txSigTmp               = tx_sig(lenSync+1:end);
txSig                  = reshape(txSigTmp,[],Nf);
% drop CP
txSigNoCP              = txSig(GI+1:end,:);

% OFDM demodulate
txSymbolTmp            = fft(txSigNoCP,[],1);
txSymbolTmp2           = circshift(txSymbolTmp,symbols_per_carrier/2,1);
txSymbol               = txSymbolTmp2(1:symbols_per_carrier,:);

% drop 1st subcarrier
txSymbolEff            = txSymbol;
txSymbolEff(symbols_per_carrier/2+1,:) = [];

figure(101);
plot(txSymbolEff,'.')
% plot(abs(txSymbolEff(:,1)))