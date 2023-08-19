

%gm1
%gm2
%rf 
%rs
%cs

%TempAmp1=Amp2Noise(1, 1, 1, 1, 1, 1, 1, 1, 1);
rt=-rf*(1-1/(gm2*rf));
    
numerator1=[(-gm1*rt*rs*cs),(-gm1*rt)];
denominator1=[(rs*cs), (1+((gm1*rs)/2))];
sys1=tf(numerator1, denominator1);
sysgain1=dcgain(sys1);

numerator2=[(-gm1*rt*rs*cs)*1.5, (-gm1*rt)*1.5];
denominator2=[(rs*cs)*1.5, (1+((gm1*rs)/2))*1.5];
sys2=tf(numerator2, denominator2);
sysgain2=dcgain(sys2);

numerator3=[(-gm1*rt*rs*cs)*1.75,(-gm1*rt)*1.75];
denominator3=[(rs*cs)*1.75, (1+((gm1*rs)/2))*1.75];
sys3=tf(numerator3, denominator3);
sysgain3=dcgain(sys3);

cascadedAmplifiers=sys1*sys2*sys3;
t = 0:1/1e3:5;
y = chirp(t,0,2.5,50);
inputsize=size(y);

%noisemagnitude=sqrt(na+na2+na3);
%noisepower=(noisemagnitude^2)/0.50
%noisesamples=wgn(inputsize, 1, power2db(noisepower));
%sigtonr=snr(y, noisesamples);

%now add the gaussian noise
%noisysignal=awgn(y, sigtonr);





outputsig=lsim(cascadedAmplifiers,y,t);
%plot(outputsig);
eyediagram(outputsig, 15);









