%Iris Eting 209027333
%Nadav Orenstein 312349509

function free_willy = Free_Willy(Willy)
    % Count the number of peaks in the first row of Willy
    fx = size(findpeaks(Willy(1, :)), 2);

    % Get the number of columns in Willy (assuming it represents an image)
    N = size(Willy, 2);

    % Create a meshgrid for the x-axis
    x = meshgrid(0:N-1, 1:size(Willy, 1));

    % Generate a sine wave as a prison bar pattern
    prison_bar = 0.5 * sin((2 * pi * fx / N) * x);

    % Perform FFT on the images (Willy and prison_bar)
    Willy_fft = fft2(Willy);
    prison_fft = fft2(prison_bar);

    % Subtract the sine frequencies (prison bar) from the image frequencies
    free_willy_fft = Willy_fft - prison_fft;

    % Perform Inverse FFT to get the modified image
    free_willy = ifft2(free_willy_fft);

    % Display the resulting image
    figure;
    imshow(free_willy);
    title('Freed WIlly')
end
