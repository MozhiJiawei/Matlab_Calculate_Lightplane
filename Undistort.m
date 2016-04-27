function Undistort(pic_num)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
filePathOut = fullfile(pwd,'pic_input','undistortimages');
for i = 1:1:pic_num 
  imageFileNames{i} = fullfile(pwd,'pic_input','lightimages',...
      sprintf('%d.bmp',i));
end

load('calibrationSession.mat')
if( ~exist(filePathOut))
  mkdir(filePathOut);
end

for i=1:1:pic_num
  originalImage = imread(imageFileNames{i});
  undistortedImage = undistortImage(originalImage, ...
    calibrationSession.CameraParameters);
    
  imagename = fullfile(filePathOut, sprintf('%d.bmp',i));
  imwrite(undistortedImage, imagename);
end

end

