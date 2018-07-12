% find frame sync
fprintf('%s\n', '- start to find framer ...');
synchead               = txSig(1:lenSync);
synLen                 = lenTx + lenSync;

% real part sync
rxSigRe                = real(rxSig(1:synLen));
syncSeqRe              = real(synchead);
[~,tauRe]              = syncFrame(rxSigRe,syncSeqRe);
segRxEff               = floor( (lenRx-tauRe)/lenTx);
lenRxEff               = lenTx*segRxEff;
rxSigEffRe             = real(rxSig(tauRe+(1:lenRxEff)));
rxSigEffRe             = rxSigEffRe/rms(rxSigEffRe)*rmsTxRe;
fprintf('%s%d\n', '- framer index of Inphase at: No. #',tauRe);

% imag part sync
rxSigIm                = imag(rxSig(1:synLen));
syncSeqIm              = imag(synchead);
[~,tauIm]              = syncFrame(rxSigIm,syncSeqIm);
rxSigEffIm             = imag(rxSig(tauIm+(1:lenRxEff)));
rxSigEffIm             = rxSigEffIm/rms(rxSigEffIm)*rmsTxIm;
fprintf('%s%d\n', '- framer index of Quadrature at: No. #',tauIm);

% get effective rx signal for OFDM demodulation
rxSigEff               = complex(rxSigEffRe, rxSigEffIm);
fprintf('%s\n', '- effective offline rx signal is ready.');