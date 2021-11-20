function dqdt = dqdt(ti, q0)
global system mode
%q = [x0: pitch; x0Dot; pitchDot];
%dqdt = [x0Dot; pitchDot; x0DotDot; pitchDotDot];

dqdt = zeros(4,1); %column vector
x0 = q0(1);
x0Dot = q0(3);
pitch = q0(2);
pitchDot = q0(4);

if mode.decaytest==1
    GF = zeros(2,1); %for Q8 Decay test
else
    [GF] = GFCalc(x0Dot, pitchDot, ti);
end

q_DotDot = inv(system.M + system.A)*(GF - system.C*[x0; pitch] - ...
    system.B*[x0Dot; pitchDot]);

dqdt = [x0Dot; pitchDot; q_DotDot(1); q_DotDot(2)];

end