function [k] = kSolve(f,g,h)
%Wave length calculation
%   freq: wave frequency
%   g: gravity
%   h: depth 

omega = (2*pi)*f;
guess_k = omega^2/g ;
k = fzero(@(k) omega^2-g*k*tanh(k*h) , guess_k ) ;

end