% Read the image
image = imread('Image_433.jpg');

% Convert to grayscale
grayImage = rgb2gray(image);

% Invert the image, as graphene flakes are likely darker
invertedImage = imcomplement(grayImage);

% Threshold the image - this value may need to be tuned
thresholdValue = 150; % Assuming that the darker regions are below this value after inversion
binaryImage = invertedImage > thresholdValue;

% Remove small objects and noise
cleanedBinaryImage = bwareaopen(binaryImage, 50); % Size threshold may need to be tuned

% Label the connected components
[labeledImage, numObjects] = bwlabel(cleanedBinaryImage, 8);

% Measure properties of connected components
measurements = regionprops(labeledImage, 'Area', 'PixelIdxList');

% Initialize the darkest value to a high number
darkestValue = 255;
darkestFlakeIndex = 0;

% Go through each region to find the darkest one
for k = 1:numObjects
    % Extract the intensity values of the current region
    currentFlakePixelValues = grayImage(measurements(k).PixelIdxList);
    
    % Calculate the mean intensity of the current flake
    meanValue = mean(currentFlakePixelValues);
    
    % If the current flake is darker than the darkest one found, update
    if meanValue < darkestValue
        darkestValue = meanValue;
        darkestFlakeIndex = k;
    end
end

% Highlight the darkest flake in the image
highlightedImage = image;

% Check if we found any flake
if darkestFlakeIndex > 0
    % Create a binary mask for the darkest flake
    darkestFlakeMask = ismember(labeledImage, darkestFlakeIndex);
    
    % Create an RGB mask
    maskedImage = cat(3, darkestFlakeMask, darkestFlakeMask, darkestFlakeMask);
    
    % Highlight the darkest flake in red
    highlightedImage(repmat(darkestFlakeMask, [1, 1, 3])) = 0;
    highlightedImage(maskedImage) = 255;
else
    disp('No graphene flakes found!');
end

% Display the result
imshow(highlightedImage);
title('Darkest Graphene Flake Highlighted');
