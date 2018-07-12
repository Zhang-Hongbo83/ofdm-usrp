%% processing rx signal
fprintf('%s\n', '- start to process offline data ...');
rxSigSerial            = reshape(rxSigEff(:),[],segRxEff);
Nf                     = (size(rxSigSerial,1) - lenSync)/smplPerOFDM*segRxEff;
fprintf('%s%d\n', '- effective received ofdm symbol number is: #',Nf)

% drop sync
fprintf('%s\n', '- remove synchead ...');
rxSigTmp               = rxSigSerial(lenSync+1:end,:);
rxSigMat               = reshape(rxSigTmp,[],Nf);

% drop CP
fprintf('%s\n', '- remove cyclic prefix ...');
rxSigNoCP              = rxSigMat(GI+1:end,:);

% OFDM demodulate
rxSymbolTmp            = fft(rxSigNoCP,[],1);
rxSymbolTmp2           = circshift(rxSymbolTmp,Nsceff/2,1);
rxSymbolTmp3           = rxSymbolTmp2(1:Nsceff,:);
fprintf('%s\n', '- OFDM demodulation completed.');

% DHT decoding
if (isDHTON == 1)
    rxSymbol           = IDHartleyT(rxSymbolTmp3);
else
    rxSymbol           = rxSymbolTmp3;
end

% drop the 1st subcarrier
fprintf('%s\n', '- remove the 1st sub-carrier ...');
rxSymbolEff            = rxSymbol;
rxSymbolEff(Nsceff/2+1,:) = [];

% ideal channel equalization
ofdmEqualization;

% phase recovery
fprintf('%s\n', '- phase noise recoverying ...');
[rxSymbolRec,estPhase] = phaseNoiseComp_QPSK(rxSymbolEffEq);
% % for pi/4-QPSK
% rxSymbolRec            = rxSymbolRec*exp(-1j*pi/4);


figure(102);
plot(rxSymbolRec,'.');
grid on;