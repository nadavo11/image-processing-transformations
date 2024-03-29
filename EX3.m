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
% as for the algorithm, we will implement it by slightly rearranging the equation:
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
imshow(real(my_FFT))
title('our fft')
F = fft2(I);
%% 
% let's just check how our algorithm compares to MATLAB's implementation:

imshow(real(F))
title('MATLAB fft')

imshow(F-my_FFT);
title('the difference between our implementation and MATLAB built in')
% Reconstruct the original image
% by using your inverse-FFT function. Is it identical to the original image? 
% Note that the output of the iFFT are complex numbers - you should display only 
% the real part of the image using imshow(real(-))

reconstructed_img = dip_ifft2(my_FFT);
imshow(real(reconstructed_img))
title('reconstructed image')
%% 
% but are they identical? to answer that we will compute the error, to estimate 
% the loss to the original image by applying $F^{-1} \left\lbrace F\left\lbrace 
% I\left(m,n\right)\right\rbrace \right\rbrace$ 

mse = mean(mean((reconstructed_img - I) .^ 2))
%% 
% 
%% 1.2 Transformation properties
% 

load("freewilly.mat");
imshow(freewilly)
% b. find the frequency of the bars
% 
% 
% first, we plotted the first row, which seems to contain the least of the original 
% image information.

row1 = freewilly(1,:)
plot(row1);
F = fft(row1);
title('w_1 - the first row of the image')
grid on
%% 
% by plotting it, it seems clear that $B\propto \sin \left(\frac{2\pi f_x }{N}\;x\right)$ 
% and that we can already estimate $f_x$ by counting peaks. 
% 
% however, for more accurate and scientific assesment, we chose to go further 
% and calculate it's fourier transform


plot(imag(F));
title('im(F\{w_1\}) - Fourier transform of the first row (imaginary part)')
grid on
%% 
% by plotting the imaginary part we can use the descrete transform identity 
% $\mathcal{F}\left\lbrace \sin \left(\frac{2\pi f_x }{N}\;x\right)\right\rbrace 
% \propto \;i\delta \left(N-f_x \right)-i\delta \left(f_x \right)$ . so we can 
% find $f_x$ by taking the $\underset{k\in \left\lbrack 0,639\right\rbrack }{\textrm{argmax}} 
% \left(\mathcal{F}\left\lbrace \sin \left(\frac{2\pi f_x }{N}\;x\right)\right\rbrace 
% \left(k\right)\right)$
% 
% of course, let's not forget to add one, to account for MATLAB's indexing.
% 
% 

 [argvalue, argmin] = min(imag(F))
 [argvalue, argmax] = max(imag(F))
%% 
% we get that $f_x =10$ and so the sinusoidal bars follow the equation of $\sin 
% \left(\frac{2\pi }{N}\cdot 10x\right)$. it makes a lot of sense that this is 
% a good estimation, because there are roughly 10 bars in total of N pixels.
% c. creating the image of the prison bars 
% we will use the equation that we have to create the pattern along the $x$ 
% axis. we will repeat it along the $y\;$axis to recieve the image of the bars.
% 
% 

[M, N] = size(freewilly);
bars = 0.5*sin(2*(pi/N)*10*(1:N));
bars = repmat(bars,M,1);
imshow(bars)
% d.Compute the 2D-FFT of the prison bars image
% 
% 
% 
% 
% let's see how this is represented in the frequancy domaimn:

bars_fft = fft2(bars);
imshow(bars_fft)
%% 
% it makes sense: what we see is a blank image (zeros everywhere) and two non 
% zero amplitudes, at the pixels corresponding to the frequencies we discovered 
% in section (b), given by the two $\delta$ functions given by transforming the 
% sine waves on the $x$ axis.
% 
% our prison bars are represented by
% 
% $$b\left(x,y\right)=$$$$\sin \left(\frac{2\pi }{N}\cdot 10x\right)$$
% 
% so the fourier transform
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\sum_{m=0}^{M-1} 
% \left(\sum_{n=0}^{N-1} b\left(m,n\right)\cdot e^{-2\pi i\left(\frac{v\cdot n}{N}\right)} 
% \right)e^{-2\pi i\left(\frac{u\cdot m}{M}\right)}$$
% 
% 
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\sum_{m=0}^{M-1} 
% \left(\sum_{n=0}^{N-1} \sin \left(\frac{2\pi }{N}\cdot 10\cdot n\right)\cdot 
% e^{-2\pi i\left(\frac{v\cdot n}{N}\right)} \right)e^{-2\pi i\left(\frac{u\cdot 
% m}{M}\right)}$$
% 
% 
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\sum_{m=0}^{M-1} 
% \left(\mathcal{F}\left\lbrace \sin \left(\frac{2\pi }{N}\cdot 10\cdot n\right)\right\rbrace 
% \right)e^{-2\pi i\left(\frac{u\cdot m}{M}\right)}$$
% 
% 
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\sum_{m=0}^{M-1} 
% \textrm{const}\cdot \left(i\delta \left(n-N+10\right)-i\delta \left(n-\textrm{10}\right)\right)e^{-2\pi 
% i\left(\frac{u\cdot m}{M}\right)}$$
% 
% but this depends only in $n$
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\left(i\delta 
% \left(n-N+10\right)-i\delta \left(n-\textrm{10}\right)\right)\cdot \sum_{m=0}^{M-1} 
% \textrm{const}\cdot e^{-2\pi i\left(\frac{u\cdot m}{M}\right)}$$
% 
% 
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\left(i\delta 
% \left(n-N+10\right)-i\delta \left(n-\textrm{10}\right)\right)\cdot \mathcal{F}\left\lbrace 
% \textrm{const}\right\rbrace$$
% 
% 
% 
% $$\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace =\;$$$$\left(i\delta 
% \left(n-N+10\right)-i\delta \left(n-\textrm{10}\right)\right)\cdot \delta \left(m\right)$$
% 
% 
% 
% on the $y$ axis on the other hand, the bars image is constant, which results 
% in a delta function at the 0 index (1 in MATLAB). so, we see our two pulses 
% on the 10'th and negative 10'th columns are activated only on the first row, 
% beacause of the multiplication with $\delta \left(m\right)$
% 
% 
% e. freeing willy
% 
% 
% due to the linearity of the fourier transform, given by the identity $\mathcal{F}\left\lbrace 
% a\left(x\right)-b\left(x\right)\right\rbrace =\mathcal{F}\left\lbrace a\left(x\right)\right\rbrace 
% -\mathcal{F}\left\lbrace b\left(x\right)\right\rbrace \;$ we might be able to 
% free willy by subtracting the $\mathcal{F}\left\lbrace b\left(m,n\right)\right\rbrace 
% \;$from the spectral domain of the original image:

willy_fft = fft2(freewilly);
willy_fft = willy_fft - bars_fft;
willy_free = ifft2(willy_fft);
imshow(willy_free)
%% 
% we maneged to drastically decrease the bars intensity though it didn't work 
% perfectly. we can try erasing the bars frequency alltogether by eliminating 
% the 2 delta functions that represent  their transform 

willy_fft = fft2(freewilly);
willy_fft(abs(bars_fft)>1) = 0;
willy_free = ifft2(willy_fft);
imshow(willy_free)
%% 
%% 2. Scaling, translation and seperability
% (a) we Initialized a 128×128 all-zeros matrix. At the center of it, we placed 
% a 40×40 all-ones square, and displayed the image and its 2D-FFT:

A = zeros(128,128);

A(44:83,44:83) = 1;

figure;
imshow(A);
title('A matrix');

FA = fft2(A);
figure;
subplot(1, 3, 1);
imshow(abs(FA));
title('|F\{A\}|')

subplot(1, 3, 2);
imshow(imag(FA));
title('im(F\{A\})')
subplot(1, 3, 3);
imshow(real(FA));
title('re(F\{A\})')
%% 
% why does it look the way it does?

figure;
middlerow = imag(circshift(FA(64,:),64));
plot(middlerow);


%% 
% (b) now we put the square at the bottom right,

A = zeros(128,128);

A(64:103,64:103) = 1;

figure;
imshow(A);
title('A matrix');

FA = fft2(A);
figure;
subplot(1, 3, 1);
imshow(abs(FA));
title('|F\{A\}|')

subplot(1, 3, 2);
imshow(imag(FA));
title('im(F\{A\})')
subplot(1, 3, 3);
imshow(real(FA));
title('re(F\{A\})')
%% 
% (c) now we place a rectangle at the center,

A = zeros(128,128);

A(24:103,54:73) = 1;

figure;
imshow(A);
title('A matrix');

FA = fft2(A);
figure;
subplot(1, 3, 1);
imshow(abs(FA));
title('|F\{A\}|')

subplot(1, 3, 2);
imshow(imag(FA));
title('im(F\{A\})')
subplot(1, 3, 3);
imshow(real(FA));
title('re(F\{A\})')

figure;
middlerow = abs(FA(64,:));
plot(middlerow);