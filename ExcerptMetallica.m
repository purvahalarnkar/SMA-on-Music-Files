clc
close all
clear all

[y,Fs]=audioread('ExcerptMetallica.wav');
N=input('Enter order of filter: ');
a=(1);
b=ones(1,N)/N;
yf=filter(b,a,y);

%pole zero plot
figure(1)
zplane(b,a)
title('Pole Zero plot: Moving average filter')

%impulse response of filter
figure(2)
impz(b,a);
grid on

%frequency resonse of filter
figure(3)
freqz(b,1)
title('Frequency Response')
grid on

fT=1/Fs;
afT=0:fT:(length(y)-1)*fT;

%original left channel
left_o=y(:,1);
figure(4)
subplot(4,2,1)
plot(afT,left_o,'r')
grid on 
xlabel('Time [s]')
ylabel('Amplitude')
title('Original Left Channel')

%original right channel
right_o=y(:,2);
subplot(4,2,2)
plot(afT,right_o,'r')
grid on
xlabel('Time [s]')
ylabel('Amplitude')
title('Original Right Channel')

afT=0:fT:(length(yf)-1)*fT;

%processed left channel
left_p=yf(:,1);
subplot(4,2,3)
plot(afT,left_p,'b')
grid on
xlabel('Time [s]')
ylabel('Amplitude')
title('Processed Left Channel')

%processed right channel
right_p=yf(:,2);
subplot(4,2,4)
plot(afT,right_p,'b')
grid on
xlabel('Time [s]')
ylabel('Amplitude')
title('Processed Right Channel')

%original left channel spectrum
f_left_o=Fs/length(left_o);
af_left_o=0:f_left_o:(length(y)*f_left_o)-f_left_o;
subplot(4,2,5)
semilogx(af_left_o, 20*log10(abs(fft(left_o))),'r')
grid on
axis([10e0 10e3 -100 100])
title('Original Left Channel Spectrum')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

%original right channel spectrum
f_right_o=Fs/length(right_o);
af_right_o=0:f_right_o:(length(y)*f_right_o)-f_right_o;
subplot(4,2,6)
semilogx(af_right_o, 20*log10(abs(fft(right_o))),'r')
grid on
axis([10e0 10e3 -100 100])
title('Original Right Channel Spectrum')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

%processed left channel spectrum
f_left_p=Fs/length(left_p);
af_left_p=0:f_left_p:(length(yf)*f_left_p)-f_left_p;
subplot(4,2,7)
semilogx(af_left_p, 20*log10(abs(fft(left_p))),'b')
grid on
axis([10e0 10e3 -100 100])
title('Processed Left Channel Spectrum')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

%processed right channel spectrum
f_right_p=Fs/length(right_p);
af_right_p=0:f_right_p:(length(yf)*f_right_p)-f_right_p;
subplot(4,2,8)
semilogx(af_right_p, 20*log10(abs(fft(right_p))),'b')
grid on
axis([10e0 10e3 -100 100])
title('Processed Right Channel Spectrum')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

soundsc(y,Fs)
pause(32)
soundsc(yf,Fs)