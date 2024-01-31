function I_normalized = imread_normalized(src)
    I = imread(src);
    I = rgb2gray(I);
    I = im2double(I);
    I_min = min(I(:));
    I_max = max(I(:));
    I_normalized = (I - I_min) / (I_max - I_min);
end