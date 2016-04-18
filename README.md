# Matlab_Calculate_Lightplane
实现光平面标定的Matlab工程

其中有两个可执行.m程序
Cal_light_plane.m  计算光平面的接口
Undistort.m 去除激光线图像中的畸变，生成SheetLight_XX.bmp

.mat 为相机标定数据

First_Try文件夹中存有本程序使用的图像

相关函数：
Img_to_wcs(u, v, n) 像素坐标(u,v)向n号世界坐标的Z=0平面的转换
Inv_Mex(n) 返回n号世界坐标的逆变换矩阵
Mex(n) 返回n号世界坐标的变换矩阵
Wcs_to_wcs(p_in, n2, n1) 将n2坐标系中的点转换到n1坐标系中
