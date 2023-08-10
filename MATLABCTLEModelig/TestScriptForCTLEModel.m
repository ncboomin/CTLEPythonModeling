%transfer function info
num1=[(gm1*rd1*rs1*cs1),(gm1*rd1)];
den1=[(rs1*cs1),(1+(gm1*rs1)/2)];
sys1=tf(num1, den1);
num2=[(gm2*rd2*rs2*cs2),(gm2*rd2)];
den2=[(rs2*cs2),(1+(gm2*rs2)/2)];
sys2=tf(num2, den2);
cascadedsys=sys1*sys2*sys2*sys2*sys2;
%output signal
outputsignal=lsim(cascadedsys, inputsig, t);
%info/analytics for input signal
inputquantization=range/(2^n-1);
inputconversion=fix(inputsig/inputquantization);
inputyd=dec2bin(inputconversion,n);
inputyq=inputconversion*quantization;
%info/analytics for output signal
outputquantization=range/(2^n-1);
outputconversion=fix(outputsig/outputquantization);
outputyd=dec2bin(outputconversion,n);
outputyq=outputconversion*quantization;

