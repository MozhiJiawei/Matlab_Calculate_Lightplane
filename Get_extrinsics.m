function Get_extrinsics( numImages )
%   ����ξ��󣬷�����һ������ʹ��
%   ����extrinsics.mat��
fileName = cell(1, numImages);
for i=1:numImages
  fileName{i} = fullfile(pwd, 'pic_input', 'undistortimages', ...
    sprintf('%d.bmp', i * 2 - 1));
  
end

[imagePoints, boardSize] = detectCheckerboardPoints(fileName);

squareSize = 10;
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

load('calibrationSession.mat');

for i=1:size(imagePoints,3)
  [lightExtrinsics.rotationMatrix(:,:,i), ...
    lightExtrinsics.translationVector(i,:)] = extrinsics(...
    imagePoints(:,:,i), worldPoints, calibrationSession.CameraParameters);

end
save('lightExtrinsics.mat','lightExtrinsics');
end

