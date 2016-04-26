function [ result ] = Img_to_lightplane(u, v, wcs_or_ccs)
% 激光线转换至相机坐标 OR 世界坐标
% 读.mat获取内参，光平面参量；
load('light_plane.mat')
load('calibrationSession_firt_try.mat')

intr_mat = calibrationSession.CameraParameters.IntrinsicMatrix;
line_ccs = [intr_mat(1,1),0,intr_mat(3,1)-u,0;
    0,intr_mat(2,2),intr_mat(3,2)-v,0];

light_plane = light_plane_ccs;

A = [light_plane(:,1:3);line_ccs(:,1:3)];
B = [-light_plane(:,4);-line_ccs(:,4)];
result = A\B;

if ( ~strcmp(wcs_or_ccs, 'ccs'))
  result = [result;1];
  result = mex_wcs\result;
  result = result(1:3);
end
end

