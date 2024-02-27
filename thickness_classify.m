% Load the matrix from the file (assuming it's a .mat file)
file_path = 'Ratio Map.mat';
loaded_data = load(file_path);
matrix_data = loaded_data.ratio_map; % Replace 'matrix' with the actual variable name

% Define classification intervals
intervals = 0:0.2:2.4;

% Initialize a cell array to store classified data
classified_data = cell(1, length(intervals) - 1);

% Classify the numbers into intervals
for i = 1:length(intervals)-1
    lower_limit = intervals(i);
    upper_limit = intervals(i+1);
    
    % Use logical indexing to extract numbers within the current interval
    indices = (matrix_data >= lower_limit) & (matrix_data < upper_limit);
    
    % Store the classified numbers in the cell array
    classified_data{i} = matrix_data(indices);
end

% Display or further process the classified data
for i = 1:length(classified_data)
    fprintf('Numbers in interval %.1f to %.1f: %s\n', intervals(i), intervals(i+1), mat2str(classified_data{i}));
end
