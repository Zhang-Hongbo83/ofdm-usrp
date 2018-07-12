% OFDM channel estimation and equalization
if (isEqualization == 1)
    fprintf('%s\n', '- start ideal channel equalization ...');
    [rowTmp, colTemp]      = size(txSymbolEff);
    
    CR                     = zeros(rowTmp,segRxEff);
    for iSegRxEff = 1:segRxEff
        colSegTemp         = (1:colTemp) + (iSegRxEff-1)*colTemp;
        CR(:,iSegRxEff)    = mean(rxSymbolEff(1:rowTmp,colSegTemp)./txSymbolEff,2);
    end
    
    CRMat                  = kron(conj(CR)./abs(CR).^2,ones(1,colTemp));
    rxSymbolEffEq          = rxSymbolEff.*CRMat;
    % clear rowTmp colTemp colSegTemp;
else
    rxSymbolEffEq          = rxSymbolEff;
end