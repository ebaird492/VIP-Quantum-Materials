% Read the image
image = imread('image_433.jpg');

% Convert the image to grayscale
grayImage = rgb2gray(image);

% Enhance the contrast
contrastedImage = imadjust(grayImage);

% Threshold the image to get a binary image of the flakes
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

imwrite(highlightedImage,'graphene.jpg');
image2 = imread('graphene.jpg');

% Convert to grayscale
grayImage2 = rgb2gray(image2);

% Binarize the image
thresholdValue = 50; % You might need to adjust this value
binaryImage = grayImage2 < thresholdValue;

% Label the connected components
[labeledImage, numberOfBlobs] = bwlabel(binaryImage);

% Measure the area of each component
blobMeasurements = regionprops(labeledImage, 'area');

% Get all the areas
allAreas = [blobMeasurements.Area];

% Find the largest connected component
[biggestArea, indexOfBiggest] = max(allAreas);

% Extract the largest connected component
largestBlob = ismember(labeledImage, indexOfBiggest);

% Display the original image
imshow(image);
hold on;

% Highlight the largest connected component
[largestBlobY, largestBlobX] = find(largestBlob);
title('Largest Graphene Flake Highlighted');
plot(largestBlobX, largestBlobY, 'r*');


