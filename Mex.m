function [ R_T ] = Mex( n_of_Mex )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   n�����
load('calibrationSession.mat')
r_mat = calibrationSession.CameraParameters.RotationMatrices(:,:,n_of_Mex)';
t_vec = calibrationSession.CameraParameters.TranslationVectors(n_of_Mex,:)';
R_T = [r_mat,t_vec;zeros(1,3),1];
end

