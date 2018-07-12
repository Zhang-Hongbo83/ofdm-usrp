% check system running mode
if (vP.sysMode == 2) % 1->simulation mode;2->offline txdsp;3->offline rxdsp
    vR = [];
    return;
end

% load value and parameters
txSymbolEff            = vR.txSymbolEff;
rxSymbolRec            = vR.rxSymbolRec;
segRxEff               = vR.segRxEff;

txSymbolEffRep         = repmat(txSymbolEff,1,segRxEff);

% calc EVM/Q-dB
fprintf('%s\n', '- start to calc Q-factor in dB ...');
evmValue               = rms(txSymbolEffRep(:)-rxSymbolRec(:))/rms(txSymbolEffRep(:));
QdB                    = 20*log10(1/evmValue);
fprintf('%s%.4f\n', '- EVM value in linear is: ', evmValue);
fprintf('%s%.2f%s\n', '- Q-factor in dB is: ', QdB, 'dB');

% calc BER
fprintf('%s\n', '- start to calc bit error rate ...');

% slicer
txSymbolSlc            = slicer(txSymbolEffRep,modFormat);
rxSymbolSlc            = slicer(rxSymbolRec,modFormat);

% de-mapping symbols
[txQamSyms,txbitsSeg]  = qamDeModu(txSymbolSlc,modFormat);
[rxQamSyms,rxbits]     = qamDeModu(rxSymbolSlc,modFormat);
txbits                 = txbitsSeg; % repmat(txbitsSeg,segRxEff,1);

% calc ber
bitLen                 = length(rxbits);
errNum                 = sum(txbits ~= rxbits);
ber                    = errNum/bitLen;

% print results
fprintf('%s%d\n','- Total bit is: ',bitLen);
fprintf('%s%d\n','- Total error bit is: ',errNum);
fprintf('%s%.2e\n','- Total ber is: ',ber);
fprintf('%s\n', '- offline data processing completed.');
