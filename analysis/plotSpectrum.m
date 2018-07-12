function [h_plt,freq_in_Hz,amp_in_dB] = plotSpectrum(signal,nfft,fs,lineType)
% Description:
%     plot signal response
%
% EXAMPLE:
%     [h_plt,freq_in_Hz,amp_in_dB] = plotSigResp(signal,nfft,fs,lineType)
%
% INPUT:
%     signal             - input signal
%     Npt                - Point number of FFT
%     fs                 - sample rate
%     lineType           - plotting line type: 'r-','*-'
%
% OUTPUT:
%
% Modifications:
% Version    Date        Author        Log.
% V1.0       20170703    H.B. Zhang    Create this script

if (nargin < 4)
    lineType = 'b-';
end
lineSize                = 1;

figName                = 'Spectrum';
fig_spec_h             = findobj('Name',figName);
close(fig_spec_h);

figure('Name',figName,'NumberTitle','OFF');
fd                     = fftshift(fft(signal,nfft)/nfft);
amp_in_dB              = 20*log10(abs(fd));
freq_in_Hz             = (0:nfft-1)*fs/nfft-fs/2;
P_pos                  = amp_in_dB(floor(length(freq_in_Hz)/2):end);
f_pos                  = freq_in_Hz(floor(length(freq_in_Hz)/2):end);

h_plt                  = plot(f_pos, P_pos, lineType, 'LineWidth', lineSize);
xlabel('Hz')
ylabel('Power (dBm)')
xlim([f_pos(1) f_pos(end)]);
end