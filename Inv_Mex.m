function [ Inv ] = Inv_Mex( n_of_Mex )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
% n����ε���
load('calibrationSession_firt_try.mat')
r_mat = calibrationSession.CameraParameters.RotationMatrices(:,:,n_of_Mex)';
t_vec = calibrationSession.CameraParameters.TranslationVectors(n_of_Mex,:)';
Inv = [inv(r_mat), -inv(r_mat)*t_vec;zeros(1,3),1];
end

