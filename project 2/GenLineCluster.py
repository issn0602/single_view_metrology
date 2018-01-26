import os
import numpy as np
import cv2
from pylsd import lsd
import pandas as pd

im = cv2.imread('images/tea.jpg',cv2.IMREAD_COLOR)
cv2.imshow('input',im)
im_gray = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
lines = np.array(lsd(im_gray))

print(lines.shape)
p1= np.zeros(shape=[lines.shape[0],2])
p1[:,0]= np.array([lines[:,0]])
p1[:,1] = np.array([lines[:,1]])
#print (p1)

p2= np.zeros(shape=[lines.shape[0],2])
p2[:,0]= np.array([lines[:,2]])
p2[:,1] = np.array([lines[:,3]])

lines_x= []
lines_y = []
lines_z = []

lines_new=[]
for i in range(lines.shape[0]):
    dist = np.linalg.norm(p1[i,:]-p2[i,:]) #distance between the vectors
    if dist > 50:
        lines_new.append(lines[i,:])
lines=np.array(lines_new)
#lines_new = lines


for i in range(lines.shape[0]):
    [m,c] = np.polyfit([lines[i,0],lines[i,2]],[lines[i,1],lines[i,3]],deg=1) #y=mx+c representation
    #print m

    if m > 0.0 and m < 0.8:
        lines_y.append(lines[i][:])
    elif m < -1 and m > -55.0:
        lines_z.append(lines[i][:])
    elif m > -0.8 and m < -0.2:
        lines_x.append(lines[i][:])

print (np.array(lines_x).shape)
print (np.array(lines_y).shape)
print (np.array(lines_z).shape)

np.savetxt('lines_x.csv', lines_x, delimiter=',')
np.savetxt('lines_y.csv', lines_y, delimiter=',')
np.savetxt('lines_z.csv', lines_z, delimiter=',')
###plot the lines
#src = cv2.imread(fullName, cv2.IMREAD_COLOR)
im = cv2.imread('images/tea.jpg',cv2.IMREAD_COLOR)
for i in xrange(len(lines_x)):
    pt1 = (int(lines_x[i][0]), int(lines_x[i][1]))
    pt2 = (int(lines_x[i][2]), int(lines_x[i][3]))
    width = int(lines_x[i][4])
    cv2.line(im, pt1, pt2, (0, 0, 255), int(np.ceil(width / 2)))
cv2.imwrite(os.path.join('cv2_x_' + 'tea' + '.jpg'), im)
cv2.imshow('Lines in x-direction',im)
im = cv2.imread('images/tea.jpg',cv2.IMREAD_COLOR)
for i in xrange(len(lines_y)):
    pt1 = (int(lines_y[i][0]), int(lines_y[i][1]))
    pt2 = (int(lines_y[i][2]), int(lines_y[i][3]))
    width = int(lines_y[i][4])
    cv2.line(im, pt1, pt2, (0, 0, 255), int(np.ceil(width / 2)))
cv2.imwrite(os.path.join('cv2_y_' + 'tea' + '.jpg'), im)
cv2.imshow('Lines in y-direction',im)
im = cv2.imread('images/tea.jpg',cv2.IMREAD_COLOR)
for i in xrange(len(lines_z)):
    pt1 = (int(lines_z[i][0]), int(lines_z[i][1]))
    pt2 = (int(lines_z[i][2]), int(lines_z[i][3]))
    width = int(lines_z[i][4])
    cv2.line(im, pt1, pt2, (0, 0, 255), int(np.ceil(width / 2)))
cv2.imwrite(os.path.join('cv2_z_' + 'tea' + '.jpg'), im)
cv2.imshow('Lines in z-direction',im)