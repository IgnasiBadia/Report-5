function dqdt = dqdt(ti, q)
global system mode controller tspan_climates wind data

if mode.controller == 0
    %q = [x0: pitch; x0Dot; pitchDot];
    %dqdt = [x0Dot; pitchDot; x0DotDot; pitchDotDot];
    dqdt = zeros(4,1); %column vector
    x0 = q(1);
    x0Dot = q(3);
    pitch = q(2);
    pitchDot = q(4);

    if mode.decaytest==1
        GF = zeros(2,1); %for Q8 Decay test
    elseif mode.decaytest == 0
        [GF] = GFCalc(x0Dot, pitchDot, ti);
    end

    q_DotDot = inv(system.M + system.A)*(GF - system.C*[x0; pitch] - ...
        system.B*[x0Dot; pitchDot]);

    dqdt = [x0Dot; pitchDot; q_DotDot(1); q_DotDot(2)];
    
elseif mode.controller == 1
    %q = [x0: pitch; x0Dot; pitchDot; Ct];
    %dqdt = [x0Dot; pitchDot; x0DotDot; pitchDotDot; CtDot];
    dqdt = zeros(5,1); %column vector
    x0 = q(1);
    x0Dot = q(3);
    pitch = q(2);
    pitchDot = q(4);
    CT = q(5);
    controller.CT = CT;
    
    [GF] = GFCalc(x0Dot, pitchDot, ti);
    q_DotDot = inv(system.M + system.A)*(GF - system.C*[x0; pitch] - ...
    system.B*[x0Dot; pitchDot]);

    %Controller
    V = interp1(tspan_climates,wind.V_t,ti);
    Vhub_rel = V - (x0Dot + data.zHub*pitchDot);
    if Vhub_rel <= data.Vrated
        Ct_vrel  = data.Ct_0;
    else
        Ct_vrel = data.Ct_0*exp(-data.a*(Vhub_rel - data.Vrated)^...
            (data.b));
    end   

    Ct_Dot = - controller.gamma*(CT - Ct_vrel);
    
    dqdt = [x0Dot; pitchDot; q_DotDot(1); q_DotDot(2); Ct_Dot];
    
end
end