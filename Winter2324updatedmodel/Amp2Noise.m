classdef Amp2Noise
    properties 
        noise;
        transferfunction;
    end
    methods 
        function r = Amp2Noise(gm1, gm2, cs, rs, K, temp, gamma, rf, inputsignalbw, firststagetf)
              %%transfer function creation
             rt=-rf*(1-(1/(gm2*rf)));
            num = [(-gm1*rt*rs*cs), (-gm1*rt)];
            den = [(rs*cs), (1+(gm1*rs/2))];
            fb = dcgain(firststagetf);
            r.transferfunction=tf(num, den);
            part1=(32*K*temp*gamma)/(gm1);
            part2=((32*K*temp*gamma)/(gm2))/((getPeakGain(r.transferfunction))^2);
            sumofpart1part2 = part1+part2;
            sumtimesbw= sumofpart1part2*inputsignalbw;
            lastpart=(4*K*temp*rf)/((getPeakGain(r.transferfunction))^2);
            totalsum = sumtimesbw+lastpart;
            r.noise=(totalsum)/(fb^2);
            %%above is the noise creation, below will be the transfer
          
        end
        function getNoise = returnnoise(r)
               getNoise=r.noise;
        end 
        function getTF = gettransferfunction(r)
            getTF = r.transferfunction;
        end
    end
end