% Description:
%     Print System information for USRP-based Vehical OFDM Communication Systems.
%  
% Copyright, 2018, H.B. Zhang, <hongbo.zhang83@gmail.com>
% 
% Modifications:
% Version    Date        Author        Log.
% V1.0       20180626    H.B. Zhang    Create this script
fprintf('%s : %s\n','- System running mode is',vP.sysModeStr);
fprintf('%s\n','**********************************************************************');
fprintf('%s\n','          USRP-based Vehical OFDM Simulation Platform');
fprintf('%30s : %s %s\n','     Matlab Platform Version', vP.verInfo.projName, vP.verInfo.verNo);
fprintf('%30s : %s\n', 'Released on', vP.verInfo.date);
fprintf('%30s : %s\n', 'Released by', vP.verInfo.author);
fprintf('%30s : %s\n', 'Contact Email Address', vP.verInfo.email);
fprintf('%s\n','**********************************************************************');

fprintf('%s\n', 'Simulation parameters:')
fprintf('%s\n', '-------------------------------------------')
fprintf('%20s : %s\n', 'Modulation Format', vP.glb.modFormat);
fprintf('%20s : %d\n', 'Modulation Index', vP.glb.bitsPerSymbol);
fprintf('%20s : %.2f%s\n', 'DAC Sample Rate', vP.glb.fDAC, ' MSa/s NOTE: in real word, fDAC is constent, while fBaud is changing');
fprintf('%20s : %.2f%s\n', 'BaudRate', vP.glb.fBaud, ' MBaud');
fprintf('%20s : %.2f Mbps\n', 'BitRate', vP.glb.bitrate);
fprintf('%20s : %d\n', 'SubCarriers', vP.glb.Nsc);
fprintf('%20s : %d\n', 'Eff. SubCarriers', vP.glb.Nsceff);
fprintf('%20s : %d\n', 'Over Sampler', vP.glb.Nb);
fprintf('%20s : %d\n', 'FFT-Points', vP.glb.Nfft);
fprintf('%20s : %d\n', 'Total OFDM Symbols', vP.glb.Nf);
fprintf('%20s : %d\n', 'Total Symbols', vP.glb.Nsym);
fprintf('%20s : %d\n', 'Total Bits', vP.glb.Nbit);
fprintf('%20s : %.2f\n', 'CP Ratio', vP.glb.CP);
fprintf('%20s : %d\n', 'Equalization ON/OFF', vP.glb.isEqualization);
fprintf('%20s : %d\n', 'DHT precoding ON/OFF', vP.glb.isDHTON);
fprintf('%s\n', '-------------------------------------------')

fprintf('%s\n', 'Simulation Begin ...')
