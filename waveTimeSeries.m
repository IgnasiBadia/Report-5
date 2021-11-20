function [A, eta_time,u,dudt] = waveTimeSeries(f, t, data) 
   global wave
    Hs = wave.Hs; 
    Tp = wave.Tp;
    data.zBot = -data.zBot; 
    gammaJS = wave.gamma;
    fp = 1/Tp;  
    df = f(2) - f(1);
%% Jonswap
    for i = 1:length(f)
        if f(i)<= fp 
            sigma = 0.07;
        else
            sigma = 0.09;
        end
        f_ratio = f(i)/fp; 
        n(i) = exp(-0.5*((f_ratio-1)/sigma)^2); %gamma's exponent
        S(i) = 0.3125*Hs^2*Tp*f_ratio^(-5)*exp(-1.25*f_ratio^(-4))*...
            (1-0.287*log(gammaJS))*gammaJS^n(i);    
        
    end
    mo = trapz(f,S);
    mtarget =Hs^2/16;
    S_corrected = (mtarget/mo)*S;
    A = sqrt(2.*S_corrected.*df); %wave height
    ep = 2*pi*rand(1, length(f));
    
    %% CALCULATION OF surface elevation, h. velocity and h. acceleration
    x = 0;
    data.Nz = data.zBot + 1;
    omega= 2*pi*f;
    k = zeros(1,length(f));
    u = zeros(data.Nz,length(t));
    dudt = zeros(data.Nz,length(t));
    
for j = 1:length(f)                
    k(j)=kSolve(f(j),data.g, data.zBot); %wave number[1/m]
end

    M = length(t);
    zphys=linspace(-data.zBot,0, data.Nz);
    zcalc = zphys;
    
    etaHat= A.*exp (1i*ep);
    eta_time= M*real(ifft(pad2( etaHat ,M))); 
    for n=1:data.Nz
        %Velocity:
        uHat= A.*exp(1i*ep).*omega.*cosh(k.*(zcalc(n)+data.zBot))./...
            sinh(k.*data.zBot);
        u(n,:)= M*real(ifft(pad2( uHat ,M)));
        % Acceleration
        utHat=  A.*exp(1i*ep).*1i.*omega.^2.*cosh(k.*(zcalc(n)+...
            data.zBot))./sinh(k.*data.zBot);
        dudt(n,:)= M*real(ifft(pad2( utHat ,M)));
    end
        
end