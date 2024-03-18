% Read the image
image = imread('graphene.jpg');

% Convert to grayscale
grayImage = rgb2gray(image);

% Binarize the image
thresholdValue = 50; % You might need to adjust this value
binaryImage = grayImage < thresholdValue;

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
plot(largestBlobX, largestBlobY, 'r*');
