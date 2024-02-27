% Specify the file path of your matrix file
file_path = 'Ratio Map.mat';

% Load the matrix from the file
load(file_path);  % Assuming the matrix is saved in a .mat file

% Define the classification intervals
intervals = 0:0.2:2.4;

% Initialize a cell array to store the column and row indices for each interval
indices_cell = cell(length(intervals)-1, 2);

% Loop through each interval
for i = 1:length(intervals)-1
    lower_bound = intervals(i);
    upper_bound = intervals(i+1);
    
    % Find the indices where the matrix values fall within the current interval
    [row_indices, col_indices] = find(matrix >= lower_bound & matrix < upper_bound);
    
    % Store the indices in the cell array
    indices_cell{i, 1} = row_indices;
    indices_cell{i, 2} = col_indices;
    
    % Display the results for the current interval
    fprintf('Numbers in the range %.1f to %.1f are located at rows: %s, columns: %s\n', ...
        lower_bound, upper_bound, num2str(row_indices'), num2str(col_indices'));
end

% Display the complete cell array with all indices
disp('Complete list of indices for each interval:');
disp(indices_cell);
