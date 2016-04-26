function Undistort(pic_num)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
filePathIn = [pwd,'\pic_input\lightimages\'];
filePathOut = [pwd,'\pic_input\undistortimages\'];
for i = 1:1:pic_num 
  imageFileNames{i} = [filePathIn, num2str(i), '.bmp'];
end

load('calibrationSession_firt_try.mat')
if( ~exist(filePathOut))
  mkdir(filePathOut);
end

for i=1:1:pic_num
  originalImage = imread(imageFileNames{i});
  undistortedImage = undistortImage(originalImage, ...
    calibrationSession.CameraParameters);
    
  imagename = sprintf('%s\\%d.bmp',filePathOut,i);
  imwrite(undistortedImage, imagename);
end

end

