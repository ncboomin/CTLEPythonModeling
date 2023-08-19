classdef Amp1Noise
    properties 
        gm1;
        gm2;
        gamma;
        K;
        temp;
        dcgain;
        bandwidth;
        atas;
        rf;
        noise;
    end
    methods
        function r = Amp1Noise(gm1, gm2, gamma, K, temp, dcgain, bandwidth, atas, rf)
            part1=((32*K*temp*gamma)/(gm1));
            part2=((32*K*temp*gamma)/(gm2)/(atas^2));
            part3=bandwidth;
            part4=(4*K*temp*rf)/(atas^2);
            noise=((part1+part2)*part3)+part4;
            r=Amp1Noise;
        end
        function getNoise = returnnoise(noise)
               getNoise=noise;
        end
    end
end


