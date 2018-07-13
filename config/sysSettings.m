% Description:
%     Global configuration for USRP-based OFDM.
%  
% Parameter description
%     sysMode            - 0: system error, stop running program
%                        - 1: simulation mode
%                        - 2: offline mode: txdsp
%                        - 3: offline mode: rxdsp
% 
% Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
% 
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180626    H.B. Zhang    Create this script

%% System running mode setting: Simulation or Offline
vP                     = checkSysMode(vP);

%% =============== Global Parameters ===============
dataUnit               = 1e6;                          % Mega
isEqualization         = caseList(caseNum).isEqualization;
isDHTON                = caseList(caseNum).isDHTON;
fBaud                  = caseList(caseNum).fBaud;      % Baud Rate
modFormat              = caseList(caseNum).modFormat;
Nsc                    = caseList(caseNum).Nsc;
Nsceff                 = caseList(caseNum).Nsceff;
Nb                     = caseList(caseNum).Nb;         % SPS
Nfft                   = Nsc*Nb;
Nf                     = caseList(caseNum).Nf;         % number of OFDM symbol
CP                     = caseList(caseNum).CP;         % cyclic prefix ratio
SNR                    = caseList(caseNum).SNR;        
bitsPerSymbol          = format2nBpB(modFormat);
bitrate                = fBaud*bitsPerSymbol;
Nsym                   = Nsceff*Nf;
Nbit                   = Nsym*bitsPerSymbol;
fDAC                   = Nfft/Nsceff*fBaud;               % NOTE: here fDAC is variable

%% collection all parameters
glb.dataUnit           = dataUnit;
glb.isEqualization     = isEqualization;
glb.isDHTON            = isDHTON;
glb.fBaud              = fBaud;
glb.modFormat          = modFormat;
glb.Nsc                = Nsc;
glb.Nsceff             = Nsceff;
glb.Nfft               = Nfft;
glb.Nb                 = Nb;
glb.Nf                 = Nf;
glb.CP                 = CP;
glb.SNR                = SNR;
glb.bitsPerSymbol      = bitsPerSymbol;
glb.bitrate            = bitrate;
glb.Nsym               = Nsym;
glb.Nbit               = Nbit;
glb.fDAC               = fDAC;
vP.glb                 = glb;


%% =============== TxDSP Parameters ===============
           

% TxDSP RRC filter parameters


%% ============== Channel Parameters ==============


%% =============== RxDSP Parameters ===============


%% ============== Pre-set File Names ==============
% set results and logs file names
load workRoot.mat;
if (vP.sysMode ~= 1)   % caseNum=0 -> offline
    caseNum = 0; 
end
fileHeader             = sprintf('%s%d%s%s%s%s%s%s%s%s%s','_case_',caseNum,'_OFDM_',vP.sysModeStr,'_DHT',num2str(vP.glb.isDHTON),...
                          '_Equa',num2str(vP.glb.isEqualization),'_',datestr(now,'yyyymmddTHHMMSS'),'.txt');
logFileName            = sprintf('%s%s','logs',fileHeader);
resultFileName         = sprintf('%s%s','results',fileHeader);
diary(fullfile(workRoot,'logs',logFileName));