function [ selected_pixels, image_selected ] = select_cc_below_threshold( image, threshold, seed_tuple )
%SELECT_BELOW_THRESHOLD Select pixels in image that are below threshold
%   Detailed explanation goes here

image_selected = image;

im_size = size(image);
selected_pixels = zeros(im_size(1) * im_size(2), 2);

stack = java.util.Stack();
visited(1:im_size(1), 1:im_size(2)) = false;
stack.push(seed_tuple);

index = 1;
while ~stack.empty();
    
    p = stack.pop();
    
    connected = zeros(1, 2); % build 4-connected neighbors of p
    connected(1, :) = [p(1) - 1, p(2)];
    connected(2, :) = [p(1) + 1, p(2)];
    connected(3, :) = [p(1), p(2) - 1];
    connected(4, :) = [p(1), p(2) + 1];
    
    if ~visited(p(1), p(2)); % if p has not been visited yet
        
        selected_pixels(index, :) = p; % select p
        visited(p(1), p(2)) = true; % set p to visited
        image_selected(p(1), p(2), :) = 0;
        
        index = index + 1;
        
        for i = (1:size(connected)); % for all of p's 4-connected neighbors
            c = connected(i, :);
            if c(1) >= 1 && c(1) <= im_size(1) && c(2) >= 1 && c(2) <= im_size(2); % if c is within bounds of image
                colors = image(c(1), c(2), :);
                if colors < threshold; % if all colors are lower than threshold
                    stack.push(c); % add to stack
                end
            end
        end
    end
end

% return selected_pixels
selected_pixels = selected_pixels(1:index-1, :);

end

