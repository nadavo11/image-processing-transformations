%Iris Eting 209027333
%Nadav Orenstein 312349509

function shiftedFFT = dip_fftshift(FFT)
    % Get the size of the input FFT
    [M, N] = size(FFT);
    
    % Calculate the center indices for both dimensions
    centerX = floor(M / 2) + 1;
    centerY = floor(N / 2) + 1;
    
    % Perform the shift along the rows and columns
    shiftedFFT = FFT([centerX:M, 1:centerX-1], [centerY:N, 1:centerY-1]);
end
