function [ result ] = Img_to_lightplane(pixelCloud, wcsOrCcs)
% 激光线转换至相机坐标 OR 世界坐标
% 读.mat获取内参，光平面参量；
load('light_plane.mat')
load('calibrationSession.mat')

intrMat = calibrationSession.CameraParameters.IntrinsicMatrix;
for i = 1:size(pixelCloud,1)
  lineCcs = [intrMat(1,1),0,intrMat(3,1)-pixelCloud(i,1),0;...
    0,intrMat(2,2),intrMat(3,2)-pixelCloud(i,2),0];

  lightPlane = lightPlaneCcs;

  A = [lightPlane(:,1:3);lineCcs(:,1:3)];
  B = [-lightPlane(:,4);-lineCcs(:,4)];
  result(i,:) = (A\B)';
  if ( ~strcmp(wcsOrCcs, 'ccs'))
    result_temp = result(i,:)';
    result_temp = [result_temp;1];
    result_temp = mexWcs\result_temp;
    result(i,:) = result_temp(1:3)';
  end
end
end

