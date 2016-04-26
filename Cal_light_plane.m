p_cloud_pixel = xlsread('point_cloud.xlsx');
p_cloud_pixel = p_cloud_pixel(1:103,:);
p_cloud_wcs = [];

%将所有点转到图1坐标系中
for i = 1:1:length(p_cloud_pixel)
  p_wcs = Img_to_wcs(p_cloud_pixel(i,1), p_cloud_pixel(i,2), p_cloud_pixel(i,3));
  if(p_cloud_pixel(i,3) ~= 1)
    p_wcs = Wcs_to_wcs(p_wcs, p_cloud_pixel(i,3), 1);
  end
  p_wcs = p_wcs(1:3);
  p_cloud_wcs = [p_cloud_wcs,p_wcs];
end

p_cloud_wcs = p_cloud_wcs';

%平面拟合
xyz0 = mean(p_cloud_wcs, 1);
centeredPlane = bsxfun(@minus, p_cloud_wcs, xyz0);
[U,S,V] = svd(centeredPlane);
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
distance = abs([a,b,c,d]* [p_cloud_wcs';ones(1,length(p_cloud_wcs))])/sqrt(a^2+b^2+c^2);

% 迭代，抛弃坏点
while(max(distance) > 1)
  d_max = find(distance == max(distance));
  p_cloud_wcs(d_max,:) = [];
  
  xyz0 = mean(p_cloud_wcs, 1);
  centeredPlane = bsxfun(@minus, p_cloud_wcs, xyz0);
  [U,S,V] = svd(centeredPlane);
  a=V(1,3);
  b=V(2,3);
  c=V(3,3);
  d=-dot([a b c],xyz0);
  
  distance = abs([a,b,c,d]* [p_cloud_wcs';ones(1,length(p_cloud_wcs))])/sqrt(a^2+b^2+c^2);
end

x_wcs = p_cloud_wcs(:,1);
y_wcs = p_cloud_wcs(:,2);
z_wcs = p_cloud_wcs(:,3);
scatter3(x_wcs, y_wcs, z_wcs, 'filled');
hold on;

light_plane_wcs = [a,b,c,d];
light_plane_ccs = light_plane_wcs * Inv_Mex(1);
mex_wcs = Mex(1);
theta_plane = rad2deg(acos(c / norm([a,b,c])));
save('light_plane.mat','light_plane_wcs','light_plane_ccs','theta_plane','mex_wcs');

% 图形绘制
xfit = min(x_wcs):1:max(x_wcs);
yfit = min(y_wcs):1:max(y_wcs);
[XFIT,YFIT]= meshgrid (xfit,yfit);
ZFIT = -(d + a * XFIT + b * YFIT)/c;
mesh(XFIT,YFIT,ZFIT);
xlabel('X');
ylabel('Y');
zlabel('Z');