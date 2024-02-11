%Iris Eting 209027333
%Nadav Orenstein 312349509

function F = dip_fft2(I)    
    % Get the size of the input image
    [M, N] = size(I);
 
    % Generate arrays representing indices for rows and columns
    n = 0:N-1;
    m = 0:M-1;
    
    % Generate arrays representing indices for frequency domain
    u = 0:M-1;
    v = 0:N-1;
    
    % Create matrices of products of indices for later calculations
    um = u'.*m;
    vn = v'.*n;
    
    % Calculate the exponential term in the frequency domain for rows
    e1 = exp(-1i * 2 * pi * (vn/N));
    
    % Calculate the exponential term in the frequency domain for columns
    e2 = exp(-1i * 2 * pi * (um/M));
    
    % Perform the row-wise Fourier transform using matrix multiplication
    sum = I * e1;
    
    % Perform the column-wise Fourier transform using matrix multiplication
    F = e2 * sum;
end
