classdef Amp2Noise
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
    end
    methods
        function r = makeNoise(gm1, gm2, gamma, K, temp, dcgain, bandwidth, atas, rf)
            part1=(32*K*temp*gamma)/(gm1);
            part2=((32*K*temp*gamma)/(gm2)/(atas^2));
            part3=bandwidth;
            part4=(4*K*temp*rf)/(atas^2);
            noise=((part1+part2)*part3)+part4;
            r=noise/(dcgain^2);
        end
    end
end


