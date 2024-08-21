import cv2
import numpy as np

# Load the image
image = cv2.imread('6.jpg')
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Apply Gaussian blur
blurred = cv2.GaussianBlur(gray_image, (5, 5), 0)

# Threshold the image to get a binary image
ret, binary_image = cv2.threshold(blurred, 0, 255, cv2.THRESH_BINARY_INV + cv2.THRESH_OTSU)

# Find contours
contours, hierarchy = cv2.findContours(binary_image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Sort the contours by area and get the two biggest
sorted_contours = sorted(contours, key=cv2.contourArea, reverse=True)
biggest_contours = sorted_contours[:2]

# Initialize a list to hold the thickness data
thickness_data = []

# Calculate the mean intensity (which we'll use as a proxy for thickness) for the two biggest flakes
for i, contour in enumerate(biggest_contours):
    mask = np.zeros_like(gray_image)  # Create a mask for the contour
    cv2.drawContours(mask, [contour], -1, color=255, thickness=cv2.FILLED)
    mean_val = cv2.mean(gray_image, mask=mask)[0]  # Calculate mean intensity
    thickness_data.append(('Graphene {}'.format(i+1), mean_val))

# Draw the biggest contours on the image and annotate them with their relative thickness
for i, contour in enumerate(biggest_contours):
    cv2.drawContours(image, [contour], -1, (0, 255, 0), 3)
    cv2.putText(image, 'G{}: {:.2f}'.format(i+1, thickness_data[i][1]), tuple(contour[0][0]),
                cv2.FONT_HERSHEY_SIMPLEX, 0.6, (0, 0, 255), 2)

# Save the result
annotated_image_path = 'annotated_biggest_graphene_thickness.jpg'
cv2.imwrite(annotated_image_path, image)

# Path to the text file where the results will be saved
text_file_path = 'graphene_thickness_data.txt'

# Write the thickness data to the text file
with open(text_file_path, 'w') as file:
    for item in thickness_data:
        file.write('{}: Average Intensity {}\n'.format(item[0], item[1]))

# Return the paths to the saved image and text file
(annotated_image_path, text_file_path)
