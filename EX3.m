%% 2D-Fourier Transform
% In this section we will implement the 2D Fourier Transform on images and learn 
% about some of its properties.
% 
% 
% 
% 1. 1 the 2D FFT 
% 
% The equations for the FFT and iFFT for an image I of size $M\times N$ are 
% as follows:
% 
% $$F\left\lbrace I\left(m,n\right)\right\rbrace \left(u,v\right)=\;\sum_{m=0}^{M-1} 
% \sum_{n=0}^{N-1} I\left(m,n\right)\cdot e^{-2\pi i\left(\frac{u\cdot m}{M}+\frac{v\cdot 
% n}{N}\right)}$$
% 
% 
% 
% and the inverse transform:
% 
% $$I\left(m,n\right)=\frac{1}{M\cdot N}\sum_{u=0}^{M-1} \sum_{v=0}^{N-1} F\left(u,v\right)\cdot 
% e^{2\pi i\left(\frac{u\cdot m}{M}+\frac{v\cdot n}{N}\right)}$$
% 
% 
% 
% accounting to MATLAB's indexing, we will rewrite the array indices as such: 
% 
% $$F\left(u+1,v+1\right)=\;\sum_{m=0}^{M-1} \sum_{n=0}^{N-1} I\left(m+1,n+1\right)\cdot 
% e^{-2\pi i\left(\frac{u\cdot m}{M}+\frac{v\cdot n}{N}\right)}$$
% 
% $$I\left(m+1,n+1\right)=\frac{1}{M\cdot N}\sum_{u=0}^{M-1} \sum_{v=0}^{N-1} 
% F\left(u+1,v+1\right)\cdot e^{2\pi i\left(\frac{u\cdot m}{M}+\frac{v\cdot n}{N}\right)}$$
% 
% 
% 
% $$F\left(u+1,v+1\right)=\;\sum_{m=0}^{M-1} \left(\sum_{n=0}^{N-1} I\left(m+1,n+1\right)\cdot 
% e^{-2\pi i\left(\frac{v\cdot n}{N}\right)} \right)e^{-2\pi i\left(\frac{u\cdot 
% m}{M}\right)}$$
% 
% 

% __________________________________________________
%|                                                  |
%|                                                  |
%|            1.1 2D-Fourier Transform              |
%|                                                  |
%|__________________________________________________|

% part 3
%% 
% let's read the beatles.png image, convert it to grayscale, and normalize to 
% $\in \left\lbrack 0,1\right\rbrack$

I = imread_normalized("beatles.png");

% 4
my_FFT = dip_fft2(I);
F = fft2(I);
imshow(real(my_FFT))
imshow(real(F))
imshow(F-my_FFT);
% 


% Reconstruct the original image
% by using your inverse-FFT function. Is it identical to the original image? 
% Note that the output of the iFFT are complex numbers - you should display only 
% the real part of the image using imshow(real(-))

reconstructed_img = dip_ifft2(my_FFT);
imshow(reconstructed_img)
%% 
% but are they identical? to answer that we will compute the error, to estimate 
% the loss to the original image by applying $F^{-1} \left\lbrace F\left\lbrace 
% I\left(m,n\right)\right\rbrace \right\rbrace$ 

mse = mean(mean((reconstructed_img - I) .^ 2))
%% 
% 
%% 1.2 Transformation properties

load("freewilly.mat");
imshow(freewilly)
% b. find the frequency of the bars

row1 = freewilly(1,:)
plot(row1);
F = fft(row1);
grid on
plot(imag(F));
grid on
 [argvalue, argmin] = min(imag(F))
 [argvalue, argmax] = max(imag(F))
%% 
% we get that $f_x =10$ and so the sinusoidal bars follow the equation of $\sin 
% \left(\frac{2\pi }{N}\cdot 10x\right)$. it makes a lot of sense that this is 
% a good estimation, because there are roughly 10 bars in total of N pixels.

[M, N] = size(freewilly)
bars = 0.5*sin(2*(pi/N)*10*(1:N))
bars = repmat(bars,M,1)
imshow(bars)
%% 
% d.Compute the 2D-FFT of the prison bars image, and display its amplitude

bars_fft = fft2(bars)
imshow(bars_fft)
willy_fft = fft2(freewilly);
willy_fft = willy_fft - 1.08*bars_fft;
willy_free = ifft2(willy_fft);
imshow(willy_free)