import numpy as np
import cv2
import warnings
warnings.filterwarnings("ignore")

li = list()
y = np.linspace(0, 8, 9)

for i in range(22, 31):
    img_path = f"testimage/I{i}.jpg"
    li.append(cv2.imread(img_path)[:,:,2])

n_li = [[list(pair) for pair in zip(*sublist)] for sublist in zip(*li)]
dim1 = len(n_li)
dim2 = len(n_li[0])
fin_li = []
for i in range(dim1):
    sub_li = []
    for j in range(dim2):
        try:
            slope, _ = np.polyfit(n_li[i][j], y , 1)
            if slope < 0:
                sub_li.append(0)
                continue
            sub_li.append(slope)
        except:
            sub_li.append(0)
    fin_li.append(sub_li)

fin_li = np.array(fin_li)
cv2.imshow("img", fin_li)
cv2.imwrite("fin_image.png", fin_li)
cv2.waitKey(0)