% Read the image
image = imread('5.jpg');

if size(image, 3) == 3
    grayImage = rgb2gray(image);
else
    grayImage = image;
end

% Apply filters or thresholding to enhance the graphene flakes
% This will need to be adjusted based on your specific image
filteredImage = medfilt2(grayImage, [3 3]);

% Threshold the image to create a binary mask of the graphene flakes
thresh = graythresh(filteredImage);
binaryImage = imbinarize(filteredImage, thresh);

% Label connected components
[labels, num] = bwlabel(binaryImage);
stats = regionprops(labels, 'Area', 'PixelIdxList', 'BoundingBox');

% Sort the regions by area and get the indices of the ten largest
[~, idx] = sort([stats.Area], 'descend');
tenLargestIdx = idx(1:min(10,num));

% Extract the intensity values of these ten largest flakes
intensities = cell(length(tenLargestIdx), 1);
for i = 1:length(tenLargestIdx)
    intensities{i} = grayImage(stats(tenLargestIdx(i)).PixelIdxList);
end

% Calculate the average intensity for each of the ten largest regions
averageIntensity = zeros(length(tenLargestIdx), 1);
for i = 1:length(tenLargestIdx)
    averageIntensity(i) = mean(intensities{i});
end

% Sort the average intensities from thinnest to thickest (assuming higher intensity means thicker)
[sortedIntensities, sortOrder] = sort(averageIntensity, 'ascend');

% Create a figure and overlay the bounding boxes on the original image
figure, imshow(image), title('Thickness Analysis Results');
hold on;
for i = 1:length(sortOrder)
    rectangle('Position', stats(tenLargestIdx(sortOrder(i))).BoundingBox, ...
              'EdgeColor', 'r', 'LineWidth', 2)
end
hold off;

% Save the results image to file
saveas(gcf, 'thickness_analysis_results.png');

% Open a file to write the results
fileID = fopen('thickness_analysis_results.txt', 'w');
fprintf(fileID, 'Rank\tFlake Index\tAverage Intensity\n');

% Write the results to the file and also display on the command window
for i = 1:length(sortOrder)
    fprintf('Graphene flake %d has an average intensity of %.2f and is ranked %d in thickness.\n', ...
            tenLargestIdx(sortOrder(i)), sortedIntensities(i), i);
    fprintf(fileID, '%d\t%d\t%.2f\n', i, tenLargestIdx(sortOrder(i)), sortedIntensities(i));
end

% Close the file
fclose(fileID);
