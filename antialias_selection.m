function [ antialiased_image ] = antialias_selection( corrected_image, selection_coordinates )
%ANTIALIAS_SELECTION Summary of this function goes here
%   Detailed explanation goes here

im_size = size(corrected_image);
mask = zeros(im_size(1), im_size(2));

just_girl = zeros(im_size(1), im_size(2), 3, 'uint8');
just_background = corrected_image;

for i = (1:size(selection_coordinates, 1))
    x = selection_coordinates(i, 1);
    y = selection_coordinates(i, 2);
    
    mask(x, y) = 1.0;
    
    just_selection(x, y, :) = corrected_image(x, y, :);
    just_background(x, y, :) = 0.0;
end

filter = [
    [0.06, 0.12, 0.06];
    [0.12, 0.28, 0.12];
    [0.06, 0.12, 0.06]
];

filtered = conv2(mask, filter, 'same');
filtered = conv2(filtered, filter, 'same');

antialiased_image = zeros(im_size(1), im_size(2), 3, 'uint8');
for x = (1:size(filtered, 1))
    for y = (1:size(filtered, 2))
        m = filtered(x, y);
        
        if m == 1
            antialiased_image(x, y, :) = just_selection(x, y, :);
        elseif m == 0
            antialiased_image(x, y, :) = just_background(x, y, :);
        else
            antialiased_image(x, y, :) = ...
                    (m * just_selection(x, y, :)) + ...
                    ((1 - m) * just_background(x, y, :));
        end
    end
end

end

