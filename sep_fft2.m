%Iris Eting 209027333
%Nadav Orenstein 312349509

function F = sep_fft2(v1,v2)    
    % Calculate the fourier transform of v1
    F1 = fft(v1);
    % Calculate the fourier transform of v2
    F2 = fft(v2);
    F = F1*F2;
end
