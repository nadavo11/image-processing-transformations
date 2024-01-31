function F = dip_ifft2(I)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    [M,N] = size(I);

    n = 0:N-1;
    m = 0:M-1;
    
    u = 0:M-1;
    v = 0:N-1;
    
    um = u'.*m;
    vn = v'.*n;
    
    e1 = exp(1i * 2 * pi * (vn/N));
    e2 = exp(1i * 2 * pi * (um/M));
    sum = I*e1;
    F = (1/(M*N))*e2 *sum;
end