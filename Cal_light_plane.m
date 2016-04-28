pCloudPixel = xlsread('point_cloud.xlsx');
% pCloudPixel = pCloudPixel(1:288,:);
pCloudWcs = [];
Undistort(8);
Get_extrinsics(4);

%将所有点转到图1坐标系中
for i = 1:1:length(pCloudPixel)
  pWcs = Img_to_wcs(pCloudPixel(i,1), pCloudPixel(i,2), pCloudPixel(i,3));
  if(pCloudPixel(i,3) ~= 1)
    pWcs = Wcs_to_wcs(pWcs, pCloudPixel(i,3), 1);
  end
  pWcs = pWcs(1:3);
  pCloudWcs = [pCloudWcs,pWcs];
end

pCloudWcs = pCloudWcs';

%平面拟合
xyz0 = mean(pCloudWcs, 1);
centeredPlane = bsxfun(@minus, pCloudWcs, xyz0);
[U,S,V] = svd(centeredPlane);
a=V(1,3);
b=V(2,3);
c=V(3,3);
d=-dot([a b c],xyz0);
distance = abs([a,b,c,d]* [pCloudWcs';ones(1,length(pCloudWcs))])/sqrt(a^2+b^2+c^2);

% 迭代，抛弃坏点
% while(max(distance) > 1)
%   dMax = find(distance == max(distance));
%   pCloudWcs(dMax,:) = [];
%   
%   xyz0 = mean(pCloudWcs, 1);
%   centeredPlane = bsxfun(@minus, pCloudWcs, xyz0);
%   [U,S,V] = svd(centeredPlane);
%   a=V(1,3);
%   b=V(2,3);
%   c=V(3,3);
%   d=-dot([a b c],xyz0);
%   
%   distance = abs([a,b,c,d]* [pCloudWcs';ones(1,length(pCloudWcs))])/sqrt(a^2+b^2+c^2);
% end

xWcs = pCloudWcs(:,1);
yWcs = pCloudWcs(:,2);
zWcs = pCloudWcs(:,3);
scatter3(xWcs, yWcs, zWcs, 'filled');
hold on;

lightPlaneWcs = [a,b,c,d];
lightPlaneCcs = lightPlaneWcs * Inv_Mex(1);
mexWcs = Mex(4);
thetaPlane = rad2deg(acos(c / norm([a,b,c])));
save('light_plane.mat','lightPlaneWcs','lightPlaneCcs','thetaPlane','mexWcs');

% 图形绘制
xfit = min(xWcs):1:max(xWcs);
yfit = min(yWcs):1:max(yWcs);
[XFIT,YFIT]= meshgrid (xfit,yfit);
ZFIT = -(d + a * XFIT + b * YFIT)/c;
mesh(XFIT,YFIT,ZFIT);
xlabel('X');
ylabel('Y');
zlabel('Z');

pixelCloud = xlsread('pixel_cloud.xlsx');
result = Img_to_lightplane(pixelCloud,'wcs');
