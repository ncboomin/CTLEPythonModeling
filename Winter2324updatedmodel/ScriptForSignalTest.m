% Define the swept-band parameters
t = 0:0.01:10;     % Time vector
f0 = 1;            % Initial frequency
t1 = 10;           % End time
f1 = 10;           % Final frequency
numFreqs = 10;     % Number of frequencies in the swept-band

% Generate the swept-band signals
frequencies = linspace(f0, f1, numFreqs);   % Frequency range
signals = zeros(length(t), numFreqs);      % Matrix to store the signals


for i = 1:numFreqs
    signals(:, i) = chirp(t, f0, t1, frequencies(i));
end




for i = 1:numFreqs
    curSig=signals(:, i);
    curPowerBW=powerbw(curSig);
    amp1=Amp1Noise(0.008, 0.006, 0.5, 3000, 50, 12, 3, 300, curPowerBW);
    sysamp1num1=amp1.gettransferfunction();
    amp2=Amp2Noise(0.008, 0.006, 0.5, 3000, 50, 12, 3, 300, curPowerBW, sysamp1num1);
    sys2amp1num1=amp2.gettransferfunction();
    amp3=Amp3Noise(0.008, 0.006, 0.5, 3000, 50, 12, 3, 300, curPowerBW, sysamp1num1, sys2amp1num1);
    sys3amp1num1=amp3.gettransferfunction();
    cascadedsystem=sysamp1num1*sys2amp1num1*sys3amp1num1;
    NOISE = (sqrt(amp1.returnnoise()+amp2.returnnoise()+amp3.returnnoise()));
    randomsignal = randn(size(signals(:,1)))*std(signals(:,1))/db2mag(NOISE);
    cursnr=snr(signals(:, i), randomsignal);
    curnoisysignal=awgn(signals(:, i), cursnr);
    outputs(:, i) = lsim(cascadedsystem,curnoisysignal, t);
    

end
% Plot the output of all signals within the swept-band
figure;
hold on;
for i = 1:numFreqs
    plot(t, outputs(:, i));
end
hold off;
xlabel('Time');
ylabel('Output Signal');
title('Response of the System for Swept-Band Signals');

% Generate the eye diagram for a specific signal
signalIndex = 10;          % Index of the signal to generate the eye diagram
numsamples = 4;         % Number of samples per trace
%plot(t, outputs(:, signalIndex));
modulatedsignal=fmmod(outputs(:, signalIndex), f1, 2*f1, 1);
%plot(t, modulatedsignal);
eyediagram(modulatedsignal, numsamples);

%eyediagram(outputs(:, i), 100);
%modSig = pskmod(signals(:, signalIndex),4,pi/4);
xlabel('Time');
ylabel('Amplitude');
title('Eye Diagram of a Swept-Band Signal');


