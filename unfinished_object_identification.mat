% Specify the image file path
image_path = 's6.jpg';

% Load the pre-trained Faster R-CNN model
net = trainFasterRCNNObjectDetector(trainingData,network,options);

% Read the image
img = imread(image_path);

% Perform object detection
[bboxes, scores, labels] = detect(net, img);

% Display the results
figure;
imshow(img);
hold on;

% Display bounding boxes around detected objects
for i = 1:length(bboxes)
    rectangle('Position', bboxes(i, :), 'EdgeColor', 'r', 'LineWidth', 2);
    label = sprintf('%s: %.2f', labels{i}, scores(i));
    text(bboxes(i, 1), bboxes(i, 2) - 10, label, 'Color', 'r', 'FontSize', 8);
end

hold off;
title('Object Detection Results');
