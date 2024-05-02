import cv2
import numpy as np
import matplotlib.pyplot as plt

# Load the image
image_path = '5.jpg'
image = cv2.imread(image_path)
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Apply Gaussian blur
blurred = cv2.GaussianBlur(gray_image, (5, 5), 0)

# Threshold the image to get a binary image
_, binary_image = cv2.threshold(blurred, 0, 255, cv2.THRESH_BINARY + cv2.THRESH_OTSU)

# Find contours
contours, _ = cv2.findContours(binary_image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

# Sort the contours by area and get the ten largest
contours = sorted(contours, key=cv2.contourArea, reverse=True)[:10]

# Calculate the mean intensity (thickness) for each flake
intensities = []
for contour in contours:
    mask = np.zeros_like(gray_image) # Create a mask for each contour
    cv2.drawContours(mask, [contour], -1, color=255, thickness=cv2.FILLED)
    mean_intensity = cv2.mean(gray_image, mask=mask)[0] # Calculate mean intensity within the contour
    intensities.append((contour, mean_intensity))

# Sort the list by intensity (assuming higher intensity means thicker)
intensities = sorted(intensities, key=lambda x: x[1])

# Annotate the ten biggest flakes from thinnest to thickest
for i, (contour, intensity) in enumerate(intensities):
    cv2.drawContours(image, [contour], -1, (0, 255, 0), 3)
    cv2.putText(image, f'{i+1}', tuple(contour[0][0]), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)

# Save the annotated image
cv2.imwrite('annotated_9.jpg', image)

# Optionally, display the image
plt.imshow(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
plt.title('Annotated Graphene Flakes')
plt.show()

