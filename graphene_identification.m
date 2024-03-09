% Read the image
image = imread('Image_433.jpg');

% Convert the image to grayscale
grayImage = rgb2gray(image);

% Enhance the contrast
contrastedImage = imadjust(grayImage);

% Threshold the image to get a binary image of the flakes
% You may need to adjust the threshold to suit your specific image
thresh = graythresh(contrastedImage);
binaryImage = imbinarize(contrastedImage, thresh);

% Remove small objects that are not graphene
cleanedBinaryImage = bwareaopen(binaryImage, 50); % 50 is a guessed value

% Label the connected components
[labeledImage, numObjects] = bwlabel(cleanedBinaryImage, 8);

% Measure properties of connected components
measurements = regionprops(labeledImage, 'Area', 'BoundingBox');

% Find the largest object
largestObjectArea = 0;
largestObjectIndex = 0;
for k = 1 : numObjects
    if measurements(k).Area > largestObjectArea
        largestObjectArea = measurements(k).Area;
        largestObjectIndex = k;
    end
end

% Create a mask for the largest object
largestObjectMask = ismember(labeledImage, largestObjectIndex);

% Highlight the largest graphene flake in the original image
highlightedImage = image;
highlightedImage(repmat(~largestObjectMask, [1, 1, 3])) = 0;

% Display the result
imshow(highlightedImage, []);
title('Largest Graphene Flake Highlighted');
