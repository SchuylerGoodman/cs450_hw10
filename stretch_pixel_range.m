function [ linear_stretched, log_stretched ] = stretch_pixel_range( image, coordinates )
%STRETCH_PIXEL_RANGE Summary of this function goes here
%   Detailed explanation goes here

linear_stretched = image;
log_stretched = image;

selected_vals = zeros(size(coordinates, 1), 3);
for i = (1:size(coordinates, 1))
    coords = coordinates(i, :);
    selected_vals(i, :) = image(coords(1), coords(2), :);
end

linear_reds = im2uint8(mat2gray(selected_vals(:,1)));
linear_greens = im2uint8(mat2gray(selected_vals(:,2)));
linear_blues = im2uint8(mat2gray(selected_vals(:,3)));

log_reds = im2uint8(mat2gray(log(1 + selected_vals(:,1))));
log_greens = im2uint8(mat2gray(log(1 + selected_vals(:,2))));
log_blues = im2uint8(mat2gray(log(1 + selected_vals(:,3))));

for i = (1:size(coordinates))
    
    coords = coordinates(i, :);
    x = coords(1);
    y = coords(2);
    
    linear_stretched(x, y, :) = [
        linear_reds(i), ...
        linear_greens(i), ...
        linear_blues(i)
    ];

    log_stretched(x, y, :) = [
        log_reds(i), ...
        log_greens(i), ...
        log_blues(i)
    ];
end

end

