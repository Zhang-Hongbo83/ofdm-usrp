function slcValue = slicer(sigIn,modFormat)
% Description:
%     SLICER Hard slicer
% 
% EXAMPLE:
%     slcValue = slicer(sigIn,modFormat)
%     
% INPUT:
%     sigIn        - Input signal
%     modFormat    - Modulation format
%     
% OUTPUT:
%     slcValue       - Output value of hard slicer
%     
% Modifications:
% Version    Date        Author        Log.
% V1.0       20151023    H.B. Zhang    Create this script
% V1.1       20170703    H.B. Zhang    Add Higher order QAM
% 
% Ref:
%     

if iscell(modFormat)
    modFormat = char(modFormat);
end

sigIn_I    = real(sigIn);
sigIn_Q    = imag(sigIn);

modFormat = upper(modFormat);
switch modFormat
    case {'BPSK','NRZ'}
        slcValue_I = -(sigIn<0) + (sigIn>=0);
        slcValue_Q = sigIn_Q;
    case {'DBPSK'}
        slcValue_I = -(sigIn<0) + (sigIn>=0);
        slcValue_Q = sigIn_Q;
    case {'DQPSK','QPSK'}
        sigIn      = sigIn*exp(1j*pi/4)*sqrt(2);
        sigIn_I    = real(sigIn);
        sigIn_Q    = imag(sigIn);
        slcValue_I = -(sigIn_I<0) + (sigIn_I>=0);
        slcValue_Q = -(sigIn_Q<0) + (sigIn_Q>=0);
        sigSlc     = slcValue_I + 1j*slcValue_Q;
        sigSlcRot  = sigSlc*exp(-1j*pi/4)/sqrt(2);
        slcValue_I = real(sigSlcRot);
        slcValue_Q = imag(sigSlcRot);       
    case '4QAM'
        slcValue_I = -(sigIn_I<0) + (sigIn_I>=0);
        slcValue_Q = -(sigIn_Q<0) + (sigIn_Q>=0);
    case {'16QAM','PAM4'}
        slcValue_I = -3*(sigIn_I<-2) - (sigIn_I>=-2&sigIn_I<0) + (sigIn>=0&sigIn<2) + 3*(sigIn>=2);
        slcValue_Q = -3*(sigIn_Q<-2) - (sigIn_Q>=-2&sigIn_Q<0) + (sigIn_Q>=0&sigIn_Q<2) + 3*(sigIn_Q>=2);
    case {'32QAM'}
        slcValue_I = -5*(sigIn_I<-4) - 3*(sigIn_I>=-4&sigIn_I<-2) - 1*(sigIn_I>=-2&sigIn_I<0) ...
            + 1*(sigIn_I>=0&sigIn_I<2) + 3*(sigIn_I>=2&sigIn_I<4)+ 5*(sigIn_I>=4);
        slcValue_Q = -5*(sigIn_Q<-4) - 3*(sigIn_Q>=-4&sigIn_Q<-2) - 1*(sigIn_Q>=-2&sigIn_Q<0) ...
            + 1*(sigIn_Q>=0&sigIn_Q<2) + 3*(sigIn_Q>=2&sigIn_Q<4)+ 5*(sigIn_Q>=4);
    case {'64QAM'}
        slcValue_I = -7*(sigIn_I<-6) -5*(sigIn_I>=-6&sigIn_I<-4) - 3*(sigIn_I>=-4&sigIn_I<-2) - 1*(sigIn_I>=-2&sigIn_I<0) ...
            + 1*(sigIn_I>=0&sigIn_I<2) + 3*(sigIn_I>=2&sigIn_I<4)+ 5*(sigIn_I>=4&sigIn_I<6) + 7*(sigIn_I>=6);
        slcValue_Q = -7*(sigIn_Q<-6) -5*(sigIn_Q>=-6&sigIn_Q<-4) - 3*(sigIn_Q>=-4&sigIn_Q<-2) - 1*(sigIn_Q>=-2&sigIn_Q<0) ...
            + 1*(sigIn_Q>=0&sigIn_Q<2) + 3*(sigIn_Q>=2&sigIn_Q<4)+ 5*(sigIn_Q>=4&sigIn_Q<6) + 7*(sigIn_Q>=6);
    case {'128QAM'}
        slcValue_I = -11*(sigIn_I<-10) -9*(sigIn_I>=-10&sigIn_I<-8)-7*(sigIn_I>=-8&sigIn_I<-6) -5*(sigIn_I>=-6&sigIn_I<-4) - 3*(sigIn_I>=-4&sigIn_I<-2) - 1*(sigIn_I>=-2&sigIn_I<0) ...
            + 1*(sigIn_I>=0&sigIn_I<2) + 3*(sigIn_I>=2&sigIn_I<4)+ 5*(sigIn_I>=4&sigIn_I<6) + 7*(sigIn_I>=6&sigIn_I<8) + 9*(sigIn_I>=8&sigIn_I<10) + 11*(sigIn_I>=10);
        slcValue_Q = -11*(sigIn_Q<-10) -9*(sigIn_Q>=-10&sigIn_Q<-8)-7*(sigIn_Q>=-8&sigIn_Q<-6) -5*(sigIn_Q>=-6&sigIn_Q<-4) - 3*(sigIn_Q>=-4&sigIn_Q<-2) - 1*(sigIn_Q>=-2&sigIn_Q<0) ...
            + 1*(sigIn_Q>=0&sigIn_Q<2) + 3*(sigIn_Q>=2&sigIn_Q<4)+ 5*(sigIn_Q>=4&sigIn_Q<6) + 7*(sigIn_Q>=6&sigIn_Q<8) + 9*(sigIn_Q>=8&sigIn_Q<10) + 11*(sigIn_Q>=10);
    case {'256QAM'}
        slcValue_I = -15*(sigIn_I<-14) -13*(sigIn_I>=-14&sigIn_I<-12) -11*(sigIn_I>=-12&sigIn_I<-10) -9*(sigIn_I>=-10&sigIn_I<-8)-7*(sigIn_I>=-8&sigIn_I<-6) -5*(sigIn_I>=-6&sigIn_I<-4) - 3*(sigIn_I>=-4&sigIn_I<-2) - 1*(sigIn_I>=-2&sigIn_I<0) ...
            + 1*(sigIn_I>=0&sigIn_I<2) + 3*(sigIn_I>=2&sigIn_I<4)+ 5*(sigIn_I>=4&sigIn_I<6) + 7*(sigIn_I>=6&sigIn_I<8) + 9*(sigIn_I>=8&sigIn_I<10) + 11*(sigIn_I>=10&sigIn_I<12) + 13*(sigIn_I>=12&sigIn_I<14) + 15*(sigIn_I>=14);
        slcValue_Q = -15*(sigIn_Q<-14) -13*(sigIn_Q>=-14&sigIn_Q<-12) -11*(sigIn_Q>=-12&sigIn_Q<-10) -9*(sigIn_Q>=-10&sigIn_Q<-8)-7*(sigIn_Q>=-8&sigIn_Q<-6) -5*(sigIn_Q>=-6&sigIn_Q<-4) - 3*(sigIn_Q>=-4&sigIn_Q<-2) - 1*(sigIn_Q>=-2&sigIn_Q<0) ...
            + 1*(sigIn_Q>=0&sigIn_Q<2) + 3*(sigIn_Q>=2&sigIn_Q<4)+ 5*(sigIn_Q>=4&sigIn_Q<6) + 7*(sigIn_Q>=6&sigIn_Q<8) + 9*(sigIn_Q>=8&sigIn_Q<10) + 11*(sigIn_Q>=10&sigIn_Q<12) + 13*(sigIn_Q>=12&sigIn_Q<14) + 15*(sigIn_Q>=14);
    otherwise
        error('Un-supported modulation format');
end

slcValue   = complex(slcValue_I,slcValue_Q);

if isreal(sigIn)
    slcValue = real(slcValue);
else
    % do nothing
end

end